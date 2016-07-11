package com.solar.tech.controller;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.Domain;
import com.solar.tech.bizmodel.DomainService;



@Controller
@RequestMapping("/framework")
public class DomainController {
	@Resource(name="domainService")
	private DomainService service;
	
	
	
	public DomainService getService() {
		return service;
	}



	public void setService(DomainService service) {
		this.service = service;
	}



	@RequestMapping(value="/model/addDomain.action")
	@ResponseBody
	public Map<String,Object> addDomain(Domain domain){
		Map<String,Object>result=new HashMap<String,Object>();
		service.addDomain(domain);
		result.put("success", true);
		return result;
	}
	
	
	@RequestMapping("/model/updateDomain.action")
	@ResponseBody
	public Map<String,Object> updateDomain(Domain domain){
		Map<String,Object>result=new HashMap<String,Object>();
		service.updateDomain(domain);
		result.put("success", true);
		return result;
	}
	
	
	@RequestMapping("/model/deleteDomain.action")
	@ResponseBody
	public Map<String,Object> deleteDomain(@RequestParam("ids[]") List<Integer> ids){
		Map<String,Object>result=new HashMap<String,Object>();
		List<Serializable> domainIds=new ArrayList<Serializable>();
		System.out.println(new JSONArray(ids));
		for(Integer id :ids)
			domainIds.add(id);
		service.deleteDomain(domainIds);
		result.put("success", true);
		return result;
	}
	
	
	@RequestMapping("/model/getDomainPage.action")
	@ResponseBody
	public Map<String,Object> getDomainPage(int page,int rows){
		Map<String,Object>result=new HashMap<String,Object>();
		
		List<Domain>domains=service.getDomainPage(page, rows);
		result.put("total", service.getDomainNum());
		result.put("rows", domains);
		return result;
	}
	
	@RequestMapping("/model/getDomains.action")
	@ResponseBody
	public List<Domain> getDomains(){
		return service.getDomains();
	}
	
	@RequestMapping("/model/getSelectDomains.action")
	@ResponseBody
	public List<Domain> getSelectDomains(){
		List<Domain> domains= new LinkedList<Domain>();
		Domain d=new Domain();
		d.setDomainId(0);
		d.setDomainCName("所有数据域");
		domains.add(0, d);
		domains.addAll(service.getDomains());
		return domains;
	}
	
	
	
}
