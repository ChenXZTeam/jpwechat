package com.solar.tech.controller.framework;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.entity.userOrderInfo;
import com.solar.tech.bean.entity.tpRecords;
import com.solar.tech.service.TpRecordsServices;







@Controller
@RequestMapping("/framework/tuipiao")
public class tpController {
    
	@Autowired
	private TpRecordsServices tprecords;
	
	@RequestMapping(value="/clear.action",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> clear(){
		Map<String, Object> map = new HashMap<String, Object>(); 
		try {
			int i = tprecords.clear();
			if(i == 1){
				map.put("state", 1);
				map.put("msg", "success");
				return map;
			}
			else{
			    map.put("state", 0);
			    map.put("msg", "数据删除失败");
			}
			 
		} catch (Exception e) {
			   map.put("state", -1);
	    	   map.put("msg", e.getMessage());
		}
		return map;
	}
	
	@RequestMapping(value = "/query.action", method = RequestMethod.POST)
	@ResponseBody
	
	public Map<String,Object> query(){
		Map<String,Object> map=new HashMap<String,Object>();
	    int s = tprecords.clear();
	    System.out.println(s);
	    if(s==0){
	    	return map;
	    }
		List<tpRecords> records=new ArrayList<tpRecords>();
		List<userOrderInfo> orderList=tprecords.queryStatus();
		if(orderList.size()<=0){
			tpRecords tpBorn=new tpRecords();
			tpBorn.setBornStatus("没有退票订单");
			records.add(tpBorn);
			map.put("rows", records);
			System.out.println(map);
			return map;
		}
			
		for(userOrderInfo tpOrder:orderList){
			tpRecords tpBorn=new tpRecords();
			tpBorn.setLinkName(tpOrder.getLinkName());
			tpBorn.setPnumber(tpOrder.getLinkPhoneNum());
			tpBorn.setPnr(tpOrder.getPNR());
			tpBorn.setTelNumber(tpOrder.getTelNum());
			tpBorn.setHangbanNum(tpOrder.getHangbanNum());
			tpBorn.setIdcase(tpOrder.getIDcase());
			tpBorn.setChufCity(tpOrder.getChufCity());
			tpBorn.setChufTime(tpOrder.getChufTime());
            tpBorn.setBornStatus("生成成功");
            String sendMesText=sendMesText(tpOrder.getTpStatus());
            System.out.println(sendMesText);
            tpBorn.setTpStatus(sendMesText);
			
			int i=tprecords.addtprecords(tpBorn);
			if(i==1){
				records.add(tpBorn);
				
			}
			
			
		}
	
		map.put("rows", records);
		return map;
		
		
		
		
		
	}
	
	public static String sendMesText(String text){
		   if(text.equals("1")){
			   text="退票进行中";
		   }
		   if(text.equals("2")){
			   text="退票已完成";
		   }
		   return text;
		   
	}
	
	@RequestMapping(value="/chazhao.action", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> chazhao(String linkName,String hangbanNum,String telNumber,String pnumber,String pnr,String tpstatus){
		Map<String,Object> map=new HashMap<String,Object>();
		List jilu=new ArrayList<>();
		List<tpRecords> lists=tprecords.chazhao(linkName,hangbanNum,telNumber,pnumber,pnr,tpstatus);
		if(lists.size()<=0){
			tpRecords chaxun=new tpRecords();
			chaxun.setBornStatus("没有找到符合条件的退票订单");
			jilu.add(chaxun);
			map.put("rows", jilu);
			return map;
		}
		for(tpRecords records: lists){
			records.getLinkName();
			records.getPnumber();
			records.getPnr();
			records.getTelNumber();
			records.getHangbanNum();
			records.getIdcase();
			records.getChufCity();
			records.getChufTime();
			jilu.add(records);
		}
		
		map.put("rows", jilu);
		return map;
				
	}

	
}
