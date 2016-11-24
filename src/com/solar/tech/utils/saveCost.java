//这个类用于保存价格并在用户支付时对比用户将要付款的价格是否跟系统的价格是否一致
package com.solar.tech.utils;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.solar.tech.bean.entity.SeatInfo;
import com.solar.tech.bean.entity.FlightInfo;
import com.solar.tech.service.PlanTekService;
import com.travelsky.sbeclient.obe.response.FDItem;

public class saveCost {
	public double getpay(String chufCity, String daodCity, String dateTime, String airCode, String filgNo, String cabin, String direct, String noStop){
		double paycost = 0.0;
		//PlanTekService PlanTekServ = new PlanTekService();
		List<FDItem> fdList = new ECUtils().fd(chufCity, daodCity, dateTime, airCode, null , "CH", null); // 传入出发城市、到达城市、日期及航空公司代码、航班号、是否直飞、是否有经停点
		if(fdList != null && fdList.size() > 0){
			for(FDItem item : fdList){
				// 根据当前航司代码、及舱位获取对应的运价信息
				if(airCode.equals(item.getAirline()) && cabin.equals(item.getCabin())){
					if(!StringUtils.isEmpty(item.getOnewayPrice())){
						//seatInfo.setOnewayPrice(item.getOnewayPrice()); // 设置单程运价
						paycost = Double.valueOf(item.getOnewayPrice()).doubleValue();
					}
					/*if(!StringUtils.isEmpty(item.getRoundtripPrice())){
						seatInfo.setRoundtripPrice(item.getRoundtripPrice()); // 设置往返运价
					}
					if(!StringUtils.isEmpty(item.getBasicCabin())){
						seatInfo.setBasicCabin(item.getBasicCabin()); // 设置基础舱位信息
					}*/
				}
			}
		}
		return paycost;
	}
}
