package com.solar.tech.service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.entity.TravItinerary;
import com.solar.tech.bean.entity.userOrderInfo;
import com.solar.tech.dao.GenericDao;

@Service
@Transactional
public class TravItineraryService {
	@Resource
	private GenericDao gDao;

	public Map<String,Object> getList(int page,int rows){
		Map<String,Object> map = new HashMap<String,Object>();
		List<TravItinerary> cList = this.gDao.findByPage("FROM TravItinerary ORDER BY filghtDate DESC", Integer.valueOf(page), Integer.valueOf(rows));
		Long total = this.gDao.count(TravItinerary.class,"FROM TravItinerary ORDER BY filghtDate DESC"); //获取影响的行数，用于前台分页
		map.put("rows",cList);
		map.put("total", total);
		return map;
	}
	
	public void getOrderDate(){
		List<userOrderInfo> consoleOrderDate = this.gDao.find("FROM userOrderInfo WHERE isConsole = '1' AND consoleStatus = '0'"); //拿订单表中的数据
		List<TravItinerary> soleDate = this.gDao.find("FROM TravItinerary"); //拿原来存在打印表中的数据（这样做是为了防止：插入重复的数据）
		List<TravItinerary> tempList = new ArrayList<TravItinerary>();
		if(consoleOrderDate.size()>0){
			for(userOrderInfo uInfo : consoleOrderDate){
				boolean isAdd = true;
				for(TravItinerary tt : soleDate){
					if(uInfo.getID().equals(tt.getOrderUuid())){
						isAdd = false;
						break;
					}
				}
				if(isAdd==true){
					TravItinerary ttin = new TravItinerary();
					ttin.setConsoleStutas("0");
					ttin.setCreateTime(new Timestamp(new Date().getTime()));
					ttin.setFilghtDate(uInfo.getChufDate());
					ttin.setFilghtMan(uInfo.getLinkName());
					ttin.setLinkPhone(uInfo.getLinkPhoneNum());
					ttin.setOrderUuid(uInfo.getID());
					ttin.setSandAdd(uInfo.getSendAdd());
					ttin.setSandDate("2017-12-12");
					ttin.setTicketNum(uInfo.getTelNum());
					tempList.add(ttin);
				}
				
			}
			saveDate(tempList); //保存到需要打印的数据表中
		}
		
	}
	
	public void upConStutas(String uuid,String stutas){
		this.gDao.executeJDBCSql("UPDATE userorderinfo SET consoleStatus = '"+stutas+"' WHERE ID = '"+uuid+"'");
	}
	
	public void saveDate(List<TravItinerary> titra){
		this.gDao.save(titra);
	}

	public void upInfo(TravItinerary ttay){
		this.gDao.update(ttay);
	}
	
	public void delInfo(List<TravItinerary> ttay){
		this.gDao.delete(ttay);
	}
	
	public TravItinerary findOld(String uuid){
		List<TravItinerary> ty = this.gDao.find("FROM TravItinerary WHERE uuid = '"+uuid+"'");
		return ty.get(0);
	}

}
