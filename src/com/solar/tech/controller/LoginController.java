 package com.solar.tech.controller;
 
 import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.util.SavedRequest;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.listener.sessionLister;
 
 @Controller
 public class LoginController
 {
   @RequestMapping({"/login.action"})
   @ResponseBody
   @Transactional
   public Map<String, Object> authenticate(@RequestParam("userName") String userName, @RequestParam("password") String password, HttpServletRequest httpReq, HttpSession sess)
   {
	 Map<String, Object> result = new HashMap<String, Object>();
     sessionLister sesslis = new sessionLister();
	 String ss = sesslis.userLogin(userName,password,httpReq,sess);
     
     if ((userName == null)||(password == null)||(userName.trim().isEmpty())||(password.trim().isEmpty()))
       throw new RuntimeException("用户名或密码不能为空");

     /*UsernamePasswordToken token = new UsernamePasswordToken(userName, password);   
     token.setRememberMe(true);    
     Subject subject = SecurityUtils.getSubject();     
     subject.login(token);     */
    
     String path = httpReq.getContextPath();
     String basePath = httpReq.getScheme() + "://" + httpReq.getServerName() + ":" + httpReq.getServerPort() + path + "/";
     String savedRequestUrl =basePath+ "framework/index.action";
     result.put("url", savedRequestUrl != null ? ((Object) (savedRequestUrl)) : ((Object) (httpReq.getContextPath())));
     result.put("chrdlogin", ss);
     return result;
   }
 
   @RequestMapping({"/logout.action"})
   public String logout() {
     SecurityUtils.getSubject()
       .logout();
     return "./login";
   }
 }

