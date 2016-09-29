package com.solar.tech.service;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.util.ConfigHuilvKeyAndUrl;

/**
 * 接口名：ExchangeRateService 
 *
 * 功能描述：这是汇率查询接口，定义了业务逻辑用到的抽象方法
 *
 * @author 曾令维
 *
 * Version info版本号：V1.0
 * © Copyright 续日科技 2016年7月29日  版权所有
 */
@Service
@Transactional
public class ExchangeRateService {
	
	public static String request() {
		String httpUrl = ConfigHuilvKeyAndUrl.SupportMoneyUrl;  //请求地址
		String httpArg = ""; //请求参数
	    BufferedReader reader = null;
	    String result = null;
	    StringBuffer sbf = new StringBuffer();
	    httpUrl = httpUrl + "?" + httpArg;
	    try {
	        URL url = new URL(httpUrl);
	        HttpURLConnection connection = (HttpURLConnection) url
	                .openConnection();
	        connection.setRequestMethod("GET");
	        // 填入apikey到HTTP header
	        connection.setRequestProperty("apikey",  ConfigHuilvKeyAndUrl.key);
	        connection.connect();
	        InputStream is = connection.getInputStream();
	        reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
	        String strRead = null;
	        while ((strRead = reader.readLine()) != null) {
	            sbf.append(strRead);
	            sbf.append("\r\n");
	        }
	        reader.close();
	        result = sbf.toString();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return result;
	}
	
	
	/**汇率查询的接口
	 * @param urlAll
	 *            :请求接口
	 * @param httpArg
	 *            :参数
	 * @return 返回结果
	 */
	public static String requestMoney(String httpArg) {
		String httpUrl = ConfigHuilvKeyAndUrl.ChangeMoneyUrl; //请求地址
	    BufferedReader reader = null;
	    String result = null;
	    StringBuffer sbf = new StringBuffer();
	    httpUrl = httpUrl + "?" + httpArg;

	    try {
	        URL url = new URL(httpUrl);
	        HttpURLConnection connection = (HttpURLConnection) url
	                .openConnection();
	        connection.setRequestMethod("GET");
	        // 填入apikey到HTTP header
	        connection.setRequestProperty("apikey",  ConfigHuilvKeyAndUrl.key);
	        connection.connect();
	        InputStream is = connection.getInputStream();
	        reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
	        String strRead = null;
	        while ((strRead = reader.readLine()) != null) {
	            sbf.append(strRead);
	            sbf.append("\r\n");
	        }
	        reader.close();
	        result = sbf.toString();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return result;
	}
		
}
