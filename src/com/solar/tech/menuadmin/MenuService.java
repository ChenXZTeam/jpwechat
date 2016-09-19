package com.solar.tech.menuadmin;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.solar.tech.bean.Menu;
import com.solar.tech.bean.MenuItem;
import com.solar.tech.bean.UserGroup;
import com.solar.tech.bean.UserGroupMenu;
import com.solar.tech.bean.UserInGroup;
import com.solar.tech.bean.UserMenu;
import com.solar.tech.dao.GenericDao;

/**
 * 
 * @ClassName MenuService
 * @Description 菜单处理的业务类:实现菜单的增加、删除、修改、查询
 * @Author wwd
 * @copyRight 续日科技 solartech
 * @Date 2015年6月10日
 * @Version V1.0.1
 */
@Service
public class MenuService {
	@Autowired
	private GenericDao dao;

	/**
	 * 
	 * @Title addMenu
	 * @Description 添加菜单
	 * @Return void 返回类型
	 * @param menu
	 */
	public void addMenu(Menu menu) {
		if(menu.getSortNum()==null){
			menu.setSortNum(0);
		}
		dao.save(menu);
	}

	/**
	 * 
	 * @Title shows
	 * @Description 分页显示菜单的信息
	 * @Return Map<String,Object> 返回类型
	 * @param page
	 *            页数
	 * @param rows
	 *            页大小
	 * @return
	 */
	public Map<String, Object> shows(int page, int rows) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Menu> menus = dao.findByPage("from Menu m order by sortNum desc,menuId asc", page, rows);
		Long total = dao.count(Menu.class,"");
		map.put("rows", menus);
		map.put("total", total);
		return map;
	}

	/**
	 * 
	 * @Title deleteMenu
	 * @Description 根据菜单id删除菜单
	 * @Return void 返回类型
	 * @param id
	 * @throws Exception
	 */
	public void deleteMenu(Integer id) throws Exception {
		Menu menu = dao.findById(Menu.class, id);
		if (menu == null) {
			throw new Exception("菜单id:" + id + "不存在,删除失败");
		} else {
			List<MenuItem> items=dao.find("from MenuItem where menuId="+menu.getMenuId());
			if(items.size()!=0){
				throw new Exception("菜单id:" + id + "下面存在菜单项,无法删除");
			}
			dao.delete(menu);
		}
	}

	/**
	 * 
	 * @Title updateMenu
	 * @Description 更新菜单
	 * @Return void 返回类型
	 * @param menuId
	 * @param menuName
	 * @param menuUrl
	 * @param menuType
	 * @param menuTarget
	 * @param menuStatus
	 * @param sortNum
	 * @param menuIcon
	 * @param description
	 * @param updateBy
	 * @throws Exception
	 */
	public void updateMenu(Integer menuId, String menuName, String menuUrl,
			String menuType, String menuTarget, Integer menuStatus,
			Integer sortNum, String menuIcon, String description
			) throws Exception {
		Menu menu = dao.findById(Menu.class, menuId);
		if (menu == null) {
			throw new Exception("菜单id:" + menuId + "不存在,修改失败");
		} else {
			menu.setMenuName(menuName);
			menu.setMenuUrl(menuUrl);
			menu.setMenuType(menuType);
			menu.setMenuTarget(menuTarget);
			menu.setMenuStatus(menuStatus);
			menu.setSortNum(sortNum);
			menu.setMenuIcon(menuIcon);
			menu.setDescription(description);
			menu.setUpdateTime(new Date());
			menu.setUpdateBy(com.solar.tech.util.Current.user().getUserName());
			dao.update(menu);
		}
	}
	/**
	 * 
	* @Title getAllMenus
	* @Description  获取所有的菜单
	* @Return List<Menu> 返回类型
	*@return
	 */
	public List<Menu> getAllMenus(){
		List<Menu> menus=dao.findAll(Menu.class);
		return menus;
	}
	
	/**
	 * 
	* @Title menusUser
	* @Description 菜单的用户
	* @Return Map<String,Object> 返回类型
	*@param menuId
	*@return
	 */
	public Map<String, Object> menusUser(int menuId) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Menu> menus = dao.find("from User u where u.userUID in (select uSERUID from UserMenu where menuId="+menuId+")");
		map.put("rows", menus);
		return map;
	}
	
	/**
	 * 
	* @Title unMenusUser
	* @Description 获取不属于菜单的用户
	* @Return Map<String,Object> 返回类型
	*@param menuId
	*@return
	 */
	public Map<String, Object> unMenusUser(int menuId) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Menu> menus = dao.find("from User u where u.userUID not  in (select uSERUID from UserMenu where menuId="+menuId+")");
		map.put("rows", menus);
		return map;
	}
	
	/**
	 * 
	* @Title addMenuUser
	* @Description 添加菜单的用户
	* @Return void 返回类型
	*@param menuId
	*@param users
	 * @throws Exception 
	 */
	public void addMenuUser(int menuId,List<String> usersId) throws Exception{

	  for(String userId:usersId){
		  List<UserMenu> userMenus=dao.find("from UserMenu where menuId="+menuId+" and uSERUID='"+userId+"'");
		  if(userMenus.size()==0){
			  UserMenu userMenu=new UserMenu();
			  userMenu.setMenuId(menuId);
			  userMenu.setUSERUID(userId);
			  dao.save(userMenu);
		  }
	  }

	}
	/**
	 * 
	* @Title delMenuUser
	* @Description 删除菜单的用户
	* @Return void 返回类型
	*@param menuId
	*@param usersId
	*@throws Exception
	 */
	public void delMenuUser(int menuId,List<String> usersId) throws Exception{
	  for(String userId:usersId){
		  List<UserMenu> userMenus=dao.find("from UserMenu where menuId="+menuId+" and uSERUID='"+userId+"'");
		  for(UserMenu userMenu:userMenus){
			 dao.delete(userMenu);
		  }
	  }
	
	}
	
	/**
	 * 
	* @Title menusGroup
	* @Description 菜单用户组
	* @Return Map<String,Object> 返回类型
	*@param menuId
	*@return
	 */
	public Map<String, Object> menusGroup(int menuId) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<UserGroup> menus = dao.find("from UserGroup u where u.groupId in (select groupId from UserGroupMenu  where menuId="+menuId+")");
		map.put("rows", menus);
		return map;
	}
	
	/**
	 * 
	* @Title unMenusGroup
	* @Description  不属于菜单的用户组
	* @Return Map<String,Object> 返回类型
	*@param menuId
	*@return
	 */
	public Map<String, Object> unMenusGroup(int menuId) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<UserGroup> menus = dao.find("from UserGroup u where u.groupId not  in (select groupId from UserGroupMenu  where menuId="+menuId+")");
		map.put("rows", menus);
		return map;
	}
	
	/**
	 * 
	* @Title addMenuGroup
	* @Description 添加菜单的用户组
	* @Return void 返回类型
	*@param menuId
	*@param groupId
	 * @throws Exception 
	 */
	public void addMenuGroup(int menuId,List<Integer> groupsId) throws Exception{
	  for(Integer groupId:groupsId){
		  List<UserGroupMenu> userMenus=dao.find("from UserGroupMenu where menuId="+menuId+" and groupId="+groupId);
		  if(userMenus.size()==0){
			  UserGroupMenu userGroupMenu=new UserGroupMenu();
			  userGroupMenu.setGroupId(groupId);
			  userGroupMenu.setMenuId(menuId);
			  dao.save(userGroupMenu);
		  }
	  }

	}
	
	
	/**
	 * 
	* @Title delMenuGroup
	* @Description 删除菜单的用户组
	* @Return void 返回类型
	*@param menuId
	*@param groupsId
	*@throws Exception
	 */
	public void delMenuGroup(int menuId,List<Integer> groupsId) throws Exception{
			  for(Integer groupId:groupsId){
				  List<UserGroupMenu> userGroupMenus=dao.find("from UserGroupMenu where menuId="+menuId+" and groupId="+groupId);
				 for(UserGroupMenu userGroupMenu:userGroupMenus){
					  dao.delete(userGroupMenu);
				  }
			  }
	
	}
	
	/**
	 * 
	* @Title getById
	* @Description 根据菜单id获取菜单信息
	* @Return Menu 返回类型
	*@param menutId
	*@return
	 */
	public Menu getMenuById(Integer menuId){
		return dao.findById(Menu.class,menuId);
	}
	
	/**
	 * 
	* @Title getMenuById
	* @Description 根据菜单类型获取菜单
	* @Return List<Menu> 返回类型
	*@param menuType
	*@return
	 */
	public List<Menu> getMenuByType(String menuType){
		List<Menu> meuns=dao.find("from Menu where menuType='"+menuType+"'");
		return meuns;
	}
}
