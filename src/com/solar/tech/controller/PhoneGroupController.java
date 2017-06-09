package com.solar.tech.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.PhoneGroup;
import com.solar.tech.service.PhoneGroupService;

/**
 * 处理分组信息
 * @author solarpc1
 *
 */
@Controller
@RequestMapping("/framework/phoneGroup")
public class PhoneGroupController {
	@Resource
	private PhoneGroupService PGroupService;
	
	/**
	 * 获取全部分组
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping("/getGroupList.action")
	@ResponseBody
	public Map<String, Object> getGroupList(){
		Map<String, Object> map = new HashMap<String, Object>();
		map = PGroupService.getInfoList();
		return map;
	}
	
	/**
	 * 新增分组
	 */
	@RequestMapping("/newFz.action")
	@ResponseBody
	public Map<String,Object> newFz(PhoneGroup pg){
		Map<String,Object> map=new HashMap<String,Object>();
		PGroupService.saveFz(pg);
		map.put("state",1);
		return map;
	  }
	/**
	 * 修改分组的保存功能
	 */
	@RequestMapping("/upFenZu.action")
	@ResponseBody
	public Map<String, Object> updatefzName(PhoneGroup pg){
		Map<String,Object> map=new HashMap<String,Object>();
		PGroupService.updatefzName(pg);
		map.put("state", 1);
		return map;
		
	}
	
	/**
	 * 删除分组的确定功能
	 */
	@RequestMapping("/deleteGroup.action")
	@ResponseBody
	public int DeleteGroup(String uuid){
		try {
			String[] uuidStr = uuid.split(",");
			for(String uuidCh : uuidStr){
				PGroupService.DeleteGroup(uuidCh);
			}
			return 1;
		} catch (Exception e) {
			return 0;
		}
	    
	}
	
	/**
	 * 修改分组
	 */
	@RequestMapping("/upFz.action")
	@ResponseBody
	public String upFz(PhoneGroup pg){
		try {
			PGroupService.upFz(pg);
			return "1";
		} catch (Exception e) {
			return "0";
		}
	}
	
	/**
	 * 删除分组
	 */
	@RequestMapping("/delFz.action")
	@ResponseBody
	public String delFz(PhoneGroup pg){
		try {
			PGroupService.delFz(pg);
			return "1";
		} catch (Exception e) {
			return "0";
		}
	}
	
}
