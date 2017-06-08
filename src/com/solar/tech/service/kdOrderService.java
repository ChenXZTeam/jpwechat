package com.solar.tech.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.entity.kdOrder;
import com.solar.tech.dao.GenericDao;

@Service
@Transactional
public class kdOrderService {
	@Resource
	private GenericDao gDao;
	
	public Map<String,Object> manlist(int page, int rows){
		Map<String,Object> map = new HashMap<String,Object>();
		List<kdOrder> cList = this.gDao.findByPage("FROM kdOrder ORDER BY createTime DESC", Integer.valueOf(page), Integer.valueOf(rows));
		Long total = this.gDao.count(kdOrder.class,"FROM kdOrder ORDER BY createTime DESC"); //获取影响的行数，用于前台分页
		map.put("rows",cList);
		map.put("total", total);
		return map;
	}
	
	public void addkdNum(kdOrder kdo){
		this.gDao.save(kdo);
	}
	
	public void upkdNum(kdOrder kdo){
		this.gDao.update(kdo);
	}
	
	public void delkdNum(List<kdOrder> kdo){
		this.gDao.delete(kdo);
	}
	
	public Map<String,Object> findBypo(int page, int rows, String orderNum, String isused){
		Map<String,Object> map = new HashMap<String,Object>();
		List<kdOrder> cList = this.gDao.findByPage("FROM kdOrder WHERE kdOrderNum LIKE '%"+orderNum+"%' AND isUsed LIKE '%"+isused+"%' ORDER BY createTime DESC", Integer.valueOf(page), Integer.valueOf(rows));
		Long total = this.gDao.count(kdOrder.class,"FROM kdOrder WHERE kdOrderNum LIKE '%"+orderNum+"%' AND isUsed LIKE '%"+isused+"%' ORDER BY createTime DESC"); //获取影响的行数，用于前台分页
		map.put("rows",cList);
		map.put("total", total);
		return map;
	}
}
