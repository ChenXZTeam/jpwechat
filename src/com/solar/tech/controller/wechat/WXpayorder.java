package com.solar.tech.controller.wechat;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.entity.WX_PayCost;
import com.solar.tech.bean.entity.userOrderInfo;
import com.solar.tech.service.WXpayorderSer;
import com.solar.tech.util.ConfigUtils;
import com.solar.tech.util.SHA1Util;
import com.solar.tech.util.WeiXinSignAndPackage;
import com.solar.tech.util.XMLUtil;

/**
 * 微信支付的控制器
 * @author solarpc1
 *
 */
@Controller
@RequestMapping("/wechatController/payCost")
public class WXpayorder {
	private static Logger log = Logger.getLogger(WXpayorder.class); //一般操作日志
	private static Log paymessage = LogFactory.getLog("paymessage"); //支付操作日志
	@Autowired
	private WXpayorderSer PayService;
	
	@SuppressWarnings("null")
	@RequestMapping(value = "/orderPay.action", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> orderPay(String a, String money, HttpServletRequest request, HttpSession session) throws Exception {
		money = "0.1";
		Map<String, Object> res = new HashMap<String, Object>();
		String openId = (String) session.getAttribute("openId");
		String phoneNumber = (String) session.getAttribute("phoneNumber");
		System.out.println(openId+"/"+phoneNumber);
		if(openId==null||openId.equals("")||phoneNumber==null||phoneNumber.equals("")){
			res.put("msg", "系统出错，请稍后再试");
			return res;
		}else{
			WX_PayCost wxpay = new WX_PayCost();
			userOrderInfo userOrder =  PayService.findByOrderNum(a);
			wxpay.setOpenId(openId);
			wxpay.setPhoneNumB(phoneNumber);
			wxpay.setOrderCost(userOrder.getCostMoney());
			wxpay.setPersonIDnum(userOrder.getIDcase());
			wxpay.setStatus(0);
			wxpay.setOrderNum(a);
			wxpay.setCreateTime(new Timestamp(new Date().getTime()));
			wxpay.setYhUUID(userOrder.getID());
			wxpay.setPnrNum(userOrder.getPNR());
			
			//----------------------调用微信支付接口-----------------------------
			String out_trade_num = System.currentTimeMillis() + "";
			System.out.println("商品号:" + out_trade_num); 
			String noceStr = SHA1Util.getNonceStr();// 随机字符串
			String timeStamp = SHA1Util.getTimeStamp();// 时间戳
			// 金额转化为分为单位
			float sessionmoney = Float.parseFloat(money);
			String finalmoney = String.format("%.2f", sessionmoney);
			finalmoney = finalmoney.replace(".", "");
			
			TreeMap<String, String> contentMap = new TreeMap<String, String>();
			// 接口package部分-内容
			contentMap.put("appid", ConfigUtils.APPID); // 公众账号 ID
			contentMap.put("mch_id", ConfigUtils.MCHI_ID); // 商户号
			contentMap.put("nonce_str", noceStr); // 随机字符串
			contentMap.put("body", ConfigUtils.BODY); // 商品描述
			contentMap.put("out_trade_no", out_trade_num); // 商户订单号
			contentMap.put("total_fee", "1"); // 订单总金额
			contentMap.put("spbill_create_ip", request.getRemoteAddr()); // 订单生成的机器IP
			contentMap.put("notify_url", ConfigUtils.NOTIFY_URL); // 通知地址
			contentMap.put("trade_type", ConfigUtils.TRADE_TYPE_JS); // 交易类型
			contentMap.put("openid", openId); // 用户标识
			String wxpackage = WeiXinSignAndPackage.createPackage(contentMap);
			System.out.println("微信支付签名："+wxpackage);
			contentMap.put("sign", wxpackage);// 签名

			String result = WeiXinSignAndPackage.getPrepayId(contentMap);
			System.out.println("调用统一接口返回的值："+result);
			// 调用统一接口返回的值
			if ("".equals(result) || null == result) {
				res.put("state", 0);
				res.put("msg", "订单异常，请稍后重试");
				//log.info(String.format("[YH系统] %s", "调用统一接口返回值prepay_id没有"));
				return res;
			}
			
			// 调用统一接口返回的值转换为XML格式
			Map<String, String> mapTwo = XMLUtil.doXMLParse(result);
			TreeMap<String, String> wxPayParamMap = new TreeMap<String, String>();
			wxPayParamMap.put("appId", ConfigUtils.APPID);
			wxPayParamMap.put("timeStamp", timeStamp);
			wxPayParamMap.put("nonceStr", noceStr);
			wxPayParamMap.put("package", "prepay_id=" + mapTwo.get("prepay_id"));
			wxPayParamMap.put("signType", ConfigUtils.SIGNTYPE);
			String paySign = WeiXinSignAndPackage.createPaySign(wxPayParamMap);// 支付得到的签名
			wxPayParamMap.put("paySign", paySign);
			wxPayParamMap.put("payMoney", money);// 到前端显示使用，支付不需要此参数
			
			//创建数据表
			wxpay.setTradeNum(out_trade_num); //本地生成商品号
			int i = PayService.creamOrder(wxpay);
			if(i==1){
				//res.put("msg", "订单支付数据创建成功");
				System.out.println("订单支付数据创建成功");
			}else{
				res.put("state", 0);
				res.put("msg", "支付出错，请稍后再试");
				return res;
			}
			
			//将数据反馈到前台
			res.put("state", 1);
			res.put("appId", wxPayParamMap.get("appId"));
			res.put("nonceStr", wxPayParamMap.get("nonceStr"));
			res.put("paySign", wxPayParamMap.get("paySign"));
			res.put("signType", wxPayParamMap.get("signType"));
			res.put("wxPackage", wxPayParamMap.get("package"));
			res.put("timeStamp", wxPayParamMap.get("timeStamp"));
			res.put("time", out_trade_num);
		}
		return res;
	}
	
	/**
	 * 异步处理
	 * 
	 * @param request
	 * @param response
	 * @param session
	 */
	@RequestMapping(value = "/payNotify.action", method = RequestMethod.POST)
	@ResponseBody
	public void payNotify(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		System.out.println("===========>>>>>>>>>>>>>>>>>我能进来了");
	}
}
