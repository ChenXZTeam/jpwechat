package com.solar.tech.controller;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.solar.tech.bean.InvitationCode;
import com.solar.tech.service.InviteCodeService;

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
	public List<InvitationCode> getAllInvitationCode(){
		return this.inviteCodeService.getCodeList();
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
}
