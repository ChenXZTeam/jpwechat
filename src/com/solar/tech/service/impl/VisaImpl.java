package com.solar.tech.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.hibernate.criterion.Example;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.solar.tech.bean.Countries;
import com.solar.tech.bean.HotCountries;
import com.solar.tech.bean.RequiredMaterials;
import com.solar.tech.bean.Visa;
import com.solar.tech.bean.VisaFree;
import com.solar.tech.bean.VisaOrder;
import com.solar.tech.dao.GenericDao;
import com.solar.tech.service.VisaService;
import com.solar.tech.utils.JSONFile;

import net.sf.json.JSONArray;

/**
 * 类名：VisaImpl 
 *
 * 功能描述：此类为VisaService的实现类，负责处理签证模块的业务逻辑
 *
 * @author 曾令维
 *
 * Version info版本号：V1.0
 * © Copyright 续日科技 2016年7月29日  版权所有
 */
@Service
@Transactional
public class VisaImpl implements VisaService{
	
//	private static String PATH = "images\\HotCountries\\";
	private static String PATH = "D:\\images\\";
	
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
		return this.gDao.save(visaFree);
	}

	@Override
	public void updateVisaFree(VisaFree visaFree) {
		System.out.println(visaFree);
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

	@Override
	public Serializable addHotCountries(HotCountries hotCountries,MultipartFile image) {
//    	String projectPath = request.getSession().getServletContext().getRealPath("")+"\\";
		System.out.println(image);
		String imagePath = hotCountries.getImagePath();
		String suffix = imagePath.substring(imagePath.lastIndexOf("."));
		String newImgName = JSONFile.generateID()+suffix;
		System.out.println(newImgName);
		hotCountries.setImagePath(newImgName);
		if(image!=null){
			try {
				InputStream is = image.getInputStream();
				File file = new File(PATH+newImgName);
				System.out.println(file.getAbsolutePath());
				if(!file.exists()){
					file.createNewFile();
				}
				FileOutputStream fos = new FileOutputStream(file);
				byte[] b = new byte[1024];
				while((is.read(b)) != -1){
					fos.write(b);
				}
				is.close();
				fos.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	    return this.gDao.save(hotCountries);
	}

	@Override
	public List<HotCountries> getHotCountriesList() {
		return this.gDao.findAll(HotCountries.class);
	}

	@Override
	public void updateHotCountries(HotCountries hotCountries,MultipartFile image,String imgOld) {
//			String projectPath = request.getSession().getServletContext().getRealPath("")+"\\";
			if(image!=null){
				File file = new File(PATH+imgOld);
				System.out.println(file.getAbsolutePath());
				if(file.exists()&&file.isFile()){
					file.delete();
				}
				
				String imagePath = hotCountries.getImagePath();
				String suffix = imagePath.substring(imagePath.lastIndexOf("."));
				String newImgName = JSONFile.generateID()+suffix;
				System.out.println(newImgName);
				hotCountries.setImagePath(newImgName);
				
				try {
					InputStream is = image.getInputStream();
					file = new File(PATH+hotCountries.getImagePath());
					if(!file.exists()){
						file.createNewFile();
					}
					FileOutputStream fos = new FileOutputStream(file);
					byte[] b = new byte[1024];
					while((is.read(b)) != -1){
						fos.write(b);
					}
					is.close();
					fos.close();
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		this.gDao.update(hotCountries);
		
	}

	@Override
	public int deleteHotCountries(String ids) {
//		String projectPath = request.getSession().getServletContext().getRealPath("")+"\\";
		JSONArray arr = JSONArray.fromObject(ids);
		String[] codeList = new String[arr.size()];
		for (int i=0;i<arr.size();i++) {
			codeList[i]=(String) arr.get(i);
			HotCountries hotCountries = gDao.findById(HotCountries.class, codeList[i]);
			File file = new File(PATH+hotCountries.getImagePath());
			if(file.exists()){
				System.out.println(file.exists()+":::"+file.isFile());
				file.delete();
			}
		}
		return this.gDao.deleteByIds(HotCountries.class, codeList);
	}

	@Override
	public List<VisaOrder> findByUserID(VisaOrder visaOrder) {
		return this.gDao.findExample(visaOrder);
	}

	@Override
	public VisaOrder findByVisaOrderID(String id) {
		return this.gDao.findById(VisaOrder.class, id);
	}


}
