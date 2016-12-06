
package com.solar.tech.utils;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.solar.tech.bean.entity.SeatInfo;
import com.travelsky.sbeclient.obe.response.FDItem;

public class mony_av {
	/**
	 * 只是查询运价
	 * 这个类用于保存价格并在用户支付时对比用户将要付款的价格是否跟系统的价格是否一致
	 * @return
	 */
	public double getpay(String chufCity, String daodCity, String dateTime, String airCode, String cabin){
		double paycost = 0.0;
		List<FDItem> fdList = new ECUtils().fd(chufCity, daodCity, dateTime, airCode, null , null, null); // 传入出发城市、到达城市、日期及航空公司代码、航班号、是否直飞、是否有经停点
		if(fdList != null && fdList.size() > 0){
			for(FDItem item : fdList){
				// 根据当前航司代码、及舱位获取对应的运价信息
				if(airCode.equals(item.getAirline()) && cabin.equals(item.getCabin())){
					if(!StringUtils.isEmpty(item.getOnewayPrice())){
						//seatInfo.setOnewayPrice(item.getOnewayPrice()); // 设置单程运价
						paycost = Double.valueOf(item.getOnewayPrice()).doubleValue();
					}
				}
			}
		}
		return paycost;
	}
	
	/**
	 * 查询运价对应的座位信息
	 * @return
	 */
	public List<FDItem> getsInfo(String org, String dst, String date, String airCode){
		List<FDItem> fdList = new ECUtils().fd(org, dst, date, airCode, null , null, null); // 传入出发城市、到达城市、日期及航空公司代码、航班号、是否直飞、是否有经停点
		for(int i=0; i<fdList.size(); i++){
			System.out.println("航班号："+fdList.get(i).getAirline()+", 舱位："+fdList.get(i).getCabin()+", 单程价格："+fdList.get(i).getOnewayPrice());
		}
		if(fdList != null && fdList.size() > 0){
			return fdList;
		}
		return null;
	}
}
