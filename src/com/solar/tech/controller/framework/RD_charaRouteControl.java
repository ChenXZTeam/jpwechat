package com.solar.tech.controller.framework;

import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.entity.CharaRoute;
import com.solar.tech.service.RDcharaRouteService;
import com.solar.tech.util.Current;

/**
 * 特色路线控制器
 * @author solarpc1
 *
 */
@Controller
@RequestMapping("/framework/route")
public class RD_charaRouteControl {
	@Autowired
	private RDcharaRouteService routeSer;
	
	@RequestMapping("/getRoute.action")
	@ResponseBody
	public Map<String,Object> getRoute(int page, int rows){
		Map<String, Object> map = new HashMap<String, Object>();
		map = routeSer.getlist(page,rows);
		return map;
	}
	
	/**
	 * 新建路线信息
	 */
	@RequestMapping("/createRoute.action")
	@ResponseBody
	public Map<String, Object> createRoute(String title, String conText){
		Map<String, Object> map = new HashMap<String, Object>();
		String userName = Current.user().getUserName();
		CharaRoute cRoute = new CharaRoute();
		cRoute.setCreateTime(new Timestamp(new Date().getTime()));
		cRoute.setUserName(userName);
		cRoute.setTitle(title);
		cRoute.setConText(conText);
		routeSer.saveRoute(cRoute);
		return map;
	}
	/**
	 * 删除路线信息
	 */
	@RequestMapping("/deleteRoute.action")
	@ResponseBody
	public Map<String, Object> deleteRoute(String routeID) {
	     Map<String, Object> map = new HashMap<String, Object>(); 
	     try {
	    	 int i = routeSer.deleteRoute(routeID);
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
	 * 功能：修改路线
	 *
	 */
	@RequestMapping("/updateRoute.action")
	@ResponseBody
	public Map<String, Object> updateRoute(CharaRoute charaRoute){
		Map<String, Object> map = new HashMap<String, Object>();
		String userName = Current.user().getUserName();
		charaRoute.setCreateTime(new Timestamp(new Date().getTime())); //创建时间赋值
		charaRoute.setUserName(userName);
		routeSer.updateRoute(charaRoute);
		map.put("state", 1);
		return map;
	}
	
	/**
	 * 功能描述：查找路线信息
	 *
	 * @param id
	 * @param map
	 *
	 * @return String
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("/findRoute.action")
	@ResponseBody
	public Map<String, Object> findRoute(String title,int page, int rows,HttpServletRequest req, HttpServletResponse resp) throws UnsupportedEncodingException{
		Map<String, Object> map =new HashMap<String, Object>();
		title = new String(title.getBytes("iso8859-1"),"utf-8");
		map = routeSer.findRoute(title, page, rows);
		return map;
	}
}
