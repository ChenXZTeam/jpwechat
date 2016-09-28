package com.solar.tech.controller.wechat;


import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import com.solar.tech.service.weatherService;
import com.thoughtworks.xstream.converters.reflection.SelfStreamingInstanceChecker;
 


/**
 * 获取城市列表
 * 全国天气预报接口调用JAVA示例
 * dtype     string    N    返回数据格式：json或xml,默认json    
 * key        string     Y    你申请的key    
 * @author chenj
 *
 */



@Controller
@RequestMapping("/wechatController")
public class DayWeatherController {
	
	@RequestMapping("/findweather/areaCityName.action")
	@ResponseBody
	public Map<String, Object> cityWeather(String cityname) {
		System.out.println("XGDFDS:::::"+cityname);
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String str = new weatherService("23460549", "816b4f4fec6684ee7f02ebe0ab247822", "http://ali-weather.showapi.com/area-to-weather")
					.addTextPara("area", cityname)
					.addTextPara("needMoreDay", "1")
					.addTextPara("needIndex", "1")
					.get();
			map.put("strDate", str);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
}
