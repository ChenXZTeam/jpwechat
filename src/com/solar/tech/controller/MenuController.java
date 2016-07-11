package com.solar.tech.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.Menu;
import com.solar.tech.menuadmin.MenuService;

/**
 * 
 * @ClassName MenuController
 * @Description 菜单处理控制类
 * @Author wwd
 * @copyRight 续日科技 solartech
 * @Date 2015年6月10日
 * @Version V1.0.1
 */
@Controller
@RequestMapping("/framework/menu")
public class MenuController {
	@Autowired
	private MenuService menuService;

	/**
	 * 
	 * @Title index
	 * @Description 转发到菜单界面
	 * @Return String 返回类型
	 * @return
	 */
	@RequestMapping("/index.action")
	public String index() {
		return "/framework/menu/shows";
	}

	/**
	 * 
	 * @Title shows
	 * @Description 分页获取菜单的数据
	 * @Return Map<String,Object> 返回类型
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping("/shows.action")
	@ResponseBody
	public Map<String, Object> shows(int page, int rows) {
		Map<String, Object> dataResult = menuService.shows(page, rows);
		dataResult.put("success", true);
		return dataResult;
	}

	/**
	 * 
	 * @Title addMenu
	 * @Description 添加菜单
	 * @Return Map<String,Object> 返回类型
	 * @param menuName
	 * @param menuUrl
	 * @param menuType
	 * @param menuTarget
	 * @param menuStatus
	 * @param sortNum
	 * @param menuIcon
	 * @param description
	 * @return
	 */
	@RequestMapping("/add.action")
	@ResponseBody
	public Map<String, Object> addMenu(String menuName, String menuUrl,
			String menuType, String menuTarget, Integer menuStatus,
			Integer sortNum, String menuIcon, String description) {
		Menu menu = new Menu();
		menu.setMenuName(menuName);
		menu.setMenuUrl(menuUrl);
		menu.setMenuType(menuType);
		menu.setMenuTarget(menuTarget);
		menu.setMenuStatus(menuStatus);
		menu.setSortNum(sortNum);
		menu.setMenuIcon(menuIcon);
		menu.setDescription(description);
		menu.setCreateTime(new Date());
		menu.setUpdateTime(new Date());
		String username=com.solar.tech.util.Current.user().getUserName();
	menu.setCreateBy(username);
	  menu.setUpdateBy(username);
		menuService.addMenu(menu);
		Map<String, Object> dataResult = new HashMap<String, Object>();
		dataResult.put("success", true);
		return dataResult;
	}

	/**
	 * 
	 * @Title deleteMenu
	 * @Description 删除菜单
	 * @Return Map<String,Object> 返回类型
	 * @param id
	 * @return
	 */
	@RequestMapping("/deleteMenu.action")
	@ResponseBody
	public Map<String, Object> deleteMenu(Integer id) {
		Map<String, Object> dataResult = new HashMap<String, Object>();
		try {
			menuService.deleteMenu(id);
			dataResult.put("success", true);
		} catch (Exception e) {
			dataResult.put("success", false);
			dataResult.put("errorMsg", e.getMessage());
		}
		return dataResult;
	}

	/**
	 * 
	 * @Title updateMenu
	 * @Description 更新菜单
	 * @Return Map<String,Object> 返回类型
	 * @param menuId
	 * @param menuName
	 * @param menuUrl
	 * @param menuType
	 * @param menuTarget
	 * @param menuStatus
	 * @param sortNum
	 * @param menuIcon
	 * @param description
	 * @return
	 */
	@RequestMapping("/updateMenu.action")
	@ResponseBody
	public Map<String, Object> updateMenu(Integer menuId, String menuName,
			String menuUrl, String menuType, String menuTarget,
			Integer menuStatus, Integer sortNum, String menuIcon,
			String description) {
		Map<String, Object> dataResult = new HashMap<String, Object>();
		try {
			menuService.updateMenu(menuId, menuName, menuUrl, menuType,
					menuTarget, menuStatus, sortNum, menuIcon, description);
			dataResult.put("success", true);
		} catch (Exception e) {
			dataResult.put("success", false);
			dataResult.put("errorMsg", e.getMessage());
		}
		return dataResult;
	}
	
