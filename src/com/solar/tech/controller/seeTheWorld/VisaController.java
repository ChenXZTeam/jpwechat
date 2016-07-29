package com.solar.tech.controller.seeTheWorld;

import java.io.File;
import java.io.Serializable;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.solar.tech.bean.HotCountries;
import com.solar.tech.bean.RequiredMaterials;
import com.solar.tech.bean.Visa;
import com.solar.tech.bean.VisaFree;
import com.solar.tech.bean.VisaOrder;
import com.solar.tech.service.VisaService;

/**
 * 类名：VisaController 
 *
 * 功能描述：签证信息模块的Controller类，负责接收、处理和分发签证信息模块的请求
 *
 * @author 曾令维
 *
 * Version info版本号：V1.0
 * © Copyright 续日科技 2016年7月29日  版权所有
 */
@Controller
@RequestMapping("/framework/visa")
public class VisaController {
	
	@Resource
	private VisaService visaService;
	
	/**
	 * 功能描述：获取Visa列表 并返回到前端
	 *
	 * @return List<Visa>
	 */
	@RequestMapping("/getVisaList.action")
	@ResponseBody
	public List<Visa> getVisaList(){
		return this.visaService.getVisaList();
	}

	/**
	 * 功能描述：从前台接收到Visa对象并把它存到数据库中，然后将执行结果返回前端
	 *
	 * @param visa
	 *
	 * @return Serializable
	 */
	@RequestMapping("/addVisa.action")
	@ResponseBody
	public Serializable addVisa(Visa visa){
		return this.visaService.addVisa(visa);
	}
	
	/**
	 * 功能描述：接收前端传来的id并到数据库中找到相应的Visa对象将其删除，
	 * 把执行结果返回前端
	 *
	 * @param ids
	 * @return
	 *
	 * @return int
	 */
	@RequestMapping("/deleteVisa.action")
	@ResponseBody
	public int deleteVisa(String ids){
		return this.visaService.deleteVisa(ids);
	}
	
	/**
	 * 功能描述：接收前端传来的visa对象，根据id在数据库中更新此对象
	 *
	 * @param visa
	 *
	 * @return void
	 */
	@RequestMapping("/updateVisa.action")
	@ResponseBody
	public void updateVisa(Visa visa){
		this.visaService.updateVisa(visa);
	}
	
	/**
	 * 功能描述：根据国家域名代码查找相应的Visa对象并将结果传到VisaList.jsp页面
	 *
	 * @param visa
	 * @param map
	 *
	 * @return String
	 */
	@RequestMapping("/findByCountry.action")
	public String findByCountry(Visa visa,Map map){
		List<Visa> list = this.visaService.findByCountry(visa);
		map.put("list", list);
		return "/SeeTheWorld/VisaList";
	}
	
	/**
	 * 功能描述：接收前端传来的ID并根据此ID找到对应的Visa对象传到VisaContent.jsp页面
	 *
	 * @param id
	 * @param map
	 *
	 * @return String
	 */
	@RequestMapping("/findByID.action")
	public String findByID(String id,Map map){
		Visa visa = this.visaService.findByID(id);
		map.put("visa", visa);
		return "/SeeTheWorld/VisaContent";
	}

	/**
	 * 功能描述：接收前端传来的ID并根据ID找到对应的VisaFree对象，然后将结果传到VisaFreeContent.jsp页面
	 *
	 * @param id
	 * @param map
	 *
	 * @return String
	 */
	@RequestMapping("/findByVisaFreeID.action")
	public String findByVisaFreeID(String id,Map map){
		VisaFree visaFree = this.visaService.findByVisaFreeID(id);
		map.put("visaFree", visaFree);
		return "/SeeTheWorld/VisaFreeContent";
	}
	
	/**
	 * 功能描述：查找到所有VisaFree对象并将结果返回到前端
	 *
	 * @return List<VisaFree>
	 */
	@RequestMapping("/getVisaFreeList.action")
	@ResponseBody
	public List<VisaFree> getVisaFreeList(){
		return this.visaService.getVisaFreeList();
	}

