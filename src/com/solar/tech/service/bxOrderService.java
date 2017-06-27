package com.solar.tech.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.entity.Insurance;
import com.solar.tech.bean.entity.bxOrder;
import com.solar.tech.bean.entity.userOrderInfo;
import com.solar.tech.dao.GenericDao;

@Service
@Transactional
public class bxOrderService {
	@Resource
	private GenericDao gDao;
	
	public Map<String,Object> manlist(int page, int rows){
		Map<String,Object> map = new HashMap<String,Object>();
		List<bxOrder> cList = this.gDao.findByPage("FROM bxOrder ORDER BY createTime DESC", Integer.valueOf(page), Integer.valueOf(rows));
		Long total = this.gDao.count(bxOrder.class,"FROM bxOrder ORDER BY createTime DESC"); //获取影响的行数，用于前台分页
		map.put("rows",cList);
		map.put("total", total);
		return map;
	}
	
	public Map<String,Object> manlist(int page, int rows, String on, String ct){
		Map<String,Object> map = new HashMap<String,Object>();
		List<bxOrder> cList = this.gDao.findByPage("FROM bxOrder WHERE orderNum LIKE '%"+on+"%' AND customer LIKE '%"+ct+"%' ORDER BY createTime DESC", Integer.valueOf(page), Integer.valueOf(rows));
		Long total = this.gDao.count(bxOrder.class,"FROM bxOrder WHERE orderNum LIKE '%"+on+"%' AND customer LIKE '%"+ct+"%' ORDER BY createTime DESC"); //获取影响的行数，用于前台分页
		map.put("rows",cList);
		map.put("total", total);
		return map;
	}
	
	public void configNum(String uuid, String yiwaiNum, String yanwuNum){
		this.gDao.executeJDBCSql("UPDATE fw_bxorder SET yiwaiNum = '"+yiwaiNum+"', yanwuNum = '"+yanwuNum+"' WHERE uuid = '"+uuid+"'");
	}
	
	public void upOrderBXnum(String orderNum, String yiwaiNum, String yanwuNum){
		this.gDao.executeJDBCSql("UPDATE userorderinfo SET yiwaiNum = '"+yiwaiNum+"', yanwuNum = '"+yanwuNum+"' WHERE orderNum = '"+orderNum+"'");
	}
	
	public List<userOrderInfo> load(){
		List<userOrderInfo> cList = this.gDao.find("FROM userOrderInfo WHERE tpStatus = '0' AND stutisPay = '1' AND (yanwuBX = '1' OR yiwaiBX = '1')");
		return cList;
	}
	
	public List<Insurance> bxMoney(){
		List<Insurance> cList = this.gDao.find("FROM Insurance WHERE uuid = '4028831c5c5d9376015c5d99512d0003' OR uuid = '4028831c5c5d9376015c5d9961200004'");
		return cList;
	}
	
	public void save(List<bxOrder> bxoder){
		this.gDao.save(bxoder);
	}
	
	public void delDate(){
		this.gDao.executeJDBCSql("delete from fw_bxorder");
	}
	
	public List<userOrderInfo> removeNotDate(List<userOrderInfo> userOrderList){
		List<userOrderInfo> usList = new ArrayList<userOrderInfo>();
		for(userOrderInfo usor : userOrderList){
			if("1".equals(usor.getYanwuBX())&&"0".equals(usor.getYiwaiBX())){ //如果购买了延误险,没有购买航意险
				if(null==usor.getYanwuNum()||"".equals(usor.getYanwuNum().trim())){ //并且还没有分配延误单号
					usList.add(usor);
				}
			}
			if("0".equals(usor.getYanwuBX())&&"1".equals(usor.getYiwaiBX())){ //如果没有购买延误险，购买了航意险
				if(null==usor.getYiwaiNum()||"".equals(usor.getYiwaiNum().trim())){ //并且还没有分配航意险单号
					usList.add(usor);
				}
			}
			if("1".equals(usor.getYanwuBX())&&"1".equals(usor.getYiwaiBX())){
				if(null==usor.getYanwuNum()||"".equals(usor.getYanwuNum().trim())||null==usor.getYiwaiNum()||"".equals(usor.getYiwaiNum().trim())){ //并且还没有分配单号
					usList.add(usor);
				}
			}
		}
		return usList;
	}
}
