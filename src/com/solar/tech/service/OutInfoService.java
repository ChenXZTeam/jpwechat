package com.solar.tech.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.entity.Info;
import com.solar.tech.bean.entity.OutInfo;
import com.solar.tech.bean.Visa;
import com.solar.tech.dao.GenericDao;

@Service
@Transactional
public class OutInfoService {
	@Resource
	private GenericDao gDao;
	
	/**
	 * 保存国际资讯数据
	 * @param outinfo
	 * @return
	 */
	public int addInfo(OutInfo outinfo) {
		try {
			gDao.save(outinfo);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	
	/**
	 * 获取国际资讯链表
	 * @param pag
	 * @param row
	 * @return
	 */
	public Map<String, Object> getInfoList(int pag, int row) {
		Map<String, Object> map = new HashMap<String, Object>();
		String hql = "FROM OutInfo out order by out.createTime desc";
		if(row==10000){
			List<Visa> iList = this.gDao.find(hql);
			map.put("iList", iList);
		}else{
			List<Info> cList = this.gDao.findByPage(hql, Integer.valueOf(pag), Integer.valueOf(row));
			Long total = this.gDao.count(OutInfo.class,hql); //获取影响的行数，用于前台分页
			map.put("rows", cList);
			map.put("total", total);
		}
		return map;
	}
	
	/**
	 * 删除国际资讯
	 * @param outinfoID
	 * @return
	 */
	public int deleteInfo(String outinfoID) {
		gDao.deleteByIds(OutInfo.class, outinfoID);
		return 1;
	}
	
	/**
	 * 功能描述：更新指定的info
	 *
	 * @param visa
	 *
	 * @return void
	 */
	public void updateInfo(OutInfo outinfo) {
		gDao.update(outinfo);
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
		String hql = "FROM OutInfo out where out.title like '%"+title+"%' ";
		List<Info> cList = this.gDao.findByPage(hql, Integer.valueOf(pag), Integer.valueOf(row));
		Long total = this.gDao.count(OutInfo.class,hql); //获取影响的行数，用于前台分页
		map.put("rows", cList);
		map.put("total", total);
		return map;
	}

	public Map<String, Object> getOutInfo() {
		Map<String, Object> map = new HashMap<String, Object>();
		String hql = "FROM OutInfo out order by out.createTime desc";
		List<OutInfo> cList = this.gDao.queryHQL(hql);
		Long total = this.gDao.count(OutInfo.class,hql); //获取影响的行数，用于前台分页
		map.put("rows", cList);
		map.put("total", total);
		
		return map;
	}

	public Map<String, Object> findOutInfoByTitle(String title) {
		Map<String, Object> map = new HashMap<String, Object>();
		String hql = "FROM OutInfo i where i.title like '%"+title+"%' ";
		List<OutInfo> cList = this.gDao.queryHQL(hql);
		Long total = this.gDao.count(OutInfo.class,hql); //获取影响的行数，用于前台分页
		map.put("rows", cList);
		map.put("total", total);
		return map;
	}
	
	/**
	 * 这个是获取最新一条的国际资讯
	 * @return
	 */
	public OutInfo getNewOutInfo(){
		OutInfo ss = new OutInfo();
		ss.setTitle("国际资讯标题获取失败");
		ss.setIntroduction("国际资讯简介获取失败");
		String hql = "FROM OutInfo ORDER BY createTime DESC";
		List<OutInfo> chInfo = new ArrayList<OutInfo>();
		try{
			chInfo = this.gDao.queryHQL(hql);
			if(chInfo.size()>0){
				ss = chInfo.get(0);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return ss;
	}

}
