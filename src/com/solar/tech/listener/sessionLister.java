package com.solar.tech.listener;

import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;

/**
 * 监听登录的监听器
 */
public class sessionLister implements HttpSessionListener {
	//用户和Session绑定关系 
	public static final Map<String, HttpSession> USER_SESSION=new HashMap<String, HttpSession>();
	//seeionId和用户的绑定关系 
	public static final Map<String, String> SESSIONID_USER=new HashMap<String, String>();    
	
	/**
     * Default constructor. 
     */
    public sessionLister() {
    	
    }

	/**
     * Session创建事件
     */
    public void sessionCreated(HttpSessionEvent se)  { 

    }

	/**
     * Session销毁事件
     */
    public void sessionDestroyed(HttpSessionEvent se){ 
    	String sessionId=se.getSession().getId();  
	    USER_SESSION.remove(SESSIONID_USER.get(sessionId)); //通过接收到的
	    SESSIONID_USER.remove(sessionId);
    }
    
    public String userLogin(String userName, String pass, HttpServletRequest httpReq, HttpSession sess){
         //处理用户登录(保持同一时间同一账号只能在一处登录)  
         String msgTishi = userLoginHandle(userName,sess);
         if ((userName == null) || (pass == null) || (userName.trim().isEmpty()) || (pass.trim().isEmpty())) throw new RuntimeException("用户名或密码不能为空");
    	 /*校验登录账号密码*/
    	 UsernamePasswordToken token = new UsernamePasswordToken(userName, pass);   
    	 token.setRememberMe(true);    
    	 Subject subject = SecurityUtils.getSubject();     
    	 subject.login(token); 
    	     
         //添加用户与HttpSession的绑定  
    	 USER_SESSION.put(userName.trim(), sess);  
    	 //添加sessionId和用户的绑定  
    	 SESSIONID_USER.put(sess.getId(), userName);
    	 for (String ss : SESSIONID_USER.keySet()) {
    	       System.out.println("正在登陆的用户有:" + SESSIONID_USER.get(ss));
    	 }
    	 return msgTishi;
    }

    /** 
     * 用户登录时的处理 
     * 处理一个账号同时只有一个地方登录的关键 
     * @param request 
     */  
    public static String userLoginHandle(String userName,HttpSession sess){ 
    	for(String s : SESSIONID_USER.keySet()) { //遍历旧用户和sessionid的Map检查该用户是否正在登陆
    		if(SESSIONID_USER.get(s).equals(userName)){ //如果等于就说明这个账号正在登陆
    			for(String ses : USER_SESSION.keySet()) { //如果正在登录，那就获取用户和session的Map中的httpsession,因为这个要拿来清除掉
    				sess = USER_SESSION.get(ses);
    			}
				USER_SESSION.remove(SESSIONID_USER.get(s));
				SESSIONID_USER.remove(s);
    			sess.invalidate(); //清除之前正在登陆的用户session
    			return "1";
    		}
    	}
    	return "";
    }
    
    //删除正在登陆的用户登录信息的方法
    public void deleteuserSid(String userName, String sessid){
    	USER_SESSION.remove(SESSIONID_USER.remove(sessid));
    }
}
