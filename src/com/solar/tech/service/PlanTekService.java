package com.solar.tech.service;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.utils.ECUtils;
import com.solar.tech.utils.OptimizeECUtils;
import com.solar.tech.bean.entity.FlightInfo;
import com.solar.tech.bean.entity.FlightMessage;
import com.solar.tech.bean.entity.SeatInfo;
import com.solar.tech.bean.entity.SeatInfoData;
import com.solar.tech.bean.entity.SeatPriceData;
import com.solar.tech.dao.GenericDao;
import com.travelsky.sbeclient.obe.response.AvSegment;
import com.travelsky.sbeclient.obe.response.FDItem;

/**
 * @title PlanTekService 处理机票的查询、预定的类
 * @author solarpc1
 *
 */
@Service
@Transactional
public class PlanTekService {
	@Resource
	private GenericDao gDao;
	
	//查询可用座位(出发城市、到达城市、出发时间)
	public List<SeatInfoData> SreachSeat(String org, String dst, String date){
		List<SeatInfoData> noStop = OnlySeatInfo(org,dst,date); //直达的
		if(noStop.size()==0){  //如果直达的航班为空，则说明这个条件航班没有查找过记录，需要重新查找
			System.out.println("符合查找接口的条件");
			List<AvSegment> hsavList = new ECUtils().av(org, dst, date, null, null, "false", null, null, null); //查询座位可用   有中转
			hsavList = new OptimizeECUtils().removeNullreapte(hsavList); //剔除掉重复的、没有座位的、共享的航班
			for(int i=0; i<hsavList.size(); i++){
				AvSegment avs = hsavList.get(i);
				SeatInfoData aidata = new SeatInfoData(); //要保存到数据库的对象
				UUID uuid = UUID.randomUUID();
				aidata.setSignFilghtNum(uuid.toString());
				aidata.setAirline(avs.getAirline());
				aidata.setDepDate(avs.getDepDate().substring(0,8));
				aidata.setDeptimemodify(avs.getDeptimemodify());
				aidata.setDepTime(avs.getDepTime());
				aidata.setDepTerm(avs.getDepTerm());
				aidata.setOrgcity(avs.getOrgcity());
				aidata.setArriTerm(avs.getArriTerm());
				aidata.setArriTime(avs.getArriTime());
				aidata.setArriveDate(avs.getArriveDate().substring(0,8));
				aidata.setArriveTimeModify(avs.getArriveTimeModify());
				aidata.setDstcity(avs.getDstcity());
				//把舱位数变成字符串存到数据库中
				String[] cangData = avs.getCangwei_data(); 
				String sd = "";
				for(String ss : cangData){
					sd+=ss+",";
				}
				aidata.setCangwei_data(sd.substring(0,sd.length()-1));
				//把舱位数的下标变成字符串存到数据库中
				char[] astr = avs.getCangwei_index();
				String b = "";
				for(char a : astr){
					String s = String.valueOf(a); 
					b+=s+",";
				}
				aidata.setCangwei_index(b.substring(0,b.length()-1));
				aidata.setFlyTime(avs.getFlyTime());
				aidata.setPlanestyle(avs.getPlanestyle());
				aidata.setMeal(avs.getMeal());
				aidata.setCreateTime(new Timestamp(new Date().getTime()));
				gDao.save(aidata);
				noStop.add(aidata);
			}
		}else{  //如果不为空，就说明之前已经有用户查找过，可以调用数据库中的数据即可
			System.out.println("符合查找数据库的条件");
			noStop = SeachSeatInfo(org,dst,date); //全部符合的数据（直达或者中转）
		}
		return noStop;
	}
	
