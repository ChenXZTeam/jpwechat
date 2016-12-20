package com.solar.tech.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.entity.CharaRoute;
import com.solar.tech.bean.entity.Info;
import com.solar.tech.dao.GenericDao;


@Service
@Transactional
public class RDcharaRouteService {
	@Resource
	private GenericDao gDao;
	
	/**
	 * 保存特色路线
	 * @param route
	 * @return
	 */
	public int saveRoute(CharaRoute route){
		try{
			gDao.save(route);
			return 1;
		}catch(Exception e){
			return 0;
		}
	}
	
	/**
	 * 获取全部的数据
	 * @return
	 */
	public Map<String, Object> getlist(int page, int rows){
		Map<String, Object> map = new HashMap<String, Object>();
		String hql = "FROM CharaRoute ORDER BY createTime DESC";
		List<CharaRoute> chRoute = this.gDao.findByPage(hql, Integer.valueOf(page), Integer.valueOf(rows));
		Long total = this.gDao.count(CharaRoute.class,hql); //获取影响的行数，用于前台分页
		map.put("rows", chRoute);
		map.put("total", total);
		return map;
	}
}
