 package com.solar.tech.controller;
 
 import com.solar.tech.bean.AbstractUserGroup;
 import com.solar.tech.users.AbstractUserGroupService;
 import java.util.HashMap;
 import java.util.List;
 import java.util.Map;
 import org.springframework.beans.factory.annotation.Autowired;
 import org.springframework.web.bind.annotation.RequestMapping;
 import org.springframework.web.bind.annotation.RequestParam;
 import org.springframework.web.bind.annotation.ResponseBody;
 
 public class AbstractGroupController
 {
 
   @Autowired
   private AbstractUserGroupService groupService;
 
   @RequestMapping({"/index.action"})
   public String index()
   {
     return "/framework/user/shows";
   }
   @RequestMapping({"/shows.action"})
   @ResponseBody
   public Map<String, Object> shows(int page, int rows) {
     Map dataResult = this.groupService.shows(Integer.valueOf(page), Integer.valueOf(rows));
     dataResult.put("success", Boolean.valueOf(true));
     return dataResult;
   }
   @RequestMapping({"/add.action"})
   @ResponseBody
   public String addUser(String groupName, String description) {
     AbstractUserGroup userGroup = new AbstractUserGroup();
     userGroup.setGroupName(groupName);
     userGroup.setDescription(description);
     this.groupService.addUserGroup(userGroup);
     System.out.println("add.action");
     Map dataResult = new HashMap();
     dataResult.put("success", Boolean.valueOf(true));
     return dataResult.toString();
   }
   @RequestMapping({"/update.action"})
   @ResponseBody
   public String updateUser(Integer groupId, String groupName, String description) {
     Map dataResult = new HashMap();
     AbstractUserGroup userGroup = this.groupService.get(groupId);
     userGroup.setGroupId(groupId);
     userGroup.setGroupName(groupName);
     userGroup.setDescription(description);
     System.out.println("update.action");
     this.groupService.updateUserGroup(userGroup);
     dataResult.put("success", Boolean.valueOf(true));
     return dataResult.toString();
   }
   @RequestMapping({"/delete.action"})
   @ResponseBody
   public Map<String, Object> deleteUser(Integer groupId) {
     Map dataResult = new HashMap();
     System.out.println("delete.action");
     try {
       this.groupService.deleteUserGroup(groupId);
       dataResult.put("success", Boolean.valueOf(true));
     } catch (Exception e) {
       dataResult.put("success", Boolean.valueOf(false));
       dataResult.put("errorMsg", e.getMessage());
     }
     return dataResult;
   }
   @RequestMapping({"/showMembers.action"})
   @ResponseBody
   public Map<String, Object> showMembers(int groupId) {
     Map dataResult = this.groupService.showMembers(groupId);
     System.out.println("showMembers.action");
     dataResult.put("success", Boolean.valueOf(true));
     return dataResult;
   }
   @RequestMapping({"/showLastMembers.action"})
   @ResponseBody
   public Map<String, Object> showLastMembers(int groupId) {
     Map dataResult = this.groupService.showLastMembers(groupId);
     System.out.println("showLastMembers.action");
     dataResult.put("success", Boolean.valueOf(true));
     return dataResult;
   }
   @RequestMapping({"/addMember.action"})
   @ResponseBody
   public Map<String, Object> addMember(int groupId, @RequestParam("userIds[]") List<String> userIds) {
     Map dataResult = new HashMap();
     this.groupService.addMember(groupId, userIds);
     System.out.println("addMember.action");
     dataResult.put("success", Boolean.valueOf(true));
     return dataResult;
   }
   @RequestMapping({"/deleteMember.action"})
   @ResponseBody
   public Map<String, Object> deleteMember(int groupId, @RequestParam("userIds[]") List<String> userIds) {
     Map dataResult = new HashMap();
     this.groupService.deleteMember(groupId, userIds);
     System.out.println("/deleteMember.action");
     dataResult.put("success", Boolean.valueOf(true));
     return dataResult;
   }
 }
