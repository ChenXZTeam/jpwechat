package com.solar.tech.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.Menu;
import com.solar.tech.menuadmin.MenuItemService;

/**
 * 
* @ClassName IndexController
* @Description 系统主界面
* @Author wwd
*@copyRight 续日科技 solartech
* @Date 2015年6月15日
*@Version V1.0.1
 */
@Controller
@RequestMapping("/framework")
public class IndexController {
	 @Autowired
	private MenuItemService menuItemService;
  	/**
  	 * 
  	 * @Title index
  	 * @Description 转发到菜单界面
  	 * @Return String 返回类型
  	 * @return
  	 */
  	@RequestMapping("/index.action")
  	public String index(Map<String, Object> map) {
		List<Menu> menus = menuItemService.systemMenu();
		map.put("sysMenus", menus);
		return "/framework/index";
	}
  	
	@RequestMapping("/sysMenuItem.action")
	@ResponseBody
	public List<Map<String, Object>> sysMenuItem(int parentItemId,int menuId) {
			List<Map<String, Object>> map =menuItemService.sysMenuItem(parentItemId, menuId);
			return map;
		}
  	
	@RequestMapping("/test.action")
	@ResponseBody
	public List<Map<String, Object>> test() {
			List<Map<String, Object>> lists=new ArrayList<Map<String,Object>>();
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("id", 1);
			map.put("name", "All Tasks");
			map.put("begin", "3/4/2010");
			map.put("end", "3/20/2010");
			map.put("progress", 60);
			map.put("iconCls", "icon-ok");
			//lists.add(map);
			
			Map<String,Object> map1=new HashMap<String,Object>();
			map1.put("id", 2);
			map1.put("name", " Designing");
			map1.put("begin", "3/4/2010");
			map1.put("end", "3/20/2010");
			map1.put("progress", 60);
			map1.put("iconCls", "icon-ok");
			map1.put("_parentId", 1);

			//lists.add(map1);

			Map<String,Object> map2=new HashMap<String,Object>();
			map2.put("id", 3);
			map2.put("name", " uml");
			map2.put("begin", "3/4/2010");
			map2.put("end", "3/20/2010");
			map2.put("progress", 60);
			map2.put("iconCls", "icon-ok");
			map2.put("_parentId", 2);
          
			lists.add(map);
			lists.add(map1);
			lists.add(map2);
			return lists;
		}
}
