package com.solar.tech.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.solar.tech.bean.InvitationCode;
import com.solar.tech.dao.GenericDao;
import com.solar.tech.service.InviteCodeService;
import net.sf.json.JSONArray;

/**
 * 类名：InvitationCodeImpl 
 *
 * 功能描述：这是InviteCodeService的实现类，负责邀请码模块的业务逻辑
 *
 * @author 曾令维
 *
 * Version info版本号：V1.0
 * © Copyright 续日科技 2016年7月29日  版权所有
 */
@Service
@Transactional
public class InvitationCodeImpl implements InviteCodeService {
	private static final String[] storeInvitationChars={"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O"
			,"P","Q","R","S","T","U","V","W","X","Y","Z"};
	
	@Resource
	private GenericDao gDao;
	
	
	public void generateUUID(InvitationCode invitationCode,String deadline_){
		String code = new String();
    	Random random = new Random();
    	InvitationCode flag = new InvitationCode();
    	while(flag!=null)	{
    		for(int i=0;i<6;i++){
    			int index = random.nextInt(25);
    			code += storeInvitationChars[index];
    		}
    		flag = this.gDao.findById(InvitationCode.class, code);
    	}
    	invitationCode.setInvitationCode(code);
    	System.out.println(deadline_);
    	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    	Date deadline;
			try {
				deadline = format.parse(deadline_);
				System.out.println(deadline);
				invitationCode.setDeadline(deadline);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	this.gDao.save(invitationCode);
	}

	public List<InvitationCode> getCodeList(){
		List<InvitationCode> list = (List<InvitationCode>) this.gDao.findAll(InvitationCode.class);
		return list;
	}

	@Override
	public int deleteCode(String ids) {
		JSONArray arr = JSONArray.fromObject(ids);
		String[] codeList = new String[arr.size()];
		for (int i=0;i<arr.size();i++) {
			codeList[i]=(String) arr.get(i);
		}
		return this.gDao.deleteByIds(InvitationCode.class, codeList);
	}

	@Override
	public void updateCode(InvitationCode invitationCode, String deadline_) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    	Date deadline;
			try {
				deadline = format.parse(deadline_);
				System.out.println(deadline);
				invitationCode.setDeadline(deadline);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			this.gDao.update(invitationCode);
	}
}
