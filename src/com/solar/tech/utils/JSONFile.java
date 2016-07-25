package com.solar.tech.utils;

import java.io.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.solar.tech.bean.Countries;
import com.solar.tech.dao.GenericDao;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

/**
 * 
 * 功能描述：此类为处理JSON文件、JSON类型字符串以及java集合与json数组类型之间的转换
 *
 * 类名：JSONFile
 *
 * Version info 版本号：V1.0 
 * © Copyright 续日科技 2016年7月6日 版权所有
 */
public class JSONFile {
	
	/**
	 * 
	 * 功能描述：此方法将字符串 fileContent 写入到路径为 filePathAndName 的文件中
	 * 
	 * @param filePathAndName
	 * @param fileContent
	 *
	 */
	public static void writeFile(String filePathAndName, String fileContent) { 
		try { 
		   File f = new File(filePathAndName); 
		   if (!f.exists()) { 
			   f.createNewFile(); 
		   } 
		   OutputStreamWriter write = new OutputStreamWriter(new FileOutputStream(f),"UTF-8"); 
		   BufferedWriter writer=new BufferedWriter(write);   
		   //PrintWriter writer = new PrintWriter(new BufferedWriter(new FileWriter(filePathAndName))); 
		   //PrintWriter writer = new PrintWriter(new FileWriter(filePathAndName)); 
		   writer.write(fileContent); 
		   writer.close(); 
		} catch (Exception e) { 
		   System.out.println("写文件内容操作出错"); 
		   e.printStackTrace(); 
		} 
	} 
	
	/**
	 * 
	 * 功能描述：此方法读取路径为 path 的文件，并返回 字符串
	 * 
	 * @param path
	 * @return String
	 * @throws IOException
	 *
	 */
	public static String readFile(String path) throws IOException {  
		File file = new File(path);  
        InputStreamReader read = null;  
        String laststr = "";
        if(!file.exists()){
	        	file.createNewFile();
        }
        try {  
            read = new InputStreamReader(new FileInputStream(file),"UTF-8"); 
            BufferedReader reader =new BufferedReader(read); 
            String tempString = null;  
            while ((tempString = reader.readLine()) != null) {  
                laststr = laststr + tempString;  
            }  
            reader.close();  
        } catch (IOException e) {  
            e.printStackTrace();  
        } finally {  
            if (read != null) {  
                try {  
                	read.close();  
                } catch (IOException e1) {  
                	e1.printStackTrace();
                }  
            }  
        }  
      
        return laststr;
	}
	
	  /**
	   *  
	   * 功能描述：此方法将字符串jsons转换成存放clazz类型对象的集合中，并返回该集合
	   * 
	   * @param clazz
	   * @param jsons
	   * @return List<T>
	   */ 
	  public static <T> List<T> getJavaCollection(T clazz, String jsons) {
	        List<T> objs=null;
	        JSONArray jsonArray;
	        try {
		        jsonArray=JSONArray.fromObject(jsons);
		        if(jsonArray!=null){
		            objs=new ArrayList<T>();
		            List list=(List)JSONSerializer.toJava(jsonArray);
		            for(Object o:list){
		                JSONObject jsonObject=JSONObject.fromObject(o);
						T obj=(T)JSONObject.toBean(jsonObject, clazz.getClass());
		                objs.add(obj);
		            }
		        }
	        } catch (Exception e) {
	        	e.printStackTrace();
	        }
	        return objs;
	    }
	
