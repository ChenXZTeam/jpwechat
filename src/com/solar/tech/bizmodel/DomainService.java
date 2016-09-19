package com.solar.tech.bizmodel;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.solar.tech.bean.Domain;
import com.solar.tech.dao.GenericDao;


@Service("domainService")
public class DomainService {
	
	@Resource(name="genericDao")
	private GenericDao dao;

	public void addDomain(Domain domain){
		
		dao.save(domain);
	}
	
	public void addDomainBatch(List<Domain> domains){
		dao.save(domains);
	}
	
	public void updateDomain(Domain domain){
		dao.saveOrUpdate(domain);
	}
	
	
	public void deleteDomain(List<Serializable> domainIds){
		dao.deleteByIds(Domain.class, domainIds);
	}

	public int getDomainNum(){
		return dao.count(Domain.class,"").intValue();
	}
	public List<Domain>getDomainPage(int page,int rows){
		List<Domain> domains=new ArrayList<Domain>();
		domains=dao.findByPage(Domain.class, page, rows);
		return domains;
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public GenericDao getDao() {
		return dao;
	}

	public void setDao(GenericDao dao) {
		this.dao = dao;
	}

	public List<Domain> getDomains() {
		return dao.findAll(Domain.class);
	}
	
	
	public void addException() throws Exception{
		throw new Exception("转换 异常");
	}
	

}
