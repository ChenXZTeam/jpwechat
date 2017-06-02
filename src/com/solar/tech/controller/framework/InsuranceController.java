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

import com.solar.tech.bean.entity.Insurance;
import com.solar.tech.service.InsuranceService;

@Controller
@RequestMapping("/framework/insurance")
public class InsuranceController {
	@Resource
	private InsuranceService inService;
	
	/**
	 * 获取数据库列表
	 * @return
	 */
	@RequestMapping("/numList.action")
	@ResponseBody
	public Map<String,Object> numList(int page, int rows){
		Map<String,Object> insura = inService.listNum(page, rows);
		return insura;
	}
	
	@RequestMapping("/addNum.action")
	@ResponseBody
	public int addNum(String bxNum,String bxType,String cost,String commit){
		try {
			Insurance info = new Insurance();
			info.setBxNum(bxNum);
			info.setIsUse("0");
			info.setIsOpen("0");
			info.setCreateTime(new Timestamp(new Date().getTime()));
			info.setBxType(bxType);
			info.setCost(cost);
			info.setCommit(commit);
			inService.addInsuran(info);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	} 
	
	@RequestMapping("/updateNum.action")
	@ResponseBody
	public int upNum(String uuid,String isUse,String isOpen,String createTime,String bxNum,String bxType,String cost,String commit){
		try {
			Insurance info = new Insurance();
			info.setUuid(uuid);
			info.setBxNum(bxNum);
			info.setIsUse(isUse);
			info.setIsOpen(isOpen);
			info.setCreateTime(Timestamp.valueOf(createTime));
			info.setBxType(bxType);
			info.setCost(cost);
			info.setCommit(commit); 
			inService.upInsuran(info);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	
	@RequestMapping("/delteNum.action")
	@ResponseBody
	public int delNum(String num){
		String[] numStr = num.split(",");
		List<Insurance> strList = new ArrayList<Insurance>();
		for(String sStr : numStr){
			Insurance info = new Insurance();
			info.setUuid(sStr);
			strList.add(info);
		}
		try {
			inService.delNum(strList);
			return 1;
		} catch (Exception e) {
			return 0;
		}
		
	}
	
	@RequestMapping("/findBypage.action")
	@ResponseBody
	public Map<String,Object> findBypage(String num, int page, int rows){
		Map<String,Object> map = inService.findNum(num,page,rows);
		return map;
	}
	
	@RequestMapping("/upMortCost.action")
	@ResponseBody
	public int upCost(String num,String mon){
		try {
			inService.upcost(num,mon);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
}
