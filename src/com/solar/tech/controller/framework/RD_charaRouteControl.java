package com.solar.tech.controller.framework;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

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
}
