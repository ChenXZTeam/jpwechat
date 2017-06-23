package com.solar.tech.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.entity.userOrderInfo;
import com.solar.tech.dao.GenericDao;

@Service
@Transactional
public class AverTekDateService {
	@Resource
	private GenericDao gDao;
	
	public List<userOrderInfo> getlist(String starTime, String overTime){
		List<userOrderInfo> listorder = this.gDao.find("FROM userOrderInfo WHERE createTime >= '"+starTime+" 00:00:00' AND createTime <= '"+overTime+" 23:59:59'");
		return listorder;
	}
}
