package com.solar.tech.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.dao.GenericDao;
import com.solar.tech.bean.entity.tpRecords;
import com.solar.tech.bean.entity.userOrderInfo;


@Service
@Transactional
public class TpRecordsServices {
	
	@Resource
	private GenericDao gDao;
	
	public List<userOrderInfo> queryStatus(){
		String sql="FROM userOrderInfo WHERE tpStatus<>0";
		List<userOrderInfo> tpStatus=this.gDao.find(sql);
		return tpStatus;
	}
	
    public int addtprecords(tpRecords tpBorn){
    	try {
    		gDao.save(tpBorn);
    		return 1;
    	}catch (Exception e){
    		return 0;
    	}
    }
    
    public int clear(){
    	
    	try {
    		String sql="delete FROM tpRecords";
    		gDao.executeJDBCSql(sql);
    		return 1;
		} catch (Exception e) {
			return 0;
		}
    	
    }
	
	public List<tpRecords> chazhao(String linkName,String hangbanNum,String telNumber,String pnumber,String pnr,String tpstatus){
		
		String sql="FROM tpRecords WHERE 1=1 ";
		if(linkName !=null&&linkName !=""){
			sql+="and linkName='"+linkName+"'";
		}
		if(hangbanNum !=null&&hangbanNum !=""){
			sql+="and hangbanNum='"+hangbanNum+"'";
		}
		if(telNumber !=null&&telNumber !=""){
			sql+="and telNumber='"+telNumber+"'";
		}
		if(pnumber !=null&&pnumber !=""){
			sql+="and pnumber='"+pnumber+"'";
		}
		if(pnr !=null&&pnr !=""){
			sql+="and pnr='"+pnr+"'";
		}
		if(tpstatus !=null&&tpstatus !=""){
			sql+="and tpstatus='"+tpstatus+"'";
		}
		System.out.println(sql);
		List<tpRecords> Orders=this.gDao.find(sql);
		return Orders;
	}
}
