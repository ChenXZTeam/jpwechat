package com.solar.tech.users;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.User;
import com.solar.tech.bean.UserInGroup;
import com.solar.tech.bean.entity.RD_wechatUser;
import com.solar.tech.dao.GenericDao;
import com.solar.tech.users.AbstractUserService;

@Service
@Transactional
public class UserService extends AbstractUserService{
	@Resource
	private GenericDao gDao;
	
	public Map<String, Object> showUsers(int page, int rows){
		Map<String, Object> map = new HashMap<String, Object>();
		List<User> list = new ArrayList<User>(); 
		String hql = "FROM User";
		list = gDao.findByPage(User.class, page, rows);
		Long total = this.gDao.count(User.class,hql); 
		map.put("rows", list);
		map.put("total", total);
		return map;
	}
	
	public int addUser(User user){
		try {
			gDao.save(user);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	
	public int addUserinGroup(String uid){
		 UserInGroup userInGroup = new UserInGroup();
	     userInGroup.setUserUID(uid);
	     userInGroup.setGroupId(1);
	     userInGroup.setUGID((int)System.currentTimeMillis());
	     try {
				gDao.save(userInGroup);
				return 1;
			} catch (Exception e) {
				return 0;
			}
	}
	
	public void deleteUser(String userUID){
//		UserInGroup uig = gDao.findById(UserInGroup.class, userUID);---id不对应  ，所需是UGId,而传的是userUID
		UserInGroup uig = new UserInGroup();
		uig.setUserUID(userUID);
		System.out.println("uig: "+uig);
		//try {---使用 @Transactional
			gDao.deleteById(User.class, userUID);
//			gDao.deleteById(UserInGroup.class, userUID);  //此方法不可行，userUID不对应
			gDao.deleteByExample(uig);
			
//		} catch (Exception e) {
//			System.out.println(e.getMessage());
//		}
	}
	
	public List<RD_wechatUser> findAllUser(){
		return this.gDao.findAll(RD_wechatUser.class);
	}
}
