//这个类用于保存价格并在用户支付时对比用户将要付款的价格是否跟系统的价格是否一致
package com.solar.tech.utils;

import java.util.List;

import com.solar.tech.bean.entity.SeatInfo;
import com.solar.tech.bean.entity.FlightInfo;
import com.solar.tech.service.PlanTekService;

public class saveCost {
	public String getpay(String chufCity, String daodCity, String dateTime, String airCode, String filgNo, String cabin,String paycost){
		PlanTekService PlanTekServ = new PlanTekService();
		List<FlightInfo> list = new OptimizeECUtils().query(chufCity, daodCity, dateTime, airCode, filgNo); // 传入出发城市、到达城市、日期及航空公司代码及航班号
		List<FlightInfo> newList = PlanTekServ.removeRepeat(list);
		for(int i = 0; i<newList.size(); i++){
			if((newList.get(i).getFlightNo()).equals(filgNo)){
				for(SeatInfo info : newList.get(i).getSeatList()){
					System.out.println("CZ3107航班的信息：舱位="+info.getCangwei()+" 单程对应的价格="+info.getOnewayPrice());	
					paycost=info.getOnewayPrice();//将查询出来的结果金额放在变量中
					if(info.getCangwei().equals(cabin)&&info.getOnewayPrice().equals(paycost+".00")){
						paycost=info.getOnewayPrice();
					}
				}			
			}			
		}
		return paycost;
	}
}
