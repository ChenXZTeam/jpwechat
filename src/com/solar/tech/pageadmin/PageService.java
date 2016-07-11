package com.solar.tech.pageadmin;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.solar.tech.bean.Menu;
import com.solar.tech.bean.PageModule;
import com.solar.tech.bean.UserGroup;
import com.solar.tech.bean.UserGroupPageModule;
import com.solar.tech.bean.UserGroupWebPage;
import com.solar.tech.bean.UserPageModule;
import com.solar.tech.bean.UserWebPage;
import com.solar.tech.bean.WebPage;
import com.solar.tech.dao.GenericDao;

/**
 * 
 * @ClassName PageService
 * @Description 页面信息业务逻辑处理类 实现页面信息的增、删、改、查
 * @Author wwd
 * @copyRight 续日科技 solartech
 * @Date 2015年6月17日
 * @Version V1.0.1
 */
@Service
public class PageService {
	@Autowired
	private GenericDao dao;
  
	/**
	 * 
	 * @Title add
	 * @Description 添加页面
	 * @Return void 返回类型
	 * @param webPage
	 * @throws Exception
	 */
	public PageModel add(WebPage webPage) throws Exception {
		webPage.setCreateTime(new Date());
		String username=com.solar.tech.util.Current.user().getUserName();
		webPage.setCreateBy(username);
		webPage.setUpdateTime(new Date());
		webPage.setUpdateBy(username);
		List<WebPage> webPages = dao.find("from WebPage where moduleId="
				+ webPage.getModuleId() + " and pageName='"
				+ webPage.getPageName() + "'");
		if (webPages.size() != 0) {
			throw new Exception("页面名称在同一层级下是不可重复的");
		} else {

			if (webPage.getSortNum() == null) {
				webPage.setSortNum(0);
			}

			if (webPage.getModuleId() == null) {
				webPage.setModuleId(0);
			}

			dao.save(webPage);
			return model(webPage);
		}
	}

