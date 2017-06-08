package com.solar.tech.controller.framework;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.entity.kdOrder;
import com.solar.tech.service.kdOrderService;

@Controller
@RequestMapping("/framework/kdorder")
public class kdOrderController {
	@Autowired
	private kdOrderService kdorderSer;
	
	@RequestMapping("/getOrderList.action")
	@ResponseBody
	public Map<String,Object> getOrderList(int page, int rows){
		Map<String,Object> map = kdorderSer.manlist(page, rows);
		return map;
	}
	
	@RequestMapping("/addkdNum.action")
	@ResponseBody
	public int addkdNum(kdOrder kdo){
		try {
			kdo.setCreateTime(new Timestamp(new Date().getTime()));
			kdorderSer.addkdNum(kdo);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	
	@RequestMapping("/upkdNum.action")
	@ResponseBody
	public int upkdNum(kdOrder kdo){
		try {
			kdorderSer.upkdNum(kdo);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	
	@RequestMapping("/delkdNum.action")
	@ResponseBody
	public int delkdNum(String num){
		try {
			List<kdOrder> kdList = new ArrayList<kdOrder>();
			String[] chs = num.split(",");
			for(String oneStr : chs){
				kdOrder delNum = new kdOrder();
				delNum.setUuid(oneStr);
				kdList.add(delNum);
			}
			kdorderSer.delkdNum(kdList);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	
	@RequestMapping("/findkdNum.action")
	@ResponseBody
	public Map<String,Object> findkdNum(int page, int rows, String num, String isusd){
		Map<String,Object> map = kdorderSer.findBypo(page, rows, num, isusd);
		return map;
	}
}
