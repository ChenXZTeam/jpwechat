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
import com.solar.tech.bean.MenuItem;
import com.solar.tech.menuadmin.MenuItemModel;
import com.solar.tech.menuadmin.MenuItemService;
import com.solar.tech.menuadmin.MenuService;

/**
 * 
 * @ClassName MenuItemController
 * @Description 菜单项控制处理类
 * @Author wwd
 * @copyRight 续日科技 solartech
 * @Date 2015年6月11日
 * @Version V1.0.1
 */
@Controller
@RequestMapping("/framework/menu/item")
public class MenuItemController {
	@Autowired
	private MenuItemService menuItemService;
	@Autowired
	private MenuService menuService;

	/**
	 * 
	 * @Title index
	 * @Description 转发到菜单项界面
	 * @Return String 返回类型
	 * @return
	 */
	@RequestMapping("/index.action")
	public String index(Map<String, Object> map) {
		List<Menu> menus = menuService.getAllMenus();
		map.put("menus", menus);
		return "/framework/menu/item/shows";
	}

	/**
	 * 
	 * @Title add
	 * @Description 添加菜单项
	 * @Return void 返回类型
	 * @param itemName
	 * @param menuId
	 * @param parentItemId
	 * @param itemUrl
	 * @param itemTarget
	 * @param pageId
	 * @param itemType
	 * @param itemStatus
	 * @param sortNum
	 * @param itemIcon
	 * @param description
	 */
	@RequestMapping("/add.action")
	@ResponseBody
	public Map<String, Object> add(String itemName, Integer menuId,
			Integer parentItemId, String itemUrl, String itemTarget,
			Integer pageId, String itemType, Integer itemStatus,
			Integer sortNum, String itemIcon, String description) {
		MenuItem item = new MenuItem();
		item.setItemName(itemName);
		item.setMenuId(menuId);
		item.setParentItemId(parentItemId);
		item.setItemUrl(itemUrl);
		item.setItemTarget(itemTarget);
		item.setPageId(pageId);
		item.setItemType(itemType);
		item.setItemStatus(itemStatus);
		item.setSortNum(sortNum);
		item.setItemIcon(itemIcon);
		item.setDescription(description);
		item.setCreateTime(new Date());
		item.setUpdateTime(new Date());
		String username=com.solar.tech.util.Current.user().getUserName();
		item.setCreateBy(username);
	    item.setUpdateBy(username);
		menuItemService.add(item);
		Map<String, Object> dataResult = new HashMap<String, Object>();
		dataResult.put("success", true);
		return dataResult;
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
	public List<MenuItemModel> shows(Integer page, Integer rows) {
		Map<String, Object> dataResult = menuItemService.shows(page, rows);
		dataResult.put("success", true);
		
		return (List<MenuItemModel>) dataResult.get("rows");
	}

	/**
	 * 
	 * @Title deleteMenu
	 * @Description 删除菜单
	 * @Return Map<String,Object> 返回类型
	 * @param id
	 * @return
	 */
	@RequestMapping("/delMenuItem.action")
	@ResponseBody
	public Map<String, Object> deleteMenuItem(Integer id) {
		Map<String, Object> dataResult = new HashMap<String, Object>();
		try {
			menuItemService.deleteMenuItem(id);
			dataResult.put("success", true);
		} catch (Exception e) {
			dataResult.put("success", false);
			dataResult.put("errorMsg", e.getMessage());
		}
		return dataResult;
	}

	/**
	 * 
	 * @Title getMenus
	 * @Description 获取上级菜单项的树形菜单的数据
	 * @Return List<Map<String,Object>> 返回类型
	 * @param id
	 * @param flag
	 * @return
	 */
	@RequestMapping("/menuItemTree.action")
	@ResponseBody
	public List<Map<String, Object>> getMenus(int id, String flag) {
		List<Map<String, Object>> map = menuItemService.getParentMenuItemTree(
				id, flag);
		return map;
	}
     /**
      * 
     * @Title update
     * @Description  修改菜单项
     * @Return Map<String,Object> 返回类型
     *@param itemId
     *@param itemName
     *@param menuId
     *@param parentItemId
     *@param itemUrl
     *@param itemTarget
     *@param pageId
     *@param itemType
     *@param itemStatus
     *@param sortNum
     *@param itemIcon
     *@param description
     *@return
      */
	@RequestMapping("/update.action")
	@ResponseBody
	public Map<String, Object> update(Integer itemId, String itemName,
			Integer menuId, Integer parentItemId, String itemUrl,
			String itemTarget, Integer pageId, String itemType,
			Integer itemStatus, Integer sortNum, String itemIcon,
			String description) {
		Map<String, Object> dataResult = new HashMap<String, Object>();
		try {
			menuItemService.update(itemId, itemName, menuId, parentItemId,
					itemUrl, itemTarget, pageId, itemType, itemStatus, sortNum,
					itemIcon, description);
			dataResult.put("success", true);
		} catch (Exception e) {
			dataResult.put("success", false);
			dataResult.put("errorMsg", e.getMessage());
		}
		return dataResult;
	}
	
	/**
	 * 
	* @Title addItemUser
	* @Description  添加菜单项成员
	* @Return Map<String,Object> 返回类型
	*@param menuId
	*@param userIds
	*@return
	 */
	@RequestMapping("/addItemUser.action")
	@ResponseBody
	public Map<String, Object> addItemUser(int itemId, @RequestParam("userIds[]") List<String> userIds) {
		Map<String, Object> dataResult = new HashMap<String, Object>();
		try {
			System.out.println("userIds:=====:"+userIds);
			menuItemService.addItemUser(itemId, userIds);
			dataResult.put("success", true);
		} catch (Exception e) {
			dataResult.put("success", false);
			dataResult.put("errorMsg", e.getMessage());
		}
		return dataResult;
	}
	
	/**
	 * 
	* @Title itemUsers
	* @Description 菜单项的用户
	* @Return Map<String,Object> 返回类型
	*@param itemId
	*@return
	 */
	@RequestMapping("/itemUsers.action")
	@ResponseBody
	public Map<String, Object> itemUsers(int itemId) {
		Map<String, Object> dataResult =menuItemService.itemsUser(itemId);
		dataResult.put("success", true);
		return dataResult;
	}
	
	@RequestMapping("/unItemUsers.action")
	@ResponseBody
	public Map<String, Object> unItemUsers(int itemId) {
		Map<String, Object> dataResult =menuItemService.unItemsUser(itemId);
		dataResult.put("success", true);
		return dataResult;
	}
	/**
	 *
	* @Title delItemUser
	* @Description 删除菜单项成员
	* @Return Map<String,Object> 返回类型
	*@param menuId
	*@param userIds
	*@return
	 */
	@RequestMapping("/delItemUser.action")
	@ResponseBody
	public Map<String, Object> delItemUser(int itemId, @RequestParam("userIds[]") List<String> userIds) {
		Map<String, Object> dataResult = new HashMap<String, Object>();
		try {
			menuItemService.delItemUser(itemId, userIds);
			dataResult.put("success", true);
		} catch (Exception e) {
			dataResult.put("success", false);
			dataResult.put("errorMsg", e.getMessage());
		}
		return dataResult;
	}
	

	@RequestMapping("/addUserGroup.action")
	@ResponseBody
	public Map<String, Object> addUserGroup(int itemId, @RequestParam("groupsId[]") List<Integer> groupsId) {
		Map<String, Object> dataResult = new HashMap<String, Object>();
		try {
			menuItemService.addItemUserGroup(itemId, groupsId);
			dataResult.put("success", true);
		} catch (Exception e) {
			dataResult.put("success", false);
			dataResult.put("errorMsg", e.getMessage());
		}
		return dataResult;
	}
	

	@RequestMapping("/itemUserGroups.action")
	@ResponseBody
	public Map<String, Object> itemUserGroups(int itemId) {
		Map<String, Object> dataResult =menuItemService.itemUserGroup(itemId);
		dataResult.put("success", true);
		return dataResult;
	}
	

	@RequestMapping("/unItemUserGroups.action")
	@ResponseBody
	public Map<String, Object> unItemUserGroups(int itemId) {
		Map<String, Object> dataResult = menuItemService.unItemUserGroup(itemId);
		dataResult.put("success", true);
		return dataResult;
	}
	
	@RequestMapping("/delItemUserGroup.action")
	@ResponseBody
	public Map<String, Object> delItemUserGroup(int itemId, @RequestParam("groupsId[]") List<Integer> groupsId) {
		Map<String, Object> dataResult = new HashMap<String, Object>();
		try {
			menuItemService.delItemUserGroup(itemId, groupsId);
			dataResult.put("success", true);
		} catch (Exception e) {
			dataResult.put("success", false);
			dataResult.put("errorMsg", e.getMessage());
		}
		return dataResult;
	}
	
	
}
