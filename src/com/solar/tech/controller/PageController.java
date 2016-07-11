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
import com.solar.tech.bean.WebPage;
import com.solar.tech.pageadmin.PageGroupModel;
import com.solar.tech.pageadmin.PageModel;
import com.solar.tech.pageadmin.PageService;

/**
 * 
 * @ClassName PageController
 * @Description 页面控制层处理类
 * @Author wwd
 * @copyRight 续日科技 solartech
 * @Date 2015年6月15日
 * @Version V1.0.1
 */
@Controller
@RequestMapping("/framework/page")
public class PageController {
	@Autowired
	private PageService pageService;

	/**
	 * 
	 * @Title index
	 * @Description 转发到页面管理的主界面
	 * @Return String 返回类型
	 * @return
	 */
	@RequestMapping("/index.action")
	public String index() {
		return "/framework/page/shows";
	}

	@RequestMapping("/add.action")
	@ResponseBody
	public Map<String, Object> add(String pageName, String pageUrl,
			Integer sortNum, Integer moduleId, String description,String pageNum
			,String needAclCtrl,String pageType) {
		Map<String, Object> dataResult = new HashMap<String, Object>();
		try {
			WebPage webPage = new WebPage();
			webPage.setPageName(pageName);
			webPage.setPageUrl(pageUrl);
			webPage.setSortNum(sortNum);
			webPage.setModuleId(moduleId);
			webPage.setDescription(description);
			webPage.setPageType(pageType);
			webPage.setNeedAclCtrl(needAclCtrl);
			webPage.setPageNum(pageNum);
			PageModel module=pageService.add(webPage);
			dataResult.put("success", true);
			dataResult.put("flag", "add");
			dataResult.put("module", module);
		} catch (Exception e) {
			dataResult.put("success", false);
			dataResult.put("errorMsg", e.getMessage());
		}
		return dataResult;
	}

	/**
	 * 
	 * @Title shows
	 * @Description 分页获取页面的数据
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
		Map<String, Object> dataResult = pageService.shows(page, rows);
		dataResult.put("success", true);
		
		return dataResult;
	}
	/**
	 * 
	* @Title delete
	* @Description 删除页面
	* @Return Map<String,Object> 返回类型
	*@param id
	*@return
	 */
	@RequestMapping("/del.action")
	@ResponseBody
	public Map<String, Object> delete(Integer id){
		Map<String, Object> dataResult = new HashMap<String, Object>();
		try {
			pageService.delete(id);
			dataResult.put("success", true);
		} catch (Exception e) {
			dataResult.put("success", false);
			dataResult.put("errorMsg", e.getMessage());
		}
			return dataResult;
		}
	
	/**
	 * 
	* @Title update
	* @Description 更新页面
	* @Return Map<String,Object> 返回类型
	*@param pageId
	*@param pageName
	*@param pageUrl
	*@param sortNum
	*@param moduleId
	*@param description
	*@return
	 */
	@RequestMapping("/update.action")
	@ResponseBody
	public Map<String, Object> update(Integer pageId,String pageName, String pageUrl,
			Integer sortNum, Integer moduleId, String description,String pageNum
			,String needAclCtrl,String pageType) {
		Map<String, Object> dataResult = new HashMap<String, Object>();
		try {
			PageModel module=pageService.update( pageId, pageName,  pageUrl,
					 sortNum,  moduleId,  description,pageNum, needAclCtrl, pageType);
			dataResult.put("success", true);
			dataResult.put("flag", "update");
			dataResult.put("module", module);
		} catch (Exception e) {
			dataResult.put("success", false);
			dataResult.put("errorMsg", e.getMessage());
		}
		return dataResult;
	}
	
	/**
	 * 
	* @Title pageTree
	* @Description  页面树形控件的数据
	* @Return List<Map<String,Object>> 返回类型
	*@param id
	*@return
	 */
	@RequestMapping("/pageTree.action")
	@ResponseBody
	public List<Map<String, Object>> pageTree(int id) {
		List<Map<String, Object>> map = pageService.pageTree(id);
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
	public PageModel  detail(int id) {
		PageModel model = pageService.detail(id);
		return model;
	}
	
	@RequestMapping("/userGroupWebPage.action")
	@ResponseBody
	public Map<String, Object>  userGroupPageModule(int pageModuleId) {
		System.out.println("pageModuleId:"+pageModuleId);
		Map<String, Object> dataResult= pageService.userGroupWebPage(pageModuleId);
		dataResult.put("success", true);
		return dataResult;
	}
	
	@RequestMapping("/unUserGroupWebPage.action")
	@ResponseBody
	public Map<String, Object> unUserGroupWebPage(int pageModuleId) {
		Map<String, Object> dataResult = pageService.unUserGroupWebPage(pageModuleId);
		dataResult.put("success", true);
		return dataResult;
	}
	
	
	@RequestMapping("/addUserGroupWebPage.action")
	@ResponseBody
	public Map<String, Object> addUserGroupWebPage(int pageGroupId, @RequestParam("groupsId[]") List<Integer> groupsId) {
		Map<String, Object> dataResult = new HashMap<String, Object>();
		try {
			pageService.addUserGroupWebPage(pageGroupId, groupsId);
			dataResult.put("success", true);
		} catch (Exception e) {
			dataResult.put("success", false);
			dataResult.put("errorMsg", e.getMessage());
		}
		return dataResult;
	}
	
	@RequestMapping("/delUserGroupWebPage.action")
	@ResponseBody
	public Map<String, Object> delUserGroupWebPage(int pageGroupId, @RequestParam("groupsId[]") List<Integer> groupsId) {
		Map<String, Object> dataResult = new HashMap<String, Object>();
		try {
			pageService.delUserGroupWebPage(pageGroupId, groupsId);
			dataResult.put("success", true);
		} catch (Exception e) {
			dataResult.put("success", false);
			dataResult.put("errorMsg", e.getMessage());
		}
		return dataResult;
	}
	
	@RequestMapping("/userWebPage.action")
	@ResponseBody
	public Map<String, Object> userWebPage(int pageModuleId) {
		Map<String, Object> dataResult = pageService.userWebPage(pageModuleId);
		dataResult.put("success", true);
		return dataResult;
	}
	
	@RequestMapping("/unUserWebPage.action")
	@ResponseBody
	public Map<String, Object> unUserWebPage(int pageModuleId) {
		Map<String, Object> dataResult = pageService.unUserWebPage(pageModuleId);
		dataResult.put("success", true);
		return dataResult;
	}
	
	@RequestMapping("/addUserWebPage.action")
	@ResponseBody
	public Map<String, Object> addUserWebPage(int pageGroupId, @RequestParam("usersId[]") List<String> usersId) {
		Map<String, Object> dataResult = new HashMap<String, Object>();
		try {
			pageService.addUserWebPage(pageGroupId, usersId);
			dataResult.put("success", true);
		} catch (Exception e) {
			dataResult.put("success", false);
			dataResult.put("errorMsg", e.getMessage());
		}
		return dataResult;
	}
	
	@RequestMapping("/delUserWebPage.action")
	@ResponseBody
	public Map<String, Object> delUserWebPage(int pageGroupId, @RequestParam("usersId[]") List<String> usersId) {
		Map<String, Object> dataResult = new HashMap<String, Object>();
		try {
			pageService.delUserWebPage(pageGroupId, usersId);
			dataResult.put("success", true);
		} catch (Exception e) {
			dataResult.put("success", false);
			dataResult.put("errorMsg", e.getMessage());
		}
		return dataResult;
	}
}
