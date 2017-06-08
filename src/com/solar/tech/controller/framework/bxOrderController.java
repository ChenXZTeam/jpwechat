package com.solar.tech.controller.framework;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.service.bxOrderService;

@Controller
@RequestMapping("/framework/bxList")
public class bxOrderController {
	@Autowired
	private bxOrderService bxOrderSer;
	
	@RequestMapping("/numList.action")
	@ResponseBody
	public Map<String,Object> getOrderList(int page, int rows){
		Map<String,Object> map = bxOrderSer.manlist(page, rows);
		return map;
	}
	
	@RequestMapping("/seach.action")
	@ResponseBody
	public Map<String,Object> seach(int page, int rows, String on, String ct){
		Map<String,Object> map = bxOrderSer.manlist(page, rows, on, ct);
		return map;
	}
	
	@RequestMapping("/configNum.action")
	@ResponseBody
	public int configNum(String uuid, String bxNum){
		try {
			bxOrderSer.configNum(uuid,bxNum);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
}
