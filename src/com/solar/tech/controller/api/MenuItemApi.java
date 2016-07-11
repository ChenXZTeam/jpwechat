package com.solar.tech.controller.api;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.Menu;
import com.solar.tech.bean.MenuItem;
import com.solar.tech.menuadmin.MenuItemService;
import com.solar.tech.menuadmin.MenuService;

/**
 * 
 * @ClassName MenuItemApi
 * @Description 菜单项api
 * @Author wwd
 * @copyRight 续日科技 solartech
 * @Date 2015年6月29日
 * @Version V1.0.1
 */
@Controller
@RequestMapping("/api/framework/menuitem")
public class MenuItemApi {
	@Autowired
	private MenuItemService menuItemService;

	@RequestMapping("/getMenuItem.action")
	@ResponseBody
	public Map<String, Object> getMenuItemById(Integer itemid) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			MenuItem menuItem = menuItemService.getMenuItemById(itemid);
			map.put("result", 100);
			map.put("menuitem", menuItem);
		} catch (Exception e) {
			map.put("result", -1);
			map.put("reason", e.getMessage());
		}
		return map;
	}

	  /**
	   * 
	  * @Title getMenuItemByItem
	  * @Description 获取指定菜单项的子菜单项
	  * @Return Map<String,Object> 返回类型
	  *@param itemid
	  *@param dept
	  *@return
	   */
	@RequestMapping("/getMenuItemByItem.action")
	@ResponseBody
	public Map<String, Object> getMenuItemByItem(Integer itemid,Integer depth) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if(depth==null||depth==0){
				depth=0;
			}
			map= menuItemService.getMenuItemByItem(itemid,depth,1);
			map.put("result", 100);
		} catch (Exception e) {
			map.put("result", -1);
			map.put("reason", e.getMessage());
		}
		return map;
	}

	/**
	 * 
	* @Title getItemByMennuId
	* @Description 3.9.2.2.	获取指定菜单下的菜单项
	* @Return Map<String,Object> 返回类型
	*@param menuid
	*@return
	 */
	@RequestMapping("/getMenuItemByMenu.action")
	@ResponseBody
	public Map<String, Object>  getItemByMennuId(Integer menuid,Integer depth) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if(depth==null||depth==0){
				depth=0;
			}
		map = menuItemService.getItemByMennuId(0, menuid,depth,1);
		map.put("result", 100);
		map.put("itemlist", map.get("item"));
		map.remove("item");
	//	map.put("", list);
	} catch (Exception e) {
		map.put("result", -1);
		map.put("reason", e.getMessage());
	}
	return map;
	}

/*	@RequestMapping("/getItemByType.action")
	@ResponseBody
	public List<Object> getItemByType(Integer menuId, String itemType) {
		List<Object> list = menuItemService.getItemByType(itemType, menuId, 0);
		return list;
	}*/
}