	//查询航班舱位运价(出发城市、到达城市、出发时间)
	public List<SeatPriceData> seachPrice(String org, String dst, String date){
		List<FDItem> fdList = null;
		List<SeatPriceData> spd = findBySqlData(org, dst);
		if(spd!=null&&spd.size()>0){
			System.out.println("获取到数据库中的运价数据");
			return spd;
		}else{
			try {
				fdList = new ECUtils().fd(org, dst, date, null, null, null, null);
				System.out.println("符合查询中航信接口中的运价条件："+fdList.size());
				if(fdList.size()>0){
					List<SeatPriceData> spList = new ArrayList<SeatPriceData>();
					for(FDItem fdt : fdList){
						SeatPriceData spce = new SeatPriceData();
						spce.setAirline(fdt.getAirline());
						spce.setAirportTax(fdt.getAirportTax());
						spce.setBasicCabin(fdt.getBasicCabin());
						spce.setCabin(fdt.getCabin());
						spce.setDstCity(fdt.getDstCity());
						spce.setFueltax(fdt.getFueltax());
						spce.setOnewayPrice(fdt.getOnewayPrice());
						spce.setRoundtripPrice(fdt.getRoundtripPrice());
						spce.setOrgCity(fdt.getOrgCity());
						spce.setCreateTime(new Timestamp(new Date().getTime()));
						spList.add(spce);
						spd.add(spce);
					}
					spList = removeSp(spList);//入库之前要进行去重处理
					System.out.println("断电："+spList.size());
					gDao.save(spList);
				}
			} catch (Exception e) {
				System.out.println("查询接口运价异常");
			}
			spd = removeSp(spd); //去重
		}
		
		return spd;
	}
	
	/**
	 * @title 传入出发城市、到达城市、日期、航班号及舱位，返回该舱位可用座位数 
	 */
	//传入出发城市、到达城市、日期及航空公司代码  例如："CAN", "PEK", "2016-12-01", "CZ"
	public List<FlightInfo> findHB(String chufCity,String daodCity,String airCode, String dateTime, String filgNo, String direct, String noStop){
		System.out.println("=======>>>>开始执行查找中航信系统数据<=> 出发城市："+chufCity+", 到达城市："+daodCity+", 航空公司："+airCode+", 出发日期："+dateTime);
		// 传入出发城市、到达城市、日期、航空公司代码是否直达、是否有经停点
		List<FlightInfo> list = new OptimizeECUtils().query(chufCity, daodCity, dateTime, airCode, filgNo, direct, noStop);
		if(list.size()<1){
			return null;
		}
		List<FlightInfo> tempFlil = removeRepeat(list); //剔除重复的数据
		List<FlightInfo> newFlil = removeNullSeat(tempFlil);  //剔除座位为空的数据
		
		//将这些数据缓存到数据库里面
		List<FlightMessage> fliMes = new ArrayList<FlightMessage>();
		for(FlightInfo finfo : newFlil){
			FlightMessage fm = new FlightMessage();
			fm.setAirCode(finfo.getAirCode());
			fm.setArrTime(finfo.getArrTime());
			fm.setCreateTime(new Timestamp(new Date().getTime()));
			fm.setDepTime(finfo.getDepTime());
			fm.setDstCity(finfo.getDstCity());
			fm.setFlightNo(finfo.getFlightNo());
			fm.setOrgCity(finfo.getOrgCity());
			fm.setPlaneStyle(finfo.getPlaneStyle());
			fm.setOrgDate(dateTime);
			String infoStr = "";
			for(SeatInfo snfo : finfo.getSeatList()){
				infoStr += snfo.toString()+"-";
			}
			fm.setSeatInfo(infoStr.substring(0,infoStr.length()-1));
			fliMes.add(fm);
		}
		gDao.save(fliMes);
		return newFlil;
	}
	
