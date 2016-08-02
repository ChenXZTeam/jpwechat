package com.solar.tech.service;
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
public interface ExchangeRateService {
	
	/**
	 * 功能描述：根据接收到的币种查询汇率的转换结果并将其返回
	 *
	 * @param fromCurrency
	 * @param toCurrency
	 * @param amount
	 *
	 * @return String
	 */
	String queryExchangeRate(String fromCurrency,String toCurrency,String amount);
		
}
