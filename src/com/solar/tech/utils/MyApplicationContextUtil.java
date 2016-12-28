package com.solar.tech.utils;
import org.springframework.beans.BeansException;  
import org.springframework.context.ApplicationContext;  
import org.springframework.context.ApplicationContextAware;  
/** 
 * 普通类调用注解service类的方法的中间类（起到桥梁的作用）
 * @author xiangqian 
 */  
public class MyApplicationContextUtil implements ApplicationContextAware {  
    private static ApplicationContext appCtx;
    /** 
     * 此方法可以把ApplicationContext对象inject到当前类中作为一个静态成员变量。 
     * @param applicationContext ApplicationContext 对象. 
     * @throws BeansException 
     */  
    @Override  
    public void setApplicationContext( ApplicationContext applicationContext ) throws BeansException {  
        appCtx = applicationContext;  
    }  
    /** 
     * 根据beanName就能获取到该beanName的service方法
     */  
    public static Object getBean( String beanName ) {  
        return appCtx.getBean( beanName );  
    }  
} 