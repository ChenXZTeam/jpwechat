package com.solar.tech.controller.seeTheWorld;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.service.ExchangeRateService;

@RequestMapping("/framework/exchangeRate")
@Controller
public class ExchangeRateController {

	@Resource
	private ExchangeRateService exchangeRateService; 
	
	@RequestMapping("/queryCurrency.action")
	@ResponseBody
	public String queryCurrency(){
		return this.exchangeRateService.queryCurrency();
	}
	
	@RequestMapping("/queryExchangeRate.action")
	@ResponseBody
	public String queryExchangeRate(String fromCurrency,String toCurrency,String amount){
		return this.exchangeRateService.queryExchangeRate(fromCurrency, toCurrency, amount);
	}
}
