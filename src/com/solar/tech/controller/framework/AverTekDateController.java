package com.solar.tech.controller.framework;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import scala.reflect.generic.Trees.New;

import com.solar.tech.bean.entity.userOrderInfo;
import com.solar.tech.service.AverTekDateService;

@Controller
@RequestMapping("/framework/atdcontroller")
public class AverTekDateController {
	@Autowired
	private AverTekDateService atkserv;
	
	@RequestMapping("/getOrderList.action")
	@ResponseBody
	public List<userOrderInfo> getOrderList(String starTime, String overTime){
		List<userOrderInfo> listOrder = atkserv.getlist(starTime, overTime);
		return listOrder;
	}
	
	@RequestMapping("/morenList.action")
	@ResponseBody
	public List<userOrderInfo> morenList(){
		SimpleDateFormat stamatter = new SimpleDateFormat("yyyy-MM");
		SimpleDateFormat ovematter = new SimpleDateFormat("yyyy-MM-dd");
		String starTime = stamatter.format(new Date())+"-01";
		String overTime = ovematter.format(new Date());
		List<userOrderInfo> listOrder = atkserv.getlist(starTime, overTime);
		return listOrder;
	}
}
