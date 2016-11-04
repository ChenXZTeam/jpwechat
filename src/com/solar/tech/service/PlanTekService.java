package com.solar.tech.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.Test;
import com.solar.tech.utils.ECUtils;
import com.solar.tech.utils.OptimizeECUtils;
import com.solar.tech.bean.entity.FlightInfo;
import com.solar.tech.dao.GenericDao;
import com.travelsky.sbeclient.obe.response.AVDoubleResponse;

/**
 * @title PlanTekService 处理机票的查询、预定的类
 * @author solarpc1
 *
 */
@Service
@Transactional
public class PlanTekService {
	@Resource
	private GenericDao gDao;
	
	/**
	 * @title 传入出发城市、到达城市、日期、航班号及舱位，返回该舱位可用座位数 
	 */
	//传入出发城市、到达城市、日期及航空公司代码  例如："CAN", "PEK", "2016-12-01", "CZ"
	public List<FlightInfo> findHB(String chufCity,String daodCity,String airCode, String dateTime, String filgNo, String direct, String noStop){//cancelPnr
		List<FlightInfo> list = new OptimizeECUtils().query(chufCity, daodCity, dateTime, airCode , filgNo, direct, noStop); // 传入出发城市、到达城市、日期、航空公司代码是否直达、是否有经停点
		return list;
	}
	
	//返回往返的全部航班信息
	/*public Map<String,Object> roundtripAv(String org, String dst, String date, String returnDate, String airline, Integer page){
			Map<String,Object> map  = new OptimizeECUtils().roundtripAv(org, dst, date, returnDate, airline, page);
			return map;
	}*/
	
	
	// 剔除重复的数据
	public List<FlightInfo> removeRepeat(List<FlightInfo> list){
		List<FlightInfo> resultList = new ArrayList<FlightInfo>();
		
		if(list != null && list.size() > 0){
			for(FlightInfo info : list){
				boolean flag = true;
				for(FlightInfo rInfo : resultList){
					if(info.getFlightNo().equals(rInfo.getFlightNo())){
						flag = false;
						break;
					}
				}
				if(flag){
					resultList.add(info);
				}
			}
		}
		
		return resultList;
	}
	/*
	//临时方法
	public List getPlanList(){
		String sql = "select AIRPORTNAMECN,AIRPORTCODE,CITYNAMECN,ISDOMESTIC from b_airport";
		return this.gDao.executeJDBCSqlQuery(sql);
	}*/
}
