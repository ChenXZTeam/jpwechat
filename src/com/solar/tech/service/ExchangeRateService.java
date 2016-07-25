package com.solar.tech.service;

public interface ExchangeRateService {
	
	//查询汇率
	String queryExchangeRate(String fromCurrency,String toCurrency,String amount);
	
	//查询币种
	String queryCurrency();
	
}
