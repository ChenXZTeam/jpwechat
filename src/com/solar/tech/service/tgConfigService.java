package com.solar.tech.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.entity.tgConfig;
import com.solar.tech.dao.GenericDao;

@Service
@Transactional
public class tgConfigService {
	@Resource
	private GenericDao gDao;
	
	public Map<String, Object> getInfoList(int pag, int row) {
		Map<String, Object> map = new HashMap<String, Object>();
		String hql = "FROM tgConfig  ORDER BY upTime DESC";
		List<tgConfig> cList = this.gDao.findByPage(hql, Integer.valueOf(pag), Integer.valueOf(row));
		Long total = this.gDao.count(tgConfig.class,hql); //获取影响的行数，用于前台分页
		map.put("rows", cList);
		map.put("total", total);
		return map;
	}
	
	public Map<String, Object> getInfoList(int pag, int row,String keyValue) {
		Map<String, Object> map = new HashMap<String, Object>();
		String hql = "FROM tgConfig WHERE airCode = '"+keyValue+"' ORDER BY upTime DESC";
		List<tgConfig> cList = this.gDao.findByPage(hql, Integer.valueOf(pag), Integer.valueOf(row));
		Long total = this.gDao.count(tgConfig.class,hql); //获取影响的行数，用于前台分页
		map.put("rows", cList);
		map.put("total", total);
		return map;
	}
	
	public void addInfo(tgConfig tgCon){
		this.gDao.save(tgCon);
	}
	
	public void upInfo(tgConfig tgCon){
		this.gDao.update(tgCon);
	}
	
	public void delInfo(List<tgConfig> tgCon){
		this.gDao.delete(tgCon);
	}
	
}
