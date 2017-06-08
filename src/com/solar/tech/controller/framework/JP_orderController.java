package com.solar.tech.controller.framework;

import java.io.IOException;
import java.net.MalformedURLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.entity.phoneMess;
import com.solar.tech.bean.entity.userOrderInfo;
import com.solar.tech.service.userOrderService;
import com.solar.tech.service.framework.JP_orderService;
import com.solar.tech.util.Current;
import com.solar.tech.utils.Send106msg;

@Controller
@RequestMapping("/framework/order")
public class JP_orderController {
	Logger log = Logger.getLogger(JP_orderController.class);
	@Autowired
	private JP_orderService jporderService;
	@Autowired
	private userOrderService OrderService;
	
	@RequestMapping("/getOrderList.action")
	@ResponseBody
	public Map<String, Object> getOrderList(int page, int rows){
		Map<String, Object> map = new HashMap<String, Object>();
		map = jporderService.loadOrder(page, rows);
		if(map.size()>0){
			map.put("msg", 1);
		}else{
			map.put("msg", 0);
		}
		return map;
	}
	
	@RequestMapping("/addOrderAdmin.action")
	@ResponseBody
	public int addOrderAdmin(userOrderInfo sd){
		try {
			sd.setOrderNum(OrderService.createOrderNum("RDOD", 8));
			sd.setStutisPay("1");
			sd.setAdminDel("0");
			sd.setChufTime(sd.getChufTime().replaceAll(":", ""));
			sd.setDaodTime(sd.getDaodTime().replaceAll(":", ""));
			sd.setUpdateTime(new Timestamp(new Date().getTime()));
			sd.setCreateTime(new Timestamp(new Date().getTime()));
			sd.setIsSuccess("1");
			jporderService.savaOrder(sd);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	
	@RequestMapping("/findOrder.action")
	@ResponseBody
	public Map<String, Object> findOrder(int page, int rows, String Info){
		Map<String, Object> map = new HashMap<String, Object>();
		map = jporderService.findByInfo(page, rows, Info);
		if(map.size()>0){
			map.put("msg", 1);
		}else{
			map.put("msg", 0);
		}
		return map;
	}
	
	/**
	 * 获取短信发送消息的表单
	 * @return
	 */
	@RequestMapping({"/obtainPhoneMess.action"})
    @ResponseBody
	public Map<String, Object> obtainPhoneMess(int page, int rows){
		Map<String, Object> map = new HashMap<String, Object>();
		map = jporderService.otindPhoneMes(page, rows);
		return map;
	}
	
	/**
	 * 根据手机号码查找发送的记录
	 * @param phoneNumber
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping({"/findPhoneMess.action"})
    @ResponseBody
	public Map<String, Object> findPhoneMess(String phoneNumber, int page, int rows){
		Map<String, Object> map = new HashMap<String, Object>();
		map = jporderService.findPhoneMes(phoneNumber,page, rows);
		return map;
	}
	
	@RequestMapping({"/findBy.action"})
    @ResponseBody
    public Map<String,Object> findByuuid(String a){
		Map<String,Object> map = jporderService.findbyid(a);
		return map;
	}
	
	/**
	 * 短信发送功能，在后台的订单页面使用
	 * @param phoneNumList
	 * @param text
	 * @return
	 */
	@RequestMapping({"/sendMessToUser.action"})
	@ResponseBody
	public Map<String, Object> sendMessToUser(String phoneNumList, String text, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		String userName = Current.user().getUserName();
		Send106msg sender = new Send106msg();
		phoneMess ph=new phoneMess();
		try {
			String res = sender.SendMSGtoPhone("【广州永弘】" + text,phoneNumList);
			ph.setUserName(userName);
			ph.setPhoneNumber(phoneNumList);
			ph.setText(text);
			ph.setZuNumber("187-码");;
			ph.setCreateTime(new Timestamp(new Date().getTime()));
			if(res.equals("1")||"1".equals(res)){
				ph.setSendType(1);
				map.put("mess", 1);
				log.info("==========>>>>发送短信到手机为："+phoneNumList+" 发送内容为："+text+"<<<<==============");
			}else{
				ph.setSendType(0);
				map.put("mess", 0);
				log.info("==========>>>>发送短信失败手机为："+phoneNumList+"<<<<==============");
			}
			jporderService.savaPhoneMess(ph);
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return map;
	}	
	
}
