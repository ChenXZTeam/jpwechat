package com.solar.tech.controller.wechat;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

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
import com.solar.tech.utils.ECUtils;
import com.travelsky.sbeclient.obe.response.PATFareItem;

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
	
	@RequestMapping(value = "/orderPay.action", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> orderPay(String subDateJson, HttpServletRequest request, HttpSession session) throws Exception {
		Map<String, Object> res = new HashMap<String, Object>();
		String openId = (String) session.getAttribute("openId");
		String phoneNumber = (String) session.getAttribute("phoneNumber");
		System.out.println(openId+"/"+phoneNumber);
		if(openId==null||openId.equals("")||phoneNumber==null||phoneNumber.equals("")){
			res.put("state", "0");
			res.put("msg", "系统出错，请稍后再试");
			return res;
		}
		//生成商品号
		String out_trade_num = System.currentTimeMillis() + "";
		System.out.println("商品号:" + out_trade_num); 
		int lastpayCout = 0;
		JSONObject jsonObject=JSONObject.fromObject(subDateJson);
		String sign = jsonObject.get("sign")+""; //获取标志
		if("0".equals(sign)){ //支付单个航班的
			String yawai = jsonObject.get("yawai")+""; //获取是否购买航意险
			String yanwu = jsonObject.get("yanwu")+""; //获取是否购买延误险
			String uuid = jsonObject.get("uuid")+""; //uuid
			System.out.println(yawai+","+yanwu+","+uuid);
			String pn_tr = jsonObject.get("pn_tr")+""; //pnr码
			PATFareItem[] sd = new ECUtils().patPNR(pn_tr,"A",null,null,false,null,null,null);
			if(null==sd){
				res.put("state", "0");
				res.put("msg", "支付价格校验出错，请稍后再试");
				return res;
			}
			String mongeyStr = sd[0].getPataFareResponse().getTotal();
			mongeyStr = mongeyStr.substring(0,mongeyStr.indexOf("."));
			lastpayCout = Integer.parseInt(mongeyStr);
			if("1".equals(yawai)){  //是否购买航意险
				lastpayCout = lastpayCout+30;
			}
			if("1".equals(yanwu)){	//是否购买延误险
				lastpayCout = lastpayCout+20;
			}
			lastpayCout = lastpayCout*100; //化成单位/分
		}else if("1".equals(sign)){ //同时支付两段航班
			int onePrice = 0;
			int twoPrice = 0;
			String yiwai = jsonObject.get("yiwai")+"";
			String yanwu = jsonObject.get("yanwu")+"";
			String pntrer = jsonObject.get("pntrer")+"";
			String pntrtw = jsonObject.get("pntrtw")+"";
			String uuid1 = jsonObject.get("uuid1")+"";
			String uuid2 = jsonObject.get("uuid2")+"";
			System.out.println(uuid1+"/"+uuid2+"/"+pntrer+"/"+pntrtw);
			PATFareItem[] PAT1 = new ECUtils().patPNR(pntrer,"A",null,null,false,null,null,null);
			if(null==PAT1){
				res.put("state", "0");
				res.put("msg", "支付价格校验出错，请稍后再试");
				return res;
			}else{
				String mongeyStr = PAT1[0].getPataFareResponse().getTotal();
				mongeyStr = mongeyStr.substring(0,mongeyStr.indexOf("."));
				onePrice = Integer.parseInt(mongeyStr);
				if("1".equals(yiwai)){  //是否购买航意险
					onePrice = onePrice+30;
				}
				if("1".equals(yanwu)){	//是否购买延误险
					onePrice = onePrice+20;
				}
			}
			
			PATFareItem[] PAT2 = new ECUtils().patPNR(pntrtw,"A",null,null,false,null,null,null);
			if(null==PAT2){
				res.put("state", "0");
				res.put("msg", "支付价格校验出错，请稍后再试");
				return res;
			}else{
				String mongeyStr = PAT2[0].getPataFareResponse().getTotal();
				mongeyStr = mongeyStr.substring(0,mongeyStr.indexOf("."));
				twoPrice = Integer.parseInt(mongeyStr);
				if("1".equals(yiwai)){  //是否购买航意险
					twoPrice = twoPrice+30;
				}
				if("1".equals(yanwu)){	//是否购买延误险
					twoPrice = twoPrice+20;
				}
				lastpayCout = onePrice+twoPrice; //计算得到两个航段的价格
			}
			lastpayCout = lastpayCout*100; //化成单位/分
		}
		
		
		/*以下这些代码是可以共用的*/
		//----------------------调用微信支付接口-----------------------------
		String noceStr = SHA1Util.getNonceStr();// 随机字符串
		String timeStamp = SHA1Util.getTimeStamp();// 时间戳
		// 金额转化为分为单位
		float sessionmoney = Float.parseFloat(Double.toString(lastpayCout));
		String finalmoney = String.format("%.2f", sessionmoney);
		finalmoney = finalmoney.replace(".", "");
		
		TreeMap<String, String> contentMap = new TreeMap<String, String>();
		// 接口package部分-内容
		contentMap.put("appid", ConfigUtils.APPID); // 公众账号 ID
		contentMap.put("mch_id", ConfigUtils.MCHI_ID); // 商户号
		contentMap.put("nonce_str", noceStr); // 随机字符串
		contentMap.put("body", ConfigUtils.BODY); // 商品描述
		contentMap.put("out_trade_no", out_trade_num); // 商户订单号
		contentMap.put("total_fee", lastpayCout+""); // 订单总金额
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
		wxPayParamMap.put("payMoney", finalmoney);// 到前端显示使用，支付不需要此参数
		
		//将数据反馈到前台
		res.put("state", 1);
		res.put("appId", wxPayParamMap.get("appId"));
		res.put("nonceStr", wxPayParamMap.get("nonceStr"));
		res.put("paySign", wxPayParamMap.get("paySign"));
		res.put("signType", wxPayParamMap.get("signType"));
		res.put("wxPackage", wxPayParamMap.get("package"));
		res.put("timeStamp", wxPayParamMap.get("timeStamp"));
		res.put("time", out_trade_num);
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
	
	/*创建支付表*/
	public int creanPay(String a, String openId, String phoneNumber, String out_trade_num){
		//创建支付信息表
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
		//创建数据表
		wxpay.setTradeNum(out_trade_num); //本地生成商品号
		int i = PayService.creamOrder(wxpay);
		if(i==1){
			System.out.println("订单支付数据创建成功");
		}else{
			return 0;
		}
		return 1;
	}
}
