package com.solar.tech.service;

import java.sql.Timestamp;
import java.text.ParseException;
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

import com.solar.tech.bean.entity.SeatInfoData;
import com.solar.tech.bean.entity.hcConfig;
import com.solar.tech.dao.GenericDao;
import com.solar.tech.utils.ECUtils;
import com.solar.tech.utils.OptimizeECUtils;
import com.travelsky.sbeclient.obe.response.AvSegment;

@Service
@Transactional
public class hcConfigService {
	@Resource
	private GenericDao gDao;
	
	public Map<String, Object> getInfoList(int pag, int row) {
		Map<String, Object> map = new HashMap<String, Object>();
		String hql = "FROM hcConfig ORDER BY handUpTime DESC";
		List<hcConfig> cList = this.gDao.findByPage(hql, Integer.valueOf(pag), Integer.valueOf(row));
		Long total = this.gDao.count(hcConfig.class,hql); //获取影响的行数，用于前台分页
		map.put("rows", cList);
		map.put("total", total);
		return map;
	}
	
	/**
	 * 重新获取航班的缓存
	 */
	public void reload(){
		List<SeatInfoData> allFilgInfo = this.gDao.find("FROM SeatInfoData"); //拿到全部的缓存航班的信息
		this.gDao.executeJDBCSql("DELETE FROM fw_hcconfig"); //清空原来的暂存表
		
		List<hcConfig> tempList = new ArrayList<hcConfig>();
		if(allFilgInfo.size()>0){
			for(SeatInfoData sd : allFilgInfo){
				boolean yesNo = true;
				for(hcConfig hc : tempList){
					if(hc.getOrgCity().equals(sd.getDwOrgCity())&&hc.getDstCity().equals(sd.getDwDstCity())){
						yesNo = false; //有重复的
						break;
					}
				}
				if(yesNo == true){ //没重复的
					hcConfig hcCon = new hcConfig();
					hcCon.setOrgCity(sd.getDwOrgCity());
					hcCon.setDstCity(sd.getDwDstCity());
					hcCon.setCreateTime(sd.getCreateTime());
					hcCon.setHcType(sd.getDayNum());
					hcCon.setOverTime(CalcuDate(sd.getCreateTime(), sd.getDayNum()));
					hcCon.setHandUpTime(new Timestamp(new Date().getTime()));
					//判断是否过期(如果过期时间在现在的时候之后，就说明还没有过期)
					if(hcCon.getOverTime().after(new Timestamp(new Date().getTime()))){
						hcCon.setIsOver("1");
					}else if(new Timestamp(new Date().getTime()).after(hcCon.getOverTime())){
						hcCon.setIsOver("0");
					}
					tempList.add(hcCon);
				}
			}
			this.gDao.save(tempList);
		}
		
	}
	
	public Map<String,Object> findfunc(int pag, int row, String orgCity, String dstCity, String goTimeSel, String isOverSel){
		Map<String, Object> map = new HashMap<String, Object>();
		String hql = "FROM hcConfig WHERE orgCity LIKE '%"+orgCity+"%' AND dstCity LIKE '%"+dstCity+"%' AND hcType LIKE '%"+goTimeSel+"%' AND isOver LIKE '%"+isOverSel+"%' ORDER BY handUpTime DESC";
		List<hcConfig> cList = this.gDao.findByPage(hql, Integer.valueOf(pag), Integer.valueOf(row));
		Long total = this.gDao.count(hcConfig.class,hql); //获取影响的行数，用于前台分页
		map.put("rows", cList);
		map.put("total", total);
		return map;
	}
	
	public void upHcTable(String chsign, SeatInfoData seatDate){
		hcConfig hcf = new hcConfig();
		hcf.setUuid(chsign);
		hcf.setOrgCity(seatDate.getDwOrgCity());
		hcf.setDstCity(seatDate.getDwDstCity());
		hcf.setCreateTime(seatDate.getCreateTime());
		hcf.setHandUpTime(new Timestamp(new Date().getTime()));
		hcf.setHcType(seatDate.getDayNum());
		hcf.setOverTime(CalcuDate(seatDate.getCreateTime(), seatDate.getDayNum()));
		if(hcf.getOverTime().after(new Timestamp(new Date().getTime()))){
			hcf.setIsOver("1");
		}else if(new Timestamp(new Date().getTime()).after(hcf.getOverTime())){
			hcf.setIsOver("0");
		}
		this.gDao.update(hcf);
	}
	
