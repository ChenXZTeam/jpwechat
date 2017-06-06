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

import com.solar.tech.bean.entity.Freight;
import com.solar.tech.bean.entity.SeatPriceData;
import com.solar.tech.dao.GenericDao;
import com.solar.tech.utils.ECUtils;
import com.travelsky.sbeclient.obe.response.FDItem;

@Service
@Transactional
public class FreightService {
	@Resource
	private GenericDao gDao;
	
	public Map<String, Object> getInfoList(int pag, int row) {
		Map<String, Object> map = new HashMap<String, Object>();
		String hql = "FROM Freight ORDER BY updateTime DESC";
		List<Freight> cList = this.gDao.findByPage(hql, Integer.valueOf(pag), Integer.valueOf(row));
		Long total = this.gDao.count(Freight.class,hql); //获取影响的行数，用于前台分页
		map.put("rows", cList);
		map.put("total", total);
		return map;
	}
	
	public Map<String, Object> findBySel(int pag, int row, String orgCity, String dstCity, String isOverSel) {
		Map<String, Object> map = new HashMap<String, Object>();
		String hql = "FROM Freight WHERE orgCity LIKE '%"+orgCity+"%' AND dstCity LIKE '%"+dstCity+"%' AND isOver LIKE '%"+isOverSel+"%' ORDER BY updateTime DESC";
		List<Freight> cList = this.gDao.findByPage(hql, Integer.valueOf(pag), Integer.valueOf(row));
		Long total = this.gDao.count(Freight.class,hql); //获取影响的行数，用于前台分页
		map.put("rows", cList);
		map.put("total", total);
		return map;
	}
	
	public void reloadDate(){
		
		List<Freight> fre = new ArrayList<Freight>();
		String hql = "FROM SeatPriceData";
		List<SeatPriceData> spd = this.gDao.find(hql);
		for(SeatPriceData spda : spd){
			boolean yesNo = true;
			for(Freight ffr : fre){
				if((ffr.getOrgCity().equals(spda.getOrgCity())&&ffr.getDstCity().equals(spda.getDstCity()))||ffr.getDstCity().equals(spda.getOrgCity())&&ffr.getOrgCity().equals(spda.getDstCity())){
					yesNo = false;
					break;
				}
			}
			if(yesNo == true){
				Freight frie = new Freight();
				frie.setCreateTime(spda.getCreateTime());
				frie.setDstCity(spda.getDstCity());
				frie.setOrgCity(spda.getOrgCity());
				frie.setUpdateTime(new Timestamp(new Date().getTime()));
				frie.setOverTime(CalcuDate(spda.getCreateTime()));
				//判断是否过期(如果过期时间在现在的时候之后，就说明还没有过期)
				if(frie.getOverTime().after(new Timestamp(new Date().getTime()))){
					frie.setIsOver("1");
				}else if(new Timestamp(new Date().getTime()).after(frie.getOverTime())){
					frie.setIsOver("0");
				}
				fre.add(frie);
			}
			
		}
		this.gDao.executeJDBCSql("DELETE FROM fw_freight");
		this.gDao.save(fre);
	}
	
	public Freight findByuuid(String uuid){
		List<Freight> fri = this.gDao.find("FROM Freight WHERE uuid = '"+uuid+"'");
		return fri.get(0);
	}
	
	public void delHcOldDate(String orgCity, String dstCity){
		this.gDao.executeJDBCSql("DELETE FROM fw_seatpricedata WHERE orgCity = '"+orgCity+"' AND dstCity = '"+dstCity+"'");
	}
	
	//手动更新运价的信息
	public List<SeatPriceData> upPrice(String org, String dst, String date){
		List<SeatPriceData> spList = new ArrayList<SeatPriceData>();
		try {
			List<FDItem> fdList = new ECUtils().fd(org, dst, date, null, null, null, null);
			System.out.println("符合查询中航信接口中的运价条件："+fdList.size());
			if(fdList.size()>0){
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
				System.out.println("去重之后的长度："+spList.size());
				this.gDao.save(spList);
				
				//然后更新管理员手动缓存表
				Freight frie = new Freight();
				frie.setCreateTime(spList.get(0).getCreateTime());
				frie.setDstCity(spList.get(0).getDstCity());
				frie.setOrgCity(spList.get(0).getOrgCity());
				frie.setUpdateTime(new Timestamp(new Date().getTime()));
				frie.setOverTime(CalcuDate(spList.get(0).getCreateTime()));
				//判断是否过期(如果过期时间在现在的时候之后，就说明还没有过期)
				if(frie.getOverTime().after(new Timestamp(new Date().getTime()))){
					frie.setIsOver("1");
				}else if(new Timestamp(new Date().getTime()).after(frie.getOverTime())){
					frie.setIsOver("0");
				}
				this.gDao.save(frie);
			}
		} catch (Exception e) {
			System.out.println("查询接口运价异常");
		}
		return spList;
	}
	
	public void addYjInfo(String org, String dst, String date){
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
				System.out.println("去重之后的长度："+spList.size());
				gDao.save(spList);
			}
		} catch (Exception e) {
			System.out.println("查询接口运价异常");
		}
	}
	
	public void upHcTable(String chsign, SeatPriceData sd){
		Freight frie = new Freight();
		frie.setUuid(chsign);
		frie.setCreateTime(sd.getCreateTime());
		frie.setDstCity(sd.getDstCity());
		frie.setOrgCity(sd.getOrgCity());
		frie.setUpdateTime(new Timestamp(new Date().getTime()));
		frie.setOverTime(CalcuDate(sd.getCreateTime()));
		//判断是否过期(如果过期时间在现在的时候之后，就说明还没有过期)
		if(frie.getOverTime().after(new Timestamp(new Date().getTime()))){
			frie.setIsOver("1");
		}else if(new Timestamp(new Date().getTime()).after(frie.getOverTime())){
			frie.setIsOver("0");
		}
		this.gDao.update(frie);
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
	
	//根据创建时间计算过期时间
	public Timestamp CalcuDate(Timestamp creaTime){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Calendar c = Calendar.getInstance();
			c.setTime(creaTime);
			c.add(Calendar.MONTH, 6);
			Date date = c.getTime();
			String pastTime = sdf.format(date);
			Timestamp ts = Timestamp.valueOf(pastTime);
			return ts;
	}

}
