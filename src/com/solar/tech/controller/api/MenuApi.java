package com.solar.tech.controller.api;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.Menu;
import com.solar.tech.menuadmin.MenuService;

/**
 * 
 * @ClassName MenuApi
 * @Description 菜单api
 * @Author wwd
 * @copyRight 续日科技 solartech
 * @Date 2015年6月29日
 * @Version V1.0.1
 */
@Controller
@RequestMapping("/api/framework/menu")
public class MenuApi {
	@Autowired
	private MenuService menuService;

	/**
	 * 
	 * @Title getAllMenus
	 * @Description 获取所有的菜单api
	 * @Return List<Menu> 返回类型
	 * @return
	 */
	@RequestMapping("/getAllMenu.action")
	@ResponseBody
	public Map<String, Object> getAllMenus() {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			List<Menu> menus = menuService.getAllMenus();
			map.put("result", 0);
			map.put("menulist", menus);
		} catch (Exception e) {
			map.put("result", -1);
			map.put("reason", e.getMessage());
		}
		return map;
	}

	@RequestMapping("/getMenu.action")
	@ResponseBody
	public Map<String, Object> getMenuById(Integer menuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			Menu menu = menuService.getMenuById(menuid);
			map.put("result", 0);
			map.put("menu", menu);
		} catch (Exception e) {
			map.put("result", -1);
			map.put("reason", e.getMessage());
		}
		return map;
	}

	@RequestMapping("/getMenuByType.action")
	@ResponseBody
	public Map<String, Object> getMenuByType(String typename) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			List<Menu> meuns = menuService
					.getMenuByType(typename.toUpperCase());
			map.put("result", 0);
			map.put("menulist", meuns);
		} catch (Exception e) {
			map.put("result", -1);
			map.put("reason", e.getMessage());
		}
		return map;
	}
}
