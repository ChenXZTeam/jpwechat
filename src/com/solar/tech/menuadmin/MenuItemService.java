package com.solar.tech.menuadmin;

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
import com.solar.tech.bean.UserGroupMenuItem;
import com.solar.tech.bean.UserInGroup;
import com.solar.tech.bean.UserMenu;
import com.solar.tech.bean.UserMenuItem;
import com.solar.tech.bean.WebPage;
import com.solar.tech.dao.GenericDao;
import com.solar.tech.util.Current;

/**
 * 
 * @ClassName MenuItemService
 * @Description 菜单项业务处理类
 * @Author wwd
 * @copyRight 续日科技 solartech
 * @Date 2015年6月11日
 * @Version V1.0.1
 */
@Service
public class MenuItemService {
	@Autowired
	private GenericDao dao;
	@Autowired
	private MenuService menuService;

	/**
	 * 
	 * @Title add
	 * @Description 添加菜单项
	 * @Return void 返回类型
	 * @param item
	 */
	public void add(MenuItem item) {
		if (item.getSortNum() == null) {
			item.setSortNum(0);
		}
		if (item.getParentItemId() == null) {
			item.setParentItemId(0);
		}
		dao.save(item);
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
		/*List<MenuItem> menus = dao.findByPage(
				"from MenuItem m order by sortNum desc,itemId asc", page, rows);*/
		List<MenuItem> menus = dao.findAll(MenuItem.class);
		Long total = dao.count(MenuItem.class,"");
		map.put("rows", MenuItemToMenuItemModel(menus));
		map.put("total", total);
		return map;
	}

	/**
	 * 
	 * @Title deleteMenuItem
	 * @Description 根据菜单项id删除菜单项
	 * @Return void 返回类型
	 * @param id
	 * @throws Exception
	 */
	public void deleteMenuItem(Integer id) throws Exception {
		MenuItem item = dao.findById(MenuItem.class, id);
		if (item == null) {
			throw new Exception("菜单项id:" + id + "不存在,删除失败");
		} else {
			List<MenuItem> items = dao.find("from MenuItem where parentItemId="
					+ item.getItemId());
			if (items.size() != 0) {
				throw new Exception("菜单项下面存在菜单,无法删除");
			}
			dao.delete(item);
		}
	}

	/**
	 * 
	 * @Title getParentMenuItemTree
	 * @Description 获取上级菜单项的树形菜单的数据
	 * @Return List<Map<String,Object>> 返回类型
	 * @param id
	 * @param flag
	 * @return
	 */
	public List<Map<String, Object>> getParentMenuItemTree(int id, String flag) {
		List<Map<String, Object>> results = new ArrayList<Map<String, Object>>();
		
		Map<String, Object> map1 = new HashMap<String, Object>();
		map1.put("id", 0);
		map1.put("text","第一级菜单项");
		map1.put("state", "");
	   results.add(map1);
	/*	if (id == 0) {
			List<Menu> menus = menuService.getAllMenus();
			for (Menu menu : menus) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", menu.getMenuId());
				map.put("text", menu.getMenuName());
				map.put("url", "root");
				List<Object> obj = dao
						.find("from MenuItem item where item.menuId="
								+ menu.getMenuId());
				if (obj.size() == 0) {
					map.put("state", "");
				} else {
					map.put("state", "closed");
				}
				results.add(map);
			}
		} else {*/
			List<MenuItem> menuItems = new ArrayList<MenuItem>();
			if (flag.equals("root")) {
				menuItems = dao
						.find("from MenuItem item where item.parentItemId=0 and item.menuId="
								+ id);
			} else {
				menuItems = dao
						.find("from MenuItem item where item.parentItemId="
								+ id);
			}
			
			for (MenuItem menuItem : menuItems) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", menuItem.getItemId());
				map.put("text", menuItem.getItemName());
				map.put("url", "children");
				List<Object> obj = dao
						.find("from MenuItem item where item.parentItemId="
								+ menuItem.getItemId());
				if (obj.size() == 0) {
					map.put("state", "");
				} else {
					map.put("state", "closed");
				}
				results.add(map);
			}
		
