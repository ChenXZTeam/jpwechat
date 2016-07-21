package com.solar.tech.controller.wechat;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.entity.userOrderInfo;
import com.solar.tech.service.userOrderService;

@Controller
@RequestMapping("/userOrderController")
public class userOrderController {
	@Autowired
	private userOrderService OrderService;
	
	@RequestMapping("/add/order.action")
	@ResponseBody
	public Map<String, Object> addOrder(String ChufDate,String ChufTime,String ChufCity,String DaodCity,String DaodTime,String QishiPlan,String hangbanNum,String DaodPlan,String lishiTime,String CostPay,String LinkName,String Sex,String iDcaseType,String iDcase,String PhoneNum,String YiwaiBX,String YanwuBX,HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		userOrderInfo oderInfo = new userOrderInfo();
		oderInfo.setChufDate(ChufDate);
		oderInfo.setChufTime(ChufTime);
		oderInfo.setDaodTime(DaodTime);
		oderInfo.setChufCity(ChufCity);
		oderInfo.setDaodCity(DaodCity);
		oderInfo.setUserName((String) session.getAttribute("userName"));
		oderInfo.setQishiPlane(QishiPlan);
		oderInfo.setHangbanNum(hangbanNum);
		oderInfo.setDaodPlane(DaodPlan);
		oderInfo.setCuntTime(lishiTime);
		oderInfo.setCostMoney(CostPay);
		oderInfo.setLinkName(LinkName);
		oderInfo.setLinkPhoneNum(PhoneNum);
		oderInfo.setLinkSex(Sex); 
		oderInfo.setIDcase(iDcase);
		oderInfo.setIDcaseType(iDcaseType);
		oderInfo.setYiwaiBX(YiwaiBX);
		oderInfo.setYanwuBX(YanwuBX);
		oderInfo.setStutisPay("0");//未支付
		oderInfo.setTakePlane("0");//未登机
		int num=OrderService.addOrder(oderInfo);//保存信息到数据库
		if(num==1){
			System.out.println("数据插入成功");
		}else if(num==0){
			System.out.println("数据插入失败");
		}else{
			System.out.println("数据错误");
		}
		return map;
	}
}
