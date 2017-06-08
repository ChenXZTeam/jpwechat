package com.solar.tech.service.framework;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.entity.phoneMess;
import com.solar.tech.bean.entity.userOrderInfo;
import com.solar.tech.dao.GenericDao;

@Service
@Transactional
public class JP_orderService {
	@Resource
	private GenericDao gDao;
	/**
	 * 加载用户订单
	 * @param userName
	 * @param openId
	 * @return
	 */
	public Map<String, Object> loadOrder(int pag,int row){
		Map<String, Object> map = new HashMap<String, Object>();
		String hql = "FROM userOrderInfo u where AdminDel = 0 order by u.createTime desc";
		if(row==10000){
			List<userOrderInfo> vList = this.gDao.find(hql);
			map.put("vList", vList);
		}else{
			List<userOrderInfo> cList = this.gDao.findByPage(hql, Integer.valueOf(pag), Integer.valueOf(row));
			Long total = this.gDao.count(userOrderInfo.class,hql); //获取影响的行数，用于前台分页
			map.put("rows", cList);
			map.put("total", total);
			System.out.println("总数据："+total);
		}
		return map;
	}
	
	/**
	 * 
	 * @param countId
	 * @return
	 */
	public Map<String, Object>  findByInfo(int pag, int row, String Info){
		Map<String, Object> map = new HashMap<String, Object>();
		String hql = "FROM userOrderInfo u where u.IDcase like '%"+Info+"%' OR u.orderNum like '%"+Info+"%' OR u.telNum like '%"+Info+"%' order by u.createTime desc";
		List<userOrderInfo> vList = this.gDao.findByPage(hql, Integer.valueOf(pag), Integer.valueOf(row));
		Long total = this.gDao.count(userOrderInfo.class,hql); //获取影响的行数，用于前台分页
		map.put("rows", vList);
		map.put("total", total);
		return map;
	};
	
	/**
	 * 获取短信发送的列表
	 * @param page
	 * @param rows
	 * @return
	 */
	public Map<String, Object> otindPhoneMes(int page,int rows){
		Map<String, Object> map = new HashMap<String, Object>();
	    String hql = "FROM phoneMess ORDER BY createTime DESC";
	    List<phoneMess> orders = this.gDao.findByPage(hql, Integer.valueOf(page), Integer.valueOf(rows));	    
	    Long total = this.gDao.count(phoneMess.class,hql); //获取影响的行数，用于前台分页
	    map.put("rows", orders);
	    map.put("total", total);
	    return map;
	}
	
	/**
	 * 查找短信的信息
	 * @return
	 */
	public Map<String, Object> findPhoneMes(String phoneNumber,int page,int rows){
		Map<String, Object> map = new HashMap<String, Object>();
		String hql = "FROM phoneMess WHERE phoneNumber like '%"+phoneNumber+"%'ORDER BY createTime DESC";
		List<phoneMess> orders = this.gDao.findByPage(hql, Integer.valueOf(page), Integer.valueOf(rows));	    
	    Long total = this.gDao.count(phoneMess.class,hql); //获取影响的行数，用于前台分页
	    map.put("rows", orders);
	    map.put("total", total);
		return map;
	}
	
	public Map<String,Object> findbyid(String uuid){
		Map<String,Object> map = new HashMap<String,Object>();
		List<userOrderInfo> orList = this.gDao.find("FROM userOrderInfo WHERE ID = '"+uuid+"'");
		map.put("dateStr", orList);
		return map;
	}
	
	/**
	 * 记录短信发送的方法
	 */
	public void savaPhoneMess(phoneMess ph) {
		try {
			gDao.save(ph);
		} catch (Exception e) {
		}
	}
	
}
