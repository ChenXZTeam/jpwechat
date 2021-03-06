package com.solar.tech.controller.framework;

import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.entity.Info;
import com.solar.tech.service.InfoService;
/**
 * 类名：InfoController 
 *
 * 功能描述：最新资讯模块的Controller类，负责添加国内、国外的最新资讯信息
 *
 * @author 曾令维
 *
 * Version info版本号：V1.0
 * © Copyright 续日科技 2016年7月29日  版权所有
 */
@Controller
@RequestMapping("/framework/info")
public class InfoController {
	@Resource
	private InfoService infoService;
	
	/**
	 * 功能描述：获取国内最新资讯全部列表数据 并返回到前端
	 *
	 * @return List<Visa>
	 */
	@RequestMapping("/getInfoList.action")
	@ResponseBody
	public Map<String, Object> getInfoList(int page, int rows){
		Map<String, Object> map = new HashMap<String, Object>();
		map = infoService.getInfoList(page, rows);
		if(map.size()>0){
			map.put("msg", 1);
		}else{
			map.put("msg", 0);
		}
		return map;
	}
	/**
	 * 功能描述：获得国内资讯，返回到微信列表页面
	 *
	 * @return List<Info>
	 */
	@RequestMapping("/getInfo.action")
	@ResponseBody
	public Map<String, Object> getInfo(){
		Map<String, Object> map = new HashMap<String, Object>();
		map = infoService.getInfo();
		if(map.size()>0){
			map.put("msg", 1);
		}else{
			map.put("msg", 0);
		}
		return map;
	}
	
	/**
	 * 功能描述：添加国内外资讯
	 *
	 * @return Serializable
	 */
	@RequestMapping("/addInfo.action")
	@ResponseBody
	public Map<String, Object> addInfo(Info info,HttpServletRequest request, HttpServletResponse response, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		Enumeration<String> paramNames = request.getParameterNames();   
	    // 通过循环将表单参数放入键值对映射中  
	    while(paramNames.hasMoreElements()) {  
	       String key = paramNames.nextElement();  
	       String value = request.getParameter(key); 
	       if(key.equals("title"))info.setTitle(value); 
	       if(key.equals("info"))info.setInfo(value); 
	       if(key.equals("introduction"))info.setIntroduction(value); 
	       if(key.equals("fmUrl"))info.setFmUrl(value); 
	    }
	   
	    info.setCreateTime(new Timestamp(new Date().getTime())); //创建时间赋值
	    int i = infoService.addInfo(info);
	    if(i==1){
	    	map.put("msg","1");
	    }else{
	    	map.put("msg","0");
	    }
		return map;
	}
	
	/**
	 * 功能描述：接收前端传来的id并到数据库中找到相应的info对象将其删除，
	 * 把执行结果返回前端
	 *
	 * @param ids
	 * @return
	 *
	 * @return int
	 */
	@RequestMapping("/deleteInfo.action")
	@ResponseBody
	public Map<String, Object> deleteInfo(String infoID) {
	     Map<String, Object> map = new HashMap<String, Object>(); 
	     try {
	    	 int i = infoService.deleteInfo(infoID);
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
	 * 功能描述：接收前端传来的info对象，根据id在数据库中更新此对象
	 *
	 * @param visa
	 *
	 * @return void
	 */
	@RequestMapping("/updateInfo.action")
	@ResponseBody
	public Map<String, Object> updateVisa(Info info){
		Map<String, Object> map = new HashMap<String, Object>();
		info.setCreateTime(new Timestamp(new Date().getTime())); //创建时间赋值
		infoService.updateInfo(info);
		map.put("state", 1);
		return map;
	}
	
	/**
	 * 功能描述：接收前端传来的ID并根据此ID找到对应的Info对象传到InfoContent.jsp页面
	 *
	 * @param id
	 * @param map
	 *
	 * @return String
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("/findInfo.action")
	@ResponseBody
	public Map<String, Object> findVisa(String title,int page, int rows,HttpServletRequest req, HttpServletResponse resp) throws UnsupportedEncodingException{
		Map<String, Object> map =new HashMap<String, Object>();
		title = new String(title.getBytes("iso8859-1"),"utf-8");
		map = infoService.findVisa(title, page, rows);
		return map;
	}
	
	/**
	 * 功能描述：接收前端传来的ID并根据此ID找到对应的Info对象传到InfoContent.jsp页面
	 *
	 * @param id
	 * @param map
	 *
	 * @return String
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("/findInfoByID.action")
	@ResponseBody
	public Map<String, Object> findInfoByID(String title) throws UnsupportedEncodingException{
		Map<String, Object> map =new HashMap<String, Object>();
		map = infoService.findInfoByID(title);
		if(map.size()>0){
			map.put("msg", 1);
		}else{
			map.put("msg", 0);
		}
		return map;
	}
	
}
