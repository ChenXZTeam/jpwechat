package com.solar.tech.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.dao.GenericDao;
import com.solar.tech.bean.entity.hcConfig;
import com.solar.tech.bean.entity.tpRecords;
import com.solar.tech.bean.entity.userOrderInfo;


@Service
@Transactional
public class TpRecordsServices {
	
	@Resource
	private GenericDao gDao;
	
	public List<userOrderInfo> queryStatus(){
		String sql="FROM userOrderInfo WHERE tpStatus = '1' AND stutisPay = '1'";
		List<userOrderInfo> tpStatus=this.gDao.find(sql);
		return tpStatus;
	}
	
    public int addtprecords(List<tpRecords> tpBorn){
    	try {
    		gDao.save(tpBorn);
    		return 1;
    	}catch (Exception e){
    		return 0;
    	}
    }
    
    public int addtprecords(tpRecords tpBorn){
    	try {
    		gDao.save(tpBorn);
    		return 1;
    	}catch (Exception e){
    		return 0;
    	}
    }
    
    public Map<String, Object> getInfoList(int pag, int row) {
		Map<String, Object> map = new HashMap<String, Object>();
		String hql = "FROM tpRecords ORDER BY tpStatus, createTime DESC";
		List<tpRecords> cList = this.gDao.findByPage(hql, Integer.valueOf(pag), Integer.valueOf(row));
		Long total = this.gDao.count(tpRecords.class,hql); //获取影响的行数，用于前台分页
		map.put("rows", cList);
		map.put("total", total);
		return map;
	}
    
    public void clear(){
    	gDao.executeJDBCSql("delete FROM tpRecords WHERE tpstatus = '1'");
    }
	
	public Map<String,Object> chazhao(int page, int rows,String linkName,String hangbanNum,String telNumber,String pnumber,String pnr,String tpstatus){
		Map<String,Object> map = new HashMap<String,Object>();
		String sql="FROM tpRecords WHERE 1=1 ";
		if(linkName !=null&&linkName !=""){
			sql+=" AND linkName='"+linkName+"'";
		}
		if(hangbanNum !=null&&hangbanNum !=""){
			sql+=" AND hangbanNum='"+hangbanNum+"'";
		}
		if(pnumber !=null&&pnumber !=""){
			sql+=" AND telNumber='"+pnumber+"'";
		}
		if(telNumber !=null&&telNumber !="" ){
			sql+=" AND pnumber='"+telNumber+"'";
		}
		if(pnr !=null&&pnr !=""){
			sql+=" AND pnr='"+pnr+"'";
		}
		if(tpstatus !=null&&tpstatus !=""){
			sql+=" AND tpstatus='"+tpstatus+"'";
		}
		sql += " ORDER BY tpStatus, createTime DESC";
		System.out.println(sql);
		List<tpRecords> cList = this.gDao.findByPage(sql, Integer.valueOf(page), Integer.valueOf(rows));
		Long total = this.gDao.count(tpRecords.class,sql); //获取影响的行数，用于前台分页
		map.put("rows", cList);
		map.put("total", total);
		return map;
	}
	
	public void upstatus(String uuid,String status,String matherUuid){
		this.gDao.executeJDBCSql("UPDATE userorderinfo SET tpStatus = '"+status+"' WHERE ID = '"+matherUuid+"' AND stutisPay = '1'"); //更改订单表中的退票状态
		this.gDao.executeJDBCSql("UPDATE tprecords SET tpStatus = '"+status+"' WHERE ID = '"+uuid+"'"); //更改退票表中的状态
	}
}
