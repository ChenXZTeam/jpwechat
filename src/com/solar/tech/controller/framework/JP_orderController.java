package com.solar.tech.controller.framework;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.service.framework.JP_orderService;

@Controller
@RequestMapping("/framework/order")
public class JP_orderController {
	@Autowired
	private JP_orderService jporderService;
	
	@RequestMapping("/getOrderList.action")
	@ResponseBody
	public Map<String, Object> getVisaList(int page, int rows){
		System.out.println(page+"/"+rows);
		Map<String, Object> map = new HashMap<String, Object>();
		map = jporderService.loadOrder(page, rows);
		if(map.size()>0){
			map.put("msg", 1);
		}else{
			map.put("msg", 0);
		}
		return map;
	}
}
