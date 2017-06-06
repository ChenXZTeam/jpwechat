package com.solar.tech.controller.framework;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.entity.CTCTnum;
import com.solar.tech.service.CTCTnumService;

@Controller
@RequestMapping("/framework/ctct")
public class CTCTnumController {
	@Autowired
	private CTCTnumService ctctSer;
	
	@RequestMapping("/numList.action")
	@ResponseBody
	public List<CTCTnum> numList(){
		List<CTCTnum> insura = ctctSer.getInfoList(); 
		return insura;
	}
	
	@RequestMapping("/update.action")
	@ResponseBody
	public int update(String uuid, String phone){
		System.out.println(uuid+","+phone);
		try {
			ctctSer.update(uuid, phone);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	
}
