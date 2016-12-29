package com.solar.tech.controller.wechat;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 
 * @ClassName: WechatPageControlle 
 * @Description: TODO
 * @author: ChenXZ
 * @date: 2016年5月6日 下午2:46:53
 */
@Controller
@RequestMapping("/wechatController/page")
public class WechatPageControlle {
	
	/**
	 * 
	 * @Title: resultBusiness 
	 * @Description: TODO
	 * @return: String
	 */
	@RequestMapping("/regies.action")
	public String resultBusiness() {
		return "wechat/regies";
	}
	
	/**
	 * 
	 * @Title: resultMine 
	 * @Description: TODO
	 * @return: String
	 */
	@RequestMapping("/mine.action")
	public String resultMine() {
		return "wechat/orderList";
	}
	
	/**
	 * @title 订票时跳转到信息填写和确认界面
	 * @return
	 */
	@RequestMapping("/YDticket.action")
	public String yudiTek() {
		return "wechat/confirmInfo";
	}
	
	/**
	 * @title 机票查找拦截
	 * @return
	 */
	@RequestMapping("/planTek.action")
	public String planTek() {
		return "wechat/planTek";
	}
	
	/**
	 * @title 机票查找结果界面
	 * @return
	 */
	@RequestMapping("/mudiPlace.action")
	public String mudiPlace() {
		return "wechat/mudiPlace";
	}
	
	/**
	 * @title 机票查找结果界面(往返)
	 * @return
	 */
	@RequestMapping("/mudiPlacewf.action")
	public String mudiPlacewf() {
		return "wechat/mudiPlacewf";
	}
	
	/**
	 * @title 邀请用户界面跳转
	 * @return
	 */
	@RequestMapping("/yqUser.action")
	public String yqUser() {
		return "wechat/yqUser";
	}
	
	/**
	 * @title 签证界面跳转
	 * @return
	 */
	@RequestMapping("/visaMessage.action")
	public String visaMessage() {
		return "wechat/qzMassege";
	}
	
	/**
	 * @title 汇率查询界面跳转
	 * @return
	 */
	@RequestMapping("/huilvSearch.action")
	public String huilvSearch() {
		return "wechat/huilvSearchNew";
	}
	
	/**
	 * @title 我的订单界面跳转
	 * @return
	 */
	@RequestMapping("/myPlaneTickek.action")
	public String myPlaneTickek() {
		return "wechat/myPlaneTickek";
	}
	
	/**
	 * @title 个人中心界面跳转
	 * @return
	 */
	@RequestMapping("/oneself.action")
	public String oneself() {
		return "wechat/oneself";
	}
	
	
	
	/**
	 * @title 天气界面跳转
	 * @return
	 */
	@RequestMapping("/dayWeath.action")
	public String dayWeath() {
		return "wechat/WeatherInter";
	}
	
	/**
	 * @title 飞机模型界面跳转
	 * @return
	 */
	@RequestMapping("/fjModel.action")
	public String fjModel() {
		return "wechat/fjModel";
	}
	
	/**
	 * @title 行李须知界面跳转
	 * @return
	 */
	@RequestMapping("/travelCost.action")
	public String travelCost() {
		return "wechat/travelCost";
	}
	
	/**
	 * @title 行李须知界面跳转
	 * @return
	 */
	@RequestMapping("/callKeFu.action")
	public String callKeFu() {
		return "wechat/callKeFu";
	}
	
	/**
	 * @title 开发中的界面跳转
	 * @return
	 */
	@RequestMapping("/kaifing.action")
	public String kaifing() {
		return "wechat/waiting";
	}

	/**
	 * 国内资讯
	 * @return
	 */
	@RequestMapping("/details.action")
	public String details() {
		return "wechat/details";
	}
	
	/**
	 * 国外资讯
	 * @return
	 */
	@RequestMapping("/gwdetails.action")
	public String gwdetails() {
		return "wechat/gwdetails";
	}
	
	/**
	 * 特色路线的界面跳转
	 * @return
	 */
	@RequestMapping("/routedetail.action")
	public String charaRoute() {
		return "wechat/routedetail";
	}
}
