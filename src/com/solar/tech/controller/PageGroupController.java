package com.solar.tech.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Column;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.PageModule;
import com.solar.tech.pageadmin.PageGroupModel;
import com.solar.tech.pageadmin.PageGroupService;

/**
 * 
 * @ClassName PageGroupController
 * @Description 页面组控制层处理类
 * @Author wwd
 * @copyRight 续日科技 solartech
 * @Date 2015年6月15日
 * @Version V1.0.1
 */
@Controller
@RequestMapping("/framework/page/group")
public class PageGroupController {
	@Autowired
	private PageGroupService pageGroupService;
	/**
	 * 
	 * @Title index
	 * @Description 转发到页面组管理的主界面
	 * @Return String 返回类型
	 * @return
	 */
	@RequestMapping("/index.action")
	public String index() {
		return "/framework/page/group/shows";
	}
	/**
	 * 
	* @Title add
	* @Description 添加页面组
	* @Return Map<String,Object> 返回类型
	*@param moduleName
	*@param parentModuleId
	*@param sortNum
	*@param moduleIcon
	*@param description
	*@return
	 */
	@RequestMapping("/add.action")
	@ResponseBody
	public Map<String, Object> add(String moduleName, Integer parentModuleId, Integer sortNum, 
			String moduleIcon, String description){
		Map<String, Object> dataResult = new HashMap<String, Object>();
		try {
		PageModule pageModule=new PageModule();
		pageModule.setModuleName(moduleName);
		pageModule.setParentModuleId(parentModuleId);
		pageModule.setSortNum(sortNum);
		pageModule.setModuleIcon(moduleIcon);
		pageModule.setDescription(description);
		pageModule.setCreateTime(new Date());
		String username=com.solar.tech.util.Current.user().getUserName();
		pageModule.setCreateBy(username);
		pageModule.setUpdateTime(new Date());
		pageModule.setUpdateBy(username);
		PageModule module=pageGroupService.add(pageModule);
		dataResult.put("success", true);
		dataResult.put("module", module);
		dataResult.put("flag", "add");
	} catch (Exception e) {
		dataResult.put("success", false);
		dataResult.put("errorMsg", e.getMessage());
	}
		return dataResult;
	}
	
	/**
	 * 
	 * @Title shows
	 * @Description 分页获取页面组的数据
	 * @Return Map<String,Object> 返回类型
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping("/shows.action")
	@ResponseBody
	public Map<String, Object> shows(Integer page, Integer rows) {
		System.out.println(page);
		System.out.println(rows);
		Map<String, Object> dataResult = pageGroupService.shows(page, rows);
		dataResult.put("success", true);
		return dataResult;
	}
	/**
	 * 
	* @Title update
	* @Description 更新页面组
	* @Return Map<String,Object> 返回类型
	*@param moduleId
	*@param moduleName
	*@param parentModuleId
	*@param sortNum
	*@param moduleIcon
	*@param description
	*@return
	 */
	@RequestMapping("/update.action")
	@ResponseBody
	public Map<String, Object> update(Integer moduleId,String moduleName, Integer parentModuleId, Integer sortNum, 
			String moduleIcon, String description){
		Map<String, Object> dataResult = new HashMap<String, Object>();
		try {
			PageModule mdule=pageGroupService.update( moduleId, moduleName,  parentModuleId,  sortNum, 
					 moduleIcon,  description);
			dataResult.put("success", true);
			dataResult.put("module", mdule);
			dataResult.put("flag", "update");
		} catch (Exception e) {
			dataResult.put("success", false);
			dataResult.put("errorMsg", e.getMessage());
		}
			return dataResult;
		
		}
	/**
	 * 
	* @Title delete
	* @Description 删除页面组
	* @Return Map<String,Object> 返回类型
	*@param id
	*@return
	 */
	@RequestMapping("/del.action")
	@ResponseBody
	public Map<String, Object> delete(Integer id){
		Map<String, Object> dataResult = new HashMap<String, Object>();
		try {
			pageGroupService.delete(id);
			dataResult.put("success", true);
		} catch (Exception e) {
			dataResult.put("success", false);
			dataResult.put("errorMsg", e.getMessage());
		}
			return dataResult;
		}
	/**
	 * 
	* @Title getParentModul
	* @Description 上级导航页面树形菜单的数据
	* @Return List<Map<String,Object>> 返回类型
	*@param id
	*@return
	 */
	@RequestMapping("/parentModul.action")
	@ResponseBody
	public List<Map<String, Object>> getParentModul(int id) {
		List<Map<String, Object>> map = pageGroupService.ParentModul(id);
		return map;
	}
	/**
	 * 导航页面
	* @Title pageGuid
	* @Description 【这里用一句话描述这个方法的作用】
	* @Return List<Map<String,Object>> 返回类型
	*@param id
	*@return
	 */
	@RequestMapping("/pageGuid.action")
	@ResponseBody
	public List<Map<String, Object>> pageGuid(int id) {
		List<Map<String, Object>> map = pageGroupService.gruopAndPage(id);
		return map;
	}
	