	/**
	 * 查找数据库中的航班信息
	 * @param chufCity
	 * @param daodCity
	 * @param cangW
	 * @param dateTime
	 * @return
	 */
	public Map<String,Object> findflight(String chufCity,String daodCity,String cangW,String dateTime){
		//findHB(chufCity, daodCity, null, dateTime, null, "true", null);
		Map<String,Object> map = new HashMap<String,Object>();
		List<FlightInfo> flig = new ArrayList<FlightInfo>();
		String hql = "FROM FlightMessage WHERE orgCity = '"+chufCity+"' AND dstCity = '"+daodCity+"'";
		List<FlightMessage> rows = gDao.find(hql);
		//如果本地数据库中没有的航班，就从中航信系统中查询
		if(rows.size()==0){
			flig = findHB(chufCity, daodCity, null, dateTime, null, "true", null);
			map.put("listDate", flig);
			return map;
		}
		for(FlightMessage fm : rows){
			List<SeatInfo> seaList = new ArrayList<SeatInfo>();  //保存座位的链表
			String seat = fm.getSeatInfo();
			String[] stringArr = seat.split("-");
			for(int i=0;i<stringArr.length; i++){
				String seStr = stringArr[i];
				SeatInfo sifn = new SeatInfo();
				seStr = seStr.substring(1,seStr.length()-1);
				String[] chs = seStr.split(",");
				sifn.setCangwei(chs[0].substring(chs[0].indexOf("=")+1));
				sifn.setCangwei_data(chs[1].substring(chs[1].indexOf("=")+1));
				sifn.setBasicCabin(chs[2].substring(chs[2].indexOf("=")+1));
				sifn.setOnewayPrice(chs[3].substring(chs[3].indexOf("=")+1));
				sifn.setRoundtripPrice(chs[4].substring(chs[4].indexOf("=")+1));
				seaList.add(sifn);
			}

			FlightInfo fg = new FlightInfo();
			fg.setAirCode(fm.getAirCode());
			fg.setArrTime(fm.getArrTime());
			fg.setDepTime(fm.getDepTime());
			fg.setDstCity(fm.getDstCity());
			fg.setFlightNo(fm.getFlightNo());
			fg.setOrgCity(fm.getOrgCity());
			fg.setPlaneStyle(fm.getPlaneStyle());
			fg.setSeatList(seaList);
			
			flig.add(fg);
		}
		map.put("listDate", flig);
		return map;
	}
	
	//从数据库中查询航班的座位信息(只搜直达)
	public List<SeatInfoData> OnlySeatInfo(String org, String dst, String date){
		date = date.replaceAll("-", "");
		String hql = "FROM SeatInfoData WHERE orgcity = '"+org+"' AND dstcity = '"+dst+"' AND depDate = '"+date+"'";
		List<SeatInfoData> avs = gDao.find(hql);
		return avs;
	}
	
	//从数据库中查询航班的座位信息(包括中转)
	public List<SeatInfoData> SeachSeatInfo(String org, String dst, String date){
		date = date.replaceAll("-", "");
		String hql = "FROM SeatInfoData WHERE (orgcity = '"+org+"' OR dstcity = '"+dst+"') AND depDate = '"+date+"'";
		List<SeatInfoData> avs = gDao.find(hql);
		return avs;
	}
	
	//从数据库中查询航班的运价
	public List<SeatPriceData> findBySqlData(String org, String dst){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();
		c.add(Calendar.DAY_OF_YEAR, 0);
		Date date = c.getTime();
		String pastTime = sdf.format(date);
		List<SeatPriceData> spd = gDao.find("FROM SeatPriceData WHERE DATE_FORMAT(createTime,'%Y-%m-%d') > '"+pastTime+"'");
		return spd;
	}
	
	//根据id从数据库中获取到数据
	public Map<String,Object> findByUUID(String uuid,String canbin){
		Map<String,Object> map = new HashMap<String,Object>();
		List<SeatInfoData> sinfo = gDao.find("FROM SeatInfoData WHERE signFilghtNum = '"+uuid+"'");
		List<SeatPriceData> spd = findByCanbin(sinfo.get(0).getOrgcity(),sinfo.get(0).getDstcity(),canbin,sinfo.get(0).getAirline());
		map.put("canbin", spd.get(0).getCabin());
		map.put("cost", spd.get(0).getOnewayPrice());
		map.put("dataObj", sinfo);
		return map;
	}
	
	//根据舱位、航空公司、起始城市、到达城市
	public List<SeatPriceData> findByCanbin(String org,String dst,String canbin,String codeAir){
		List<SeatPriceData> sepList = gDao.find("FROM SeatPriceData WHERE ((orgCity = '"+org+"' AND dstCity = '"+dst+"') OR (orgCity = '"+dst+"' AND dstCity = '"+org+"')) AND cabin = '"+canbin+"' AND airline = '"+codeAir.substring(0,2)+"'");
		return sepList;
	}
	
