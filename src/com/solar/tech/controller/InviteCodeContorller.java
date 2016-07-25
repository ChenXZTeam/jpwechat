package com.solar.tech.controller;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.solar.tech.bean.InvitationCode;
import com.solar.tech.service.InviteCodeService;

@Controller
@RequestMapping("/framework/invite")
public class InviteCodeContorller {
	
	@Resource
	private InviteCodeService inviteCodeService;
	
	@RequestMapping("/addInviteID.action")
	@ResponseBody
	public void addInvaiteID(InvitationCode invitationCode,String deadline_){
		this.inviteCodeService.generateUUID(invitationCode,deadline_);
	}
	
	@RequestMapping("/getAllInvitCode.action")
	@ResponseBody
	public List<InvitationCode> getAllInvitationCode(){
		return this.inviteCodeService.getCodeList();
	}
	
	@RequestMapping("/deleteCode.action")
	@ResponseBody
	public int deleteCode(String ids){
		return this.inviteCodeService.deleteCode(ids);
	}
	
	@RequestMapping("/updateCode.action")
	@ResponseBody
	public void update(InvitationCode invitationCode,String deadline_){
		System.out.println(invitationCode+","+deadline_);
		this.inviteCodeService.updateCode(invitationCode, deadline_);
	}
}
