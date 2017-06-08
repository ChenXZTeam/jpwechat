package com.solar.tech.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.entity.bxOrder;
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
	
	public void configNum(String uuid, String numStr){
		this.gDao.executeJDBCSql("UPDATE fw_bxorder SET bxNum = '"+numStr+"' WHERE uuid = '"+uuid+"'");
	}
}
