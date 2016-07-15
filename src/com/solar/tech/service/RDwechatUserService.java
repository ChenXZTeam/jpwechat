package com.solar.tech.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.entity.RD_wechatUser;
import com.solar.tech.dao.GenericDao;

/**
 * 
 * @ClassName: YHopenIDService 
 * @Description: 微信注册用户处理类
 * @author: XieCG
 * @date: 2016年5月4日 下午5:28:02
 */
@Service
@Transactional
public class RDwechatUserService {
	@Resource
	private GenericDao gDao;
	
	/**
	 * 
	 * @Title: addUser 
	 * @Description: 添加注册用户
	 * @param yhopenID
	 * @return: int
	 */
	public int addUser(RD_wechatUser RD_User){
		try {
			gDao.save(RD_User);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	
	/**
	 * 
	 * @Title: findbyOpenid 
	 * @Description: 根据openId查找
	 * @param Openid
	 * @return: boolean
	 */
	public boolean  findbyOpenid(String Openid){
		String hql="from RD_wechatUser u where u.openID='"+Openid+"'";
		List list=gDao.find(hql);
		if(list.size()>0){
			return true;
		}
		return false;
	}
	
	/**
	 * @Title: loginService(用于登录验证) 
	 * @param userName
	 * @param password
	 * @return
	 */
	public boolean  loginService(String userName,String password){
		String hql="from RD_wechatUser u where (u.UserName='"+userName+"' OR u.PhoneNum='"+userName+"') AND u.PassWord='"+password+"'";
		List list=gDao.find(hql);
		if(list.size()>0){
			return true;
		}
		return false;
	}
	
	/**
	 * @title IsExistServ(检查用户名和手机是否被注册过)
	 * @param userName
	 * @param password
	 * @return
	 */
	
	public boolean  IsExistServ(String userName){
		String hql="from RD_wechatUser u where u.UserName='"+userName+"' OR u.PhoneNum='"+userName+"'";
		List list=gDao.find(hql);
		if(list.size()>0){
			return true;
		}
		return false;
	}
	
	/**
	 * 
	 * @Title: findbyOpenids 
	 * @Description: 查询绑定对象
	 * @param openid
	 * @return: YHopenID
	 */
	public RD_wechatUser findbyOpenids(String openid) {
		String hql="from RD_wechatUser u where u.openID='"+openid+"'";
		List list=gDao.find(hql);
		 
		return (RD_wechatUser) list.get(0);
	}
}
