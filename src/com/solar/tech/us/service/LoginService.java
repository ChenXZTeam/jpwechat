package com.solar.tech.us.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.User;
import com.solar.tech.dao.GenericDao;
import com.solar.tech.us.entity.Result;
import com.solar.tech.us.util.Encode;

@Service
@Transactional
public class LoginService {
//	@Resource
	@Autowired
	private GenericDao dao;
	
	public Result checkLogin(String username, String password){
		System.out.println("LoginService: "+username+", "+password);
		
		List<Object> params=new ArrayList<Object>();
		params.add(username);
		String sql="from User u where u.userName=?";
//		String sql="from Fw_User u where u.userName=?";
		List<User> list=dao.getListByHql(User.class, sql, params);
		System.out.println("list:"+ list.size());
		
//		if(list.size()>0)
//			return list.get(0);
//		else
//			return null;
		
		Result result = new Result();
		User user = null;
		if(list.size()>0){
			user = list.get(0);
		}
//		User user = userDao.findByName(name);
		if(user == null){
			result.setStatus(1);
			result.setMsg("用户名不存在");
			return result;
		}
		//将用户输入明文加密
		String md5_pwd = Encode.MD5(password).toLowerCase();
		System.out.println("加密后："+md5_pwd);
		//比对加密后的密码
		if(user.getPassword().equals(md5_pwd)){
//		if(password.equals(user.getPassword())){
			result.setStatus(0);
			result.setMsg("用户名和密码正确");
//			result.setData("redirect:framework/index.action");
			result.setData("redirect:../framework/index.action");
			return result;
		}else{
			result.setStatus(2);
			result.setMsg("密码不正确");
			return result;
		}
		
	
//		if(list.size()>0){
//			User user = list.get(0);
//			if(user!=null){
//				if(password.equals(user.getPassword())){
//					//HttpSession session=req.getSession();
//					//session.setAttribute("user", list.get(0));
//					return "redirect:framework/index.action";				
//				}else{
//					req.setAttribute("msg", "密码错误！");
//					return "us/login";
//				}
//			}
//			return null;
//		}else {
//			req.setAttribute("msg", "用户不存在！");
//			return "us/login";
//		}
	}
}
