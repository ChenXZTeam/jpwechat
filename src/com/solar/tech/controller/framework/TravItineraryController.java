package com.solar.tech.controller.framework;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.entity.TravItinerary;
import com.solar.tech.service.TravItineraryService;

@Controller
@RequestMapping("/framework/travItinerary")
public class TravItineraryController {
	
	@Autowired
	private TravItineraryService tts;
	
	@RequestMapping("/getInfoList.action")
	@ResponseBody
	public Map<String,Object> InfoList(int page, int rows){
		Map<String,Object> map = tts.getList(page, rows);
		return map;
	}
	
	/**
	 * 更新需要打印的订单数据
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping("/getreload.action")
	@ResponseBody
	public Map<String,Object> getreload(int page, int rows){
		try {
			tts.getOrderDate();
		} catch (Exception e) {
			e.toString();
		}
		
		Map<String,Object> map = tts.getList(page, rows);
		return map;
	}
	
	@RequestMapping("/upInfo.action")
	@ResponseBody
	public int upInfo(TravItinerary ttin){
		try {
			TravItinerary ttine = tts.findOld(ttin.getUuid());
			ttine.setSandAdd(ttin.getSandAdd());
			ttine.setLinkPhone(ttin.getLinkPhone());
			ttine.setSandDate(ttin.getSandDate());
			if(ttine.getConsoleStutas().equals(ttin.getConsoleStutas())){ //如果管理员修改了打印状态， 那订单表中的打印状态也要改变
			}else{
				tts.upConStutas(ttine.getOrderUuid(),ttin.getConsoleStutas());
			}
			ttine.setConsoleStutas(ttin.getConsoleStutas());
			tts.upInfo(ttine);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	
	@RequestMapping("/delInfo.action")
	@ResponseBody
	public int delInfo(String num){
		try {
			List<TravItinerary> tempList = new ArrayList<TravItinerary>();
			String[] uid = num.split(",");
			for(String id : uid){
				TravItinerary ttay = new TravItinerary();
				ttay.setUuid(id);
				tempList.add(ttay);
			}
			tts.delInfo(tempList);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}

}
