package com.solar.tech.controller.framework;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.solar.tech.bean.entity.LinkMan;
import com.solar.tech.bean.entity.RD_wechatUser;
import com.solar.tech.service.LinkManService;

@Controller
@RequestMapping("/framework/LinkMan")
public class LinkManController {
	@Resource
	private LinkManService linkMans;
	
	@RequestMapping("/numList.action")
	@ResponseBody
	public Map<String,Object> ManList(int page, int rows){
		Map<String,Object> map = linkMans.manlist(page,rows);
		return map;
	}
	
	@RequestMapping("/addInfo.action")
	@ResponseBody
	public int addInfo(LinkMan lma){
		try {
			List<RD_wechatUser> linkm = linkMans.getuserList(lma.getUserName());
			List<LinkMan> llk = linkMans.isRepeat(lma.getCaseNum(),linkm.get(0).getUserName());
			if(llk.size()>0){
				return 2;
			}
			if(linkm.size()==1){
				lma.setOpenID(linkm.get(0).getOpenID());
				lma.setUserNamePhone(linkm.get(0).getPhoneNum());
			}
			lma.setBirthday(lma.getBirthday().substring(0,10));
			lma.setCaseTime(lma.getCaseTime().substring(0,10));
			lma.setLinkman(new String(lma.getLinkman().getBytes("ISO8859-1"),"utf-8"));
			lma.setChinaName(new String(lma.getChinaName().getBytes("ISO8859-1"),"utf-8"));
			lma.setCommit(new String(lma.getCommit().getBytes("ISO8859-1"),"utf-8"));
			lma.setCreateTime(new Timestamp(new Date().getTime()));
			linkMans.addInfo(lma);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	
	@RequestMapping("/delInfo.action")
	@ResponseBody
	public int delInfo(String num){
		try {
			List<LinkMan> lima = new ArrayList<LinkMan>();
			String[] strLm = num.split(",");
			for(String nnk : strLm){
				LinkMan llmm = new LinkMan();
				llmm.setID(nnk);
				lima.add(llmm);
			}
			linkMans.delInfo(lima);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	
	@RequestMapping("/upInfo.action")
	@ResponseBody
	public int upInfo(LinkMan lma,String id){
		try {
			List<RD_wechatUser> linkm = linkMans.getuserList(lma.getUserName());
			if(linkm.size()==1){
				lma.setOpenID(linkm.get(0).getOpenID());
				lma.setUserNamePhone(linkm.get(0).getPhoneNum());
			}
			lma.setID(id);
			lma.setLinkman(new String(lma.getLinkman().getBytes("ISO8859-1"),"utf-8"));
			lma.setChinaName(new String(lma.getChinaName().getBytes("ISO8859-1"),"utf-8"));
			lma.setCommit(new String(lma.getCommit().getBytes("ISO8859-1"),"utf-8"));
			linkMans.upInfo(lma);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	
	@RequestMapping("/findPage.action")
	@ResponseBody
	public Map<String,Object> findPage(int page, int rows,String cusAdmin,String custor,String chinaName,String phoneNum){
		Map<String,Object> map = linkMans.findPage(page,rows,cusAdmin,custor,chinaName,phoneNum);
		return map;
	}
	
	@RequestMapping("/getuserList.action")
	@ResponseBody
	public List<RD_wechatUser> getuserList(){
		List<RD_wechatUser> listDate = linkMans.getuserList();
		return listDate;
	}
	
	@RequestMapping("/importPass.action")
	@ResponseBody
	 public Map<String, Object> getReport(@RequestParam(value="file") MultipartFile file)  
	            throws Exception { 
		
	       if(file.isEmpty()){
	    	   return null;
	       }
	       Map<String, Object> map=new HashMap<String,Object>();
	       String resultMsg = linkMans.readReport(file.getInputStream(), file.getOriginalFilename()); 
	       if(resultMsg.equals("")||resultMsg==null){
	    	   map.put("state", 0);
	    	   map.put("msgRe", resultMsg);
	    	   return map;
	       }else{
	    	   map.put("state", 1);
	           return map;
	       }
	}
	
	@RequestMapping("/isExtie.action")
	@ResponseBody
	public boolean isExtie(String userName){
		List<RD_wechatUser> isList = linkMans.getuserList(userName);
		if(isList.size()>0){
			return true;
		}
		return false;
	}
	
	@RequestMapping(value ="/exportImformation.action", method = RequestMethod.GET)
	 public void getXLSs(HttpServletRequest request, HttpServletResponse response){
		linkMans.exportexcel(request, response);
	}
	

	
	
	
}
