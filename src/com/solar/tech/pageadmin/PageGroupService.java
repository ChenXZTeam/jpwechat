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
import com.solar.tech.bean.MenuItem;
import com.solar.tech.bean.PageModule;
import com.solar.tech.bean.UserGroup;
import com.solar.tech.bean.UserGroupMenu;
import com.solar.tech.bean.UserGroupPageModule;
import com.solar.tech.bean.UserPageModule;
import com.solar.tech.bean.WebPage;
import com.solar.tech.dao.GenericDao;

/**
 * 
 * @ClassName PageGroupService
 * @Description 页面组业务逻辑处理类
 * @Author wwd
 * @copyRight 续日科技 solartech
 * @Date 2015年6月15日
 * @Version V1.0.1
 */
@Service
public class PageGroupService {
	@Autowired
	private GenericDao dao;

	/**
	 * 
	 * @Title add
	 * @Description 添加页面组
	 * @Return void 返回类型
	 * @param pageModule
	 * @throws Exception
	 */
	public PageModule add(PageModule pageModule) throws Exception {
		if (pageModule.getParentModuleId() == null) {
			pageModule.setParentModuleId(0);
		}
		if (pageModule.getSortNum() == null) {
			pageModule.setSortNum(0);
		}
		List<PageModule> lists = dao
				.find("from PageModule p where p.moduleName='"
						+ pageModule.getModuleName() + "'");
		if (lists.size() != 0) {
			throw new Exception(pageModule.getModuleName() + "已经存在无法重复添加");
		}
		dao.save(pageModule);
		return pageModule;
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
		List<PageModule> pageModules = dao.findByPage(
				"from PageModule p order by sortNum desc,moduleId asc", page,
				rows);
		Long total = dao.count(PageModule.class);
		map.put("rows", pageModules);
		map.put("total", total);
		return map;
	}

	/**
	 * 
	 * @Title update
	 * @Description 修改页面组
	 * @Return void 返回类型
	 * @param moduleId
	 * @param moduleName
	 * @param parentModuleId
	 * @param sortNum
	 * @param moduleIcon
	 * @param description
	 * @param username
	 * @throws Exception
	 */
	public PageModule update(Integer moduleId, String moduleName,
			Integer parentModuleId, Integer sortNum, String moduleIcon,
			String description) throws Exception {
		PageModule pageModule = dao.findById(PageModule.class, moduleId);
		if (pageModule == null) {
			throw new Exception("页面组ID:" + moduleId + "不存在,修改失败");
		} else {
			if (!moduleName.equals(pageModule.getModuleName())) {
				List<PageModule> lists = dao
						.find("from PageModule p where p.moduleName='"
								+ moduleName + "'");
				if (lists.size() != 0) {
					throw new Exception(moduleName + "已经存在无法重复添加");
				}
			}
			pageModule.setModuleName(moduleName);
			pageModule.setParentModuleId(parentModuleId);
			pageModule.setSortNum(sortNum);
			pageModule.setModuleIcon(moduleIcon);
			pageModule.setDescription(description);
			pageModule.setUpdateTime(new Date());
			pageModule.setUpdateBy(com.solar.tech.util.Current.user().getUserName());
			dao.update(pageModule);
			return pageModule;
		}
	}

	/**
	 * 
	 * @Title delete
	 * @Description 删除页面组
	 * @Return void 返回类型
	 * @param id
	 * @throws Exception
	 */
	public void delete(Integer id) throws Exception {
		PageModule pageModule = dao.findById(PageModule.class, id);
		if (pageModule == null) {
			throw new Exception("页面组ID:" + id + "不存在,删除失败");
		} else {
			List<WebPage> webPage = dao.find("from WebPage where moduleId="
					+ id);
			if (webPage.size() != 0) {
				throw new Exception("页面组ID:" + id + "下面有还有页面,无法删除");
			}
			
			List<PageModule> pageModules = dao.find("from PageModule where parentModuleId="
					+ id);
			if (pageModules.size() != 0) {
				throw new Exception("页面组ID:" + id + "下面有还有页面组,无法删除");
			}
			dao.delete(pageModule);
		}
	}

