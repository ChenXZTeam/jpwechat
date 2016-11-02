package com.solar.tech.controller.seeTheWorld;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import com.solar.tech.utils.HttpUtils;

import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.service.ExchangeRateService;

/**
 * 类名：ExchangeRateController 
 *
 * 功能描述：这是汇率查询的Controller类，负责接收、处理以及分发汇率模块的请求
 *
 * @author 曾令维
 *
 * Version info版本号：V1.0
 * © Copyright 续日科技 2016年7月29日  版权所有
 */
@RequestMapping("/framework/exchangeRate")
@Controller
public class ExchangeRateController {

	@Resource
	private ExchangeRateService exchangeRateService; 
	
	
	@RequestMapping("/supperExchangeRate.action")
	@ResponseBody
	public Map<String, Object> supperExchangeRate(){
		Map<String, Object> map = new HashMap<String, Object>();
		String supperMoney = exchangeRateService.request();
		map.put("data", supperMoney);
		return map;
	}
	/**
	 * 功能描述：根据前端传来的币种进行汇率转换并将结果返回到前端
	 *
	 * @param fromCurrency
	 * @param toCurrency
	 * @param amount
	 *
	 * @return String
	 */
	@RequestMapping("/queryExchangeRate.action")
	@ResponseBody
	public Map<String, String> queryExchangeRate(String fromCurrency,String amount,String toCurrency){
		String host = "http://ali-waihui.showapi.com";
	    String path = "/waihui-transform";
	    String method = "GET";
	    Map<String, String> headers = new HashMap<String, String>();
	    Map<String, String> map = new HashMap<String, String>();
	    //最后在header中的格式(中间是英文空格)为Authorization:APPCODE 83359fd73fe94948385f570e3c139105
	    headers.put("Authorization", "APPCODE 62f05b64dc8a4662a5b99bf84f2c0cb9");
	    Map<String, String> querys = new HashMap<String, String>();
	    querys.put("fromCode", fromCurrency);
	    querys.put("money", amount);
	    querys.put("toCode", toCurrency);
        System.out.println(querys);
        System.out.println(host);
        String resut = null;
	    try { 
	    	HttpResponse response = HttpUtils.doGet(host, path, method, headers, querys);
	    	//获取response的body
	    	//System.out.println(EntityUtils.toString(response.getEntity()));
	    	resut = EntityUtils.toString(response.getEntity());
	    	System.out.println(resut);
	    	map.put("date",resut);
	    } catch (Exception e) {
	    	e.printStackTrace();
	    }
	    return map;  
	}
	

}
