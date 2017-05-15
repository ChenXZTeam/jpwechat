package com.solar.tech.controller.framework;

import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.DuanxinExample;
import com.solar.tech.service.DuanxinExampleService;
import com.solar.tech.util.Current;
/**
 * 类名：InfoController 
 * 功能描述：短信提醒---短信模板
 */
@Controller
@RequestMapping("/framework/duanxin")
public class DuanxinExampleController {
	@Resource
	private DuanxinExampleService duanxinExampleService;
	
	/**
	 * 功能描述：获得所有短信模板列表
	 *
	 * @return 
	 */
	@RequestMapping("/getExampleList.action")
	@ResponseBody
	public Map<String, Object> getExampleList(int page, int rows){
		Map<String, Object> map = new HashMap<String, Object>();
		map = duanxinExampleService.getExampleList(page, rows);
		if(map.size()>0){
			map.put("msg", 1);
		}else{
			map.put("msg", 0);
		}
		return map;
	}
	
	
	/**
	 * 功能描述：添加新的短信模板
	 *
	 * @return Serializable
	 */
	@RequestMapping("/addExample.action")
	@ResponseBody
	public Map<String, Object> addExample(DuanxinExample duanxinExample,String creamTime){
		Map<String, Object> map = new HashMap<String, Object>();
	    String userName = Current.user().getUserName();
	    duanxinExample.setUserName(userName);
	    duanxinExample.setCreamTime(new Timestamp(new Date().getTime()));
	    int i = duanxinExampleService.addExample(duanxinExample);
	    if(i==1){
	    	map.put("msg","1");
	    }else{
	    	map.put("msg","0");
	    }
		return map;
	}
	
	/**
	 * 功能描述：删除
	 *
	 * @param ids
	 * @return
	 *
	 * @return int
	 */
	@RequestMapping("/deleteExample.action")
	@ResponseBody
	public Map<String, Object> deletePhoneNum(String ExampleID) {
	     Map<String, Object> map = new HashMap<String, Object>(); 
	     try {
	    	 int i = duanxinExampleService.deleteExample(ExampleID);
	    	 if(i == 1){
	    		 map.put("state", 1);
				 map.put("msg", "success");
				 return map;
	    	 }
			 map.put("state", 0);
			 map.put("msg", "数据删除失败");
	     } catch (Exception e) {
	    	 map.put("state", -1);
	    	 map.put("msg", e.getMessage());
	     }
	     return map;
	 }
	
	/**
	 * 功能描述：更新模板
	 *
	 * @param visa
	 *
	 * @return void
	 */
	@RequestMapping("/updateExample.action")
	@ResponseBody
	public Map<String, Object> updateExample(DuanxinExample duanxinExample,String id){
		duanxinExample.setID(id);
		duanxinExample.setUpdateTime(new Timestamp(new Date().getTime()));
		Map<String, Object> map = new HashMap<String, Object>();
		duanxinExampleService.updateExample(duanxinExample);
		map.put("state", 1);
		return map;
	}
	
	/**
	 * 功能描述：查找
	 *
	 * @param id
	 * @param map
	 *
	 * @return String
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("/findExample.action")
	@ResponseBody
	public Map<String, Object> findExample(String banPeople,int page, int rows,HttpServletRequest req, HttpServletResponse resp) throws UnsupportedEncodingException{
		Map<String, Object> map =new HashMap<String, Object>();
		banPeople = new String(banPeople.getBytes("iso8859-1"),"utf-8");
		map = duanxinExampleService.findExample(banPeople, page, rows);
		return map;
	}
	
}
