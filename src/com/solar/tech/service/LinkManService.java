package com.solar.tech.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.entity.LinkMan;
import com.solar.tech.bean.entity.RD_wechatUser;
import com.solar.tech.dao.GenericDao;

@Service
@Transactional
public class LinkManService {
	@Resource
	private GenericDao gDao;
	
	public Map<String,Object> manlist(int page, int rows){
		Map<String,Object> map = new HashMap<String,Object>();
		List<LinkMan> cList = this.gDao.findByPage("FROM LinkMan ORDER BY createTime DESC", Integer.valueOf(page), Integer.valueOf(rows));
		Long total = this.gDao.count(LinkMan.class,"FROM LinkMan ORDER BY createTime DESC"); //获取影响的行数，用于前台分页
		map.put("rows",cList);
		map.put("total", total);
		return map;
	}
	
	public void addInfo(LinkMan lman){
		gDao.save(lman);
	}
	
	public void delInfo(List<LinkMan> lman){
		gDao.delete(lman);
	}
	
	public void upInfo(LinkMan lman){
		gDao.update(lman);
	}
	
	public List<RD_wechatUser> getuserList(){
		List<RD_wechatUser> ulist = this.gDao.find("FROM RD_wechatUser");
		List<RD_wechatUser> formDate = new ArrayList<RD_wechatUser>();
		for(RD_wechatUser sd : ulist){
			RD_wechatUser forsd = new RD_wechatUser();
			forsd.setUserName(sd.getUserName());
			formDate.add(forsd);
		}
		return formDate;
	}
	
	public List<RD_wechatUser> getuserList(String userName){
		List<RD_wechatUser> ulist = this.gDao.find("FROM RD_wechatUser WHERE UserName = '"+userName+"'");
		return ulist;
	}
	
	public Map<String,Object> findPage(int page,int rows,String cusAdmin,String custor,String chinaName,String phoneNum){
		Map<String,Object> map = new HashMap<String,Object>();
		List<LinkMan> cList = this.gDao.findByPage("FROM LinkMan WHERE UserName LIKE '%"+cusAdmin+"%' AND linkman LIKE '%"+custor+"%' AND chinaName LIKE '%"+chinaName+"%' AND linkNumber LIKE '%"+phoneNum+"%' ORDER BY createTime DESC", Integer.valueOf(page), Integer.valueOf(rows));
		Long total = this.gDao.count(LinkMan.class,"FROM LinkMan WHERE UserName LIKE '%"+cusAdmin+"%' AND linkman LIKE '%"+custor+"%' AND chinaName LIKE '%"+chinaName+"%' AND linkNumber LIKE '%"+phoneNum+"%' ORDER BY createTime DESC"); //获取影响的行数，用于前台分页
		map.put("rows",cList);
		map.put("total", total);
		return map;
	}
}
