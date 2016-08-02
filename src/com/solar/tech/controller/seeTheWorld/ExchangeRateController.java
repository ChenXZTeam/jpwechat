package com.solar.tech.controller.seeTheWorld;

import javax.annotation.Resource;

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
	public String queryExchangeRate(String fromCurrency,String toCurrency,String amount){
		return this.exchangeRateService.queryExchangeRate(fromCurrency, toCurrency, amount);
	}
}
