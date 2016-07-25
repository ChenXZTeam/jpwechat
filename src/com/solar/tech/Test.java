package com.solar.tech;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.TestExecutionListeners;

import com.solar.tech.bean.Countries;
import com.solar.tech.bean.InvitationCode;
import com.solar.tech.bean.User;
import com.solar.tech.service.impl.InvitationCodeImpl;
import com.solar.tech.users.UserService;
import com.solar.tech.utils.JSONFile;

import me.chanjar.weixin.mp.api.WxMpConfigStorage;
import net.sf.json.JSONArray;

public class Test {
	protected WxMpConfigStorage wxMpConfigStorage;
	
	private static final String[] storeInvitationChars={"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O"
			,"P","Q","R","S","T","U","V","W","X","Y","Z"};
			    /**
			     * @author liushuaic
			     * @date 2015/11/18 14:53
			     * @desc  生成邀请码
			     * 格式： 15（年）+01（月）+18（日）+id
			     * */
				public static Integer generateInvitationCode(User user){
			        Date date=Calendar.getInstance().getTime();
			        SimpleDateFormat sdf2=new SimpleDateFormat("YYMMdd");
			        String dateStr= sdf2.format(date);
			        return Integer.valueOf(dateStr+user.getUserUID().toString());
			    }
			    /**
			     * @author liushuaic
			     * @date 2015/11/26 18:01
			     * @desc  生成邀请码
			     * 格式： abcd12
			     * */
			    public static String generateInvitationCodeTwo(User user){
			        String userIdStr=user.getUserUID();
			        int forSize=5-userIdStr.length();
			        String randomStr="";
			        for(int i=0;i<forSize;i++){
			            Random random=new Random();
			            int randomIndex=random.nextInt(35);
			            randomStr=randomStr+storeInvitationChars[randomIndex];
			        }
			        return randomStr+userIdStr;
			    }
			    
			    public static void main(String[] args) {
			    	Map<String,String> map = new HashMap<String,String>();
			    	map.put("OnJob", "在职");
			    	map.put("Freelance", "自由职业");
			    	map.put("Retire", "退休");
			    	map.put("Student","在校学生");
			    	map.put("Children", "学龄儿童");
					List<Countries> list = new ArrayList<Countries>();
					Countries country;
			    	
			    	for(String key : map.keySet()){
						country = new Countries();
						country.setId(key);
						country.setName(map.get(key));
						list.add(country);
					}
					JSONArray countriesJSON = JSONArray.fromObject(list);
//					JSONFile.writeFile("D:\\CustomerType.json",countriesJSON.toString());
					System.out.println(countriesJSON.toString());
			    }	
			    
			    @org.junit.Test
			    public void test(){
			    	try {
			    		String token = this.wxMpConfigStorage.getAccessToken();
			    		System.out.println(token);
					} catch (Exception e) {
						e.printStackTrace();
					}
			    }
}