	/**
	 * 功能描述：接收前端传来的VisaFree对象并将其存到数据库中，然后返回执行结果到前端
	 *
	 * @param visaFree
	 *
	 * @return Serializable
	 */
	@RequestMapping("/addVisaFree.action")
	@ResponseBody
	public Serializable addVisaFree(VisaFree visaFree){
		return this.visaService.addVisaFree(visaFree);
	}
	
	/**
	 * 功能描述：接收前端传来的VisaFree对象然后在数据库中找到相应的VisaFree记录并对其更新
	 *
	 * @param visaFree
	 *
	 * @return void
	 */
	@RequestMapping("/updateVisaFree.action")
	@ResponseBody
	public void updateVisaFree(VisaFree visaFree){
		this.visaService.updateVisaFree(visaFree);
	}
	
	/**
	 * 功能描述：接收前端传来的ID再根据这些ID在数据库中找到相应的记录将其删除，然后返回执行结果到前端
	 *
	 * @param ids
	 *
	 * @return int
	 */
	@RequestMapping("/deleteVisaFree.action")
	@ResponseBody
	public int deleteVisaFree(String ids){
		return this.visaService.deleteVisaFree(ids);
	}
	
	/**
	 * 功能描述：查找到所有VisaOrder的记录并接结果返回到前端
	 *
	 * @return List<VisaOrder>
	 */
	@RequestMapping("/getVisaOrderList.action")
	@ResponseBody
	public List<VisaOrder> getVisaOrderList(){
		return this.visaService.getVisaOrderList();
	}
	
	/**
	 * 功能描述：接收前端传来的VisaOrder对象将其添加到数据库中，然后返回执行结果到前端
	 *
	 * @param visaOrder
	 *
	 * @return Serializable
	 */
	@RequestMapping("/addVisaOrder.action")
	@ResponseBody
	public Serializable addVisaOrder(VisaOrder visaOrder){
		return this.visaService.addVisaOrder(visaOrder);
	}
	
	/**
	 * 功能描述：根据前端传过来的VisaOrder对象从数据库找到对应的VisaOrder对象将其更新
	 *
	 * @param visaOrder
	 *
	 * @return void
	 */
	@RequestMapping("/updateVisaOrder.action")
	@ResponseBody
	public void updateVisaOrder(VisaOrder visaOrder){
		this.visaService.updateVisaOrder(visaOrder);
	}
	
	/**
	 * 功能描述：根据前端传过来的ID找到对应的VisaOrder对象并将其删除，返回执行结果到前端
	 *
	 * @param ids
	 *
	 * @return int
	 */
	@RequestMapping("/deleteVisaOrder.action")
	@ResponseBody
	public int deleteVisaOrder(String ids){
		return this.visaService.deleteVisaOrder(ids);
	}

	/**
	 * 功能描述：查找到所有RequiredMaterials对象并将结果返回到前端
	 *
	 * @return List<RequiredMaterials>
	 */
	@RequestMapping("/getRequiredMaterialsList.action")
	@ResponseBody
	public List<RequiredMaterials> getRequiredMaterialsList(){
		return this.visaService.getRequiredMaterialsList();
	}
	
	/**
	 * 功能描述：接收前端传来的RequiredMaterials对象并将其保存，返回执行结果到前端
	 *
	 * @param requiredMaterials
	 *
	 * @return Serializable
	 */
	@RequestMapping("/addRequiredMaterials.action")
	@ResponseBody
	public Serializable addRequiredMaterials(RequiredMaterials requiredMaterials){
		return this.visaService.addRequiredMaterials(requiredMaterials);
	}
	
	/**
	 * 功能描述：接收前端传来的RequiredMaterials对象，
	 * 并在数据库中找到对应的RequiredMaterials对象将其更新
	 *
	 * @param requiredMaterials
	 *
	 * @return void
	 */
	@RequestMapping("/updateRequiredMaterials.action")
	@ResponseBody
	public void updateRequiredMaterials(RequiredMaterials requiredMaterials){
		this.visaService.updateRequiredMaterials(requiredMaterials);
	}
	
