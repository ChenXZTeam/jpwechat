package com.solar.tech.controller.framework;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.entity.tgConfig;
import com.solar.tech.service.tgConfigService;

@Controller
@RequestMapping("/framework/tgConfig")
public class tgConfigController {
	@Resource
	private tgConfigService tgService;
	
	@RequestMapping("/numList.action")
	@ResponseBody
	public Map<String,Object> numList(int page, int rows){
		Map<String,Object> insura = tgService.getInfoList(page, rows); 
		return insura;
	}
	
	@RequestMapping("/findNumList.action")
	@ResponseBody
	public Map<String,Object> findNumList(int page, int rows,String num){
		Map<String,Object> insura = tgService.getInfoList(page, rows, num); 
		return insura;
	}
	
	@RequestMapping("/addInfo.action")
	@ResponseBody
	public int addInfo(tgConfig addInfo){
		try {
			addInfo.setUpTime(new Timestamp(new Date().getTime()));
			tgService.addInfo(addInfo); 
			return 1;
		} catch (Exception e) {
			return 0;
		}
		
	}
	
	@RequestMapping("/upInfo.action")
	@ResponseBody
	public int upInfo(tgConfig addInfo){
		try {
			addInfo.setUpTime(new Timestamp(new Date().getTime()));
			tgService.upInfo(addInfo); 
			return 1;
		} catch (Exception e) {
			return 0;
		}
		
	}
	
	@RequestMapping("/delInfo.action")
	@ResponseBody
	public int delInfo(String num){
		try {
			List<tgConfig> lima = new ArrayList<tgConfig>();
			String[] strLm = num.split(",");
			for(String nnk : strLm){
				tgConfig llmm = new tgConfig();
				llmm.setUuid(nnk);
				lima.add(llmm);
			}
			tgService.delInfo(lima);
			return 1;
		} catch (Exception e) {
			return 0;
		}
		
	}
	
}
