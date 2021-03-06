package com.solar.tech.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.solar.tech.bean.AbstractUser;
import com.solar.tech.bean.User;
import com.solar.tech.bean.entity.RD_wechatUser;
import com.solar.tech.controller.AbstractUserController;
import com.solar.tech.dao.GenericDao;
import com.solar.tech.users.UserService;

/**
 * 用户注册类
 * @author solarpc1
 *
 */
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
		int j = userService.addUserinGroup(user.getUserUID());
		if(i==1&&j==1){
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
	
	 @RequestMapping({"/update.action"})
	 @ResponseBody
	 public String updateUser(String userUID, @RequestParam("userName") String userName, String userType, String userClass, Integer userStatus, String email, String headImg, MultipartFile headImgFile, String mobile, String userExtProps, String description)
	     throws IllegalStateException, IOException
	 {
	     Map<String, Object> dataResult = new HashMap<String, Object>();
	     AbstractUser user = this.userService.get(userUID);
	     user.setUserUID(userUID);
	     user.setUserName(userName);
	     user.setUserType(userType);
	     if (userClass != null) user.setUserClass(userClass);
	     user.setUserStatus(userStatus);
	     user.setEmail(email);
	     user.setMobile(mobile);
	     user.setUserExtProps(userExtProps);
	     user.setDescription(description);
	     user.setHeadImg(headImg);
	     this.userService.updateUser(user, headImgFile);
	     dataResult.put("success", Boolean.valueOf(true));
	     return "";
	 }

	@RequestMapping("/findAllUser.action")
	@ResponseBody
	public List<RD_wechatUser> findAllUser(){
		return userService.findAllUser();
	}
}
