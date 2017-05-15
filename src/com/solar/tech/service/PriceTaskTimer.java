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
import com.solar.tech.bean.entity.SeatPriceData;

/**
 * 
 * @ClassName: TaskTimer
 * @Description: 定时任务，对过期订单处理（缓存当天的航班）
 * @author: ChenXZ
 * @date: 2016年5月6日 下午8:05:31
 */

@Component
public class PriceTaskTimer {
	private static Logger log = Logger.getLogger(PriceTaskTimer.class);
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
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar c = Calendar.getInstance();
			c.add(Calendar.DAY_OF_YEAR, -180);
			Date date = c.getTime();
			String pastTime = sdf.format(date);
			System.out.println("条件时间："+pastTime);
			List<SeatPriceData> flightInfo = ptService.SeatPriceList(pastTime);
			if(flightInfo.size()>0){
				System.out.println("有运价过期了，10秒之后重新开始缓存");
				/*
				 *缓存步骤：
				 *1、删除之前的
				 *2、重新生成现在的
				 */
				List<SeatPriceData> delFli = new ArrayList<SeatPriceData>();
				for(SeatPriceData fin : flightInfo){
					delFli.add(fin);
				}
				ptService.delSeatPrice(delFli);
				
				List<SeatPriceData> flign = removeFm(flightInfo);
				for(SeatPriceData fli : flign){
					ptService.loadBronAv(fli.getOrgCity(), fli.getDstCity(), pastTime);
				}
				
			}else{
				System.out.println("没有符合的过期的运价，不用缓存");
			}
			//System.out.println("现在的日期："+pastTime.toString());
		}
	}
	
	//查找之前先剔除出发城市和到达城市重复的航班
	private List<SeatPriceData> removeFm(List<SeatPriceData> fm){
		List<SeatPriceData> fmg = new ArrayList<SeatPriceData>();
		if(fm!=null&&fm.size()>0){
			for(SeatPriceData fmes : fm){
				boolean flag = true;
				for(SeatPriceData rInfo : fmg){
					if(fmes.getOrgCity().equals(rInfo.getOrgCity())&&fmes.getDstCity().equals(rInfo.getDstCity())){
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
		PriceTaskTimer dao = ac.getBean("taskTimer", PriceTaskTimer.class);
		dao.startTask("订单删除");
	}

}