	/**
	 * 功能描述：根据前端传来的ID找到对应的MaterialsContent对象将其删除，返回执行结果
	 *
	 * @param ids
	 *
	 * @return int
	 */
	@RequestMapping("/deleteRequiredMaterials.action")
	@ResponseBody
	public int deleteRequiredMaterials(String ids){
		return this.visaService.deleteRequiredMaterials(ids);
	}
	
	/**
	 * 功能描述：根据前端传来的ID查找到对应的RequiredMaterials对象，传到MaterialsContent.jsp页面中
	 *
	 * @param id
	 * @param map
	 *
	 * @return String
	 */
	@RequestMapping("/findByMaterialsID.action")
	public String findByMaterialsID(String id,Map map){
		RequiredMaterials materials = this.visaService.findByMaterialsID(id);
		map.put("materials", materials);
		return "/SeeTheWorld/MaterialsContent";
	}
	
	/**
	 * 功能描述：查找到所有HotCountries对象将结果返回到前端
	 *
	 * @return List<HotCountries>
	 */
	@RequestMapping("/getHotCountriesList.action")
	@ResponseBody
	public List<HotCountries> getHotCountriesList(){
		return this.visaService.getHotCountriesList();
	}
	
	/**
	 * 功能描述：把前端传来的HotCountries对象存到数据库中，传来的图片文件存到指定文件夹中
	 *
	 * @param hotCountries
	 * @param image
	 *
	 * @return Serializable
	 */
	@RequestMapping("/addHotCountries.action")
	@ResponseBody
	public Serializable addHotCountries(HotCountries hotCountries,MultipartFile image){
	    return this.visaService.addHotCountries(hotCountries, image);
	}
	
	/**
	 * 功能描述：根据前端传来的参数找到对应HotCountries对象将其更新
	 *
	 * @param hotCountries
	 * @param image
	 * @param imgOld
	 *
	 * @return void
	 */
	@RequestMapping("/updateHotCountries.action")
	@ResponseBody
	public void updateHotCountries(HotCountries hotCountries,MultipartFile image,String imgOld){
		this.visaService.updateHotCountries(hotCountries, image,imgOld);
	}
	
	/**
	 * 功能描述：根据前端传来的ID查找到对应的HotCountries记录将其删除，返回执行结果
	 *
	 * @param ids
	 *
	 * @return int
	 */
	@RequestMapping("/deleteHotCountries.action")
	@ResponseBody
	public int deleteHotCountries(String ids){
		return this.visaService.deleteHotCountries(ids);
	}
	
	/**
	 * 功能描述：根据前端传来的userID查找对应VisaOrder对象并返回到前端
	 *
	 * @param visaOrder
	 *
	 * @return List<VisaOrder>
	 */
	@RequestMapping("/findByUserID.action")
	@ResponseBody
	public List<VisaOrder> findByUserID(VisaOrder visaOrder){
		return this.visaService.findByUserID(visaOrder);
	}
	
	/**
	 * 功能描述：根据前端传来的ID找到对应的VisaOrder对象然后传到VisaOrderContent.jsp页面
	 *
	 * @param id
	 * @param map
	 *
	 * @return String
	 */
	@RequestMapping("/findByVisaOrderID.action")
	public String findByVisaOrderID(String id,Map map){
		VisaOrder visaOrder = this.visaService.findByVisaOrderID(id);
		map.put("visaOrder",visaOrder);
		return "/SeeTheWorld/VisaOrderContent";
	}

	/**
	 * 功能描述：根据前端传来的ID找到对应的VisaOrder对象然后传到ProgressContent.jsp页面
	 *
	 * @param id
	 * @param map
	 *
	 * @return String
	 */
	@RequestMapping("/findByProgress.action")
	public String findByProgress(String id,Map map){
		VisaOrder visaOrder = this.visaService.findByVisaOrderID(id);
		map.put("visaOrder",visaOrder);
		return "/SeeTheWorld/ProgressContent";
	}
	
}
