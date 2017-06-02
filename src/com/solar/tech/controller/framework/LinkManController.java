package com.solar.tech.controller.framework;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
			if(linkm.size()==1){
				lma.setOpenID(linkm.get(0).getOpenID());
				lma.setUserNamePhone(linkm.get(0).getPhoneNum());
			}
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
			linkMans.upInfo(lma);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	
	@RequestMapping("/findPage.action")
	@ResponseBody
	public Map<String,Object> findPage(int page, int rows){
		Map<String,Object> map = linkMans.findPage(page,rows);
		return map;
	}
	
	@RequestMapping("/getuserList.action")
	@ResponseBody
	public List<RD_wechatUser> getuserList(){
		List<RD_wechatUser> listDate = linkMans.getuserList();
		return listDate;
	}
	
}