	/**
	 * 
	* @Title addMember
	* @Description  添加菜单用户组
	* @Return Map<String,Object> 返回类型
	*@param menuId
	*@param userIds
	*@return
	 */
	@RequestMapping("/addMenuGroup.action")
	@ResponseBody
	public Map<String, Object> addMenuGroup(int menuId, @RequestParam("groupsId[]") List<Integer> groupsId) {
		Map<String, Object> dataResult = new HashMap<String, Object>();
		try {
			menuService.addMenuGroup(menuId, groupsId);
			dataResult.put("success", true);
		} catch (Exception e) {
			dataResult.put("success", false);
			dataResult.put("errorMsg", e.getMessage());
		}
		return dataResult;
	}
	
	/**
	 * 
	* @Title menuUsers
	* @Description 【菜单的用户组
	* @Return Map<String,Object> 返回类型
	*@param menuId
	*@return
	 */
	@RequestMapping("/menuGroups.action")
	@ResponseBody
	public Map<String, Object> menuGroups(int menuId) {
		Map<String, Object> dataResult = menuService.menusGroup(menuId);
		dataResult.put("success", true);
		return dataResult;
	}
	
	/**
	 * 
	* @Title unMenuGroups
	* @Description  不属于菜单用户组
	* @Return Map<String,Object> 返回类型
	*@param menuId
	*@return
	 */
	@RequestMapping("/unMenuGroups.action")
	@ResponseBody
	public Map<String, Object> unMenuGroups(int menuId) {
		Map<String, Object> dataResult = menuService.unMenusGroup(menuId);
		dataResult.put("success", true);
		return dataResult;
	}
	/**
	 *
	* @Title delMenuGroup
	* @Description 删除菜单组
	* @Return Map<String,Object> 返回类型
	*@param menuId
	*@param userIds
	*@return
	 */
	@RequestMapping("/delMenuGroup.action")
	@ResponseBody
	public Map<String, Object> delMenuGroup(int menuId, @RequestParam("groupsId[]") List<Integer> groupsId) {
		Map<String, Object> dataResult = new HashMap<String, Object>();
		try {
			menuService.delMenuGroup(menuId, groupsId);
			dataResult.put("success", true);
		} catch (Exception e) {
			dataResult.put("success", false);
			dataResult.put("errorMsg", e.getMessage());
		}
		return dataResult;
	}
	
	
	/**
	 * 
	* @Title addMember
	* @Description  添加菜单成员
	* @Return Map<String,Object> 返回类型
	*@param menuId
	*@param userIds
	*@return
	 */
	@RequestMapping("/addMenuUser.action")
	@ResponseBody
	public Map<String, Object> addMember(int menuId, @RequestParam("userIds[]") List<String> userIds) {
		Map<String, Object> dataResult = new HashMap<String, Object>();
		try {
			menuService.addMenuUser(menuId, userIds);
			dataResult.put("success", true);
		} catch (Exception e) {
			dataResult.put("success", false);
			dataResult.put("errorMsg", e.getMessage());
		}
		return dataResult;
	}
	
	/**
	 * 菜单的用户
	* @Title menuUsers
	* @Description 【这里用一句话描述这个方法的作用】
	* @Return Map<String,Object> 返回类型
	*@param menuId
	*@return
	 */
	@RequestMapping("/menuUsers.action")
	@ResponseBody
	public Map<String, Object> menuUsers(int menuId) {
		Map<String, Object> dataResult = menuService.menusUser(menuId);
		dataResult.put("success", true);
		return dataResult;
	}
	
	@RequestMapping("/unMenuUsers.action")
	@ResponseBody
	public Map<String, Object> unMenuUsers(int menuId) {
		Map<String, Object> dataResult = menuService.unMenusUser(menuId);
		dataResult.put("success", true);
		return dataResult;
	}
	/**
	 *
	* @Title delMember
	* @Description 菜单成员
	* @Return Map<String,Object> 返回类型
	*@param menuId
	*@param userIds
	*@return
	 */
	@RequestMapping("/delMenuUser.action")
	@ResponseBody
	public Map<String, Object> delMember(int menuId, @RequestParam("userIds[]") List<String> userIds) {
		Map<String, Object> dataResult = new HashMap<String, Object>();
		try {
			menuService.delMenuUser(menuId, userIds);
			dataResult.put("success", true);
		} catch (Exception e) {
			dataResult.put("success", false);
			dataResult.put("errorMsg", e.getMessage());
		}
		return dataResult;
	}
	
	
}
