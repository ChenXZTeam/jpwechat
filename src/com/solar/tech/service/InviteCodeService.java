package com.solar.tech.service;

import java.util.List;
import java.util.Map;

import com.solar.tech.bean.InvitationCode;

/**
 * 接口名：InviteCodeService 
 *
 * 功能描述：这是邀请码接口，这里定义了业务逻辑用到的抽象方法
 *
 * @author 曾令维
 *
 * Version info版本号：V1.0
 * © Copyright 续日科技 2016年7月29日  版权所有
 */
public interface InviteCodeService {
	
	/**
	 * 功能描述：生成邀请码并添加到数据库中
	 *
	 * @param invitationCode
	 * @param deadline_
	 *
	 * @return void
	 */
	void generateUUID(InvitationCode invitationCode,String deadline_);

	/**
	 * 功能描述：获取邀请码列表
	 *
	 * @return List<InvitationCode>
	 */
	Map<String, Object> getCodeList(int page, int rows);
	
	/**
	 * 功能描述：根据id删除对应的邀请码
	 *
	 * @param ids
	 *
	 * @return int
	 */
	int deleteCode(String ids);
	
	/**
	 * 功能描述：根据前端传来的InvitationCode对象到数据库中找到对应的，并将其更新
	 *
	 * @param invitationCode
	 * @param deadline_
	 *
	 * @return void
	 */
	void updateCode(InvitationCode invitationCode,String deadline_);
	
	/**
	 * 
	 * */
	Map<String, Object> findByid(String id);
	
	/**
	 * 
	 * @param invitationCode
	 * @param PhoneNum
	 * @return 
	 */
	
	int updateinvatecode(String invitationCode,String PhoneNum,String ivID);
}
