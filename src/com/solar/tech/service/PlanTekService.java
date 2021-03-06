package com.solar.tech.service;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.utils.ECUtils;
import com.solar.tech.utils.OptimizeECUtils;
import com.solar.tech.bean.CenterDate;
import com.solar.tech.bean.entity.FlightInfo;
import com.solar.tech.bean.entity.FlightMessage;
import com.solar.tech.bean.entity.Insurance;
import com.solar.tech.bean.entity.SeatInfo;
import com.solar.tech.bean.entity.SeatInfoData;
//import com.solar.tech.bean.entity.SeatInfoDataWF;
import com.solar.tech.bean.entity.SeatPriceData;
import com.solar.tech.bean.entity.kdCost;
import com.solar.tech.dao.GenericDao;
import com.travelsky.sbeclient.obe.request.PataFareInfo;
import com.travelsky.sbeclient.obe.response.AVDoubleItem;
import com.travelsky.sbeclient.obe.response.AVDoubleResponse;
import com.travelsky.sbeclient.obe.response.AVDoubleSegment;
import com.travelsky.sbeclient.obe.response.AvSegment;
import com.travelsky.sbeclient.obe.response.FDItem;
import com.travelsky.sbeclient.obe.response.PataFarePriceInfo;

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
	public List<SeatInfoData> SreachSeat(String org, String dst, String date, Integer isWf){
		List<SeatInfoData> noStop = SeatInfo(org,dst,date,isWf); //查找数据是否已经缓存
		noStop = guoDateInfo(noStop); // 进一步处理看看是否有过期的航班
		if(noStop.size()==0){  //如果数据库缓存的航班为空，则说明这个条件航班没有查找过记录，需要重新查找
			//System.out.println("符合查找接口的条件");
			noStop = upHcDate(org, dst, date, isWf); //封装了缓存的方法
		}
		
		//还要再处理出发时间大于当前时间的2.5小时(只有当天出发的航班才筛选，不是当天的航班不筛选)
		if(pointTime(date)==0){
			noStop = flyTime(noStop);
		}
		
		return noStop;
	}
	
	//查询航班舱位运价(出发城市、到达城市、出发时间)
	public List<SeatPriceData> seachPrice(String org, String dst, String date,String airline){
		List<FDItem> fdList = null;
		List<SeatPriceData> spd = findBySqlData(org, dst,airline);
		if(spd!=null&&spd.size()>0){
			//System.out.println("获取到数据库中的运价数据");
			return spd;
		}else{
			try {
				fdList = new ECUtils().fd(org, dst, date, airline, null, null, null);
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
					}
					spList = removeSp(spList);//入库之前要进行去重处理
					gDao.save(spList);
					spd = spList; //把这些结果集给另一个结果集让他返回
				}
			} catch (Exception e) {
				return spd;
			}
		}
		
		return spd;
	}
	
	/*public List<AVDoubleItem> reAvfilght(String orgCity, String dstCity, String orgDate, String retDate){
		AVDoubleResponse list = new ECUtils().roundtripAv(orgCity, dstCity, orgDate, retDate, "", null);
		List<SeatInfoDataWF> desFilgInfo = new ArrayList<SeatInfoDataWF>();
		List<AVDoubleItem> ygDesFilg = list.getDepartAvItems();
		for(AVDoubleItem avdItem : ygDesFilg){
			List<AVDoubleSegment> AVDoubs = avdItem.getSegments();
			for(AVDoubleSegment avdbles : AVDoubs){
				if(seatInfoIsNull(avdbles)){ //座位不为空
					SeatInfoDataWF sidate = new SeatInfoDataWF();
					sidate.setAirline(avdbles.getAirline());
					sidate.setArriTerm(avdbles.getArriTerm());
					sidate.setArriTime(avdbles.getArriTime());
					sidate.setArriveDate(avdbles.getArriveDate().substring(0,10));
					sidate.setArriveTimeModify(avdbles.getArriveTimeModify());
					sidate.setDepDate(avdbles.getDepDate());
					sidate.setDepTerm(avdbles.getDepTerm());
					sidate.setDepTime(avdbles.getDepTime());
					sidate.setDeptimemodify(avdbles.getDeptimemodify());
					sidate.setDstcity(avdbles.getDstcity());
					sidate.setFlyTime(avdbles.getFlyTime());
					sidate.setMeal(avdbles.getMeal());
					sidate.setOrgcity(avdbles.getOrgcity());
					sidate.setPlanestyle(avdbles.getPlanestyle());
					sidate.setCreateTime(new Timestamp(new Date().getTime()));
					sidate.setDwOrgCity(avdbles.getOrgcity());
					sidate.setDwDstCity(avdbles.getDstcity());
					long juliDay = pointTime(avdbles.getArriveDate().substring(0,10));
					String dayNum = "";
					if(juliDay==0){dayNum = "1";}else if(juliDay>0&&juliDay<=3){dayNum = "2";}else if(juliDay>3&&juliDay<=7){dayNum = "3";}else if(juliDay>7&&juliDay<=15){dayNum = "4";}else if(juliDay>15&&juliDay<=30){dayNum = "5";}else if(juliDay>30){dayNum = "6";}
					sidate.setDayNum(dayNum);
					UUID uuid = UUID.randomUUID();
					sidate.setSignFilghtNum(uuid.toString());
					
					//把舱位数变成字符串存到数据库中
					String[] cangData = avdbles.getCangwei_data(); 
					String sd = "";
					for(String ss : cangData){
						sd+=ss+",";
					}
					sidate.setCangwei_data(sd.substring(0,sd.length()-1));
					//把舱位数的下标变成字符串存到数据库中
					char[] astr = avdbles.getCangwei_index();
					String b = "";
					for(char a : astr){
						String s = String.valueOf(a); 
						b+=s+",";
					}
					sidate.setCangwei_index(b.substring(0,b.length()-1));
					desFilgInfo.add(sidate);
				}
				
			}
		}
		System.out.println(desFilgInfo.size()); 
		return ygDesFilg;
	}*/
	
	public boolean seatInfoIsNull(AVDoubleSegment avd){
		if(avd.getCangwei_data()==null||"".equals(avd.getCangwei_data())){
			return false;
		}
		System.out.println("不为空的航班："+avd.getAirline());
		return true;
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
	
	//从数据库中查询航班的座位信息
	public List<SeatInfoData> SeatInfo(String org, String dst, String date, Integer isWf){
		long juliDay = pointTime(date);
		String dayNum = "";
		if(juliDay==0){
			System.out.println("当天的航班");
			dayNum = "1";
		}else if(juliDay>0&&juliDay<=3){
			System.out.println("三天之内的航班");
			dayNum = "2";
		}else if(juliDay>3&&juliDay<=7){
			System.out.println("3-7天之内的航班");
			dayNum = "3";
		}else if(juliDay>7&&juliDay<=15){
			System.out.println("7-15天之内的航班");
			dayNum = "4";
		}else if(juliDay>15&&juliDay<=30){
			System.out.println("15-30天之内的航班");
			dayNum = "5";
		}else if(juliDay>30){
			System.out.println("30天以上的航班");
			dayNum = "6";
		}
		String hql = "";
		if(isWf==1){
			hql = "FROM SeatInfoData WHERE orgcity = '"+org+"' AND dstcity = '"+dst+"' AND dayNum = '"+dayNum+"'";
		}else{
			hql = "FROM SeatInfoData WHERE dwOrgCity = '"+org+"' AND dwDstCity = '"+dst+"' AND dayNum = '"+dayNum+"'";
		}
		
		List<SeatInfoData> avs = gDao.find(hql);
		return avs;
	}
	
	//判断航班是否出发时间是否大于2.5小时
	public List<SeatInfoData> flyTime(List<SeatInfoData> siflist){
		List<SeatInfoData> seatList = new ArrayList<SeatInfoData>();
		if(siflist.size()>0){
			for(SeatInfoData sidate : siflist){
				if(getDistanceDays(sidate.getDepTime())){ //如果这个方法为true 就说明这个航班的出发时间大于或者等于2.5小时，符合条件
					seatList.add(sidate);
				}
			}
		}
		return seatList;
	}
	
	//判断数据是否过期
	public List<SeatInfoData> guoDateInfo(List<SeatInfoData> sif){
		List<SeatInfoData> deleIdList = new ArrayList<SeatInfoData>();  //用于临时存放过期的航班uuid
		List<SeatInfoData> saveSinf = new ArrayList<SeatInfoData>();  //用于临时存放没有过期的航班
		for(SeatInfoData sid : sif){
			if(sid.getDayNum().equals("1")){
				//当天的航班 超过一个小时就是过期
				Calendar c = Calendar.getInstance();
				c.add(Calendar.HOUR_OF_DAY, -1);
				Date NowDate = c.getTime();
				Date creaTime = sid.getCreateTime();

				if(creaTime.after(NowDate)){
					saveSinf.add(sid);
				}else if(NowDate.after(creaTime)){
					deleIdList.add(sid);
				}
			}else if(sid.getDayNum().equals("2")){
				//3天之内的航班 超过二个小时就是过期
				Calendar c = Calendar.getInstance();
				c.add(Calendar.HOUR_OF_DAY, -2);
				Date NowDate = c.getTime();
				Date creaTime = sid.getCreateTime();

				if(creaTime.after(NowDate)){
					saveSinf.add(sid);
				}else if(NowDate.after(creaTime)){
					deleIdList.add(sid);
				}
			}else if(sid.getDayNum().equals("3")){
				//3-7天的航班 超过八个小时就是过期
				Calendar c = Calendar.getInstance();
				c.add(Calendar.HOUR_OF_DAY, -8);
				Date NowDate = c.getTime();
				Date creaTime = sid.getCreateTime();

				if(creaTime.after(NowDate)){
					saveSinf.add(sid);
				}else if(NowDate.after(creaTime)){
					deleIdList.add(sid);
				}
			}else if(sid.getDayNum().equals("4")){
				//7-15天的航班 超过24个小时就是过期
				Calendar c = Calendar.getInstance();
				c.add(Calendar.HOUR_OF_DAY, -24);
				Date NowDate = c.getTime();
				Date creaTime = sid.getCreateTime();

				if(creaTime.after(NowDate)){
					saveSinf.add(sid);
				}else if(NowDate.after(creaTime)){
					deleIdList.add(sid);
				}
				
			}else if(sid.getDayNum().equals("5")){
				//15-30天的航班 超过2天就是过期
				Calendar c = Calendar.getInstance();
				c.add(Calendar.DAY_OF_YEAR, -2);
				Date NowDate = c.getTime();
				Date creaTime = sid.getCreateTime();

				if(creaTime.after(NowDate)){
					saveSinf.add(sid);
				}else if(NowDate.after(creaTime)){
					deleIdList.add(sid);
				}
			}else if(sid.getDayNum().equals("6")){
				//30天以上的航班 超过5天就是过期
				Calendar c = Calendar.getInstance();
				c.add(Calendar.DAY_OF_YEAR, -5);
				Date NowDate = c.getTime();
				Date creaTime = sid.getCreateTime();

				if(creaTime.after(NowDate)){
					saveSinf.add(sid);
				}else if(NowDate.after(creaTime)){
					deleIdList.add(sid);
				}
			}
		}
		gDao.delete(deleIdList);//删除过期的航班
		return saveSinf;
	}
	
	/**
	 * 删除掉不是直达的航班
	 */
	public List<FlightInfo> doDateCity(List<FlightInfo> sd, String org, String dst){
		List<FlightInfo> finfo = new ArrayList<FlightInfo>();
		for(FlightInfo fi : sd){
			if(org.equals(fi.getOrgCity())&&dst.equals(fi.getDstCity())){
				finfo.add(fi);
			}
		}
		return finfo;
	}
	
	/**
	 * 封装座位价格和航班信息的方法
	 */
	public List<FlightInfo> priceInfo(List<SeatInfoData> avList,String dateTime){
		List<SeatInfoData> delList = new ArrayList<SeatInfoData>();//用于删掉数据库中的运价异常的航班
		List<FlightInfo> flightInfo = new ArrayList<FlightInfo>();
		
		//查找价格并且组合
		Iterator<SeatInfoData> it = avList.iterator();
		while(it.hasNext()){
			SeatInfoData avs = it.next();
			List<SeatPriceData> spList = seachPrice(avs.getOrgcity(),avs.getDstcity(),dateTime,avs.getAirline().substring(0,2)); //一个航班查找一次才符合
			if(spList.size()==0){
				//如果出现数据库没有缓存的运价，而且接口也没有查找到运价。那这段航班就会被剔除掉。不会缓存到数据库中
				delList.add(avs);
				it.remove(); //需要显示到前端的数据也不会包含该航班
			}else{
				List<SeatInfo> seatList = new ArrayList<SeatInfo>(); // 航班座位信息
				FlightInfo finf = new FlightInfo();
				finf.setUuid(avs.getSignFilghtNum());
				finf.setAirCode(avs.getAirline().substring(0,2));
				finf.setArrTime(avs.getArriTime());
				finf.setDepTime(avs.getDepTime());
				finf.setDstCity(avs.getDstcity());
				finf.setOrgCity(avs.getOrgcity());
				finf.setFlightNo(avs.getAirline());
				finf.setPlaneStyle(avs.getPlanestyle());
				finf.setDeptimemodify(avs.getDeptimemodify());
				finf.setArriveTimeModify(avs.getArriveTimeModify());
				
				String cwNum = avs.getCangwei_data(); //舱位的数量
				String[] cwNum_Org = cwNum.split(","); 
				String cwIndex = avs.getCangwei_index(); //舱位的类别
				String[] cwIndex_Org = cwIndex.split(",");

				for(int i=0; i<cwIndex_Org.length; i++){
					SeatInfo seatInfo = new SeatInfo();
					String cwChiled = cwIndex_Org[i];
					String cwNumChild = cwNum_Org[i];
					seatInfo.setCangwei(cwChiled);
					seatInfo.setCangwei_data(cwNumChild);
					for(SeatPriceData spdata : spList){
						if(finf.getAirCode().equals(spdata.getAirline())&&cwChiled.equals(spdata.getCabin())){ //如果航空公司和舱位对得上。就说明查找到结果
							seatInfo.setBasicCabin(spdata.getBasicCabin());
							seatInfo.setOnewayPrice(spdata.getOnewayPrice());
							seatInfo.setRoundtripPrice((Double.parseDouble(spdata.getOnewayPrice())*2)+"");
						}
					}
					seatList.add(seatInfo);
				}
				finf.setSeatList(seatList);
				flightInfo.add(finf);
			}
		}
		 
		//删除没有运价的航班
		delFlight(delList);
		
		return flightInfo;
	}
	
	public List<SeatInfoData> upHcDate(String org, String dst,String date, int isWf){
		List<SeatInfoData> noStop = new ArrayList<SeatInfoData>();
		List<SeatInfoData> addSave = new ArrayList<SeatInfoData>();
		String dayNum = "";
		long juliDay = pointTime(date);
		if(juliDay==0){dayNum = "1";}else if(juliDay>0&&juliDay<=3){dayNum = "2";}else if(juliDay>3&&juliDay<=7){dayNum = "3";}else if(juliDay>7&&juliDay<=15){dayNum = "4";}else if(juliDay>15&&juliDay<=30){dayNum = "5";}else if(juliDay>30){dayNum = "6";}
		List<AvSegment> hsavList = null;
		if(isWf==1){ //说明搜的是往返的  不需要中转
			hsavList = new ECUtils().av(org, dst, date, null, null, "true", null, null, null); //查询座位可用   无中转
		}else{ //否则是单程的 需要有中转
			hsavList = new ECUtils().av(org, dst, date, null, null, "false", null, null, null); //查询座位可用   有中转
		}
		if(hsavList==null||hsavList.size()==0){
			return noStop;
		}
		hsavList = new OptimizeECUtils().removeNullreapte(hsavList); //剔除没有座位的、重复的、共享的航班
		for(int i=0; i<hsavList.size(); i++){
			AvSegment avs = hsavList.get(i);
			SeatInfoData aidata = new SeatInfoData(); //要保存到数据库的对象
			UUID uuid = UUID.randomUUID();
			aidata.setSignFilghtNum(uuid.toString());
			aidata.setAirline(avs.getAirline());
			aidata.setDeptimemodify(avs.getDeptimemodify());
			aidata.setDepTime(avs.getDepTime());
			aidata.setDepTerm(avs.getDepTerm());
			aidata.setOrgcity(avs.getOrgcity());
			aidata.setDwOrgCity(org); //设置出发城市的组
			aidata.setDwDstCity(dst); //设置到达城市的组
			aidata.setDayNum(dayNum); //设置缓存的范围天数
			aidata.setArriTerm(avs.getArriTerm());
			aidata.setArriTime(avs.getArriTime());
			String depd = avs.getDepDate().substring(0,8);
			String dd = depd.substring(0,4)+"-"+depd.substring(4,6)+"-"+depd.substring(6,8);
			aidata.setDepDate(dd); //因为缓存原因  数据会有公用情况  如：三天之内的数据 26号 27号数据就共享，这样这个出发日期就没有固定值。
			
			String arrid = avs.getArriveDate().substring(0,8);
			String ad = arrid.substring(0,4)+"-"+arrid.substring(4,6)+"-"+arrid.substring(6,8);
			aidata.setArriveDate(ad); //因为缓存原因  数据会有公用情况  如：三天之内的数据 26号 27号数据就共享，这样这个到达日期就没有固定值。
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
			addSave.add(aidata);
			noStop.add(aidata);
		}
		gDao.save(addSave);
		return noStop;
	}
	
	//从数据库中查询航班的运价
	public List<SeatPriceData> findBySqlData(String org, String dst,String airline){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();
		c.add(Calendar.DAY_OF_YEAR, -180);
		Date date = c.getTime();
		String pastTime = sdf.format(date);
		List<SeatPriceData> spd = gDao.find("FROM SeatPriceData WHERE ((orgCity = '"+org+"' AND dstCity = '"+dst+"') OR (dstCity = '"+org+"' AND orgCity = '"+dst+"')) AND airline = '"+airline+"' AND DATE_FORMAT(createTime,'%Y-%m-%d') > '"+pastTime+"'");
		return spd;
	}
	
	/**
	 * 在控制器中用到，为了减少控制器的代码量（用于单程）
	 * @param chufCity
	 * @param daodCity
	 * @param dateTime
	 * @param isWf
	 * @return
	 */
	public Map<String,Object> findFilght(String chufCity, String daodCity, String dateTime, int isWf){
		Map<String,Object> map = new HashMap<String,Object>();
		List<FlightInfo> flightInfo = new ArrayList<FlightInfo>();
		//把整理好的数据分成中转和直达
		List<FlightInfo> zdList = new ArrayList<FlightInfo>(); //直达
		List<FlightInfo> zzList = new ArrayList<FlightInfo>(); //中转
		
		List<SeatInfoData> avList = SreachSeat(chufCity,daodCity,dateTime,isWf);
		flightInfo = priceInfo(avList, dateTime); //将航班信息和座位信息整合
		if(flightInfo.size()==0){
			map.put("msg", "0");
			map.put("listDate", zdList);
			map.put("zzListDate", zzList);
		}else{
			for(FlightInfo finfo : flightInfo){
				if(chufCity.equals(finfo.getOrgCity())&&daodCity.equals(finfo.getDstCity())){
					zdList.add(finfo);
				}else{
					zzList.add(finfo);
				}
			}
			map.put("msg", "1");
			map.put("listDate", zdList);
			map.put("zzListDate", zzList);
			System.out.println("直达航班："+zdList.size());
			System.out.println("中转航班："+zzList.size());
		}
		return map;
	}
	
	/**
	 * 用于往返（减少控制器的代码量）
	 * @param chufCity
	 * @param daodCity
	 * @param dateTime
	 * @param isWf
	 * @return
	 */
	public List<FlightInfo> findFilghtWf(String chufCity, String daodCity, String dateTime, int isWf){
		List<SeatInfoData> avList = SreachSeat(chufCity,daodCity,dateTime,isWf);
		List<FlightInfo> flightInfo = priceInfo(avList, dateTime); //将航班信息和座位信息整合
		return flightInfo;
	}
	
	//根据id从数据库中获取到数据
	public List<SeatInfoData> findByUUID(String uuid){
		List<SeatInfoData> sinfo = gDao.find("FROM SeatInfoData WHERE signFilghtNum = '"+uuid+"'");
		return sinfo;
	}
	
	//根据id从数据库中获取到数据(两个同时查找，用于预定中转和往返时候)
	public List<SeatInfoData> findByUUID(String uuid1,String uuid2){
			List<SeatInfoData> sinfo = gDao.find("FROM SeatInfoData WHERE signFilghtNum = '"+uuid1+"' OR signFilghtNum = '"+uuid2+"'");
			return sinfo;
	}
	
	//根据舱位、航空公司、起始城市、到达城市
	public List<SeatPriceData> findByCanbin(String org,String dst,String canbin,String codeAir){
		List<SeatPriceData> sepList = gDao.find("FROM SeatPriceData WHERE ((orgCity = '"+org+"' AND dstCity = '"+dst+"') OR (orgCity = '"+dst+"' AND dstCity = '"+org+"')) AND cabin = '"+canbin+"' AND airline = '"+codeAir.substring(0,2)+"'");
		return sepList;
	}
	
	public List<Insurance> findByBx(){
		List<Insurance> sepList = gDao.find("FROM Insurance");
		return sepList;
	}
	
	public List<kdCost> kdCost(){
		List<kdCost> sepList = gDao.find("FROM kdCost WHERE uuid = '4028831c5ccdf185015ccdf2dea70000'");
		return sepList;
	}
	
	//根据航班信息查找运价pataFare方法
	public List<PataFarePriceInfo> pataFare(String airline, String canbin, String org, String dst, String date, String psgType){
		PataFareInfo pf1 = new PataFareInfo();
		pf1.setFlightNo(airline);
		pf1.setCabin(canbin);
		pf1.setDate(date);
		pf1.setOrg(org);
		pf1.setDst(dst);
		List<PataFarePriceInfo> response = new ECUtils().pataFare(pf1, psgType);
		return response;
	}
	
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
		sp = removeNullPrice(sp); //先剔除座位对应运价为空的数据
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
	
	//剔除舱位对应运价为空的运价结果集
	public List<SeatPriceData> removeNullPrice(List<SeatPriceData> sp){
		List<SeatPriceData> seatPri = new ArrayList<SeatPriceData>();
		if(sp.size()>0){
			for(SeatPriceData sd : sp){
				boolean flag = true;
				if(sd.getOnewayPrice().equals("")||"".equals(sd.getOnewayPrice())){
					flag = false;
				}
				if(flag){
					seatPri.add(sd);
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
		String dayNum = "";
		long juliDay = pointTime(date);
		if(juliDay==0){dayNum = "1";}else if(juliDay>0&&juliDay<=3){dayNum = "2";}else if(juliDay>3&&juliDay<=7){dayNum = "3";}else if(juliDay>7&&juliDay<=15){dayNum = "4";}else if(juliDay>15&&juliDay<=30){dayNum = "5";}else if(juliDay>30){dayNum = "6";}
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
			aidata.setDwOrgCity(org); //设置出发城市的组
			aidata.setDwDstCity(dst); //设置到达城市的组
			aidata.setDayNum(dayNum); //设置缓存的范围天数
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
	
	//重新缓存运价的方法
	public void reloadfd(String org, String dst, String date){
		try {
			List<FDItem> fdList = new ECUtils().fd(org, dst, date, null, null, null, null);
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
				}
				spList = removeSp(spList);//入库之前要进行去重处理
				gDao.save(spList);
			}
		} catch (Exception e) {
			System.out.println("查询接口运价异常");
		}
	}
	
	//查找航班是否过期，如果过期就重新缓存
	public List<SeatInfoData> pastFlightMessageList(String num,String pastTime) {
		String hql = "FROM SeatInfoData WHERE dayNum = '"+num+"' AND DATE_FORMAT(createTime,'%Y-%m-%d %H:%i') <= '"+pastTime+"'";
		List<SeatInfoData> datas = gDao.find(hql);
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
	
	public long pointTime(String dataStr){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		long sd = -1;
		try {
			Date MuDate = sdf.parse(dataStr);
			Date NowDate = new Date();
			
			Calendar fromCalendar = Calendar.getInstance();  
		    fromCalendar.setTime(NowDate);  
		    fromCalendar.set(Calendar.HOUR_OF_DAY, 0);  
		    fromCalendar.set(Calendar.MINUTE, 0);  
		    fromCalendar.set(Calendar.SECOND, 0);  
		    fromCalendar.set(Calendar.MILLISECOND, 0); 
		        
		    Calendar toCalendar = Calendar.getInstance();  
		    toCalendar.setTime(MuDate);  
		    toCalendar.set(Calendar.HOUR_OF_DAY, 0);  
		    toCalendar.set(Calendar.MINUTE, 0);  
		    toCalendar.set(Calendar.SECOND, 0);  
		    toCalendar.set(Calendar.MILLISECOND, 0);  
		    
		    sd = (toCalendar.getTime().getTime() - fromCalendar.getTime().getTime()) / (1000 * 60 * 60 * 24); 
		} catch (ParseException e) {
			e.printStackTrace();
		}
	    
	    return sd;
	}
	
	public void addCenterDate(String htmlUuid){
		CenterDate cd = new CenterDate();
		cd.setStatus("waiting...");
		cd.setHtmlUuid(htmlUuid);
		cd.setIsgetmap("No");
		cd.setCreateTime(new Timestamp(new Date().getTime()));
		this.gDao.save(cd);
	}
	
	public void upCenterDate(String htmlUuid){
		this.gDao.executeJDBCSql("UPDATE fw_centerdate SET status='overfinsh' WHERE htmlUuid = '"+htmlUuid+"'");
	}
	
	public void upCenterDateSta(String htmlUuid){
		this.gDao.executeJDBCSql("UPDATE fw_centerdate SET isgetmap='Yes' WHERE htmlUuid = '"+htmlUuid+"'");
	}
	
	public CenterDate findCenterDate(String htmlUuid){
		List<CenterDate> centerda = this.gDao.find("FROM CenterDate WHERE htmlUuid = '"+htmlUuid+"'");
		return centerda.get(0);
	}
	
	public static boolean getDistanceDays(String str2){  
        DateFormat df = new SimpleDateFormat("HH:mm");  
        Date one;  
        Date two;  
        long days=0;  
        str2 = str2.substring(0,2)+":"+str2.substring(2,str2.length());
        try {  
            one = df.parse(df.format(new Date()));  
            two = df.parse(str2);  
            long time1 = one.getTime();  
            long time2 = two.getTime();  
            long diff ;  
            if(time1<time2) {  
                diff = time2 - time1;  
            } else {  
                diff = 0;  
            }  
            days = diff / (1000 * 60);  
        } catch (ParseException e) {  
            e.printStackTrace();  
        }
        if(days>=150){
        	return true;
        }
        return false;  
    } 
	
	public static void main(String[] args) {
		/*try {
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
		Calendar c = Calendar.getInstance();
		c.add(Calendar.MINUTE, +150);
		Date date = c.getTime();
		String pastTime = sdf.format(date);
		System.out.println(pastTime);*/
		//new PlanTekService().pastFlightMessageList("1");
		/*PlanTekService sd = new PlanTekService();
		long juliDay = sd.pointTime("2017-05-21");
		if(juliDay!=-1){
			if(juliDay==0){
				System.out.println("当天的航班");
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				Calendar c = Calendar.getInstance();
				c.add(Calendar.HOUR_OF_DAY, -1);
				Date NowDate = c.getTime();
				String pastTime = sdf.format(NowDate);
				System.out.println(pastTime);
				
			}else if(juliDay>0&&juliDay<=3){
				System.out.println("三天之内的航班");
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				Calendar c = Calendar.getInstance();
				c.add(Calendar.DAY_OF_YEAR, -1);
				Date NowDate = c.getTime();
				String pastTime = sdf.format(NowDate);
				System.out.println(pastTime);
				
			}else if(juliDay>3&&juliDay<=7){
				System.out.println("3-7天之内的航班");
			}else if(juliDay>7&&juliDay<=15){
				System.out.println("7-15天之内的航班");
			}else if(juliDay>15&&juliDay<=30){
				System.out.println("15-30天之内的航班");
			}else if(juliDay>30){
				System.out.println("30天以上的航班");
			}else{
				System.out.println("未知距离出发时间：不明");
			}
		}*/
	}
	
	//根据航班号和舱位查找数据库中缓存好的价格
	public SeatPriceData findPrice(String fildNum,String canbin,String cfCity,String ddCity){
		List<SeatPriceData> priceInfo = gDao.find("FROM SeatPriceData WHERE airline = '"+fildNum.substring(0,2)+"' AND cabin = '"+canbin+"' AND orgCity= '"+cfCity+"' AND dstCity = '"+ddCity+"'");
		return priceInfo.get(0);
	}
	
}
