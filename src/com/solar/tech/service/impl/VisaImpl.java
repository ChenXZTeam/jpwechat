package com.solar.tech.service.impl;

import java.io.Serializable;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.criterion.Example;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.Countries;
import com.solar.tech.bean.RequiredMaterials;
import com.solar.tech.bean.Visa;
import com.solar.tech.bean.VisaFree;
import com.solar.tech.bean.VisaOrder;
import com.solar.tech.dao.GenericDao;
import com.solar.tech.service.VisaService;

import net.sf.json.JSONArray;

@Service
@Transactional
public class VisaImpl implements VisaService{

	@Resource
	private GenericDao gDao;
	
	@Override
	public List<Visa> getVisaList() {
		return gDao.findAll(Visa.class);
	}

	@Override
	public Serializable addVisa(Visa visa) {
		return gDao.save(visa);
	}

	@Override
	public int deleteVisa(String ids) {
		JSONArray arr = JSONArray.fromObject(ids);
		String[] codeList = new String[arr.size()];
		for (int i=0;i<arr.size();i++) {
			codeList[i]=(String) arr.get(i);
		}
		return this.gDao.deleteByIds(Visa.class, codeList);
	}

	@Override
	public void updateVisa(Visa visa) {
		this.gDao.update(visa);
	}

	@Override
	public List<Visa> findByCountry(Visa visa) {
		List<Countries> countries = this.gDao.findAll(Countries.class);
		for (Countries country : countries) {
			if(visa.getCountry().equals(country.getId())){
				System.out.println(visa.getCountry()+":"+country.getId());
				visa.setCountry(country.getName());
			}
		}
		return this.gDao.getSession().createCriteria(visa.getClass().getName())
				.add(Example.create(visa).excludeProperty("earlyDates").excludeProperty("visaPrice")).list();
	}
	
	@Override
	public Visa findByID(String id) {
		return this.gDao.findById(Visa.class, id);
	}

	@Override
	public VisaFree findByVisaFreeID(String id) {
		return this.gDao.findById(VisaFree.class, id);
	}

	@Override
	public List<VisaFree> getVisaFreeList() {
		return this.gDao.findAll(VisaFree.class);
	}

	@Override
	public Serializable addVisaFree(VisaFree visaFree) {
		String countryID = visaFree.getCountryName();
		visaFree.setCountryID(countryID);
		Countries country = this.gDao.findById(Countries.class, countryID);
		visaFree.setCountryName(country.getName());
		return this.gDao.save(visaFree);
	}

	public static void main(String[] args) {
		ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
		VisaImpl gDao = ctx.getBean("visaImpl",VisaImpl.class);
		VisaFree visaFree = gDao.findByVisaFreeID("JP");
		System.out.println(visaFree);
	}

	@Override
	public void updateVisaFree(VisaFree visaFree) {
		Countries country = this.gDao.findById(Countries.class, visaFree.getCountryID());
		visaFree.setCountryName(country.getName());
		this.gDao.update(visaFree);
	}

	@Override
	public int deleteVisaFree(String ids) {
		JSONArray arr = JSONArray.fromObject(ids);
		String[] codeList = new String[arr.size()];
		for (int i=0;i<arr.size();i++) {
			codeList[i]=(String) arr.get(i);
		}
		return this.gDao.deleteByIds(VisaFree.class, codeList);
	}

	@Override
	public Serializable addVisaOrder(VisaOrder visaOrder) {
		Visa visa = gDao.findById(Visa.class, visaOrder.getVisaID());
		visaOrder.setVisaTitle(visa.getVisaTitle());
		return this.gDao.save(visaOrder);
	}

	@Override
	public List<VisaOrder> getVisaOrderList() {
		return this.gDao.findAll(VisaOrder.class);
	}

	@Override
	public void updateVisaOrder(VisaOrder visaOrder) {
		Visa visa = gDao.findById(Visa.class, visaOrder.getVisaID());
		visaOrder.setVisaTitle(visa.getVisaTitle());
		this.gDao.update(visaOrder);
	}

	@Override
	public int deleteVisaOrder(String ids) {
		JSONArray arr = JSONArray.fromObject(ids);
		String[] codeList = new String[arr.size()];
		for (int i=0;i<arr.size();i++) {
			codeList[i]=(String) arr.get(i);
		}
		return this.gDao.deleteByIds(VisaOrder.class, codeList);
	}

	@Override
	public Serializable addRequiredMaterials(RequiredMaterials requiredMaterials) {
		return this.gDao.save(requiredMaterials);
	}

	@Override
	public List<RequiredMaterials> getRequiredMaterialsList() {
		return this.gDao.findAll(RequiredMaterials.class);
	}

	@Override
	public void updateRequiredMaterials(RequiredMaterials requiredMaterials) {
		this.gDao.update(requiredMaterials);
	}

	@Override
	public int deleteRequiredMaterials(String ids) {
		JSONArray arr = JSONArray.fromObject(ids);
		String[] codeList = new String[arr.size()];
		for (int i=0;i<arr.size();i++) {
			codeList[i]=(String) arr.get(i);
		}
		return this.gDao.deleteByIds(RequiredMaterials.class, codeList);
	}

	@Override
	public RequiredMaterials findByMaterialsID(String id) {
		return this.gDao.findById(RequiredMaterials.class, id);
	}
}