	/**
	 * 
	 * 功能描述：此方法生成一个字符串类型的ID，并返回此ID
	 * 
	 * @return String
	 */
	public static String generateID(){
		Date current = new Date();
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
		"yyMMddHHmmss");
		String time = sdf.format(current);
		return time;
	}
	
	   /**
	    *  
	    * 功能描述：将json格式的字符串解析成Map对象
	    * 
	    * @param String
	    * @return HashMap<String,String>
	    */
		public static HashMap<String, Object> toHashMap(String str){  
	       HashMap<String, Object> data = new HashMap<String, Object>();  
	       // 将json字符串转换成jsonObject  
	       JSONObject jsonObject = JSONObject.fromObject(str);  
	       Iterator it = jsonObject.keys();  
	       // 遍历jsonObject数据，添加到Map对象  
	       while (it.hasNext()){  
	           String key = String.valueOf(it.next());  
	           Object value = jsonObject.get(key);  
	           data.put(key, value);  
	       }  
	       return data;  
	    }  
		
	public static void main(String[] args) throws IOException {
		Map<String,String> map = new HashMap<String,String>();
		Map<String,Object> continent = new HashMap<String,Object>();
		//亚洲（Asia）
				map.put("BH", "巴林");map.put("JP","日本");map.put("TM","土库曼斯坦");map.put("KZ","哈萨克斯坦");map.put("TJ","塔吉克斯坦");
				map.put("KR", "韩国");map.put("KW","科威特");map.put("SY","叙利亚");map.put("IN","印度");map.put("ID","印度尼西亚");
				map.put("LB", "黎巴嫩");map.put("UZ", "乌兹别克斯坦");map.put("LZ", "斯里兰卡");map.put("IQ", "伊拉克");map.put("VN", "越南");
				map.put("NP", "尼泊尔");map.put("YE", "也门");map.put("JO", "约旦");map.put("MM", "缅甸");map.put("DB", "孟加拉国");
				map.put("TH", "泰国");map.put("TR", "土耳其");map.put("PK", "巴基斯坦");map.put("GE","格鲁吉亚");map.put("AM","亚美尼亚");
				map.put("AE", "阿拉伯联合酋长国");map.put("IR", "伊朗");map.put("SG", "新加坡");map.put("IL", "以色列");map.put("CY", "塞浦路斯");
				map.put("OM", "阿曼");map.put("AZ", "阿塞拜疆");map.put("KP", "朝鲜");map.put("PH", "菲律宾");map.put("KH", "柬埔寨");
				map.put("QA", "卡塔尔");map.put("MV", "马尔代夫");map.put("MY", "马来西亚");map.put("MN", "蒙古");map.put("SA", "沙特阿拉伯");
				map.put("BN", "文莱");map.put("LA", "老挝");
				continent.put("亚洲", map);
				map = new HashMap<String,String>();
		//欧洲（Europe）
				map.put("IT", "意大利");map.put("DE", "德国");map.put("LU", "卢森堡");map.put("IE", "爱尔兰");map.put("DK", "丹麦");
				map.put("FI", "芬兰");map.put("PT", "葡萄牙");map.put("SM", "圣马力诺");map.put("PL", "波兰");map.put("LT", "立陶宛");
				map.put("HU", "匈牙利");map.put("MD", "摩尔多瓦");map.put("SI", "斯洛文尼亚");map.put("AM", "亚美尼亚");map.put("FR", "法国");
				map.put("NL", "荷兰");map.put("CH", "瑞士");map.put("MC", "摩纳哥");map.put("NO", "挪威");map.put("IS", "冰岛");
				map.put("GR", "希腊");map.put("MT", "马耳他");map.put("EE", "爱沙尼亚");map.put("UA", "乌克兰");map.put("SK", "斯洛伐克");
				map.put("RO", "罗马尼亚");map.put("AL", "阿尔巴尼亚");map.put("GE", "格鲁吉亚");map.put("GB", "英国");map.put("BE", "比利时");
				map.put("AT", "奥地利");map.put("LI", "列支敦士登");map.put("SE", "瑞典");map.put("ES", "西班牙");map.put("AD", "安道尔");
				map.put("LV", "拉脱维亚");map.put("CZ", "捷克");map.put("BY", "白俄罗斯");map.put("BG", "保加利亚");map.put("RU", "俄罗斯");
				continent.put("欧洲", map);
				map = new HashMap<String,String>();
		//非洲（Africa）
				map.put("ST", "圣多美和普林西比");map.put("CM", "喀麦隆");map.put("SL", "塞拉利昂");map.put("CG", "刚果");map.put("GN", "几内亚");
				map.put("GH", "加纳");map.put("GA", "加蓬");map.put("LY", "利比亚");map.put("LR", "利比里亚");map.put("MU", "毛里求斯");
				map.put("NE", "尼日尔");map.put("NG", "尼日利亚");map.put("ZA", "南非");map.put("CF", "中非");map.put("ML", "马里");
				map.put("SO", "索马里");map.put("SD", "苏丹");map.put("GM", "冈比亚");map.put("ZM", "赞比亚");map.put("NA", "纳米比亚");
				map.put("ET", "埃塞俄比亚");map.put("KE", "肯尼亚");map.put("TZ", "坦桑尼亚");map.put("SZ", "斯威士兰");map.put("MG", "马达加斯加");
				map.put("DJ", "吉布提");map.put("TN", "突尼斯");map.put("AO", "安哥拉");map.put("DZ", "阿尔及利亚");map.put("BJ", "贝宁");
				map.put("BI", "布隆迪");map.put("BF", "布基纳法索");map.put("BW", "博茨瓦纳");map.put("TG", "多哥");map.put("ZW", "津巴布韦");
				map.put("KT", "科特迪瓦");map.put("LS", "莱索托");map.put("MA", "摩洛哥");map.put("MW", "马拉维");map.put("MZ", "莫桑比克");
				map.put("SC", "塞舌尔");map.put("SN", "塞内加尔");map.put("UG", "乌干达");map.put("TD", "乍得");
				continent.put("非洲", map);
				map = new HashMap<String,String>();
		
		//美洲（America）
				map.put("AR", "阿根廷");map.put("BS", "巴哈马");map.put("BZ", "伯利兹");map.put("US", "美国");map.put("BO", "玻利维亚");
				map.put("BR", "巴西");map.put("BB", "巴巴多斯");map.put("CA", "加拿大");map.put("CO", "哥伦比亚");map.put("CL", "智利");
				map.put("CR", "哥斯达黎加");map.put("CU", "古巴");map.put("VE", "委内瑞拉");map.put("SV", "萨尔瓦多");map.put("EC", "厄瓜多尔");
				map.put("GD", "格林纳达");map.put("GT", "危地马拉");map.put("GY", "圭亚那");map.put("HN", "洪都拉斯");map.put("HT", "海地");
				map.put("JM", "牙买加");map.put("LC", "圣卢西亚");map.put("MX", "墨西哥");map.put("NI", "尼加拉瓜");map.put("PA", "巴拿马");
				map.put("PE", "秘鲁");map.put("UY", "乌拉圭");map.put("PY", "巴拉圭");map.put("SR", "苏里南");map.put("DO", "多米尼加");
				map.put("VC", "圣文森特");map.put("tt", "特立尼达和多巴哥");map.put("AG", "安提瓜和巴布达");
				continent.put("美洲", map);
				map = new HashMap<String,String>();

		//大洋洲（Oceania）
				map.put("AU", "澳大利亚");map.put("NR", "瑙鲁");map.put("PG", "巴布亚新几内亚");map.put("WS", "萨摩亚");map.put("FJ", "斐济");
				map.put("SB", "所罗门群岛");map.put("TV", "图瓦卢");map.put("NZ", "新西兰");map.put("TO", "汤加");
				continent.put("大洋洲", map);
				map = new HashMap<String,String>();
				
//		map.put("Asia", "亚洲");map.put("Europe", "欧洲");map.put("Africa", "非洲");map.put("America", "美洲");map.put("Oceania", "大洋洲");
//		List<Countries> list = new ArrayList<Countries>();
//		Countries country;
//		ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
//		GenericDao gDao = ctx.getBean("genericDao",GenericDao.class);
//		for(String key : map.keySet()){
//			country = new Countries();
//			country.setId(key);
//			country.setName(map.get(key));
//			list.add(country);
//		}
//		JSONArray countriesJSON = JSONArray.fromObject(list);
//		writeFile("D:\\countries_EN.json",countriesJSON.toString());
		JSONObject countiesJSON = JSONObject.fromObject(continent);
		writeFile("D:\\countries.json",countiesJSON.toString());
	}	
}	  
