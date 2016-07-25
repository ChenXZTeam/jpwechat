package com.solar.tech.service.impl;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import org.springframework.stereotype.Service;
import com.solar.tech.service.ExchangeRateService;

@Service
public class ExchangeRateImpl implements ExchangeRateService {
	String currencyUrl = "http://apis.baidu.com/apistore/currencyservice/type";
	String ExchangeRateUrl = "http://apis.baidu.com/apistore/currencyservice/currency";
	String apikey = "d9ad9d6aa172794f4b2fa604086c5ff4";
	
	
	@Override
	public String queryExchangeRate(String fromCurrency,String toCurrency,String amount) {
		BufferedReader reader = null;
	    String result = null;
	    StringBuffer sbf = new StringBuffer();
	    String httpArg = "fromCurrency="+fromCurrency+"&toCurrency="+toCurrency+"&amount="+amount+"";
	    ExchangeRateUrl = ExchangeRateUrl + "?" + httpArg;

	    try {
	        URL url = new URL(ExchangeRateUrl);
	        HttpURLConnection connection = (HttpURLConnection) url
	                .openConnection();
	        connection.setRequestMethod("GET");
	        // 填入apikey到HTTP header
	        connection.setRequestProperty("apikey",  apikey);
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

	@Override
	public String queryCurrency() {
		  BufferedReader reader = null;
	    String result = null;
	    StringBuffer sbf = new StringBuffer();

	    try {
	        URL url = new URL(currencyUrl);
	        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
	        connection.setRequestMethod("GET");
	        // 填入apikey到HTTP header
	        connection.setRequestProperty("apikey",  apikey);
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