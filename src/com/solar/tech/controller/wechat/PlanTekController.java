package com.solar.tech.controller.wechat;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.entity.FlightInfo;
import com.solar.tech.bean.entity.SeatInfo;
import com.solar.tech.service.PlanTekService;
import com.solar.tech.utils.SeatUtils;

@Controller
@RequestMapping("/wechatController")
public class PlanTekController {
	@Autowired
	private PlanTekService PlanTekServ;
	
	@RequestMapping("/find/planTek.action")
	@ResponseBody
	public Map<String, Object> FindPlanTek(String chufCity,String daodCity,String cangW,String dateTime){
		Map<String, Object> map = new HashMap<String, Object>();
		//PlanTekServ.findHB(chufCity, daodCity, cangW, dateTime);
		List<FlightInfo> fliL = PlanTekServ.findHB(chufCity, daodCity, cangW, dateTime);
		if(fliL != null && fliL.size() > 0){
			for(FlightInfo f : fliL){
				System.out.println("-------->航班号：" + f.getFlightNo() + "， 出发城市：" + f.getOrgCity() + " ( 起飞时间：" + f.getDepTime() + " ) " + "， 到达城市: " + f.getDstCity() + " ( 到达时间：" + f.getArrTime() + " ) ，机型：" + f.getPlaneStyle()+"<----------------------------------------");				
				if(f.getSeatList().size()==0){
					System.out.println("先生们女士们该航班座位已满"); 
				}
				for(SeatInfo info : f.getSeatList()){
					System.out.println("座位类型："+info.getCangwei() + " (" + SeatUtils.getSeatType(cangW) + ")" + "， 剩余座位: " + SeatUtils.getSeatNum(info.getCangwei_data()) +"， 单程: " + info.getOnewayPrice() + "元\t\t 往返: " + info.getRoundtripPrice()+"元");
				}
			}
		}
		System.out.println("列表的长度："+fliL.size());
		map.put("listDate", fliL);
		//System.out.println("出发城市："+chufCity+"，到达城市："+daodCity+"，舱位："+cangW+"，出发时间："+dateTime);
		return map;
	}
}
