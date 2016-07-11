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
}