	//返回往返的全部航班信息
	/*public Map<String,Object> roundtripAv(String org, String dst, String date, String returnDate, String airline, Integer page){
			Map<String,Object> map  = new OptimizeECUtils().roundtripAv(org, dst, date, returnDate, airline, page);
			return map;
	}*/
	
	
	// 剔除重复的数据
	public List<FlightInfo> removeRepeat(List<FlightInfo> list){
		List<FlightInfo> resultList = new ArrayList<FlightInfo>();
		if(list != null && list.size() > 0){
			for(FlightInfo info : list){
				boolean flag = true;
				for(FlightInfo rInfo : resultList){
					if(info.getFlightNo().equals(rInfo.getFlightNo())){
						flag = false;
						break;
					}
				}
				if(flag){
					resultList.add(info);
				}
			}
		}
		return resultList;
	}
	
	public List<SeatPriceData> removeSp(List<SeatPriceData> sp){
		List<SeatPriceData> seatPri = new ArrayList<SeatPriceData>();
		if(sp != null && sp.size() > 0){
			for(SeatPriceData info : sp){
				boolean flag = true;
				for(SeatPriceData rInfo : seatPri){
					if(info.getAirline().equals(rInfo.getAirline())&&info.getCabin().equals(rInfo.getCabin())&&info.getOrgCity().equals(rInfo.getOrgCity())&&info.getDstCity().equals(rInfo.getDstCity())){
						flag = false;
						break;
					}
				}
				if(flag){
					seatPri.add(info);
				}
			}
		}
		return seatPri;
	}
	
	//剔除座位为空的数据
	public List<FlightInfo> removeNullSeat(List<FlightInfo> list){
		List<FlightInfo> resultList = new ArrayList<FlightInfo>();
		if(list != null && list.size() > 0){
			for(FlightInfo f : list){
				if(f.getSeatList().size()!=0){
					resultList.add(f);  //将符合的航班加入新的数组链表里面
				}
			}
		}
		return resultList;
	}
	
	//重新生成缓存的方法
	public void loadBronAv(String org, String dst, String date){
		List<AvSegment> hsavList = new ECUtils().av(org, dst, date, null, null, "false", null, null, null); //查询座位可用   有中转
		hsavList = new OptimizeECUtils().removeNullreapte(hsavList); //剔除掉重复的、没有座位的、共享的航班
		for(int i=0; i<hsavList.size(); i++){
			AvSegment avs = hsavList.get(i);
			SeatInfoData aidata = new SeatInfoData(); //要保存到数据库的对象
			aidata.setAirline(avs.getAirline());
			aidata.setDepDate(avs.getDepDate().substring(0,8));
			aidata.setDeptimemodify(avs.getDeptimemodify());
			aidata.setDepTime(avs.getDepTime());
			aidata.setDepTerm(avs.getDepTerm());
			aidata.setOrgcity(avs.getOrgcity());
			aidata.setArriTerm(avs.getArriTerm());
			aidata.setArriTime(avs.getArriTime());
			aidata.setArriveDate(avs.getArriveDate().substring(0,8));
			aidata.setArriveTimeModify(avs.getArriveTimeModify());
			aidata.setDstcity(avs.getDstcity());
			//把舱位数变成字符串存到数据库中
			String[] cangData = avs.getCangwei_data(); 
			String sd = "";
			for(String ss : cangData){
				sd+=ss+",";
			}
			aidata.setCangwei_data(sd.substring(0,sd.length()-1));
			//把舱位数的下标变成字符串存到数据库中
			char[] astr = avs.getCangwei_index();
			String b = "";
			for(char a : astr){
				String s = String.valueOf(a); 
				b+=s+",";
			}
			aidata.setCangwei_index(b.substring(0,b.length()-1));
			aidata.setFlyTime(avs.getFlyTime());
			aidata.setPlanestyle(avs.getPlanestyle());
			aidata.setMeal(avs.getMeal());
			aidata.setCreateTime(new Timestamp(new Date().getTime()));
			gDao.save(aidata);
		}
	}
	
