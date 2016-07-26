package com.solar.tech.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.entity.userOrderInfo;
import com.solar.tech.dao.GenericDao;

/**
 * @title 执行订单数据的service方法
 * @author solarpc1
 *
 */
@Service
@Transactional
public class userOrderService {
	@Resource
	private GenericDao gDao;
	/**
	 * @Title addOrder(用户的订票订单)
	 * @param orderInfo
	 * @return
	 */
	public int addOrder(userOrderInfo orderInfo){
		try {
			gDao.save(orderInfo);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	
	/**
	 * 
	 * @return map
	 */
	public String fingMaxOrderNum(){
		 String hql = "SELECT (uOrder.orderNum) FROM userOrderInfo as uOrder WHERE intNum = (SELECT MAX(uinfo.intNum) FROM userOrderInfo as uinfo)";
		 List<String> MaxorderNum = this.gDao.find(hql);
		 String MaxNum = MaxorderNum.get(0);
		 return MaxNum;
	}
	
	/**
	  * 
	  * 在用此类时，必须先明确自己模块编号的开头
	  * @param start编号开头，
	  * @param num从数据库查询出的最大编号
	  * @return
	  */
	 public String getNum(String start,String num){
		  //String n=num.substring(0,4);
		  String strDate="";//流水号时间
		  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		  Date date = new Date();
		  //格式化当前时间，并按字符'-'分割
		  String[] sd=sdf.format(date).split("-");
		  //截取编号中的日期
		  String time=num.substring(4,12).toString();
		  for(int i=0;i<sd.length;i++){
			  strDate+=sd[i];
		  }
		  //如果当天或者表中没有记录，返回当天第一条记录
		  if(!time.equals(strDate)||num.equals("")||num==null||num==""){
			  String numNo=start+strDate+"000001";
			  return numNo;
		  }
		  // 截取编号最后的流水号
		  String end=num.substring(12, 18);
		  String s2="";
		  int lg=Integer.parseInt(end);
		  //对流水号结尾的四位数字进行判断，以便增加
		  if(lg>0&&lg<9){
			  s2="00000"+(lg+1);
		  }else if(lg>=9&&lg<99){
			  s2="0000"+(lg+1);
		  }else if(lg>=99&&lg<999){
			  s2="000"+(lg+1);
		  }else if(lg>=999&&lg<9999){
			  s2="00"+(lg+1);
		  }else if(lg>=9999&&lg<99999){
			  s2="0"+(lg+1);
		  }else if(lg>=99999&&lg<999999){
			  s2=""+(lg+1);
		  }else{
			  System.out.println("当天生成的预约编号已满");
		  }
		  //返回自动生成后的流水号
		  return start+=strDate+s2;
	}
}