		return results;
	}

	/**
	 * 
	 * @Title update
	 * @Description 修改菜单项
	 * @Return void 返回类型
	 * @param itemId
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
	 * @param username
	 * @throws Exception
	 */
	public void update(Integer itemId, String itemName, Integer menuId,
			Integer parentItemId, String itemUrl, String itemTarget,
			Integer pageId, String itemType, Integer itemStatus,
			Integer sortNum, String itemIcon, String description
			) throws Exception {
		MenuItem item = dao.findById(MenuItem.class, itemId);
		if (item == null) {
			throw new Exception("菜单项ID不存在修改失败");
		} else {
			item.setItemId(itemId);
			item.setItemName(itemName);
			item.setMenuId(menuId);
			item.setParentItemId((parentItemId==null?0:parentItemId));
			System.out.println("parentItemId的值:"+parentItemId);
			item.setItemUrl(itemUrl);
			item.setItemTarget(itemTarget);
			item.setPageId(pageId);
			item.setItemType(itemType);
			item.setItemStatus(itemStatus);
			item.setSortNum(sortNum);
			item.setItemIcon(itemIcon);
			item.setDescription(description);
			item.setUpdateTime(new Date());
			item.setUpdateBy(com.solar.tech.util.Current.user().getUserName());
			dao.update(item);
		}
	}

	/**
	 * 
	 * @Title systemMenu
	 * @Description 获取系统菜单
	 * @Return List<Menu> 返回类型
	 * @return
	 */
	public List<Menu> systemMenu() {
		//获取用户的uid
		if(Current.user().getUserUID()==null){
			Current.user().setUserUID("uid="+Current.user().getUserName());
		}
		
		String userUid=Current.user().getUserUID();

		//System.out.println("getUserName:  "+com.solar.tech.util.Current.user().getUserName());
		//System.out.println("getUserUID:  "+com.solar.tech.util.Current.user().getUserUID());
		//获取用户所在的组
		//UserInGroup userInGroup=dao.findSingleByProperty(UserInGroup.class, "userUID",userUid);
		List<Menu> menus=null;
		//if(userInGroup!=null){
		//	String sql="select * FROM fw_Menu WHERE menuType='FRMU' AND menuStatus=1 AND menuId IN(SELECT menuId FROM fw_UserMenu WHERE userUID='"+userUid+"' UNION SELECT menuId FROM fw_UserGroupMenu WHERE GroupId="+userInGroup.getUGID()+" )ORDER BY sortNum DESC,menuId ASC";
        
		 String sql="select * FROM fw_Menu WHERE menuType='FRMU' AND menuStatus=1 AND menuId IN(SELECT menuId FROM fw_UserMenu WHERE userUID='"+userUid+"' UNION SELECT menuId FROM fw_UserGroupMenu WHERE GroupId in(select GroupId from FW_UserInGroup where USERUID='"+userUid+"' )UNION SELECT menuId FROM fw_UserGroupMenu WHERE GroupId in('2' ) )ORDER BY sortNum DESC,menuId ASC";
		
       //String sql="select * FROM fw_Menu WHERE menuType='FRMU' AND menuStatus=1 ORDER BY sortNum DESC,menuId ASC";
		
		menus = dao.findBySql(sql,Menu.class);
		//System.out.println("menus:  "+menus.size());
		/*}else{
			 menus = dao.findBySql("select * FROM fw_Menu WHERE menuType='FRMU' AND menuStatus=1 AND menuId IN(SELECT menuId FROM fw_UserMenu WHERE userUID='"+userUid+"')ORDER BY sortNum DESC,menuId ASC",
					 Menu.class);
		}*/
	/*	String sql="select * FROM fw_Menu WHERE menuType='FRMU' AND menuStatus=1 ORDER BY sortNum DESC,menuId ASC";
		menus = dao.findBySql(sql,Menu.class);*/
		return menus;
	}
    /**
     * 
    * @Title sysMenuItem
    * @Description 获取系统菜单项
    * @Return List<Map<String,Object>> 返回类型
    *@param parentItemId
    *@param menuId
    *@return
     */
	public List<Map<String, Object>> sysMenuItem(int parentItemId, int menuId) {
		String userUid=Current.user().getUserUID();
		
	//String condition="ItemId in(SELECT ItemId  FROM FW_UserGroupMenuItem WHERE GroupId IN(SELECT GroupId FROM FW_UserInGroup WHERE USERUID='"+userUid+"')  UNION SELECT ItemId FROM FW_UserMenuItem WHERE USERUID='"+userUid+"')";
		
		List<MenuItem> menuItems = dao
				.findBySql("select * from fw_MenuItem where itemType='FRMI' and menuId="
						+ menuId + "  and  parentItemId=" + parentItemId
						+ " and  itemStatus=1    order by sortNum desc,itemId asc",MenuItem.class);
		//+ " and  itemStatus=1  and "+condition+" order by sortNum desc,itemId asc",MenuItem.class);
		List<Map<String, Object>> results = new ArrayList<Map<String, Object>>();
		for (MenuItem menuItem : menuItems) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", menuItem.getItemId());
			map.put("text", menuItem.getItemName());
			map.put("animate", true);
			List<MenuItem> obj = dao
					.findBySql("select * from fw_MenuItem where itemType='FRMI' and menuId="
							+ menuId + "  and  parentItemId="
						//	+ menuItem.getItemId() + " and itemStatus=1 and "+condition,MenuItem.class);
							+ menuItem.getItemId() + " and itemStatus=1 ",MenuItem.class);
			if (obj.size() == 0) {
				map.put("state", "");
				map.put("isLeaf", true);
			} else {
				map.put("state", "closed");
				map.put("isLeaf", false);
			}
			if(menuItem.getPageId()!=null&&menuItem.getPageId()!=0){
				WebPage webPage=dao.findById(WebPage.class, menuItem.getPageId());
		         if(webPage!=null){
		        	 menuItem.setItemUrl(webPage.getPageUrl());
		         }
			}
			
			map.put("url", menuItem.getItemUrl());
			Map<String,String> attributes=new HashMap<String,String>();
			attributes.put("target", menuItem.getItemTarget());
			map.put("attributes",attributes);
			map.put("iconCls",menuItem.getItemIcon());
			results.add(map);
		}
		return results;
	}

	/**
	 * 
	 * @Title MenuItemToMenuItemModel
	 * @Description 数据模型转换
	 * @Return List<MenuItemModel> 返回类型
	 * @param menuItems
	 * @return
	 */
	public List<MenuItemModel> MenuItemToMenuItemModel(List<MenuItem> menuItems) {
		List<MenuItemModel> models = new ArrayList<MenuItemModel>();
		for (MenuItem menuItem : menuItems) {
			MenuItemModel model = new MenuItemModel();
			model.setItemId(menuItem.getItemId());
			model.setItemName(menuItem.getItemName());
			model.setMenuId(menuItem.getMenuId());
			model.setParentItemId(menuItem.getParentItemId());
			model.setItemUrl(menuItem.getItemUrl());
			model.setCreateBy(menuItem.getCreateBy());
			model.setCreateTime(menuItem.getCreateTime());
			model.setDescription(menuItem.getDescription());
			model.setItemTarget(menuItem.getItemTarget());
			model.setPageId(menuItem.getPageId());
			model.setItemType(menuItem.getItemType());
			model.setItemStatus(menuItem.getItemStatus());
			model.setSortNum(menuItem.getSortNum());
			model.setItemIcon(menuItem.getItemIcon());
			model.setUpdateBy(menuItem.getUpdateBy());
			model.setUpdateTime(menuItem.getUpdateTime());
			Menu menu = dao.findById(Menu.class, menuItem.getMenuId());
			if (menu != null) {
				model.setMenuName(menu.getMenuName());
			}
			if (menuItem.getParentItemId() != 0) {
				MenuItem item = dao.findById(MenuItem.class,
						menuItem.getParentItemId());
				if (item != null) {
					model.setParentItemName(item.getItemName());
				}
			} else {
				model.setParentItemName("第一级菜单项");
				model.setParentItemId(null);
			}
			
			if(model.getPageId()!=null&&model.getPageId()!=0){
				WebPage webPage=dao.findById(WebPage.class, model.getPageId());
		         if(webPage!=null){
		        	 model.setPageName(webPage.getPageName());
		         }
			}
			models.add(model);
		}
		return models;
	}
	
	/**
	 * 
	* @Title itemsUser
	* @Description 菜单项的用户
	* @Return Map<String,Object> 返回类型
	*@param menuItemId
	*@return
	 */
	public Map<String, Object> itemsUser(int menuItemId) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Menu> menus = dao.find("from User u where u.userUID in (select uSERUID from UserMenuItem where itemId="+menuItemId+")");
		map.put("rows", menus);
		return map;
	}
	/**
	 * 
	* @Title itemsUser
	* @Description  获取不属于菜单项的用户
	* @Return Map<String,Object> 返回类型
	*@param menuItemId
	*@return
	 */
	public Map<String, Object> unItemsUser(int menuItemId) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Menu> menus = dao.find("from User u where u.userUID not  in (select uSERUID from UserMenuItem where itemId="+menuItemId+")");
		map.put("rows", menus);
		return map;
	}
	/**
	 * 
	* @Title addItemUser
	* @Description 添加菜单的用户
	* @Return void 返回类型
	*@param itemId
	*@param usersId
	 * @throws Exception 
	 */
	public void addItemUser(int itemId,List<String> usersId) throws Exception{
		System.out.println("执行server方法:==========");
	  for(String userId:usersId){
		  List<UserMenuItem> userMenuItems=dao.find("from UserMenuItem where itemId="+itemId+" and uSERUID='"+userId+"'");
		  System.out.println("执行server方法:==========:"+userMenuItems.size());
		  if(userMenuItems.size()==0){
			  UserMenuItem userMenuItem=new UserMenuItem();
			  userMenuItem.setItemId(itemId);
			  userMenuItem.setUSERUID(userId);
			  dao.save(userMenuItem);
		  }
	  }

	}
	/**
	 * 
	* @Title delItemUser
	* @Description 删除菜单项的用户
	* @Return void 返回类型
	*@param itemId
	*@param usersId
	*@throws Exception
	 */
	public void delItemUser(int itemId,List<String> usersId) throws Exception{
	  for(String userId:usersId){
		  List<UserMenuItem> userMenuItems=dao.find("from UserMenuItem where itemId="+itemId+" and uSERUID='"+userId+"'");
		  for(UserMenuItem userMenuItem:userMenuItems){
			 dao.delete(userMenuItem);
		  }
	  }
	
	}
	
	/**
	 * 
	* @Title itemGroup
	* @Description 菜单项用户组
	* @Return Map<String,Object> 返回类型
	*@param itemId
	*@return
	 */
	public Map<String, Object> itemUserGroup(int itemId) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<UserGroup> menus = dao.find("from UserGroup u where u.groupId in (select groupId from UserGroupMenuItem  where itemId="+itemId+")");
		map.put("rows", menus);
		return map;
	}
	
	/**
	 * 
	* @Title unItemGroup
	* @Description  不属于菜单项的用户组
	* @Return Map<String,Object> 返回类型
	*@param itemId
	*@return
	 */
	public Map<String, Object> unItemUserGroup(int itemId) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<UserGroup> menus = dao.find("from UserGroup u where u.groupId not  in (select groupId from UserGroupMenuItem  where itemId="+itemId+")");
		map.put("rows", menus);
		return map;
	}
	
	/**
	 * 
	* @Title addItemGroup
	* @Description 添加菜单项的用户组
	* @Return void 返回类型
	*@param itemId
	*@param groupId
	 * @throws Exception 
	 */
	public void addItemUserGroup(int itemId,List<Integer> groupsId) throws Exception{
	  for(Integer groupId:groupsId){
		  List<UserGroupMenuItem> userMenus=dao.find("from UserGroupMenuItem where itemId="+itemId+" and groupId="+groupId);
		  if(userMenus.size()==0){
			  UserGroupMenuItem userGroupMenuItem=new UserGroupMenuItem();
			  userGroupMenuItem.setGroupId(groupId);
			  userGroupMenuItem.setItemId(itemId);
			  dao.save(userGroupMenuItem);
		  }
	  }

	}
	
	
	/**
	 * 
	* @Title delItemGroup
	* @Description 删除菜单项的用户组
	* @Return void 返回类型
	*@param itemId
	*@param groupsId
	*@throws Exception
	 */
	public void delItemUserGroup(int itemId,List<Integer> groupsId) throws Exception{
			  for(Integer groupId:groupsId){
				  List<UserGroupMenuItem> userGroupMenuItems=dao.find("from UserGroupMenuItem where itemId="+itemId+" and groupId="+groupId);
				 for(UserGroupMenuItem userGroupMenuItem:userGroupMenuItems){
					  dao.delete(userGroupMenuItem);
				  }
			  }
	
	}
	
	/**
	 * 
	* @Title getMenuItemById
	* @Description 根据菜单项id获取菜单项
	* @Return MenuItem 返回类型
	*@param menuItemId
	*@return
	 */
	public MenuItem getMenuItemById(Integer menuItemId){
		return dao.findById(MenuItem.class, menuItemId);
	}
	/**
	 * 
	* @Title getMenuItemTreeById
	* @Description 根据菜单项id获取菜单项及其子菜单项
	* @Return Map<String,Object> 返回类型
	*@param menuItemId
	*@param menuId
	*@return
	 */
	public Map<String,Object> getMenuItemTreeById(Integer parentItemId,Integer menuId,Integer dept, Integer nowDept){
		Map<String,Object> map=new HashMap<String,Object>();
			 List<MenuItem> menuItems=dao.find("from MenuItem where menuId="+menuId+" and parentItemId="+parentItemId);
			 if(menuItems.size()==0){
				 return map;
			 }else{
				 if(dept==0||dept==1){
					 map.put("item",menuItems);
				 }else{
				        for(MenuItem item:menuItems){
					        map.put("item",item);
					        if((nowDept+1)<=dept){
					        /////////////////////////////////////////
					        List<MenuItem> items=dao.find("from MenuItem where menuId="+menuId+" and parentItemId="+item.getItemId());
					        List<Map<String,Object>> children=new ArrayList<Map<String,Object>>();
				    	         for(MenuItem temp:items){
							     Map<String,Object> itemMap=new HashMap<String,Object>();
							      itemMap.put("item", temp);
							        if((nowDept+2)<=dept){
							         itemMap.put("children",getMenuItemTreeById(temp.getItemId(),menuId,dept,nowDept+2));
							       }
							     children.add(itemMap);
				    	         }
					             map.put("children",children);
				               
				          }
				        ///////////////////////////
					        }
				 }
				 return map;
			 }//else
	}
	
	/**
	 * 
	* @Title getMenuItemByItem
	* @Description 3.9.2.3.	获取指定菜单项的子菜单项
	* @Return Map<String,Object> 返回类型
	*@param itemid
	*@param depth
	*@param nowDept
	*@return
	 */
	public Map<String,Object> getMenuItemByItem(Integer itemid,Integer depth,Integer nowDept){
		Map<String,Object> map=new HashMap<String,Object>();
		MenuItem menuItem= dao.findById(MenuItem.class, itemid);
		  if(menuItem!=null){
			 Integer parentItemId=menuItem.getItemId();
			 Integer menuId=menuItem.getMenuId();
			 Map<String,Object> items=getMenuItemTreeById(parentItemId,menuId,depth,nowDept);
			 Map<String,Object> root=new HashMap<String,Object>();
			 root.put("children", items);
			 root.put("item", menuItem);
			 map.put("itemlist", root);
		 }
		 return map;
	}

	
	public Map<String,Object> getItemByMennuId(Integer parentItem,Integer menuId,Integer depth,Integer nowDepth){
		Map<String,Object> root=new HashMap<String,Object>();
		 List<MenuItem> items=dao.find("from MenuItem where menuId="+menuId+" and parentItemId="+parentItem);
		if(depth==0||depth==1){
			root.put("item", items);
			return root;
		}else{
			List<Object> lists=new ArrayList<Object>();
		     for(MenuItem menuItem:items){
			    Integer parentItemId=menuItem.getItemId();
			    List<MenuItem> menuItems=dao.find("from MenuItem where menuId="+menuId+" and parentItemId="+parentItemId);
			    Map<String,Object> map=new HashMap<String,Object>();
			    map.put("item",menuItem);
			    if((nowDepth+1)<=depth){
			          if(menuItems.size()!=0){
				              List<Map<String,Object>> children=new ArrayList<Map<String,Object>>();
				               for(MenuItem item:menuItems){
					            Map<String,Object> m=new HashMap<String,Object>();
					            if((nowDepth+2)<=depth){
					            m.put("children",getItemByMennuId(item.getItemId(),menuId,depth,nowDepth+2));	
					            }
					            m.put("item",item);
					            children.add(m);
				                }
				               map.put("children",children);	
			             }
			    }
			    lists.add(map);
	        }
		 root.put("item", lists);
		 return root;
		}
	}
	
/*	public List<Object> getItemByType(String itemType,Integer menuId,Integer parentItem){
		List<Object> lists=new ArrayList<Object>();
		 List<MenuItem> items=dao.find("from MenuItem where menuId="+menuId+" and itemType='"+itemType+"'  and parentItemId="+parentItem);
		 for(MenuItem menuItem:items){
			 String type=menuItem.getItemType();
			 List<MenuItem> menuItems=dao.find("from MenuItem where menuId="+menuId+" and itemType='"+type+"' and parentItemId="+menuItem.getItemId());
			 Map<String,Object> map=new HashMap<String,Object>();
			 map.put("data",menuItem);
			 if(menuItems.size()!=0){
				 List<Object> children=new ArrayList<Object>();
				 for(MenuItem item:menuItems){
					 Map<String,Object> m=new HashMap<String,Object>();
					 m.put("children",getItemByType(itemType,menuId,item.getItemId()));	
					 m.put("data",item);
					 children.add(m);
				 }
				 map.put("children",children);
			 }
				 lists.add(map);
			 
			
	      }
		 return lists;
		 
	}*/
}