	//查找航班是否过期，如果过期就重新缓存
	public List<SeatInfoData> pastFlightMessageList(String pastTime) {
		StringBuffer hql = new StringBuffer();
		hql.append("FROM SeatInfoData WHERE depDate = '").append(pastTime).append("'");
		List<SeatInfoData> datas = gDao.queryHQL(hql.toString());
		return datas;
	}
	
	//查找航班运价是否过期，如果过期就重新缓存
	public List<SeatPriceData> SeatPriceList(String pastTime) {
		StringBuffer hql = new StringBuffer();
		hql.append("FROM SeatPriceData WHERE DATE_FORMAT(createTime,'%Y-%m-%d') <= '").append(pastTime).append("'");
		List<SeatPriceData> datas = gDao.queryHQL(hql.toString());
		return datas;
	}
	
	//删除掉过期的航班
	public void delFlight(List<SeatInfoData> o_op){
			gDao.delete(o_op);
	}
	
	//删除掉过期的航班运价
	public void delSeatPrice(List<SeatPriceData> o_op){
		gDao.delete(o_op);
	}
	
	//组合中转航班的方法
	/*public List<FlightInfo> zuhe(List<FlightInfo> list){
		List<FlightInfo> resultList = new ArrayList<FlightInfo>();
		Random random = new Random();
		for(int i=0; i<list.size(); i++){
			for(int j=list.size()-1; j>i; j--){
				if((list.get(i).getDstCity()).equals(list.get(j).getOrgCity())&&(list.get(i).getAirCode()).equals(list.get(j).getAirCode())&&changeSS(list.get(i).getArrTime(),list.get(j).getDepTime())>3600){
					String[] storeInvitationChars={"A","B","C","D","1","E","F","G","H","2","I","0","J","K","3","L","M","8","N","4","O","P","5","Q","R","9","S","T","U","V","6","W","X","Y","7","Z"};
					String sign = ""; //为两个符合的航班加上标识，以便在前台组合
					for(int k=0; k<20; k++){
		    			int index = random.nextInt(35);
		    			sign += storeInvitationChars[index];
		    		}
					resultList.add(list.get(i));
					resultList.add(list.get(j));
				}
			}
		}
		return resultList;
	}*/
	
	/**
	 * 将时间化成秒
	 * @param start
	 * @param overt
	 * @return
	 */
	/*public static int changeSS(String start, String overt){
		//将时间转换成秒来比较
		String shh=null,smm=null,sdd=null;
		int scount;
		int ocount; //定义总时间的两个变量
		String ohh=null,omm=null,odd=null;
		
		if(start.indexOf("+")>0){
			shh = start.substring(0,2);
			smm = start.substring(2,4);
			sdd = start.substring(4,start.length());
			scount = (Integer.parseInt(shh)*3600)+(Integer.parseInt(smm)*60)+(24*3600);
		}else{
			shh = start.substring(0,2);
			smm = start.substring(2,start.length());
			sdd = "0";
			scount = (Integer.parseInt(shh)*3600)+(Integer.parseInt(smm)*60);
		} 
		
		if(overt.indexOf("+")>0){
				ohh = overt.substring(0,2);
				omm = overt.substring(2,4);
				odd = overt.substring(4,overt.length());
				ocount = (Integer.parseInt(ohh)*3600)+(Integer.parseInt(omm)*60)+(24*3600);
		}else{
				ohh = overt.substring(0,2);
				omm = overt.substring(2,overt.length());
				odd = "0";
				ocount = (Integer.parseInt(ohh)*3600)+(Integer.parseInt(omm)*60);
		}
		return ocount-scount;
	}*/
	
	/*//临时方法
	public List getPlanList(){
		String sql = "select CODE,cn_name from b_airways";
		return this.gDao.executeJDBCSqlQuery(sql);
	}*/
}
