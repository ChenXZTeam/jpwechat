package com.solar.tech.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.DuanxinExample;
import com.solar.tech.bean.PhoneNum;
import com.solar.tech.bean.entity.phoneMess;
import com.solar.tech.bean.entity.userOrderInfo;
import com.solar.tech.dao.GenericDao;



@Service
@Transactional
public class jpbornService {

	@Resource
	private GenericDao gDao;
	
	public List<userOrderInfo> queryOrder(String linkName,String chufCity,String chufTime,String hangbanNum,String daodCity,String iDcase,String Pnumber){
		String sql="FROM userOrderInfo WHERE 1=1";
		if(linkName !=null&&linkName !=""){
			sql+="and linkName ='"+linkName+"'"; 
			
		}
		if(!"".equals(chufCity)){
			if(!"".equals(daodCity)){
				sql+="and (chufCity='"+chufCity+"'"+"or daodCity='"+daodCity+"')";
			}
			if("".equals(daodCity)){
				sql+="and chufCity='"+chufCity+"'";
			}
		}
		if("".equals(chufCity)){
			if(!"".equals(daodCity)){
				sql+="and daodCity='"+daodCity+"'";
			}
		}
		
		if(!"".equals(chufTime)){
			
				sql+="and chufTime='"+chufTime+"'";
		
		}
		if (hangbanNum!=null&&hangbanNum!=""){
			sql+="and hangbanNum='"+hangbanNum+"'";
		}
		if (iDcase!=null&&iDcase!=""){
			sql+="and IDcase='"+iDcase+"'";
		}
		if(Pnumber!=null&&Pnumber!=""){
			sql+="and linkPhoneNum='"+Pnumber+"'";
		}
		System.out.println(sql);
		List<userOrderInfo> Orders=this.gDao.find(sql);
		return Orders;
		
	}
	
	public List<DuanxinExample> queryModelMes(String model){
		String hql="FROM DuanxinExample WHERE model like '"+model+"'";
		List<DuanxinExample> mesmode=this.gDao.find(hql);
		return mesmode;
	}
	
	public List<PhoneNum> queryTx(String number){
		String hql="FROM PhoneNum WHERE phoneNumber like '"+number+"'";
        System.out.println(hql);
		List<PhoneNum> duanx=this.gDao.find(hql);
		return duanx;
	}
	public void savaPhoneMess(phoneMess ph){
		try {
			gDao.save(ph);
		} catch (Exception e) {
		}
	}
	
}
