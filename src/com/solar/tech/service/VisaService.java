package com.solar.tech.service;

import java.io.File;
import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.solar.tech.bean.Countries;
import com.solar.tech.bean.HotCountries;
import com.solar.tech.bean.RequiredMaterials;
import com.solar.tech.bean.Visa;
import com.solar.tech.bean.VisaFree;
import com.solar.tech.bean.VisaOrder;
import com.solar.tech.dao.GenericDao;
import com.solar.tech.utils.SystemOutFunc;

/**
 * 接口名：VisaService 
 *
 * 功能描述：定义了签证信息模块的抽象方法
 *
 * @author 曾令维
 *
 * Version info版本号：V1.0
 * © Copyright 续日科技 2016年7月29日  版权所有
 */
@Service
@Transactional
public class VisaService {
	@Resource
	private GenericDao gDao;
	SystemOutFunc sys = new SystemOutFunc();
	/**
	 * 功能描述：获取Visa列表 
	 *
	 * @return List<Visa>
	 */
	public Map<String, Object> getVisaList(int pag,int row){
		Map<String, Object> map = new HashMap<String, Object>();
		sys.SysOutInfo("VisaService", "45", pag+"/"+row); 
		String hql = "FROM Visa v where adminDel = 1";
		if(row==10000){
			List<Visa> vList = this.gDao.find(hql);
			map.put("vList", vList);
		}else{
			List<Visa> cList = this.gDao.findByPage(hql, Integer.valueOf(pag), Integer.valueOf(row));
			Long total = this.gDao.count(Visa.class,hql); //获取影响的行数，用于前台分页
			map.put("rows", cList);
			map.put("total", total);
		}
		return map;
	};
	
