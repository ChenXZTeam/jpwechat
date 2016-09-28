package com.solar.tech.service;

import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.apache.commons.io.IOUtils;
import org.apache.http.Header;
import org.apache.http.HttpResponse;

import com.solar.tech.weather.utils.Client;
import com.solar.tech.weather.utils.Request;
import com.solar.tech.weather.utils.HttpHeader;
import com.solar.tech.weather.utils.Method;
//import test.java.com.aliyun.api.gateway.demo.weatherService;

public class weatherService {
	private String app_key = "23460549"; //APP KEY
	private String app_secret = "816b4f4fec6684ee7f02ebe0ab247822";// APP瀵嗛挜
	private int connectTimeout = 3000;//3绉�
	private int readTimeout = 15000;//15绉�
	private String url;
	private String char_set="utf-8";
	private Header ret_headers[];
	Map<String, String> headers = new HashMap<String, String>();
	private Map<String,String> textMap=new HashMap<String, String>();
	private Map<String,List<String>> res_headtMap=new HashMap<String,List<String>>();//杩斿洖鏃剁殑Map
	public weatherService(String app_key,String app_secret,String url){
		this.app_key=app_key;
		this.app_secret=app_secret;
		this.url=url;
		headers.put(HttpHeader.HTTP_HEADER_ACCEPT, "application/json");
	}
	
	public String buildQuery(Map  params )   {
		if (params == null || params.isEmpty()) {
			return null;
		}
		StringBuilder query = new StringBuilder();
		Set<Entry<String, String>> entries = params.entrySet();
		boolean hasParam = false;
		try {
			for (Entry<String, String> entry : entries) {
				String name = entry.getKey();
				String value = entry.getValue();
				// 蹇界暐鍙傛暟鍚嶄负绌虹殑鍙傛暟
				if(name!=null&&name.length()>0 ){
					if (hasParam) {
						query.append("&");
					} else {
						hasParam = true;
					}
					query.append(name).append("=").append(value);
				}
			}
		} catch ( Exception e) {
			e.printStackTrace();
		}

		return query.toString();
	}

	/**
	 * 娣诲姞post浣撶殑瀛楃涓插弬鏁�
	 */
	public weatherService addTextPara(String key,String value) {
		this.textMap.put(key,value);
		return this;
	}
	
	public String get() throws Exception   {
		byte b[] =getAsByte();
	    String str=new String(b,char_set);
		return str;
	}
	
	public byte[] getAsByte() throws Exception   {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put(HttpHeader.HTTP_HEADER_ACCEPT, "application/json");
		String newurl=url;
		String query_str=buildQuery(this.textMap);
		if(newurl.indexOf("?")==-1)newurl=newurl+"?"+query_str;
		else newurl=newurl+"&"+query_str;
		
		Request request = new Request(Method.GET, newurl, app_key, app_secret, connectTimeout);
		request.setHeaders(headers);
		HttpResponse response = Client.execute(request);
		ret_headers=response.getAllHeaders();
		InputStream in=response.getEntity().getContent();
		byte b[] =IOUtils.toByteArray(in);
		IOUtils.closeQuietly(in);
		return b;
	}
}
