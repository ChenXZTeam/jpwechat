package com.solar.tech.controller.wechat;

import java.sql.Timestamp;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.entity.RD_wechatUser;
import com.solar.tech.service.RDwechatUserService;

@Controller
@RequestMapping("/wechatController/register")
public class RDwechatUserController {
	@Autowired
	private RDwechatUserService RDUserService;
	
	@RequestMapping("/add.action")
	@ResponseBody
	public String addUser(String userName, String password, String userPhone,String aoqing, HttpSession session) {
		System.out.println("userName: "+userName+", password: "+password+"userPhone: "+userPhone+", aoqing: "+aoqing);
		String isSuccess = "false";
		
		//if(number == null) {
			//return isSuccess;
		//}
		String openId = (String) session.getAttribute("openId");
		session.setAttribute("userPhone", userPhone);
		session.setAttribute("userName", userName);
		System.out.println(openId);
		if(openId == null) {
			return isSuccess;
		}
		
		RD_wechatUser RD_User= new RD_wechatUser();
		RD_User.setOpenID(openId);
		RD_User.setPhoneNum(userPhone);
		RD_User.setUserName(userName);
		RD_User.setInCode(aoqing);
		RD_User.setID(UUID.randomUUID().toString().replace("-", ""));
		RD_User.setBindTime(new Timestamp(new Date().getTime()));
		
		//int i = RDUserService.addUser(RD_User);
		//if(i == 1) {
		//	isSuccess = "true";
		//}

		return isSuccess;
	}
}