	/**
	 * 
	 * @Title shows
	 * @Description 分页显示页面组的信息
	 * @Return Map<String,Object> 返回类型
	 * @param page
	 *            页数
	 * @param rows
	 *            页大小
	 * @return
	 */
	public Map<String, Object> shows(Integer page, Integer rows) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<WebPage> webPages = dao.findByPage(
				"from WebPage p order by sortNum desc,pageId asc", page, rows);
		Long total = dao.count(WebPage.class);
		map.put("rows", webPageToPageModel(webPages));
		map.put("total", total);
		return map;
	}

	/**
	 * 
	 * @Title delete
	 * @Description 删除页面
	 * @Return void 返回类型
	 * @param id
	 * @throws Exception
	 */
	public void delete(Integer id) throws Exception {
		WebPage webPage = dao.findById(WebPage.class, id);
		if (webPage == null) {
			throw new Exception("页面ID:" + id + "不存在,删除失败");
		} else {
			dao.delete(webPage);
		}
	}

	/**
	 * 
	 * @Title update
	 * @Description 更新页面
	 * @Return void 返回类型
	 * @param pageId
	 * @param pageName
	 * @param pageUrl
	 * @param sortNum
	 * @param moduleId
	 * @param description
	 * @param username
	 * @throws Exception
	 */
	public PageModel update(Integer pageId, String pageName, String pageUrl,
			Integer sortNum, Integer moduleId, String description,
			 String pageNum,String needAclCtrl,String pageType) throws Exception {
		WebPage webPage = dao.findById(WebPage.class, pageId);
		if (webPage == null) {
			throw new Exception("页面ID:" + pageId + "不存在,修改失败");
		} else {
			if (!webPage.getPageName().equals(pageName)) {
				List<WebPage> webPages = dao
						.find("from WebPage where moduleId="
								+ webPage.getModuleId() + " and pageName='"
								+ pageName + "'");
				if (webPages.size() != 0) {
					throw new Exception("页面名称在同一层级下是不可重复的");
				}
			}
		}
		webPage.setPageName(pageName);
		webPage.setPageUrl(pageUrl);
		webPage.setSortNum(sortNum);
		webPage.setModuleId(moduleId);
		webPage.setDescription(description);
		webPage.setUpdateTime(new Date());
		webPage.setPageNum(pageNum);
		webPage.setPageType(pageType);
		webPage.setNeedAclCtrl(needAclCtrl);
		String username=com.solar.tech.util.Current.user().getUserName();
		webPage.setUpdateBy(username);
		dao.update(webPage);
		return model(webPage);
	}

	/**
	 * 
	 * @Title webPageToPageModel
	 * @Description 数据模型转换
	 * @Return List<PageModel> 返回类型
	 * @param webpages
	 * @return
	 */
	public List<PageModel> webPageToPageModel(List<WebPage> webpages) {
		List<PageModel> models = new ArrayList<PageModel>();
		for (WebPage webpage : webpages) {
			PageModel model = new PageModel();
			model.setPageId(webpage.getPageId());
			model.setPageNum(webpage.getPageNum());
			model.setPageName(webpage.getPageName());
			model.setPageUrl(webpage.getPageUrl());
			model.setSortNum(webpage.getSortNum());
			model.setModuleId(webpage.getModuleId());
			model.setDescription(webpage.getDescription());
			model.setCreateBy(webpage.getCreateBy());
			model.setCreateTime(webpage.getCreateTime());
			model.setUpdateBy(webpage.getUpdateBy());
			model.setUpdateTime(webpage.getUpdateTime());
			if (webpage.getModuleId() == 0) {
				model.setModuleName("未分类");
			} else {
				PageModule m = dao.findById(PageModule.class,
						webpage.getModuleId());
				if (m != null) {
					model.setModuleName(m.getModuleName());
				}
			}
			models.add(model);
		}
		return models;
	}
	
	/**
	 * 
	* @Title pageTree
	* @Description 页面树形菜单菜单的数据
	* @Return List<Map<String,Object>> 返回类型
	*@param ParentModulId
	*@return
	 */
	public List<Map<String, Object>> pageTree(Integer ParentModulId) {
		List<Map<String, Object>> results = new ArrayList<Map<String, Object>>();
		List<PageModule> pageModules = dao
				.find("from PageModule p where p.parentModuleId="
						+ ParentModulId);
		for (PageModule pageModule : pageModules) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", pageModule.getModuleId());
			map.put("text", pageModule.getModuleName());

			Map<String, String> groupAttributes = new HashMap<String, String>();
			groupAttributes.put("group", "true");
			map.put("attributes", groupAttributes);
			List<PageModule> obj = dao
					.find("from PageModule p where p.parentModuleId="
							+ pageModule.getModuleId());
			if (obj.size() == 0) {
				map.put("state", "");
				List<WebPage> webPages = dao
						.find("from WebPage where moduleId="
								+ pageModule.getModuleId());
				List<Map<String, Object>> webPageList = new ArrayList<Map<String, Object>>();
				for (WebPage webPage : webPages) {
					Map<String, Object> webPageMap = new HashMap<String, Object>();
					webPageMap.put("id", webPage.getPageId());
					webPageMap.put("text", webPage.getPageName());

					Map<String, String> groupAttributes1 = new HashMap<String, String>();
					groupAttributes1.put("group", "false");
					webPageMap.put("attributes", groupAttributes1);
					webPageList.add(webPageMap);
				}
				map.put("children", webPageList);
			} else {
				map.put("state", "closed");
				List<WebPage> webPages = dao
						.find("from WebPage where moduleId="
								+ pageModule.getModuleId());
				List<Map<String, Object>> webPageList = new ArrayList<Map<String, Object>>();
				for (WebPage webPage : webPages) {
					Map<String, Object> webPageMap = new HashMap<String, Object>();
					webPageMap.put("id", webPage.getPageId());
					webPageMap.put("text", webPage.getPageName());

					Map<String, String> groupAttributes1 = new HashMap<String, String>();
					groupAttributes1.put("group", "false");
					webPageMap.put("attributes", groupAttributes1);
					webPageList.add(webPageMap);
				}

				for (PageModule group : obj) {
					Map<String, Object> webPageMap = new HashMap<String, Object>();
					webPageMap.put("id", group.getModuleId());
					webPageMap.put("text", group.getModuleName());

					Map<String, String> groupAttributes1 = new HashMap<String, String>();
					groupAttributes1.put("group", "true");
					webPageMap.put("attributes", groupAttributes1);

					List<PageModule> hasChilden = dao
							.find("from PageModule p where p.parentModuleId="
									+ group.getModuleId());

					List<WebPage> hasWebPages = dao
							.find("from WebPage where moduleId="
									+ group.getModuleId());
					// System.out.println(group.getModuleName()+"   hasWebPages="+hasWebPages.size()+"   hasChilden="+hasChilden.size());
					if (hasChilden.size() == 0 && hasWebPages.size() == 0) {
						webPageMap.put("state", "");
					} else {
						webPageMap.put("state", "closed");
					}
					webPageList.add(webPageMap);
				}
				map.put("children", webPageList);
			}

			results.add(map);
		}

		List<WebPage> webPages = dao.find("from WebPage where moduleId="
				+ ParentModulId);
		for (WebPage webPage : webPages) {
			Map<String, Object> webPageMap = new HashMap<String, Object>();
			webPageMap.put("id", webPage.getPageId());
			webPageMap.put("text", webPage.getPageName());
			webPageMap.put("state", "");
			Map<String, String> groupAttributes1 = new HashMap<String, String>();
			groupAttributes1.put("group", "false");
			webPageMap.put("attributes", groupAttributes1);
			results.add(webPageMap);
		}
		if (ParentModulId != 0) {
			return results;
		} else {
			List<Map<String, Object>> rootList = new ArrayList<Map<String, Object>>();
			Map<String, Object> rootMap = new HashMap<String, Object>();
			rootMap.put("id", "root");
			rootMap.put("text", "页面");
			rootMap.put("state", "open");
			rootMap.put("children", results);
			Map<String, String> groupAttributes1 = new HashMap<String, String>();
			groupAttributes1.put("group", "true");
			rootMap.put("attributes", groupAttributes1);
			rootList.add(rootMap);
			return rootList;
		}
	}
	 
	/**
	 * 
	* @Title model
	* @Description 模型转换
	* @Return PageModel 返回类型
	*@param webpage
	*@return
	 */
	public  PageModel model(WebPage webpage){
		PageModel model = new PageModel();
		model.setPageId(webpage.getPageId());
		model.setPageNum(webpage.getPageNum());
		model.setPageName(webpage.getPageName());
		model.setPageUrl(webpage.getPageUrl());
		model.setSortNum(webpage.getSortNum());
		model.setModuleId(webpage.getModuleId());
		model.setDescription(webpage.getDescription());
		model.setCreateBy(webpage.getCreateBy());
		model.setCreateTime(webpage.getCreateTime());
		model.setUpdateBy(webpage.getUpdateBy());
		model.setUpdateTime(webpage.getUpdateTime());
		model.setPageType(webpage.getPageType());
		model.setNeedAclCtrl(webpage.getNeedAclCtrl());
		if (webpage.getModuleId() == 0) {
			model.setModuleName("未分类");
		} else {
			PageModule m = dao.findById(PageModule.class,
					webpage.getModuleId());
			if (m != null) {
				model.setModuleName(m.getModuleName());
			}
		}
		return model;
	}
	
	/**
	 * 
	* @Title detail
	* @Description  根据id 获取页面详情
	* @Return PageModel 返回类型
	*@param id
	*@return
	 */
  public PageModel detail(Integer id){
	  WebPage page=dao.findById(WebPage.class, id);
	  if(page==null){
		  return null;
	  }else{
		  return model(page);
	  }
  }
  
  
	
