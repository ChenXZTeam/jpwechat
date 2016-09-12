package com.solar.tech.controller.seeTheWorld;

import java.io.File;
import java.io.IOException;
import java.io.Serializable;
import java.net.MalformedURLException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
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
import com.solar.tech.service.userOrderService;
import com.solar.tech.utils.Send106msg;

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
	@Autowired
	private userOrderService OrderService;
	@Resource
	private VisaService visaService;
	
	/**
	 * 功能描述：获取Visa列表 并返回到前端
	 *
	 * @return List<Visa>
	 */
	@RequestMapping("/getVisaList.action")
	@ResponseBody
	public List<Visa> getVisaList(List<Visa> ss){
		return ss;
		//return this.visaService.getVisaList();
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
	public Map<String, Object> addVisa(Visa visa,HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> map = new HashMap<String, Object>();
		Enumeration<String> paramNames = request.getParameterNames();  
	    // 通过循环将表单参数放入键值对映射中  
	    while(paramNames.hasMoreElements()) {  
	       String key = paramNames.nextElement();  
	       String value = request.getParameter(key); 
	       if(key.equals("countryName"))visa.setCountry(value); 
	       if(key.equals("belongArea"))visa.setCotryBelongWhat(value); 
	       if(key.equals("ruNum"))visa.setImmigrationOfTimes(value); 
	       if(key.equals("douNumDay"))visa.setSojournTime(value); 
	       if(key.equals("youxiaoDate"))visa.setPeriodOfValidity(value); 
	       if(key.equals("banliDate"))visa.setElapsedTime(value); 
	       if(key.equals("payCost"))visa.setVisaPrice(value); 
	       if(key.equals("canOrderDate"))visa.setEarlyDates(value);
	       if(key.equals("qzType"))visa.setVisaType(value); 
	       if(key.equals("serviceCont"))visa.setServiceContent(value); 
	       if(key.equals("shouArea"))visa.setScopeOfAcceptance(value); 
	       if(key.equals("banliTech"))visa.setImmigrationFlow(value); 
	       if(key.equals("qzMode"))visa.setQzMode(value); 
	       if(key.equals("TouryIntro"))visa.setTouryIntro(value);
	    }
	    String newNum = visaService.fingMaxNumVisa();
	    if(newNum==null||newNum.equals("")){
	    	newNum = "1";
	    }else{
	    	newNum = (Integer.parseInt(newNum)+1)+"";
	    }
	    visa.setNewDataNum(newNum);
	    String countryIDnum = visaService.bornCountryNum(newNum);
	    visa.setCountryID(countryIDnum);
	    int i = visaService.addVisa(visa);
	    if(i==1){
	    	System.out.println("国家编辑成功");
	    	map.put("msg","1");
	    }else{
	    	map.put("msg","0");
	    }
		return map;
		//return this.visaService.addVisa(visa);
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
		return 0;
		//return this.visaService.deleteVisa(ids);
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
		//this.visaService.updateVisa(visa);
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
	public String findByCountry(Visa visa,Map<String, Object> map){
		//List<Visa> list = this.visaService.findByCountry(visa);
		//map.put("list", list);
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
	public String findByID(String id,Map<String, Object> map){
		//Visa visa = this.visaService.findByID(id);
		//map.put("visa", visa);
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
	public String findByVisaFreeID(String id,Map<String, Object> map){
		//VisaFree visaFree = this.visaService.findByVisaFreeID(id);
		//map.put("visaFree", visaFree);
		return "/SeeTheWorld/VisaFreeContent";
	}
	
	/**
	 * 功能描述：查找到所有VisaFree对象并将结果返回到前端
	 *
	 * @return List<VisaFree>
	 */
	@RequestMapping("/getVisaFreeList.action")
	@ResponseBody
	public List<VisaFree> getVisaFreeList(List<VisaFree> ss){
		return ss;
		//return this.visaService.getVisaFreeList();
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
	public Serializable addVisaFree(VisaFree visaFree,Serializable ss){
		return ss;
		//return this.visaService.addVisaFree(visaFree);
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
		//this.visaService.updateVisaFree(visaFree);
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
		return 0;
		//return this.visaService.deleteVisaFree(ids);
	}
	
	/**
	 * 功能描述：查找到所有VisaOrder的记录并接结果返回到前端
	 *
	 * @return List<VisaOrder>
	 */
	@RequestMapping("/getVisaOrderList.action")
	@ResponseBody
	public List<VisaOrder> getVisaOrderList(List<VisaOrder> ss){
		return ss;
		//return this.visaService.getVisaOrderList();
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
	public Map<String, Object> addVisaOrder(VisaOrder visaOrder,HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> map = new HashMap<String, Object>();
		Enumeration<String> paramNames = request.getParameterNames();  
	    // 通过循环将表单参数放入键值对映射中  
	    while(paramNames.hasMoreElements()) {  
	       String key = paramNames.nextElement();  
	       String value = request.getParameter(key); 
	       if(key.equals("linkName"))visaOrder.setContactsName(value);//联系人
	       if(key.equals("personWorkIpnt"))visaOrder.setCustomerType(value);//客户类型
	       if(key.equals("sexIpnt"))visaOrder.setContactsSex(value);//性别
	       if(key.equals("phoneNum"))visaOrder.setContactsPhone(value);//联系人电话
	       if(key.equals("EmailAdd"))visaOrder.setContactsEmail(value);//电子邮件
	       if(key.equals("trayTypeIpnt"))visaOrder.setTrayTypeIpnt(value);//旅客类型
	       if(key.equals("IDcase"))visaOrder.setIDcase(value);//身份证号码
	       if(key.equals("songTypeIpnt"))visaOrder.setDeliveryMethod(value);//配送方式
	       if(key.equals("sondAdd"))visaOrder.setDeliveryAddress(value);//配送地址
	       if(key.equals("payTry"))visaOrder.setTotalCost(value);//总费用
	       if(key.equals("countryName"))visaOrder.setApplyCountry(value);//申请签证的国家
	    } 
	    int MaxNum = Integer.parseInt(visaService.fingMaxNum());
	    visaOrder.setNewOrderNum((MaxNum+1)+"");
		String maxOrderNum = visaService.fingMaxOrderNum();
	    String orderNum = OrderService.getNum("RDOD", maxOrderNum);//生成预约编号
	    visaOrder.setOrderNum(orderNum);
	    visaOrder.setPaystatus("0");//支付状态
	    visaOrder.setProgress("0");//预约中
	    int i = visaService.addVisaOrder(visaOrder);
	    if(i==1){
	    	Send106msg sender = new Send106msg();
	    	try {
				sender.SendMSGtoPhone("【签证订单提醒】订单编号："+orderNum, visaOrder.getContactsPhone());
				System.out.println("短信发送成功");
			    map.put("msg", "1");
			} catch (MalformedURLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
	    }
		return map;
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
		//this.visaService.updateVisaOrder(visaOrder);
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
		return 0;
		//return this.visaService.deleteVisaOrder(ids);
	}

	/**
	 * 功能描述：查找到所有RequiredMaterials对象并将结果返回到前端
	 *
	 * @return List<RequiredMaterials>
	 */
	@RequestMapping("/getRequiredMaterialsList.action")
	@ResponseBody
	public List<RequiredMaterials> getRequiredMaterialsList(List<RequiredMaterials> s){
		return s;
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
	public Serializable addRequiredMaterials(RequiredMaterials requiredMaterials,Serializable ss){
		return ss;
		//return this.visaService.addRequiredMaterials(requiredMaterials);
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
		//this.visaService.updateRequiredMaterials(requiredMaterials);
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
		return 0;
		//return this.visaService.deleteRequiredMaterials(ids);
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
	public String findByMaterialsID(String id,Map<String, Object> map){
		//RequiredMaterials materials = this.visaService.findByMaterialsID(id);
		//map.put("materials", materials);
		return "/SeeTheWorld/MaterialsContent";
	}
	
	/**
	 * 功能描述：查找到所有HotCountries对象将结果返回到前端
	 *
	 * @return List<HotCountries>
	 */
	@RequestMapping("/getHotCountriesList.action")
	@ResponseBody
	public List<HotCountries> getHotCountriesList(List<HotCountries> ss){
		return ss;
		//return this.visaService.getHotCountriesList();
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
	public Serializable addHotCountries(HotCountries hotCountries,MultipartFile image,Serializable ss){
	    return ss;
		//return this.visaService.addHotCountries(hotCountries, image);
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
		//this.visaService.updateHotCountries(hotCountries, image,imgOld);
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
		return 0;
		//return this.visaService.deleteHotCountries(ids);
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
	public List<VisaOrder> findByUserID(VisaOrder visaOrder,List<VisaOrder> ss){
		return ss;
		//return this.visaService.findByUserID(visaOrder);
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
	public String findByVisaOrderID(String id,Map<String, Object> map){
		//VisaOrder visaOrder = this.visaService.findByVisaOrderID(id);
		//map.put("visaOrder",visaOrder);
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
	public String findByProgress(String id,Map<String, Object> map){
		//VisaOrder visaOrder = this.visaService.findByVisaOrderID(id);
		//map.put("visaOrder",visaOrder);
		return "/SeeTheWorld/ProgressContent";
	}
	
}
