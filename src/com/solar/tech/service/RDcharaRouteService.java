package com.solar.tech.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.entity.CharaRoute;
import com.solar.tech.dao.GenericDao;
import com.solar.tech.utils.PassSend;


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
	
	/**
	 * 删除数据
	 */
	public int deleteRoute(String routeiD) {
		gDao.deleteByIds(CharaRoute.class, routeiD);
		return 1;
	}
	
	/**
	 * 修改数据
	 */
	public void updateRoute(CharaRoute charaRoute) {
		gDao.update(charaRoute);
	}

	/**
	 * 查找数据用于后台管理员中的查找
	 */
	public Map<String, Object> findRoute(String title, int pag, int row) {
		Map<String, Object> map = new HashMap<String, Object>();
		String hql = "FROM CharaRoute c where c.title like '%"+title+"%' ";
		List<CharaRoute> cList = this.gDao.findByPage(hql, Integer.valueOf(pag), Integer.valueOf(row));
		Long total = this.gDao.count(CharaRoute.class,hql); //获取影响的行数，用于前台分页
		map.put("rows", cList);
		map.put("total", total);
		return map;
	}
	
	/**
	 * 通过id进行查找资讯 用于微信前端
	 * @param title
	 * @return
	 */
	public Map<String, Object> findInfoByID(String ID) {
		Map<String, Object> map = new HashMap<String, Object>();
		String hql = "FROM CharaRoute i where i.routeID = '"+ID+"' ";
		List<CharaRoute> cList = this.gDao.queryHQL(hql);
		map.put("rows", cList);
		return map;
	}
	
	/**
	 * 这个是获取最新一条的特色路线资讯
	 * @return
	 */
	public CharaRoute getCharaRoute(){
		CharaRoute ss = new CharaRoute();
		ss.setTitle("特色路线数据为空");
		ss.setIntroduction("特色路线数据为空");
		String hql = "FROM CharaRoute ORDER BY createTime DESC";
		List<CharaRoute> chInfo = new ArrayList<CharaRoute>();
		try{
			chInfo = this.gDao.queryHQL(hql);
			if(chInfo.size()>0){
				ss = chInfo.get(0);
				ss.setWebPath(PassSend.webPath());
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return ss;
	}
}
