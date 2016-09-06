package com.solar.tech.util;

import java.util.Map.Entry;
import java.util.Set;
import java.util.TreeMap;

public class WeiXinSignAndPackage {
	
	/**
	 * 创建支付包Package
	 * @param treeMap
	 * @return
	 */
	public static String createPackage(TreeMap<String,String> treeMap){
		String string1=originalString(treeMap);
		String stringSignTemp = string1 + "key="+ConfigUtils.PATERNER_KEY;
		String sign=MD5Util.MD5Encode(stringSignTemp, ConfigUtils.INPUT_CHARSET).toUpperCase();		
		return sign;
	}
	
	/**
	 * wxpackage组装原始串
	 * @param treeMap
	 * @return
	 */
	private static String originalString(TreeMap<String,String> treeMap){
		Set<Entry<String, String>> entry = treeMap.entrySet();
		StringBuffer sb = new StringBuffer();
		for(Entry<String,String> obj : entry){
			String k = obj.getKey();
			String v = obj.getValue();
			if(v == null && v.equals(""))
				continue;
			sb.append(k+"="+v+"&");
		}
		return sb.toString();
	}
	
	public static String getPrepayId(TreeMap<String, String> payParamMap){
		String result=HttpTool.sendPost(ConfigUtils.PREPAY_ID_URL, payParamMap, ConfigUtils.INPUT_CHARSET);
		return result;
	}
	
	/**
	 * 创建支付签名paysign
	 * @param wxpackage
	 * @return
	 */
	public static String createPaySign(TreeMap<String,String> param){
		String string1=originalString(param);
		String stringSignTemp = string1 + "key="+ConfigUtils.PATERNER_KEY;
		System.out.println("签名调试输出："+stringSignTemp);
		String paysign=MD5Util.MD5Encode(stringSignTemp, ConfigUtils.INPUT_CHARSET).toUpperCase();
		return paysign;
	}
	
}
