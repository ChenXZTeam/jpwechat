package com.solar.tech.controller.seeTheWorld;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
import com.solar.tech.utils.SystemOutFunc;
import com.solar.tech.utils.UploadHelper;

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
	 * 功能描述：获取Visa在签证全部列表数据 并返回到前端
	 *
	 * @return List<Visa>
	 */
	@RequestMapping("/getVisaList.action")
	@ResponseBody
	public Map<String, Object> getVisaList(int page, int rows){
		Map<String, Object> map = new HashMap<String, Object>();
		map = visaService.getVisaList(page, rows);
		if(map.size()>0){
			map.put("msg", 1);
		}else{
			map.put("msg", 0);
		}
		return map;
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
	public Map<String, Object> addVisa(Visa visa,HttpServletRequest request, HttpServletResponse response, HttpSession session){
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
	       if(key.equals("remenContry"))visa.setRemenContry(value); 
	       if(key.equals("TouryIntro"))visa.setTouryIntro(value);
	    }
	    int newNum = visaService.fingMaxNumVisa();
	    newNum = (newNum==0)?1:(newNum+1);
	    visa.setNewDataNum(newNum);
	    String countryIDnum = visaService.bornCountryNum(newNum);
	    visa.setCountryID(countryIDnum);
		String fmUrl = (String) session.getAttribute("fmUrl");//刚刚上传的文件路径
		visa.setUrlImg(fmUrl);
		visa.setAdminDel("1");
	    visa.setCreateTime(new Timestamp(new Date().getTime())); //创建时间赋值
	    int i = visaService.addVisa(visa);
	    if(i==1){
	    	map.put("msg","1");
	    }else{
	    	map.put("msg","0");
	    }
		return map;
	}
	
	@RequestMapping("/addVisaImg.action")
	@ResponseBody
	public Map<String ,Object> addVisaImg(@RequestParam(value = "myFileImg", required = false) MultipartFile file, HttpServletRequest request, HttpSession session){ 
		System.out.println("开始");  
		Map<String ,Object> map = new HashMap<String ,Object>();
		String path = request.getSession().getServletContext().getRealPath("uploadImg");  
        String fileName = file.getOriginalFilename();  //文件名
        //设置保存路径
        File targetFile = new File(path, fileName); 
        if(!targetFile.exists()){  
            targetFile.mkdirs();  
        }  
        //保存  
        try {  
            file.transferTo(targetFile);
            System.out.println("保存地址："+path);
            path = path.substring(path.length()-9,path.length());
            System.out.println("应该保存的地址："+path);
            session.setAttribute("fmUrl", path+"/"+fileName);
            map.put("status", "success");
        } catch (Exception e) {  
            e.printStackTrace();
            map.put("status", "error");
        }  
		return map; 
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
	public Map<String, Object> deleteOrder(String countryID) {
	     Map<String, Object> map = new HashMap<String, Object>(); 
	     try {
	    	 int i = visaService.deleteOrder(countryID);
	    	 if(i == 1){
	    		 map.put("state", 1);
				 map.put("msg", "success");
				 return map;
	    	 }
			 map.put("state", 0);
			 map.put("msg", "数据删除失败");
	     } catch (Exception e) {
	    	 map.put("state", -1);
	    	 map.put("msg", e.getMessage());
	     }
	     return map;
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
	public Map<String, Object> updateVisa(Visa visa){
		Map<String, Object> map = new HashMap<String, Object>();
		//String nowTime = (new Timestamp(new Date().getTime()))+"";
		visa.setCreateTime(new Timestamp(new Date().getTime())); //创建时间赋值
		visaService.updateVisaSer(visa);
		map.put("state", 1);
		return map;
	}
	
	/**
	 * 功能描述：根据国家域名代码查找相应的Visa对象并将结果传到VisaList.jsp页面
	 *
	 * @param visa
	 * @param map
	 *
	 * @return String
	 */
	@RequestMapping("/findByCountryId.action")
	@ResponseBody
	public Map<String, Object> findByCountry(String countryId){
		Map<String, Object> map = new HashMap<String, Object>();
		List<Visa> dataList = visaService.findByCountry(countryId);
		if(dataList.size()>0){
			map.put("msg",1);
			map.put("dataList", dataList);			
		}else{
			map.put("msg",0);
		}
		return map;
	}
	
	/**
	 * 功能描述：接收前端传来的ID并根据此ID找到对应的Visa对象传到VisaContent.jsp页面
	 *
	 * @param id
	 * @param map
	 *
	 * @return String
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("/findVisa.action")
	@ResponseBody
	public Map<String, Object> findVisa(String countryName,int page, int rows,HttpServletRequest req, HttpServletResponse resp) throws UnsupportedEncodingException{
		Map<String, Object> map =new HashMap<String, Object>();
		countryName = new String(countryName.getBytes("iso8859-1"),"utf-8");
		map = visaService.findVisa(countryName, page, rows);
		return map;
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
	public Map<String, Object> getVisaOrderList(int page, int rows){
		Map<String, Object> map = new HashMap<String, Object>();
		map = visaService.getVisaOrderList(page, rows);
		if(map.size()>0){
			map.put("msg", 1);
		}else{
			map.put("msg", 0);
		}
		return map;
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
	       if(key.equals("countryIdNum"))visaOrder.setVisaID(value);//申请签证的国家代码
	       if(key.equals("paystatus"))visaOrder.setPaystatus(value);//支付状态
	       if(key.equals("progress"))visaOrder.setProgress(value);//申请进度
	    } 
	    String orderNum = visaService.createOrderNum("RDOD",8);
	    visaOrder.setOrderNum(orderNum);
	    if(visaOrder.getTotalCost()==null||visaOrder.getTotalCost().equals("")){ //价格等于空这说明是从后台管理员输入的订单，因为后台没有输入价格的输入框
	    	String cost = visaService.fingCostByCounryId(visaOrder.getVisaID());
	    	visaOrder.setTotalCost(cost);
	    }else{
		    visaOrder.setPaystatus("0");//支付状态(未支付)
		    visaOrder.setProgress("0");//预约中
	    }
	    visaOrder.setDeleteSige("1");//默认不删除
	    visaOrder.setCreateTime(new Timestamp(new Date().getTime())); //创建时间赋值
	    int i = visaService.addVisaOrder(visaOrder);
	    System.out.println("i="+i);
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
	public Map<String, Object> updateVisaOrder(VisaOrder visaOrder,String idcase){
		Map<String, Object> map = new HashMap<String, Object>();
		visaOrder.setIDcase(idcase); 
	    visaOrder.setCreateTime(new Timestamp(new Date().getTime())); //创建时间赋值
		visaService.updateVisaOrder(visaOrder);
		map.put("state", 1);
		return map;
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
	public Map<String, Object> deleteVisaOrder(String orderNum){
		Map<String, Object> map = new HashMap<String, Object>(); 
	     try {
	    	 int i = visaService.deleteVisaOrder(orderNum);
	    	 if(i == 1){
	    		 map.put("state", 1);
				 map.put("msg", "success");
				 return map;
	    	 }
			 map.put("state", 0);
			 map.put("msg", "数据删除失败");
	     } catch (Exception e) {
	    	 map.put("state", -1);
	    	 map.put("msg", e.getMessage());
	     }
	     return map;
	}
	
	@RequestMapping("/findVisaOrder.action")
	@ResponseBody
	public Map<String, Object> findVisaOrder(String yuyueNumber,int page, int rows,HttpServletRequest req, HttpServletResponse resp) throws UnsupportedEncodingException{
		Map<String, Object> map =new HashMap<String, Object>();
		yuyueNumber = new String(yuyueNumber.getBytes("iso8859-1"),"utf-8");
		map = visaService.FindVisaOrder(yuyueNumber, page, rows);
		return map;
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
