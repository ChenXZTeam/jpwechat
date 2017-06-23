package com.solar.tech.controller.framework;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.entity.yhNum;
import com.solar.tech.service.yhNumService;

@Controller
@RequestMapping("/framework/yhTime")
public class yhNumController {
     
	@Autowired
	private yhNumService yhnumser;
	
	@RequestMapping("/save.action")
	@ResponseBody
	public int save(String number,String stauts){
		try{
		    yhnumser.update(number,stauts);
		    return 1;
		}catch(Exception e){
			return 0;
		}
	}
	
	@RequestMapping("/xigai.action")
	@ResponseBody
	public int xigai(String number){
		try{
			yhnumser.gengx(number);
			return 1;
		}catch(Exception e){
			return 0;
		}
	}
	
	@RequestMapping("/reload.action")
	@ResponseBody
	public List<yhNum> reload(){
		List<yhNum> yhnum = yhnumser.gengx();
		return yhnum;
	}
	
}