	/**
	 * 
	* @Title detail
	* @Description 根据id 获取页面组详情
	* @Return PageGroupModel 返回类型
	*@param id
	*@return
	 */
	@RequestMapping("/detail.action")
	@ResponseBody
	public PageGroupModel  detail(int id) {
		PageGroupModel  pageGroupModel = pageGroupService.findById(id);
		return pageGroupModel;
	}
	
	@RequestMapping("/userGroupPageModule.action")
	@ResponseBody
	public Map<String, Object>  userGroupPageModule(int pageModuleId) {
		Map<String, Object> dataResult= pageGroupService.userGroupPageModule(pageModuleId);
		dataResult.put("success", true);
		return dataResult;
	}
	
	@RequestMapping("/unUserGroupPageModule.action")
	@ResponseBody
	public Map<String, Object> unUserGroupPageModule(int pageModuleId) {
		Map<String, Object> dataResult = pageGroupService.unUserGroupPageModule(pageModuleId);
		dataResult.put("success", true);
		return dataResult;
	}
	
	@RequestMapping("/addUserGroupPageModule.action")
	@ResponseBody
	public Map<String, Object> addUserGroupPageModule(int pageGroupId, @RequestParam("groupsId[]") List<Integer> groupsId) {
		Map<String, Object> dataResult = new HashMap<String, Object>();
		try {
			pageGroupService.addUserGroupPageModule(pageGroupId, groupsId);
			dataResult.put("success", true);
		} catch (Exception e) {
			dataResult.put("success", false);
			dataResult.put("errorMsg", e.getMessage());
		}
		return dataResult;
	}
	
	@RequestMapping("/delUserGroupPageModule.action")
	@ResponseBody
	public Map<String, Object> delUserGroupPageModule(int pageGroupId, @RequestParam("groupsId[]") List<Integer> groupsId) {
		Map<String, Object> dataResult = new HashMap<String, Object>();
		try {
			pageGroupService.delUserGroupPageModule(pageGroupId, groupsId);
			dataResult.put("success", true);
		} catch (Exception e) {
			dataResult.put("success", false);
			dataResult.put("errorMsg", e.getMessage());
		}
		return dataResult;
	}
	
	
	
	@RequestMapping("/userPageModule.action")
	@ResponseBody
	public Map<String, Object> userPageModule(int pageModuleId) {
		Map<String, Object> dataResult = pageGroupService.userPageModule(pageModuleId);
		dataResult.put("success", true);
		return dataResult;
	}
	
	@RequestMapping("/unUserPageModule.action")
	@ResponseBody
	public Map<String, Object> unUserPageModule(int pageModuleId) {
		Map<String, Object> dataResult = pageGroupService.unUserPageModule(pageModuleId);
		dataResult.put("success", true);
		return dataResult;
	}
	
	
	
	@RequestMapping("/addUserPageModule.action")
	@ResponseBody
	public Map<String, Object> addUserPageModule(int pageGroupId, @RequestParam("usersId[]") List<String> usersId) {
		Map<String, Object> dataResult = new HashMap<String, Object>();
		try {
			pageGroupService.addUserPageModule(pageGroupId, usersId);
			dataResult.put("success", true);
		} catch (Exception e) {
			dataResult.put("success", false);
			dataResult.put("errorMsg", e.getMessage());
		}
		return dataResult;
	}
	
	@RequestMapping("/delUserPageModule.action")
	@ResponseBody
	public Map<String, Object> delUserPageModule(int pageGroupId, @RequestParam("usersId[]") List<String> usersId) {
		Map<String, Object> dataResult = new HashMap<String, Object>();
		try {
			pageGroupService.delUserPageModule(pageGroupId, usersId);
			dataResult.put("success", true);
		} catch (Exception e) {
			dataResult.put("success", false);
			dataResult.put("errorMsg", e.getMessage());
		}
		return dataResult;
	}
}
