package com.solar.tech.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.entity.Info;
import com.solar.tech.bean.entity.Insurance;
import com.solar.tech.dao.GenericDao;

@Service
@Transactional
public class InsuranceService {
	@Resource
	private GenericDao gDao;
	
	/**
	 * 获取列表
	 * @param pag
	 * @param row
	 * @return
	 */
	public Map<String, Object> listNum(int pag, int row){
		Map<String, Object> map = new HashMap<String, Object>();
		List<Insurance> cList = this.gDao.findByPage("FROM Insurance ORDER BY createTime DESC", Integer.valueOf(pag), Integer.valueOf(row));
		Long total = this.gDao.count(Insurance.class,"FROM Insurance ORDER BY createTime DESC"); //获取影响的行数，用于前台分页
		map.put("rows", cList);
		map.put("total", total);
		return map;
	}
	
	/**
	 * 添加保险单号
	 * @param info
	 * @return
	 */
	public void addInsuran(Insurance info) {
		gDao.save(info);
	}
	
	/**
	 * 修改单号
	 * @param info
	 */
	public void upInsuran(Insurance info) {
		gDao.update(info);
	}
	
	/**
	 * 删除单号
	 */
	public void delNum(List<Insurance> info) {
		gDao.delete(info);
	}
	
	/**
	 * 查找
	 * @param title
	 * @param pag
	 * @param row
	 * @return
	 */
	public Map<String, Object> findNum(String number, int pag, int row) {
		Map<String, Object> map = new HashMap<String, Object>();
		String hql = "FROM Insurance where bxNum like '%"+number+"%' ORDER BY createTime DESC";
		List<Insurance> cList = this.gDao.findByPage(hql, Integer.valueOf(pag), Integer.valueOf(row));
		Long total = this.gDao.count(Info.class,hql); //获取影响的行数，用于前台分页
		map.put("rows", cList);
		map.put("total", total);
		return map;
	}
	
	public void upcost(String uuid,String cost){
			String sql = "UPDATE fw_insurance SET bxNum = '"+cost+"' WHERE uuid = '"+uuid+"'";
			this.gDao.executeJDBCSql(sql);
	}
}
