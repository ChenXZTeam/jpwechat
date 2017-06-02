package com.solar.tech.service;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.entity.SeatInfoData;
import com.solar.tech.bean.entity.hcConfig;
import com.solar.tech.dao.GenericDao;

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
