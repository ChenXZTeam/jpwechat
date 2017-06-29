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
import com.solar.tech.service.TaskTimer2;
import com.solar.tech.service.TaskTimer3;
import com.solar.tech.service.TaskTimer4;
import com.solar.tech.service.TaskTimer5;
import com.solar.tech.service.TaskTimer6;
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
	private TaskTimer uTask; // 当天航班的缓存定时器
	@Autowired
	private TaskTimer2 uTask2; //1~3天内航班的缓存定时器
	@Autowired
	private TaskTimer3 uTask3; //3~7天内航班的缓存定时器
	@Autowired
	private TaskTimer4 uTask4; //7~15天内航班的缓存定时器
	@Autowired
	private TaskTimer5 uTask5; //15~30天内航班的缓存定时器
	@Autowired
	private TaskTimer6 uTask6; //30天以上航班的缓存定时器
	@Autowired
	private PriceTaskTimer pykTime; //运价的定时器
	
	private MenuManger uMenuManger;

	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {
		if(event.getApplicationContext().getParent() == null){
			log.info("========================spring容易初始化完毕============================");
			/** 定时器，处理订单超过一个时间，归档历史表 */
			/*uTask.startTask("====当天出发的航班缓存开始执行====");
			uTask2.startTask("=====1~3天出发的航班缓存开始执行===");
			uTask3.startTask("=====3~7天出发的航班缓存开始执行===");
			uTask4.startTask("=====7~15天出发的航班缓存开始执行==="); 
			uTask5.startTask("=====15~30天出发的航班缓存开始执行==="); 
			uTask6.startTask("=====30天以上出发的航班缓存开始执行==="); 
			pykTime.startTask("====启动运价过期任务定时器====");*/
			
			/** 系统启动检查自定义菜单是否已经配置自定义菜单 **/
			uMenuManger = new MenuManger();
			uMenuManger.CheckMenu();
		}
	}
	
	
}
