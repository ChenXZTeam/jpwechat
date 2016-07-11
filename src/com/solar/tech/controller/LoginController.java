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
 
 @Controller
 public class LoginController
 {
   @RequestMapping({"/login.action"})
   @ResponseBody
   @Transactional
   public Map<String, String> authenticate(@RequestParam("userName") String userName, @RequestParam("password") String password, HttpServletRequest httpReq, HttpSession sess)
   {
     HashMap result = new HashMap();
     if ((userName == null) || 
       (password == null) || 
       (userName.trim().isEmpty()) || 
       (password.trim().isEmpty()))
       throw new RuntimeException("用户名或密码不能为空");
    // System.out.println("jdskjsd");
   /**  UsernamePasswordToken token = new UsernamePasswordToken(userName, password);
     token.setRememberMe(true);
     Subject subject = SecurityUtils.getSubject();
     subject.login(token);
     Object savedReqKey = sess.getAttribute("shiroSavedRequest");
     String savedRequestUrl = savedReqKey == null ? null : ((SavedRequest)savedReqKey).getRequestUrl();
     result.put("url",  savedRequestUrl == null ? httpReq.getContextPath() : savedRequestUrl);
     return result;
     */
     UsernamePasswordToken token = new UsernamePasswordToken(userName, password);   
     token.setRememberMe(true);    
     Subject subject = SecurityUtils.getSubject();     
     subject.login(token);     
//     Object savedReqKey = sess.getAttribute("shiroSavedRequest");
    
     String path = httpReq.getContextPath();
     String basePath = httpReq.getScheme() + "://" + httpReq.getServerName() + ":" + httpReq.getServerPort() + path + "/";
//     String savedRequestUrl = (savedReqKey.toString().indexOf("console"))!= -1  ? ((SavedRequest)savedReqKey).getRequestUrl() :basePath+ "console/login.jsp";
    // String savedRequestUrl = savedReqKey != null ? ((SavedRequest)savedReqKey).getRequestUrl() : null;
    // System.out.println("url: "+savedRequestUrl);
    // String savedRequestUrl =basePath+ "console/login.jsp";
     String savedRequestUrl =basePath+ "framework/index.action";
     result.put("url", savedRequestUrl != null ? ((Object) (savedRequestUrl)) : ((Object) (httpReq.getContextPath())));
     return result;
   }
 
   @RequestMapping({"/logout.action"})
   public String logout() {
     SecurityUtils.getSubject()
       .logout();
     return "./login";
   }
 }

