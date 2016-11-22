package com.solar.tech.util;

public class ConfigUtils {
	public static final String APPID="wx21f1f64150786239";//appid
	public static final String APPSECRET="594a178490b9bc9c15748ca7e8b24038";//appsecret
	public static final String PATERNER_KEY="FJQCTSIJFVUD1YXE59ISRB7EMIBR68MR";// 商户支付密钥
	public static final String MCHI_ID="1341981201";//商户号
	public static final String BODY="仁德机票预定公众号";//商品描述
//	public static final String SPBILL_CREATE_IP=propertiesUtil.getProperties("spbill_create_ip");//支付IP地址
	public static final String SIGNTYPE="MD5";//加密方式
	public static final String NOTIFY_URL="http://jp.gzyhinc.com/BookTicketsys/wechatController/payCost/payNotify.action";//回调地址
	public static final String TRADE_TYPE_JS="JSAPI";//交易类型
	public static final String INPUT_CHARSET="UTF-8";//编码
	public static final String PREPAY_ID_URL="https://api.mch.weixin.qq.com/pay/unifiedorder";//统一支付接口
}
