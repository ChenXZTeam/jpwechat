package com.solar.tech.service;

import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.entity.userOrderInfo;
import com.solar.tech.dao.GenericDao;


@Service
@Transactional
public class SellDateService {
	
	@Resource
	private GenericDao gDao;
	
	public List<userOrderInfo> find(String ltime,String TTime) throws ParseException{
		String ctime=ltime+" "+"00:00:00";
		String dtime=TTime+" "+"24:59:59";
		String hql="FROM userOrderInfo WHERE createTime >='"+ctime+"' and createTime <='"+dtime+"'";
		//System.out.println(hql);
		List<userOrderInfo> Orders=this.gDao.find(hql);
		//System.out.println(Orders);
		return Orders;
		
	}
	
	public List<userOrderInfo> chazhao(){
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat ss=new SimpleDateFormat("yyyy-MM");
		String ptime=df.format(new Date());
		String pmonth=ss.format(new Date());
		String ppmonth=pmonth+"-"+"01"+" "+"00:00:00";
		String pptime=ptime+" "+"24:59:59";
		String hql="FROM userOrderInfo WHERE createTime >='"+ppmonth+"' and createTime<='"+pptime+"'";
		//System.out.println(hql);
		List<userOrderInfo> Orders=this.gDao.find(hql);
		return Orders;
		
		
	}
	
         
        
  
}
