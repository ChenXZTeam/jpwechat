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

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.InvitationCode;
import com.solar.tech.bean.entity.WX_PayCost;
import com.solar.tech.bean.entity.userOrderInfo;
import com.solar.tech.service.WXpayorderSer;
import com.solar.tech.util.ConfigUtils;
import com.solar.tech.util.SHA1Util;
import com.solar.tech.util.WeiXinSignAndPackage;
import com.solar.tech.util.XMLUtil;
import com.solar.tech.utils.saveCost;

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
			res.put("msg", "系统出错，请稍后再试");
			return res;
		}
		//生成商品号
		String out_trade_num = System.currentTimeMillis() + "";
		System.out.println("商品号:" + out_trade_num); 
		//获取航段共同的信息
		saveCost getCost = new saveCost();
		JSONObject jsonObject=JSONObject.fromObject(subDateJson);
		String sing = jsonObject.get("sign")+""; //接收标志 就能传进来的数据是中转数据或者往返数据
		double lastpayCout = 0.0; //最终计算后的价格
		int yiwai = Integer.parseInt(jsonObject.get("yiwai")+"");	//是否购买意外险
		int yanwu = Integer.parseInt(jsonObject.get("yanwu")+"");	//是否购买延误险
		int youhui = Integer.parseInt(jsonObject.get("youhui")+"");	//是否使用优惠券
		String activType = jsonObject.get("activType")+""; //优惠券的id
		//判断是直达的支付还是往返或者中转
		if(sing.equals("0")||"0".equals(sing)){
			//获取接收的数据
			String a = jsonObject.get("a")+""; //需要支付的订单的预约编号
			String depCity = jsonObject.get("depCity")+""; //所购买的航班的出发城市
			String arrCity = jsonObject.get("arrCity")+""; //所购买的航班的到达城市
			String depDate = jsonObject.get("depDate")+""; //所购买的航班的出发日期
			String airCode = jsonObject.get("airCode")+""; //所购买的航班的航空公司
			String canbin = jsonObject.get("canbin")+""; //所购买的航班的舱位
			System.out.println(a+", "+yiwai+", "+yanwu+", "+youhui+", "+activType+", "+depCity+", "+arrCity+", "+depDate+", "+airCode+", "+canbin);
			//获取到后台查询到的价格
			lastpayCout = getCost.getpay(depCity, arrCity, depDate, airCode, canbin);
			System.out.println("直达单程航班的价格："+lastpayCout);
			if(lastpayCout==0.0){
				res.put("msg", "运价查询出错，请稍后再试");
				return res;
			}
			
			//创建支付表
			int i = this.creanPay(a, openId, phoneNumber, out_trade_num);
			if(i==0){
				res.put("state", 0);
				res.put("msg", "支付错误！请稍后再试");
				return res;
			}
			
			//通过前台传过来的id查找相应的邀请码活动
			if(youhui!=0){
				List<InvitationCode> invt = PayService.findactivByid(activType);
				if(invt.get(0).getType().equals("discount")){
					lastpayCout = lastpayCout*((invt.get(0).getDiscount())/10);
					//lastpayCout = lastpayCout * invt.get(0).getDiscount();
				}else if(invt.get(0).getType().equals("preferential")){
					lastpayCout = lastpayCout - invt.get(0).getSum();
				}
			}
			
			//是否购买航空意外险
			if(yiwai != 0){
				lastpayCout = lastpayCout + 30;
			}
			
			//是否购买延误险
			if(yanwu != 0){
				lastpayCout = lastpayCout + 20;
			}
		}else if(sing.equals("1")||"1".equals(sing)){
			String firstFild = jsonObject.get("firt")+""; //获取第一个航班的json数据集合
	        String sconedFild = jsonObject.get("secd")+""; //获取第二个航班的json数据集合
	        firstFild = firstFild.substring(1,firstFild.length()-1);
	        sconedFild = sconedFild.substring(1,sconedFild.length()-1);
	        JSONObject firtlist = JSONObject.fromObject(firstFild); //解析第一个航班json数据的集合
	        JSONObject scedlist = JSONObject.fromObject(sconedFild);//解析第二个航班json数据的集合
	        
	        //获取第一航段的子类信息
	        String a = firtlist.get("a")+""; //所购买的航班订单的预约编号
	        String depCity = firtlist.get("depCity")+""; //所购买的航班的出发城市
			String arrCity = firtlist.get("arrCity")+""; //所购买的航班的到达城市
			String depDate = firtlist.get("depDate")+""; //所购买的航班的出发日期
			String airCode = firtlist.get("airCode")+""; //所购买的航班的航空公司
			String canbin = firtlist.get("canbin")+""; //所购买的航班的舱位
			
			//创建支付表
			int i = this.creanPay(a, openId, phoneNumber, out_trade_num);
			if(i==0){
				res.put("state", 0);
				res.put("msg", "支付错误1！请稍后再试");
				return res;
			}
			
			//获取第二航段的子类信息
			String a1 = scedlist.get("a")+""; //第二航段的订单的预约编号
	        String depCity2 = scedlist.get("depCity")+""; //所购买的航班的出发城市
			String arrCity2 = scedlist.get("arrCity")+""; //所购买的航班的到达城市
			String depDate2 = scedlist.get("depDate")+""; //所购买的航班的出发日期
			String airCode2 = scedlist.get("airCode")+""; //所购买的航班的航空公司
			String canbin2 = scedlist.get("canbin")+""; //所购买的航班的舱位
			
			//创建支付表
			int j = this.creanPay(a1, openId, phoneNumber, out_trade_num);
			if(j==0){
				res.put("state", 0);
				res.put("msg", "支付错误2！请稍后再试");
				return res;
			}

			//进行总价计算步骤
			double lastpayCout1 = getCost.getpay(depCity, arrCity, depDate, airCode, canbin); //查找第一段航班的价格
			double lastpayCout2 = getCost.getpay(depCity2, arrCity2, depDate2, airCode2, canbin2); //查找第二段航班的价格
			System.out.println("第一段航班的价格："+lastpayCout1);
			System.out.println("第二段航班的价格："+lastpayCout2);
			lastpayCout = lastpayCout1 + lastpayCout2; //两段航班的基础总价
			//通过前台传过来的id查找相应的邀请码活动
			if(youhui!=0){
				List<InvitationCode> invt = PayService.findactivByid(activType);
				if(invt.get(0).getType().equals("discount")){
					lastpayCout = lastpayCout*((invt.get(0).getDiscount())/10);
					//lastpayCout = lastpayCout * invt.get(0).getDiscount();
				}else if(invt.get(0).getType().equals("preferential")){
					lastpayCout = lastpayCout - invt.get(0).getSum();
				}
			}
			
			//是否购买航空意外险
			if(yiwai != 0){
				lastpayCout = lastpayCout + 60;
			}
			
			//是否购买延误险
			if(yanwu != 0){
				lastpayCout = lastpayCout + 40;
			}
		}
		
        System.out.println("最终价格："+lastpayCout);
        
		//String money = "0.1";
		
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