	/**
	 * 功能描述：添加新的Visa
	 *
	 * @param visa
	 *
	 * @return int
	 */
	public int addVisa(Visa visa){
		try {
			gDao.save(visa);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	
	/**
	 * 功能描述：删除所选的Visa
	 *
	 * @param ids
	 *
	 * @return int
	 */
	//int deleteVisa(String ids);
	
	/**
	 * 功能描述：更新指定的Visa
	 *
	 * @param visa
	 *
	 * @return void
	 */
	public int updateVisaSer(Visa visa){
		gDao.update(visa);
		return 1;
	}
	
	/**
	 * 功能描述：根据条件查找指定的Visa
	 *
	 * @param visa
	 *
	 * @return List<Visa>
	 */
	public List<Visa> findByCountry(String countId){
		List<Visa> vList = new ArrayList<Visa>();
		String hql = "FROM Visa v where v.countryID = '"+countId+"'";
		vList = this.gDao.find(hql);
		return vList;
	};
	
	/**
	 * 功能描述：通过id查找Visa
	 *
	 * @param id
	 *
	 * @return Visa
	 */
	public Map<String, Object> findVisa(String countryName,int pag,int row){
		Map<String, Object> map = new HashMap<String, Object>();
		//List<Visa> vList = new ArrayList<Visa>();
		String hql = "FROM Visa v where v.country like '%"+countryName+"%'";
		//vList = this.gDao.find(hql);
		List<Visa> cList = this.gDao.findByPage(hql, Integer.valueOf(pag), Integer.valueOf(row));
		Long total = this.gDao.count(Visa.class,hql); //获取影响的行数，用于前台分页
		sys.SysOutInfo("VisaService", "128", total+"/=========/"+cList); 
		map.put("rows", cList);
		map.put("total", total);
		sys.SysOutInfo("VisaService", "131", map.toString()); 
		return map;
	};
	
	/**
	 * 功能描述：通过id查找指定的VisaFree记录
	 *
	 * @param id
	 *
	 * @return VisaFree
	 */
	//VisaFree findByVisaFreeID(String id);
	
	/**
	 * 功能描述：从数据库中获取VisaFree列表
	 *
	 * @return List<VisaFree>
	 */
	//List<VisaFree> getVisaFreeList();
	
	/**
	 * 功能描述：在数据库中新增一个VisaFree记录
	 *
	 * @param visaFree
	 *
	 * @return Serializable
	 */
	//Serializable addVisaFree(VisaFree visaFree);
	
	/**
	 * 功能描述：在数据库中更新一条指定的VisaFree记录
	 *
	 * @param visaFree
	 *
	 * @return void
	 */
	//void updateVisaFree(VisaFree visaFree);
	
	/**
	 * 功能描述：删除国家列表里面的一条数据
	 * @param orderNum
	 * @return
	 */
	public int deleteOrder(String countryID) {
		try {
			if(countryID != null){
				String sql = "UPDATE fw_visa SET adminDel = 0 WHERE countryID = '"+countryID+"'";
				gDao.executeJDBCSql(sql);
			}
			return 1; 
		}catch (Exception e) {
			return -1;
		}
	}
	
	/**
	 * 功能描述：在数据库中添加新的RequiredMaterials记录
	 *
	 * @param requiredMaterials
	 *
	 * @return Serializable
	 */
	//Serializable addRequiredMaterials(RequiredMaterials requiredMaterials);
	
	/**
	 * 功能描述：获取RequiredMaterials列表
	 *
	 * @return List<RequiredMaterials>
	 */
	//List<RequiredMaterials> getRequiredMaterialsList();
	
	/**
	 * 功能描述：更新指定的RequiredMaterials
	 *
	 * @param requiredMaterials
	 *
	 * @return void
	 */
	//void updateRequiredMaterials(RequiredMaterials requiredMaterials);
	
	/**
	 * 功能描述：从数据库中删除指定的RequiredMaterials
	 *
	 * @param ids
	 *
	 * @return int
	 */
	//int deleteRequiredMaterials(String ids);
	
	/**
	 * 功能描述：通过ID查找RequiredMaterials
	 *
	 * @param id
	 *
	 * @return RequiredMaterials
	 */
	//RequiredMaterials findByMaterialsID(String id);
	
	/**
	 * 功能描述：添加新的VisaOrder记录
	 *
	 * @param visaOrder
	 *
	 * @return int
	 */
	public int addVisaOrder(VisaOrder visaOrder){
		try {
			gDao.save(visaOrder);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	
	/**
	 * @title 查找最新插入的数据
	 * @return map
	 */
	public int fingMaxNum(){
		 String hql = "SELECT MAX(uinfo.newOrderNum) FROM VisaOrder as uinfo";
		 List<Integer> MaxorderNum = this.gDao.find(hql);
		 if(MaxorderNum.get(0)==null){
			 return 0;
		 }else{
			 int MaxNum = MaxorderNum.get(0);
			 return MaxNum;
		 }
	}
	
	/**
	 * @title 查找最大的编号
	 * @return map
	 */
	public String fingMaxOrderNum(){ 
		 String hql = "SELECT (uOrder.orderNum) FROM VisaOrder as uOrder WHERE newOrderNum = (SELECT MAX(uinfo.newOrderNum) FROM VisaOrder as uinfo)";
		 List<String> MaxorderNum = this.gDao.find(hql);
		 if(MaxorderNum.size()==0){
			 return null;
		 }else{
			 String MaxNum = MaxorderNum.get(0);
			 return MaxNum;
		 }
	}
	
	/**
	 * 查找最新插入数据的最大编号用于生成国家编号
	 * @return
	 */
	public int fingMaxNumVisa(){
		 String hql = "SELECT MAX(uinfo.newDataNum) FROM Visa as uinfo";
		 List<Integer> MaxorderNum = this.gDao.find(hql);
		 if(MaxorderNum.get(0)==null){
			 return 0;
		 }else{
			 int MaxNum = MaxorderNum.get(0);
			 return MaxNum;
		 }
	}
	
	/**
	 * 自动生成国家编号的方法。因为有的国家有中文和英文多种语言的名字。所以用编号来代替该国家
	 * @return
	 */
	public String bornCountryNum(int num){
		String countryNum = "";
		 int zeroNum = 5-(num+"").length();
		 for(int i=0;i<zeroNum;i++){
			 countryNum += "0";
		 }
		return "1"+countryNum+""+num;
	}
	
	/**
	 * 功能描述：获取VisaOrder列表
	 *
	 * @return
	 *
	 * @return List<VisaOrder>
	 */
	public Map<String, Object> getVisaOrderList(int pag,int row){
		Map<String, Object> map = new HashMap<String, Object>();
		sys.SysOutInfo("VisaService", "312", pag+"/"+row); 
		String hql = "FROM VisaOrder v WHERE deleteSige = '1'";
		List<VisaOrder> cList = this.gDao.findByPage(hql, Integer.valueOf(pag), Integer.valueOf(row));
		Long total = this.gDao.count(VisaOrder.class,hql); //获取影响的行数，用于前台分页
		map.put("rows", cList);
		map.put("total", total);
		return map;
	}
	
	/**
	 * 功能描述：更新指定的VisaOrder
	 *
	 * @param visaOrder
	 *
	 * @return void
	 */
	//void updateVisaOrder(VisaOrder visaOrder);
	public int updateVisaOrder(VisaOrder visaOrder){
		gDao.update(visaOrder);
		return 1;
	}
	/**
	 * 功能描述：删除指定的VisaOrder
	 *
	 * @param ids
	 *
	 * @return int
	 */
	public int deleteVisaOrder(String orderNum){
		try {
			if(orderNum != null){
				String sql = "UPDATE fw_visaorder SET deleteSige = 0 WHERE orderNum = '"+orderNum+"'";
				gDao.executeJDBCSql(sql);
			}
			return 1; 
		}catch (Exception e) {
			return -1;
		}
	}
	
	/**
	 * 功能描述：根据用户ID查找订单列表
	 *
	 * @param visaOrder
	 *
	 * @return List<VisaOrder>
	 */
	//List<VisaOrder> findByUserID(VisaOrder visaOrder);
	
	/**
	 * 功能描述：根据订单ID查找订单
	 *
	 * @param id
	 *
	 * @return VisaOrder
	 */
	//VisaOrder findByVisaOrderID(String id);
	
	/**
	 * 功能描述：添加新的HotCountries
	 *
	 * @param hotCountries
	 * @param image
	 *
	 * @return Serializable
	 */
	//Serializable addHotCountries(HotCountries hotCountries,MultipartFile image);
	
	/**
	 * 功能描述：获取HotCountries列表
	 *
	 * @return List<HotCountries>
	 */
	//List<HotCountries> getHotCountriesList();
	
	/**
	 * 功能描述：更新指定的HotCountries
	 *
	 * @param hotCountries
	 * @param image
	 * @param imgOld
	 *
	 * @return void
	 */
	//void updateHotCountries(HotCountries hotCountries,MultipartFile image,String imgOld);
	
	/**
	 * 功能描述：删除指定的HotCountries
	 *
	 * @param ids
	 *
	 * @return int
	 */
	//int deleteHotCountries(String ids);
	
}
