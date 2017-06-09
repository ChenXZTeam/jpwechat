package com.solar.tech.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.PhoneGroup;
import com.solar.tech.bean.PhoneNum;
import com.solar.tech.dao.GenericDao;

@Service
@Transactional
public class PhoneGroupService {
	@Resource
	private GenericDao gDao;
	
	/**
	 * 获取全部分组
	 * @param pag
	 * @param row
	 * @return
	 */
	public Map<String, Object> getInfoList() {
		Map<String, Object> map = new HashMap<String, Object>();
		String hql = "FROM PhoneGroup";
		List<PhoneGroup> cList = this.gDao.find(hql);
		map.put("rows", cList);
		return map;
	}
	
	/**
	 * 删除分组
	 * @param pg
	 */
	public void delFz(PhoneGroup pg){
		gDao.delete(pg);
	}
	
	/**
	 * 修改分组
	 */
	public void upFz(PhoneGroup pg){
		gDao.update(pg);
	}
	
	/**
	 *新增分组 
	 */
	public void saveFz(PhoneGroup pg){
		gDao.save(pg);
	}
	
	/**
	 * 修改保存分组
	 */
	public void updatefzName(PhoneGroup pg){
		gDao.update(pg);
	}
	
	/**
	 * 删除分组
	 */
	public void DeleteGroup(String uuid){
		gDao.deleteByIds(PhoneGroup.class, uuid);
	}
	
}
