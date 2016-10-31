package com.solar.tech.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.commons.lang.StringUtils;

public class CityUtils {
	
	private static Properties pro = new Properties();
	// 初始化机场三字码资源文件
	static{
		InputStream is = null;
		try {
			String ss = "D:/GitHome/git/jpwechat/src/city.properties";
			String s1 = "src/city.properties";
			is = new FileInputStream(new File(ss));
			//File file = new File("src/city.properties");
			//System.out.println(file.getAbsolutePath());
		} catch (FileNotFoundException e1) {
			e1.printStackTrace();
		}
		try {
			if(is != null){
				pro.load(is);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	// 通过三字码获取机场名称
	public static String getAirportNameByCode(String code){
		return StringUtils.isEmpty(code)?null:pro.getProperty(code.toUpperCase().toString());
	}
	
	public static String huoquPlane(String plane){
		if(plane.indexOf("机场")<0){
			plane+="机场";
		}
		return plane;
	}
	
	public static void main(String[] args){
		System.out.println(huoquPlane(getAirportNameByCode("HAK")));
	}
}