public Map<String, Object> userGroupWebPage(int pageId) {
	Map<String, Object> map = new HashMap<String, Object>();
	List<UserGroup> menus = dao.find("from UserGroup u where u.groupId in (select groupId from UserGroupWebPage  where PageId="+pageId+")");
	map.put("rows", menus);
	return map;
}

public Map<String, Object> unUserGroupWebPage(int moduleId) {
	Map<String, Object> map = new HashMap<String, Object>();
	List<UserGroup> menus = dao.find("from UserGroup u where u.groupId not  in (select groupId from UserGroupWebPage  where PageId="+moduleId+")");
	map.put("rows", menus);
	return map;
}

public void addUserGroupWebPage(int pageId,List<Integer> groupsId) throws Exception{
	  for(Integer groupId:groupsId){
		  List<UserGroupWebPage> userGroupWebPages=dao.find("from UserGroupWebPage where PageId="+pageId+" and groupId="+groupId);
		  if(userGroupWebPages.size()==0){
			  UserGroupWebPage userGroupWebPage=new UserGroupWebPage();
			  userGroupWebPage.setGroupId(groupId);
			  userGroupWebPage.setPageId(pageId);
			  dao.save(userGroupWebPage);
		  }
	  }

	}

public void delUserGroupWebPage(int moduleId,List<Integer> groupsId) throws Exception{
	  for(Integer groupId:groupsId){
		  List<UserGroupWebPage> userGroupWebPages=dao.find("from UserGroupWebPage where PageId="+moduleId+" and groupId="+groupId);
		 for(UserGroupWebPage userGroupWebPage:userGroupWebPages){
			  dao.delete(userGroupWebPage);
		  }
	  }
}


public Map<String, Object> userWebPage(int pageGroupId) {
	Map<String, Object> map = new HashMap<String, Object>();
	List<Menu> menus = dao.find("from User u where u.userUID in (select uSERUID from UserWebPage where PageId="+pageGroupId+")");
	map.put("rows", menus);
	return map;
}


public Map<String, Object> unUserWebPage(int pageGroupId) {
	Map<String, Object> map = new HashMap<String, Object>();
	List<Menu> menus = dao.find("from User u where u.userUID not  in (select uSERUID from UserWebPage where PageId="+pageGroupId+")");
	map.put("rows", menus);
	return map;
}


public void addUserWebPage(int moduleId,List<String> usersId) throws Exception{
	  for(String userId:usersId){
		  List<UserWebPage> userWebPages=dao.find("from UserWebPage where PageId="+moduleId+" and uSERUID='"+userId+"'");
		  if(userWebPages.size()==0){
			  UserWebPage userWebPage=new UserWebPage();
			  userWebPage.setPageId(moduleId);
			  userWebPage.setUSERUID(userId);
			  dao.save(userWebPage);
		  }
	  }

	}

public void delUserWebPage(int moduleId,List<String> usersId) throws Exception{
	  for(String userId:usersId){
		  List<UserWebPage> userWebPages=dao.find("from UserWebPage where PageId="+moduleId+" and uSERUID='"+userId+"'");
		 for(UserWebPage userWebPage:userWebPages){
			  dao.delete(userWebPage);
		  }
	  }
}


}
