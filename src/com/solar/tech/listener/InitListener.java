package com.solar.tech.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

import com.solar.tech.service.MenuManger;
import com.solar.tech.service.PriceTaskTimer;
import com.solar.tech.service.TaskTimer;
/**
 * 
 * @ClassName: InitListener 
 * @Description: TODO
 * @author: ChenXZ
 * @date: 2016年5月6日 下午2:28:20
 */
@Component("InitListener")
public class InitListener implements ApplicationListener<ContextRefreshedEvent>{
private static Logger log = Logger.getLogger(InitListener.class);
	
	@Autowired
	private TaskTimer uTask;
	@Autowired
	private PriceTaskTimer pykTime;
	
	private MenuManger uMenuManger;

	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {
		if(event.getApplicationContext().getParent() == null){
			log.info("========================spring容易初始化完毕============================");
			/** 定时器，处理订单超过一个时间，归档历史表 */
			//uTask.startTask("过期航班任务");
			//pykTime.startTask("过期运价任务");
			
			/** 系统启动检查自定义菜单是否已经配置自定义菜单 **/
			uMenuManger = new MenuManger();
			uMenuManger.CheckMenu();
		}
	}
	
	
}
