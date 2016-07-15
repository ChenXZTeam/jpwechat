package com.solar.tech.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.solar.tech.utils.SeatUtils;
import com.solar.tech.utils.OptimizeECUtils;
import com.solar.tech.bean.entity.FlightInfo;
import com.solar.tech.bean.entity.SeatInfo;

/**
 * @title PlanTekService 处理机票的查询、预定的类
 * @author solarpc1
 *
 */
@Service
@Transactional
public class PlanTekService {
	
	/**
	 * @title 传入出发城市、到达城市、日期、航班号及舱位，返回该舱位可用座位数 
	 */
	//传入出发城市、到达城市、日期及航空公司代码  例如："CAN", "PEK", "2016-12-01", "CZ"
	public List<FlightInfo> findHB(String chufCity,String daodCity,String cangW, String dateTime){
		//SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//String startDate = fmt.format(new Date());
		List<FlightInfo> list = new OptimizeECUtils().query("CAN", "PEK", dateTime, "CZ"); // 传入出发城市、到达城市、日期及航空公司代码		
		return list;
	}
}
