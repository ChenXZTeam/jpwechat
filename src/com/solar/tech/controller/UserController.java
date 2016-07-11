package com.solar.tech.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.User;
import com.solar.tech.controller.AbstractUserController;
import com.solar.tech.dao.GenericDao;
import com.solar.tech.users.UserService;

@Controller
@RequestMapping("/framework/user")
public class UserController extends AbstractUserController{
	@Resource
	private UserService userService;
	
	@RequestMapping("/shows.action")
	@ResponseBody
	public Map<String, Object> showUsers(int page, int rows){
		Map<String, Object> map = new HashMap<String, Object>();
		map = userService.showUsers(page, rows);
		map.put("success", true);
		return map;
	}
	
	@RequestMapping("/add.action")
	@ResponseBody
	public Map<String, Object> addUser(User user){
		Map<String, Object> map = new HashMap<String, Object>();
		int i = userService.addUser(user);
		if(i==1){
			map.put("success", true);
		}
		return map;
	}
	
	@RequestMapping("/delete.action")
	@ResponseBody
	public Map<String, Object> deleteUser(String userUID){
		Map<String, Object> map = new HashMap<String, Object>();
		userService.deleteUser(userUID);
		map.put("success", true);
		System.out.println(map);
		return map;
	}
}
