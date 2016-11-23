package com.solar.tech.controller;

import java.io.IOException;
import java.net.MalformedURLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.solar.tech.bean.InvitationCode;
import com.solar.tech.service.InviteCodeService;
import com.solar.tech.service.impl.InvitationCodeImpl;
import com.solar.tech.utils.Send106msg;

/**
 * 类名：InviteCodeContorller  
 *
 * 功能描述：此类为邀请码模块的Controller类，负责接收、处理和分发邀请码功能模块的请求
 *
 * @author 曾令维
 *
 * Version info版本号：V1.0
 * © Copyright 续日科技 2016年7月29日  版权所有
 */
@Controller
@RequestMapping("/framework/invite")
public class InviteCodeContorller {
	
	@Resource
	private InviteCodeService inviteCodeService;
	
	/**
	 * 功能描述：接收前端传来的InvitationCode对象并将其存入数据库
	 *
	 * @param invitationCode
	 * @param deadline_
	 *
	 * @return void
	 */
	@RequestMapping("/addInviteID.action")
	@ResponseBody
	public void addInvaiteID(InvitationCode invitationCode,String deadline_){
		this.inviteCodeService.generateUUID(invitationCode,deadline_);
	}
	
	/**
	 * 功能描述：查找所有的InvitationCode对象并将结果返回到前端
	 *
	 * @return List<InvitationCode>
	 */
	@RequestMapping("/getAllInvitCode.action")
	@ResponseBody
	public Map<String, Object> getAllInvitationCode(int page, int rows){
		System.out.println(page+", "+rows);
		return this.inviteCodeService.getCodeList(page,rows);
	}
	
	/**
	 * 功能描述：根据前端传来的ID找到对应的InvitationCode对象并将其删除，返回执行结果到前端
	 *
	 * @param ids
	 *
	 * @return int
	 */
	@RequestMapping("/deleteCode.action")
	@ResponseBody
	public int deleteCode(String ids){
		return this.inviteCodeService.deleteCode(ids);
	}
	
	/**
	 * 功能描述：接收前端传来的InvitationCode对象并在数据库中找到此对象将其更新
	 *
	 * @param invitationCode
	 * @param deadline_
	 *
	 * @return void
	 */
	@RequestMapping("/updateCode.action")
	@ResponseBody
	public void update(InvitationCode invitationCode,String deadline_){
		this.inviteCodeService.updateCode(invitationCode, deadline_);
	}
	
	/**
	 * 根据邀请码的id查找邀请码数据
	 * @param id
	 */
	@RequestMapping("/findByid.action")
	@ResponseBody
	public Map<String, Object> findByid(String id){
		return this.inviteCodeService.findByid(id);
	}
	
	
	/*
	 * 功能描述：把折扣信息发送到选中的用户当中去
	 * @param telnumber
	 * @param invitationCode
	 * return 1
	 * */
	@RequestMapping("/send.action")
	@ResponseBody
	public int send(String telnumber, String invitationCode, String ivID){
		System.out.println(telnumber+", "+invitationCode+", "+ivID); 
		Send106msg sender = new Send106msg();
		String resultNum = null;
		int i = this.inviteCodeService.updateinvatecode(invitationCode, telnumber, ivID);
		if(i==1){
			try {
				resultNum = sender.SendMSGtoPhone("【微信】邀请码为："+invitationCode, telnumber);
			} catch (MalformedURLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return 1;
		}else{
			return 0;
		}
	
	}
	
}