	/**
	 * 根据缓存时间设置默认查找时间
	 * @return
	 */
	public String formDate(String numDay){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();
		if(numDay.equals("1")){
			c.add(Calendar.DAY_OF_YEAR, +0);
		}else if(numDay.equals("2")){
			c.add(Calendar.DAY_OF_YEAR, +1);
		}else if(numDay.equals("3")){
			c.add(Calendar.DAY_OF_YEAR, +4);
		}else if(numDay.equals("4")){
			c.add(Calendar.DAY_OF_YEAR, +8);
		}else if(numDay.equals("5")){
			c.add(Calendar.DAY_OF_YEAR, +15);
		}else if(numDay.equals("6")){
			c.add(Calendar.DAY_OF_YEAR, +31);
		}
		Date date = c.getTime();
		String pastTime = sdf.format(date);
		return pastTime;
	}
	
	public hcConfig findByuuid(String uuid){
		List<hcConfig> hcf = this.gDao.find("FROM hcConfig WHERE uuid = '"+uuid+"'");
		return hcf.get(0);
	}
	
	//手动更新缓存时  得删除原先的数据
	public void delHcOldDate(String orgCity, String dstCity, String numDay){
		this.gDao.executeJDBCSql("DELETE FROM fw_seatinfodata WHERE dwOrgCity = '"+orgCity+"' AND dwDstCity = '"+dstCity+"' AND dayNum = '"+numDay+"'");
	}
	
	//手动增加座位航班缓存的方法
	public void upYjPrice(String orgCity, String dstCity, String date){
		List<SeatInfoData> sind = new ArrayList<SeatInfoData>();
		String dayNum = "";
		long juliDay = pointTime(date);
		if(juliDay==0){dayNum = "1";}else if(juliDay>0&&juliDay<=3){dayNum = "2";}else if(juliDay>3&&juliDay<=7){dayNum = "3";}else if(juliDay>7&&juliDay<=15){dayNum = "4";}else if(juliDay>15&&juliDay<=30){dayNum = "5";}else if(juliDay>30){dayNum = "6";}
		List<AvSegment> hsavList = null;
		hsavList = new ECUtils().av(orgCity, dstCity, date, null, null, "false", null, null, null); //查询座位可用   有中转
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
			aidata.setDwOrgCity(orgCity); //设置出发城市的组
			aidata.setDwDstCity(dstCity); //设置到达城市的组
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
			gDao.save(aidata);
			sind.add(aidata); //给下面调用的，就只有这一个作用
		}
		
		//更新管理员手动更新座位缓存表（主要是用于给管理员看的  刚刚更新是否成功的意思，没什么卵用）
		hcConfig hcf = new hcConfig();
		hcf.setOrgCity(sind.get(0).getDwOrgCity());
		hcf.setDstCity(sind.get(0).getDwDstCity());
		hcf.setCreateTime(sind.get(0).getCreateTime());
		hcf.setHandUpTime(new Timestamp(new Date().getTime()));
		hcf.setHcType(sind.get(0).getDayNum());
		hcf.setOverTime(CalcuDate(sind.get(0).getCreateTime(), sind.get(0).getDayNum()));
		if(hcf.getOverTime().after(new Timestamp(new Date().getTime()))){
			hcf.setIsOver("1");
		}else if(new Timestamp(new Date().getTime()).after(hcf.getOverTime())){
			hcf.setIsOver("0");
		}
		this.gDao.save(hcf);
		
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

	
	//根据创建时间计算过期时间
	public Timestamp CalcuDate(Timestamp creaTime, String numDay){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar c = Calendar.getInstance();
		if(numDay.equals("1")){
			c.setTime(creaTime);
			c.add(Calendar.HOUR_OF_DAY, +1);
		}else if(numDay.equals("2")){
			c.setTime(creaTime);
			c.add(Calendar.HOUR_OF_DAY, +2);
		}else if(numDay.equals("3")){
			c.setTime(creaTime);
			c.add(Calendar.HOUR_OF_DAY, +8);
		}else if(numDay.equals("4")){
			c.setTime(creaTime);
			c.add(Calendar.HOUR_OF_DAY, +24);
		}else if(numDay.equals("5")){
			c.setTime(creaTime);
			c.add(Calendar.DAY_OF_YEAR, +2);
		}else if(numDay.equals("6")){
			c.setTime(creaTime);
			c.add(Calendar.DAY_OF_YEAR, +5);
		}
		Date date = c.getTime();
		String pastTime = sdf.format(date);
		Timestamp ts = Timestamp.valueOf(pastTime);
		return ts;
	}
	
	//test
	public static void main(String[] args) {
		//Timestamp sd = Timestamp.valueOf("2016-05-25 12:20:00");
		//System.out.println(new hcConfigService().CalcuDate(sd, "2"));
		System.out.println(new hcConfigService().formDate("6"));
	}
	
}
