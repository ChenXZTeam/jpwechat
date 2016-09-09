package com.solar.tech.service;

import java.io.File;
import java.io.Serializable;
import java.util.List;

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
	/**
	 * 功能描述：获取Visa列表 
	 *
	 * @return List<Visa>
	 */
	//List<Visa> getVisaList();
	
	/**
	 * 功能描述：添加新的Visa
	 *
	 * @param visa
	 *
	 * @return Serializable
	 */
	//Serializable addVisa(Visa visa);
	
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
	//void updateVisa(Visa visa);
	
	/**
	 * 功能描述：根据条件查找指定的Visa
	 *
	 * @param visa
	 *
	 * @return List<Visa>
	 */
	//List<Visa> findByCountry(Visa visa);
	
	/**
	 * 功能描述：通过id查找Visa
	 *
	 * @param id
	 *
	 * @return Visa
	 */
	//Visa findByID(String id);
	
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
	 * 功能描述：在数据库中删除指定的VisaFree
	 *
	 * @param ids
	 *
	 * @return int
	 */
	//int deleteVisaFree(String ids);
	
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
	public String fingMaxNum(){
		 String hql = "SELECT MAX(uinfo.newOrderNum) FROM VisaOrder as uinfo";
		 List<String> MaxorderNum = this.gDao.find(hql);
		 String MaxNum = MaxorderNum.get(0);
		 return MaxNum;
	}
	
	/**
	 * @title 查找最大的编号
	 * @return map
	 */
	public String fingMaxOrderNum(){ 
		 String hql = "SELECT (uOrder.orderNum) FROM VisaOrder as uOrder WHERE newOrderNum = (SELECT MAX(uinfo.newOrderNum) FROM VisaOrder as uinfo)";
		 List<String> MaxorderNum = this.gDao.find(hql);
		 String MaxNum = MaxorderNum.get(0);
		 return MaxNum;
	}
	
	/**
	 * 功能描述：获取VisaOrder列表
	 *
	 * @return
	 *
	 * @return List<VisaOrder>
	 */
	//List<VisaOrder> getVisaOrderList();
	
	/**
	 * 功能描述：更新指定的VisaOrder
	 *
	 * @param visaOrder
	 *
	 * @return void
	 */
	//void updateVisaOrder(VisaOrder visaOrder);
	
	/**
	 * 功能描述：删除指定的VisaOrder
	 *
	 * @param ids
	 *
	 * @return int
	 */
	//int deleteVisaOrder(String ids);
	
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
