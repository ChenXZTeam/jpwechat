 package com.solar.tech.users;
 
 import com.solar.tech.bean.AbstractUser;
 import com.solar.tech.bean.AbstractUserGroup;
 import com.solar.tech.bean.AbstractUserInGroup;
import com.solar.tech.bean.User;
import com.solar.tech.bean.UserInGroup;
 import com.solar.tech.dao.HibernateDao;
 import com.solar.tech.dao.IDao;


import java.util.ArrayList;
 import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
 import java.util.Map;
 import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public class AbstractUserGroupService
{

  @Resource(type=HibernateDao.class)
  private IDao dao;

  public Map<String, Object> shows(Integer page, Integer rows)
  {
    Map map = new HashMap();
    List UserGroups = this.dao.findByPage(AbstractUserGroup.class, page, rows);
    Long total = this.dao.count(AbstractUserGroup.class);
    map.put("rows", UserGroups);
    map.put("total", total);
    return map;
  }

  public void updateUserGroup(AbstractUserGroup userGroup) {
    this.dao.update(userGroup);
  }

  public void addUserGroup(AbstractUserGroup userGroup) {
    this.dao.save(userGroup);
  }

  public void deleteUserGroup(Integer groupId) {
    AbstractUserGroup userGroup = (AbstractUserGroup)this.dao.findById(AbstractUserGroup.class, groupId);
    AbstractUserInGroup uig = new AbstractUserInGroup();
    uig.setGroupId(userGroup.getGroupId());
    this.dao.deleteByExample(uig);
    this.dao.delete(new AbstractUserGroup[] { userGroup });
  }

  public Map<String, Object> showMembers(int groupId) {
    Map map = new HashMap();
    AbstractUserInGroup userInGroup = new AbstractUserInGroup();
    userInGroup.setGroupId(Integer.valueOf(groupId));
    List userInGroups = this.dao.findExample(userInGroup);
    ArrayList members = new ArrayList();
 /**   for (AbstractUserInGroup _userInGroup : userInGroups) {
      members.add(
        (AbstractUser)this.dao.findById(AbstractUser.class, 
        _userInGroup.getUserUID()));
    }*/
    UserInGroup _userInGroup;
    for(Iterator iterator = userInGroups.iterator(); iterator.hasNext(); )
    {
        _userInGroup = (UserInGroup)iterator.next();
        members.add( (AbstractUser)this.dao.findById(AbstractUser.class,   _userInGroup.getUserUID()));
    }    
    
    
    map.put("rows", members);
    return map;
  }

  public Map<String, Object> showLastMembers(int groupId) {
    Map map = new HashMap();
    AbstractUserInGroup userInGroup = new AbstractUserInGroup();
    userInGroup.setGroupId(Integer.valueOf(groupId));
    List userInGroups = this.dao.findExample(userInGroup);
    ArrayList members = new ArrayList();
 /**   for (AbstractUserInGroup _userInGroup : userInGroups) {
      members.add(
        (AbstractUser)this.dao.findById(AbstractUser.class, 
        _userInGroup.getUserUID()));
    }*/
    AbstractUserInGroup _userInGroup;
    for(Iterator iterator = userInGroups.iterator(); iterator.hasNext();)
    {
   	
   	 _userInGroup = (AbstractUserInGroup)iterator.next();
   	  members.add( (AbstractUser)this.dao.findById(AbstractUser.class,    _userInGroup.getUserUID()));
    }    
    
    List users = this.dao.findAll(AbstractUser.class);
    users.removeAll(members);
    map.put("rows", users);
    return map;
  }

  public void addMember(int groupId, List<String> userIds) {
    for (String userId : userIds) {
      AbstractUserInGroup userInGroup = new AbstractUserInGroup();
      userInGroup.setGroupId(Integer.valueOf(groupId));
      userInGroup.setUserUID(userId);
      this.dao.save(userInGroup);
    }
  }

  public void deleteMember(int groupId, List<String> userIds) {
    for (String userId : userIds) {
      AbstractUserInGroup userInGroup = new AbstractUserInGroup();
      userInGroup.setGroupId(Integer.valueOf(groupId));
      userInGroup.setUserUID(userId);
      this.dao.delete(this.dao.findExample(userInGroup));
    }
  }

  public AbstractUserGroup get(Integer groupId) {
    return (AbstractUserGroup)this.dao.findById(AbstractUserGroup.class, groupId);
  }
}

