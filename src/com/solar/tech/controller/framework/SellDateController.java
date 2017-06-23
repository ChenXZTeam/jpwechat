package com.solar.tech.controller.framework;

import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.entity.userOrderInfo;
import com.solar.tech.service.SellDateService;

@Controller
@RequestMapping("/framework/SellDate")
public class SellDateController {
	@Autowired
	private SellDateService selldate;
	
	@RequestMapping(value ="/selldate.action",method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> selldate(String ltime,String TTime) throws ParseException{
		Map<String,Object> map=new HashMap<String,Object>();
		List<userOrderInfo> list=selldate.find(ltime,TTime);
		if(list.size()<=0){
			String a=" ";
			map.put("state", a);
			return map;
		}
		else{
			//System.out.println(list);
			map.put("state", list);
			return map;
		}
		
	}
	
	@RequestMapping(value="/showDate.action",method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> showDate(){
		Map<String,Object> map=new HashMap<String,Object>();
		List<userOrderInfo> list=selldate.chazhao();
		if(list.size()<=0){
			String a=" ";
			map.put("state", a);
			return map;
		}
		else{
			//System.out.println(list);
			map.put("state",list);
			return map;
		}
	}
	
	
	
	
}
