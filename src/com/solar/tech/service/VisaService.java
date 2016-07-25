package com.solar.tech.service;

import java.io.Serializable;
import java.util.List;

import com.solar.tech.bean.Countries;
import com.solar.tech.bean.RequiredMaterials;
import com.solar.tech.bean.Visa;
import com.solar.tech.bean.VisaFree;
import com.solar.tech.bean.VisaOrder;

public interface VisaService {
	
	//获取Visa列表
	List<Visa> getVisaList();
	
	//添加新的Visa
	Serializable addVisa(Visa visa);
	
	//删除所选的Visa
	int deleteVisa(String ids);
	
	//更新指定的Visa
	void updateVisa(Visa visa);
	
	//查找指定的Visa
	List<Visa> findByCountry(Visa visa);
	
	//通过id查找Visa
	Visa findByID(String id);
	
	//通过id差值VisaFree
	VisaFree findByVisaFreeID(String id);
	
	//获取VisaFree列表
	List<VisaFree> getVisaFreeList();
	
	//新增一个VisaFree
	Serializable addVisaFree(VisaFree visaFree);
	
	//更新指定的VisaFree
	void updateVisaFree(VisaFree visaFree);
	
	//删除指定的VisaFree
	int deleteVisaFree(String ids);
	
	//添加新的RequiredMaterials
	Serializable addRequiredMaterials(RequiredMaterials requiredMaterials);
	
	//获取RequiredMaterials列表
	List<RequiredMaterials> getRequiredMaterialsList();
	
	//更新指定的RequiredMaterials
	void updateRequiredMaterials(RequiredMaterials requiredMaterials);
	
	//删除指定的RequiredMaterials
	int deleteRequiredMaterials(String ids);
	
	//通过ID查找RequiredMaterials
	RequiredMaterials findByMaterialsID(String id);
	
	//添加新的VisaOrder
	Serializable addVisaOrder(VisaOrder visaOrder);
	
	//获取VisaOrder列表
	List<VisaOrder> getVisaOrderList();
	
	//更新指定的VisaOrder
	void updateVisaOrder(VisaOrder visaOrder);
	
	//删除指定的VisaOrder
	int deleteVisaOrder(String ids);
	
}
