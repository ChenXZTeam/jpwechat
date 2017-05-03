package com.solar.tech.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.entity.Info;
import com.solar.tech.dao.GenericDao;
import com.solar.tech.utils.PassSend;
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
			List<Info> iList = this.gDao.find(hql);
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
	 * 功能描述：通过title查找Info
	 *
	 * @param id
	 *
	 * @return Info
	 */
	public Map<String, Object> findVisa(String title, int pag, int row) {
		Map<String, Object> map = new HashMap<String, Object>();
		String hql = "FROM Info i where i.title like '%"+title+"%' order by i.createTime desc";
		List<Info> cList = this.gDao.findByPage(hql, Integer.valueOf(pag), Integer.valueOf(row));
		Long total = this.gDao.count(Info.class,hql); //获取影响的行数，用于前台分页
		map.put("rows", cList);
		map.put("total", total);
		return map;
	}

	/**
	 * 功能描述：获得国内资讯
	 *
	 * @param id
	 *
	 * @return Info
	 */
	public Map<String, Object> getInfo() {
		Map<String, Object> map = new HashMap<String, Object>();
		String hql = "FROM Info i  order by i.createTime desc";
		List<Info> cList = this.gDao.queryHQL(hql);
		Long total = this.gDao.count(Info.class,hql); //获取影响的行数，用于前台分页
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
		String hql = "FROM Info i where i.infoID = '"+ID+"' ";
		List<Info> cList = this.gDao.queryHQL(hql);
		map.put("rows", cList);
		return map;
	}
	
	/**
	 * 这个是获取最新一条的国内资讯
	 * @return
	 */
	public Info getNewInfo(){
		Info ss = new Info();
		ss.setTitle("国内资讯数据为空");
		ss.setIntroduction("国内资讯数据为空");
		String hql = "FROM Info ORDER BY createTime DESC";
		List<Info> chInfo = new ArrayList<Info>();
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
