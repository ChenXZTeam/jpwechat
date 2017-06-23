package com.solar.tech.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.entity.yhNum;
import com.solar.tech.dao.GenericDao;

@Service
@Transactional
public class yhNumService {
    
	@Resource
	private GenericDao gDao;
	
	public void update(String number,String stauts){
		
		yhNum yh=new yhNum();
		yh.setID("402881e656b0f41a0156b0f9dc5a0000");
		yh.setNumber(number);
		yh.setStatus("0");
		this.gDao.update(yh);
	    
	
	}
	
	public void gengx(String number){
		yhNum yh=new yhNum();
		yh.setID("402881e656b0f41a0156b0f9dc5a0000");
		yh.setNumber(number);
		yh.setStatus("1");
		this.gDao.update(yh);
	}
	
	public List<yhNum> gengx(){
		List<yhNum> yh = this.gDao.find("FROM yhNum WHERE ID = '402881e656b0f41a0156b0f9dc5a0000'");
		return yh;
	}
	
}
