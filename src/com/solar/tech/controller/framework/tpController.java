package com.solar.tech.controller.framework;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
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
	
	@RequestMapping(value = "/loadDate.action", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> loadDate(int page, int rows){
		Map<String,Object> map = tprecords.getInfoList(page,rows);
		return map;
	}
	
	@RequestMapping(value = "/query.action", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> query(int page, int rows){
		Map<String,Object> map=new HashMap<String,Object>();
		List<tpRecords> records=new ArrayList<tpRecords>();
		List<userOrderInfo> orderList=tprecords.queryStatus();
		if(orderList.size()==0){
			map.put("total", orderList.size());
			map.put("rows", 0);
			return map;
		}	
		for(userOrderInfo tpOrder : orderList){
			tpRecords tpBorn = new tpRecords();
			tpBorn.setLinkName(tpOrder.getLinkName());
			tpBorn.setPnumber(tpOrder.getLinkPhoneNum());
			tpBorn.setPnr(tpOrder.getPNR());
			tpBorn.setTelNumber(tpOrder.getTelNum());
			tpBorn.setHangbanNum(tpOrder.getHangbanNum());
			tpBorn.setIdcase(tpOrder.getIDcase());
			tpBorn.setChufCity(tpOrder.getChufCity());
			tpBorn.setChufTime(tpOrder.getChufTime());
			tpBorn.setDaodCity(tpOrder.getDaodCity());
            tpBorn.setTpStatus(tpOrder.getTpStatus());
            tpBorn.setCreateTime(new Timestamp(new Date().getTime()));
            tpBorn.setMatherUuid(tpOrder.getID());
			records.add(tpBorn);
		}
		try {
			tprecords.clear();
			tprecords.addtprecords(records);
			map = tprecords.getInfoList(page,rows);
		} catch (Exception e) {}
		return map;
	}
	
	@RequestMapping(value="/upstatus.action")
	@ResponseBody
	public int upstatus(String id,String tpStatus,String matherUuid){
		try {
			tprecords.upstatus(id,tpStatus,matherUuid);
			return 1;
		} catch (Exception e) {
			return 0;
		}
		
	}
	
	@RequestMapping(value="/chazhao.action", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> chazhao(int page, int rows, String linkName,String hangbanNum,String telNumber,String pnumber,String pnr,String tpstatus){
		Map<String,Object> map=new HashMap<String,Object>();
		map = tprecords.chazhao(page,rows,linkName,hangbanNum,telNumber,pnumber,pnr,tpstatus);
		return map;
	}

	
}
