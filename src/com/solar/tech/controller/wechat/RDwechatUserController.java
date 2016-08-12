package com.solar.tech.controller.wechat;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.entity.RD_wechatUser;
import com.solar.tech.service.RDwechatUserService;
import com.solar.tech.dbutil.Encode;
import com.solar.tech.us.service.LoginService;
import com.solar.tech.util.Current;
import com.solar.tech.utils.Send106msg;
import com.solar.tech.utils.Sender;

@Controller
@RequestMapping("/wechatController")
public class RDwechatUserController {
	@Autowired
	private RDwechatUserService RDUserService;
	
	@RequestMapping("/register/add.action")
	@ResponseBody
	public Map<String, Object> addUser(String userName, String password, String userPhone,String aoqing, HttpSession session) {
		System.out.println("userName: "+userName+", password: "+password+", userPhone: "+userPhone+", aoqing: "+aoqing);
		Map<String, Object> map = new HashMap<String, Object>();
		String openId = (String) session.getAttribute("openId");
		session.setAttribute("userPhone", userPhone);
		session.setAttribute("userName", userName);
		//对密码进行加密
		String newPassWord=Current.md5(password);
		
		if(openId == null) {
			System.out.println(openId);
		}
		
		RD_wechatUser RD_User= new RD_wechatUser();
		RD_User.setUserName(userName);
		RD_User.setPassWord(newPassWord); 
		RD_User.setPhoneNum(userPhone);
		RD_User.setInCode(aoqing);
		RD_User.setOpenID(openId);
		RD_User.setID(UUID.randomUUID().toString().replace("-", ""));
		RD_User.setBindTime(new Timestamp(new Date().getTime()));
		
		int i = RDUserService.addUser(RD_User);
		if(i == 1) {
			map.put("msg",1);
			System.out.println("注册成功");
		}else{
			map.put("msg",0);
			System.out.println("注册失败");
		}

		return map;
	}
	
	/**
	 * @title message() 获取短信验证码
	 * @param userName
	 * @param phone
	 * @param session
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping("/register/message.action")
	@ResponseBody
	public String message(String phoneNum, HttpSession session) throws UnsupportedEncodingException {
		String result = "-1";
		Send106msg sender = new Send106msg();
		Random random = new Random();
		String a = random.nextInt(10) + "";
		String b = random.nextInt(10) + "";
		String c = random.nextInt(10) + "";
		String d = random.nextInt(10) + "";
		String code = a + b + c + d;
		session.setAttribute("code", code);
		session.setAttribute("phone", phoneNum);
		System.out.println(code);
		String resultNum = null;
		try {
			resultNum = sender.SendMSGtoPhone("【微信公众号机票预定平台短信验证】验证码为："+code, phoneNum);
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		//boolean success = sender.msg(phoneNum, code);
		if(resultNum=="1") {
			/*对生成的验证码进行md5加密，传到页面*/
			result = Encode.MD5(code);
		}
		System.out.println(result);
		return result;

	}
	
	@RequestMapping("/register/userNameIsExist.action")
	@ResponseBody
	public Map<String, Object> IsExist(String userName){
		Map<String, Object> map = new HashMap<String, Object>();
		//System.out.println(userName);
		boolean isExist = RDUserService.IsExistServ(userName);
		if(!isExist){
			map.put("msg", 1);
		}else{
			map.put("msg", 0);
		}
		return map;
	}
	   
	@RequestMapping({"/wechat/login.action"})
	@ResponseBody
	public Map<String, Object> wechatLogo(String userName,String PassWord,HttpServletRequest httpReq, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		String PassWords=Current.md5(PassWord);
		boolean YesOrNo = RDUserService.loginService(userName,PassWords);  
		if(YesOrNo==true){
			session.setAttribute("userName", userName);
			String path = httpReq.getContextPath();
		    String basePath = httpReq.getScheme() + "://" + httpReq.getServerName() + ":" + httpReq.getServerPort() + path + "/";
		    map.put("url", basePath+"wechatController/page/index.action");//传递地址到前台，实现页面的跳转
			map.put("msg", 1);
		}else{
			map.put("msg", 0);
		}		   
		return map;
	}
}
