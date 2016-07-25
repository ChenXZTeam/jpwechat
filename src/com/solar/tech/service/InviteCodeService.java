package com.solar.tech.service;

import java.util.List;
import com.solar.tech.bean.InvitationCode;


public interface InviteCodeService {
	
	//生成邀请码并添加到数据库中
	void generateUUID(InvitationCode invitationCode,String deadline_);

	//获取邀请码列表
	List<InvitationCode> getCodeList();
	
	//删除邀请码
	int deleteCode(String ids);
	
	//更新某条记录
	void updateCode(InvitationCode invitationCode,String deadline_);
}