	/**
	 * 
	 * @Title ParentModul
	 * @Description 获取页面组树形菜单的数据
	 * @Return List<Map<String,Object>> 返回类型
	 * @param ParentModulId
	 * @return
	 */
	public List<Map<String, Object>> ParentModul(Integer ParentModulId) {
		List<Map<String, Object>> results = new ArrayList<Map<String, Object>>();
		List<PageModule> pageModules = dao
				.find("from PageModule p where p.parentModuleId="
						+ ParentModulId);
		for (PageModule pageModule : pageModules) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", pageModule.getModuleId());
			map.put("text", pageModule.getModuleName());
			List<Object> obj = dao
					.find("from PageModule p where p.parentModuleId="
							+ pageModule.getModuleId());
			if (obj.size() == 0) {
				map.put("state", "");
			} else {
				map.put("state", "closed");
			}
			if (ParentModulId == 0) {
				map.put("url", "root");
			} else {
				map.put("url", "children");
			}
			results.add(map);

		}
		
		
		if (ParentModulId != 0) {
			return results;
		} else {
			List<Map<String, Object>> rootList = new ArrayList<Map<String, Object>>();
			Map<String, Object> rootMap = new HashMap<String, Object>();
			rootMap.put("id", "root");
			rootMap.put("text", "页面组");
			rootMap.put("state", "open");
			rootMap.put("children", results);
			rootList.add(rootMap);
			return rootList;
		}
	}

	/**
	 * 
	 * @Title gruopAndPage
	 * @Description 获取页面组及其组下的页面的树形菜单数据
	 * @Return List<Map<String,Object>> 返回类型
	 * @param ParentModulId
	 * @return
	 */
	public List<Map<String, Object>> gruopAndPage(Integer ParentModulId) {
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
		return results;
	}

	/**
	 * 
	 * @Title findById
	 * @Description 根据页面组id 获取页面组
	 * @Return PageGroupModel 返回类型
	 * @param id
	 * @return
	 */
	public PageGroupModel findById(Integer id) {
		PageModule pageModule = dao.findById(PageModule.class, id);
		if (pageModule == null) {
			return null;
		} else {
			return model(pageModule);
		}

	}

	/**
	 * 
	 * @Title model
	 * @Description 数据转换
	 * @Return PageGroupModel 返回类型
	 * @param pageModule
	 * @return
	 */
	public PageGroupModel model(PageModule pageModule) {
		PageGroupModel model = new PageGroupModel();
		model.setModuleId(pageModule.getModuleId());
		model.setModuleName(pageModule.getModuleName());
		model.setParentModuleId(pageModule.getParentModuleId());
		model.setSortNum(pageModule.getSortNum());
		model.setModuleIcon(pageModule.getModuleIcon());
		model.setDescription(pageModule.getDescription());
		model.setCreateBy(pageModule.getCreateBy());
		model.setCreateTime(pageModule.getCreateTime());
		model.setUpdateBy(pageModule.getUpdateBy());
		model.setUpdateTime(pageModule.getUpdateTime());
		model.setParentModuleName("第一级页面组");
		if (pageModule.getParentModuleId() != null
				&& pageModule.getParentModuleId() != 0) {
			PageModule page = dao.findById(PageModule.class,
					pageModule.getParentModuleId());
			if (page != null) {
				model.setParentModuleName(page.getModuleName());
			}
		}

		return model;
	}
	
    	
	public Map<String, Object> userGroupPageModule(int pageModuleId) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<UserGroup> menus = dao.find("from UserGroup u where u.groupId in (select groupId from UserGroupPageModule  where ModuleId="+pageModuleId+")");
		map.put("rows", menus);
		return map;
	}
	
	
	public void addUserGroupPageModule(int moduleId,List<Integer> groupsId) throws Exception{
		  for(Integer groupId:groupsId){
			  List<UserGroupPageModule> userGroupPageModules=dao.find("from UserGroupPageModule where moduleId="+moduleId+" and groupId="+groupId);
			  if(userGroupPageModules.size()==0){
				  UserGroupPageModule userGroupPageModule=new UserGroupPageModule();
				  userGroupPageModule.setGroupId(groupId);
				  userGroupPageModule.setModuleId(moduleId);
				  dao.save(userGroupPageModule);
			  }
		  }

		}
	
	public void delUserGroupPageModule(int moduleId,List<Integer> groupsId) throws Exception{
		  for(Integer groupId:groupsId){
			  List<UserGroupPageModule> userGroupPageModules=dao.find("from UserGroupPageModule where moduleId="+moduleId+" and groupId="+groupId);
			 for(UserGroupPageModule userGroupPageModule:userGroupPageModules){
				  dao.delete(userGroupPageModule);
			  }
		  }
}
	
	public Map<String, Object> unUserGroupPageModule(int moduleId) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<UserGroup> menus = dao.find("from UserGroup u where u.groupId not  in (select groupId from UserGroupPageModule  where moduleId="+moduleId+")");
		map.put("rows", menus);
		return map;
	}
	

	public Map<String, Object> userPageModule(int pageGroupId) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Menu> menus = dao.find("from User u where u.userUID in (select uSERUID from UserPageModule where ModuleId="+pageGroupId+")");
		map.put("rows", menus);
		return map;
	}
	

	public Map<String, Object> unUserPageModule(int pageGroupId) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Menu> menus = dao.find("from User u where u.userUID not  in (select uSERUID from UserPageModule where ModuleId="+pageGroupId+")");
		map.put("rows", menus);
		return map;
	}
	

	public void addUserPageModule(int moduleId,List<String> usersId) throws Exception{
		  for(String userId:usersId){
			  List<UserPageModule> userPageModules=dao.find("from UserPageModule where moduleId="+moduleId+" and uSERUID='"+userId+"'");
			  if(userPageModules.size()==0){
				  UserPageModule userPageModule=new UserPageModule();
				  userPageModule.setUSERUID(userId);
				  userPageModule.setModuleId(moduleId);
				  dao.save(userPageModule);
			  }
		  }

		}
	
	public void delUserPageModule(int moduleId,List<String> usersId) throws Exception{
		  for(String userId:usersId){
			  List<UserPageModule> userPageModules=dao.find("from UserPageModule where moduleId="+moduleId+" and uSERUID='"+userId+"'");
			 for(UserPageModule userPageModule:userPageModules){
				  dao.delete(userPageModule);
			  }
		  }
}
}
