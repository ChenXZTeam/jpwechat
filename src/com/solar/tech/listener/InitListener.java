package com.solar.tech.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.solar.tech.service.MenuManger;
/**
 * 
 * @ClassName: InitListener 
 * @Description: TODO
 * @author: ChenXZ
 * @date: 2016年5月6日 下午2:28:20
 */
public class InitListener implements ServletContextListener{

	private MenuManger uMenuManger;
	
	/**
	 * 
	 */
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		
	}

	/**
	 * 
	 */
	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		/** 系统启动检查自定义菜单是否已经配置自定义菜单 **/
		uMenuManger = new MenuManger();
		uMenuManger.CheckMenu();
		
		
	}
	
	
}
