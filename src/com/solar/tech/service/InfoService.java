package com.solar.tech.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.entity.Info;
import com.solar.tech.bean.Visa;
import com.solar.tech.dao.GenericDao;
@Service
@Transactional
public class InfoService {
	@Resource
	private GenericDao gDao;
	
	/**
	 * 保存国内资讯
	 * @param info
	 * @return
	 */
	public int addInfo(Info info) {
		try {
			gDao.save(info);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	
	/**
	 * 获取资讯链表
	 * @param pag
	 * @param row
	 * @return
	 */
	public Map<String, Object> getInfoList(int pag, int row) {
		Map<String, Object> map = new HashMap<String, Object>();
		String hql = "FROM Info i  order by i.createTime desc";
		if(row==10000){
			List<Visa> iList = this.gDao.find(hql);
			map.put("iList", iList);
		}else{
			List<Info> cList = this.gDao.findByPage(hql, Integer.valueOf(pag), Integer.valueOf(row));
			Long total = this.gDao.count(Info.class,hql); //获取影响的行数，用于前台分页
			map.put("rows", cList);
			map.put("total", total);
		}
		return map;
	}
	
	/**
	 * 删除国内资讯
	 * @param infoID
	 * @return
	 */
	public int deleteInfo(String infoID) {
		gDao.deleteByIds(Info.class, infoID);
		return 1;
	}
	
	/**
	 * 功能描述：更新指定的info
	 *
	 * @param visa
	 *
	 * @return void
	 */
	public void updateInfo(Info info) {
		gDao.update(info);
	}
	
	/**
	 * 功能描述：通过id查找Info
	 *
	 * @param id
	 *
	 * @return Visa
	 */
	public Map<String, Object> findVisa(String title, int pag, int row) {
		Map<String, Object> map = new HashMap<String, Object>();
		String hql = "FROM Info i where i.title like '%"+title+"%' ";
		List<Info> cList = this.gDao.findByPage(hql, Integer.valueOf(pag), Integer.valueOf(row));
		Long total = this.gDao.count(Info.class,hql); //获取影响的行数，用于前台分页
		map.put("rows", cList);
		map.put("total", total);
		return map;
	}

}
