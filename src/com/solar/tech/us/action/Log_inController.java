package com.solar.tech.us.action;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Scope;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.us.entity.Result;
import com.solar.tech.us.service.LoginService;

@Controller
//@Scope("prototype")
@RequestMapping("/user")
public class Log_inController {
	@Resource
	private LoginService loginService;
	
	@RequestMapping("/login.action")
	@ResponseBody
	public Result execute(String username, String password){
		Result result = loginService.checkLogin(username, password);
		System.out.println("LoginController: "+username+", "+password);
		return result;
	}
	
//	public static void main(String[] args) {
//		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
//		Log_inController dao = ac.getBean("log_inController", Log_inController.class);
//		
//		Result result = dao.execute("hh","password");
//		System.out.println("快乐");
//	}
}
