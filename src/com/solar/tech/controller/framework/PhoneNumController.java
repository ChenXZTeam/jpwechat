package com.solar.tech.controller.framework;

import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.solar.tech.bean.PhoneNum;
import com.solar.tech.service.PhoneNumService;
import com.solar.tech.util.Current;
/**
 * 类名：InfoController 
 * 功能描述：短信提醒--手机号码的业务操作
 */
@Controller
@RequestMapping("/framework/phoneNum")
public class PhoneNumController {
	@Resource
	private PhoneNumService phoneNumService;
	
	/**
	 * 功能描述：获得所有手机号列表
	 *
	 * @return 
	 */
	@RequestMapping("/getPhoneNumList.action")
	@ResponseBody
	public Map<String, Object> getPhoneNumList(int page, int rows){
		Map<String, Object> map = new HashMap<String, Object>();
		map = phoneNumService.getPhoneNumList(page, rows);
		if(map.size()>0){
			map.put("msg", 1);
		}else{
			map.put("msg", 0);
		}
		return map;
	}
	
	@RequestMapping("/getKeyFz.action")
	@ResponseBody
	public Map<String, Object> getKeyFz(int page, int rows,String keyVal){
		Map<String, Object> map = new HashMap<String, Object>();
		map = phoneNumService.getKeyFz(page, rows, keyVal);
		if(map.size()>0){
			map.put("msg", 1);
		}else{
			map.put("msg", 0);
		}
		return map;
	}
	
	
	/**
	 * 功能描述：添加新的手机号
	 *
	 * @return Serializable
	 */
	@RequestMapping("/addPhoneNum.action")
	@ResponseBody
	public Map<String, Object> addInfo(PhoneNum phoneNum,HttpServletRequest request, HttpServletResponse response, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		Enumeration<String> paramNames = request.getParameterNames();   
	    // 通过循环将表单参数放入键值对映射中  
	    while(paramNames.hasMoreElements()) {  
	       String key = paramNames.nextElement();  
	       String value = request.getParameter(key); 
	       if(key.equals("phoneNumber"))phoneNum.setPhoneNumber(value); 
	    }
	    String userName = Current.user().getUserName();
	    phoneNum.setUserName(userName);
	    phoneNum.setCreateTime(new Timestamp(new Date().getTime())); //创建时间赋值
	    int i = phoneNumService.addPhoneNum(phoneNum);
	    if(i==1){
	    	map.put("msg","1");
	    }else{
	    	map.put("msg","0");
	    }
		return map;
	}
	
	/**
	 * 功能描述：删除手机号码
	 * 
	 *
	 * @param ids
	 * @return
	 *
	 * @return int
	 */
	@RequestMapping("/deletePhoneNum.action")
	@ResponseBody
	public Map<String, Object> deletePhoneNum(String phoneID) {
	     Map<String, Object> map = new HashMap<String, Object>(); 
	     try {
	    	 int i = phoneNumService.deletePhoneNum(phoneID);
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
	 * 功能描述：更新手机号的信息
	 *
	 * @param visa
	 *
	 * @return void
	 */
	@RequestMapping("/updatePhoneNum.action")
	@ResponseBody
	public Map<String, Object> updatePhoneNum(PhoneNum phoneNum){
		Map<String, Object> map = new HashMap<String, Object>();
		phoneNum.setCreateTime(new Timestamp(new Date().getTime())); //创建时间赋值
		phoneNumService.updatePhoneNum(phoneNum);
		map.put("state", 1);
		return map;
	}
	
	/**
	 * 功能描述：根据手机号查找信息
	 *
	 * @param id
	 * @param map
	 *
	 * @return String
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("/findPhoneNum.action")
	@ResponseBody
	public Map<String, Object> findPhoneNum(String phoneNumber,int page, int rows,HttpServletRequest req, HttpServletResponse resp) throws UnsupportedEncodingException{
		Map<String, Object> map =new HashMap<String, Object>();
		phoneNumber = new String(phoneNumber.getBytes("iso8859-1"),"utf-8");
		map = phoneNumService.findPhoneNumByID(phoneNumber, page, rows);
		return map;
	}
	
	/**
	 * 功能描述：查看
	 *
	 * @param id
	 * @param map
	 *
	 * @return String
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("/findPhoneByID.action")
	@ResponseBody
	public Map<String, Object> findPhoneByID(String phoneID) throws UnsupportedEncodingException{
		Map<String, Object> map =new HashMap<String, Object>();
		map = phoneNumService.findPhoneByID(phoneID);
		if(map.size()>0){
			map.put("msg", 1);
		}else{
			map.put("msg", 0);
		}
		return map;
	}
	
	
	 /** 
     * 读取excel报表 
	 * @throws Exception 
     */  
    @RequestMapping(value = "/importExcel.action", method = RequestMethod.POST)  
    @ResponseBody
    public Map<String, Object> getReadReport(@RequestParam(value="file") MultipartFile file)  
            throws Exception {  
    	if(file.isEmpty()){
    		return null;
    	}
    	
    	Map<String, Object> map = new HashMap<String, Object>();
    	String resulMsg = phoneNumService.readReports(file.getInputStream(), file.getOriginalFilename()); 
    	if(resulMsg.equals("")||resulMsg==null){
    		map.put("state", 0);
    		map.put("msgRe", resulMsg);
    		return map;
        }else{
            map.put("state", 1);
            return map;
        }
    }  
}
