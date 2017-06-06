package com.solar.tech.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.entity.CTCTnum;
import com.solar.tech.dao.GenericDao;

@Service
@Transactional
public class CTCTnumService {
	@Resource
	private GenericDao gDao;
	
	public List<CTCTnum> getInfoList(){
		List<CTCTnum> ctctbn = this.gDao.find("FROM CTCTnum");
		return ctctbn;
	}
	
	public void update(String uuid,String phone){
		CTCTnum ct = new CTCTnum();
		ct.setUuid(uuid);
		ct.setPhoneNum(phone);
		this.gDao.update(ct);
	}
}
