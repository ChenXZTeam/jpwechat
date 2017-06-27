package com.solar.tech.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Component;

import com.solar.tech.bean.entity.SeatInfoData;

/**
 * 
 * @ClassName: TaskTimer
 * @Description: 定时任务，对过期订单处理（缓存当天的航班）
 * @author: ChenXZ
 * @date: 2016年5月6日 下午8:05:31
 */

@Component
public class TaskTimer {
	private static Logger log = Logger.getLogger(TaskTimer.class);
	@Autowired
	private PlanTekService ptService;
	/**
	 * @Title: startTask
	 * @Description: 启动任务
	 * @param time
	 */
	public void startTask(String time) {
		Timer timer = new Timer();
		Task uTask = new Task(time);
		timer.schedule(uTask, 10000, 3600000);
	}

	/**
	 * 
	 * @ClassName: Task
	 * @Description: 定时任务
	 * @author: ChenXZ
	 * @date: 2016年5月8日 下午4:43:27
	 */
	private class Task extends TimerTask {
		private String uTaskName = null;

		public Task(String taskName) {
			this.uTaskName = taskName;
			log.info(String.format("[任务启动] %s", uTaskName));
		}

		@Override
		public void run() {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			Calendar c = Calendar.getInstance();
			c.add(Calendar.HOUR_OF_DAY, -1);
			Date NowDate = c.getTime();
			String pastTime = sdf.format(NowDate);
			
			List<SeatInfoData> flightInfo = ptService.pastFlightMessageList("1",pastTime);
			if(flightInfo.size()>0){
				System.out.println("有当天出发的航班已经过期，开始缓存");
				/*
				 *缓存步骤：
				 *1、删除之前的
				 *2、重新生成现在的
				 */
				List<SeatInfoData> delFli = new ArrayList<SeatInfoData>();
				for(SeatInfoData fin : flightInfo){
					delFli.add(fin);
				}
				ptService.delFlight(delFli);
				
				List<SeatInfoData> flign = removeFm(flightInfo);
				for(SeatInfoData fli : flign){
					ptService.loadBronAv(fli.getDwOrgCity(), fli.getDwDstCity(), pastTime.substring(0,10));
				}
				System.out.println("当天的缓存航班已经缓存完成");
			}else{
				System.out.println("没有符合的过期航班，1个小时之后开始重新缓存");
			}
			//System.out.println("现在的日期："+pastTime.toString());
		}
	}
	
	//查找之前先剔除出发城市和到达城市重复的航班
	private List<SeatInfoData> removeFm(List<SeatInfoData> fm){
		List<SeatInfoData> fmg = new ArrayList<SeatInfoData>();
		if(fm!=null&&fm.size()>0){
			for(SeatInfoData fmes : fm){
				boolean flag = true;
				for(SeatInfoData rInfo : fmg){
					if(fmes.getDwOrgCity().equals(rInfo.getDwOrgCity())&&fmes.getDwDstCity().equals(rInfo.getDwDstCity())){
						flag = false;
						break;
					}
				}
				if(flag){
					fmg.add(fmes);
				}
			}
		}
		return fmg;
	}

	public static void main(String[] args) {
		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		TaskTimer dao = ac.getBean("taskTimer", TaskTimer.class);
		dao.startTask("订单删除");
	}

}
