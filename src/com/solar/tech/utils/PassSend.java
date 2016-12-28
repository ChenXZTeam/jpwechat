package com.solar.tech.utils;

import java.io.FileInputStream;
import java.util.Properties;

/**
 * 获取读取properties短信接口的密码的方法
 * @author 吸毒的路飞
 * @time 2016-12-16 17:41:50
 */
public final class PassSend {
	//用于web项目的方法
	public static String readValue(){
		 try {
			 	String path = PassSend.class.getClassLoader().getResource("sendPass.properties").getPath();  //先获取绝对路劲在查找
			 	FileInputStream in = new FileInputStream(path);
		    	Properties props = new Properties();
		        props.load(in);
		        String value = props.getProperty ("pass");
		        return value;
		  } catch (Exception e) {
		        e.printStackTrace();
		        return null;
		  }
	 }
	
	//用于web项目的方法
	public static String webPath(){
			 try {
				 	String path = PassSend.class.getClassLoader().getResource("sendPass.properties").getPath();  //先获取绝对路劲在查找
				 	FileInputStream in = new FileInputStream(path);
			    	Properties props = new Properties();
			        props.load(in);
			        String value = props.getProperty ("webUrl");
			        return value;
			  } catch (Exception e) {
			        e.printStackTrace();
			        return null;
			  }
	}
	
	//用于普通java项目的方法
	/*private static String param1;    
    static{    
       Properties prop = new Properties();    
       InputStream in = Object.class.getResourceAsStream("/sendPass.properties");    
        try{    
           prop.load(in);    
           param1 = prop.getProperty("pass").trim();    
       }catch(IOException e){    
           e.printStackTrace();    
       } 
    }    
    public static String getParam1() {    
        return  param1;    
    }*/
	
	public static void main(String[] args) {
		//System.out.println(getParam1());
		System.out.println(readValue());
	}

}
