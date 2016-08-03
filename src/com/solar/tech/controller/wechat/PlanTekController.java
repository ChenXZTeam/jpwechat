package com.solar.tech.controller.wechat;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.entity.FlightInfo;
import com.solar.tech.bean.entity.SeatInfo;
import com.solar.tech.service.PlanTekService;
import com.solar.tech.utils.ECUtils;
import com.solar.tech.utils.OptimizeECUtils;
import com.solar.tech.utils.SeatUtils;
import com.travelsky.sbeclient.obe.response.AvSegment;
import com.travelsky.sbeclient.obe.response.PATFareItem;
import com.travelsky.sbeclient.obe.response.PataFareResponse;

@Controller
@RequestMapping("/wechatController")
public class PlanTekController {
	@Autowired
	private PlanTekService PlanTekServ;
	
	@RequestMapping("/find/planTek.action")
	@ResponseBody
	public Map<String, Object> FindPlanTek(String chufCity,String daodCity,String cangW,String dateTime, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		session.setAttribute("qishiPlanCode", chufCity);
		session.setAttribute("daodPlanCode", daodCity);
		System.out.println(chufCity);
		System.out.println(daodCity);
		System.out.println(cangW);
		System.out.println(dateTime);
		List<FlightInfo> fliL = PlanTekServ.findHB(chufCity, daodCity, "CZ", dateTime, null);
		List<FlightInfo> tempFlil = PlanTekServ.removeRepeat(fliL);
		if(tempFlil != null && tempFlil.size() > 0){
			for(FlightInfo f : tempFlil){
				if(f.getSeatList().size()!=0){
					System.out.println("航班号：" + f.getFlightNo() + "， 出发城市：" + f.getOrgCity() + " ( 起飞时间：" + f.getDepTime() + " ) " + "， 到达城市: " + f.getDstCity() + " ( 到达时间：" + f.getArrTime() + " ) ，机型：" + f.getPlaneStyle());				
					int SumTecikNum=0;
					for(SeatInfo info : f.getSeatList()){	
						if(SeatUtils.getSeatType(info.getBasicCabin()).equals(cangW)){
							System.out.println("座位类型："+info.getCangwei() + " (" + SeatUtils.getSeatType(info.getBasicCabin()) + ")" + "， 剩余座位: " + SeatUtils.getSeatNum(info.getCangwei_data()) +"， 单程: " + info.getOnewayPrice() + "元\t\t 往返: " + info.getRoundtripPrice()+"元");
							//System.out.println(j+". 剩余的票数：" + " (" + SeatUtils.getSeatType(info.getBasicCabin()) + ") " +SeatUtils.getSeatNum(info.getCangwei_data()));							
							int TecikNum=SeatUtils.getSeatNum(info.getCangwei_data());
							SumTecikNum+=TecikNum;
						}
					}
					System.out.println(cangW+"剩余的票数：" + SumTecikNum);
				}
			}
		}
		if(tempFlil != null && tempFlil.size() > 0){
			System.out.println("列表的长度："+tempFlil.size());
			if(tempFlil.size()==0){
				map.put("msg", 0);
			}else{
				map.put("msg", 1);
				map.put("listDate", tempFlil);
			}
		}
		return map;
	}
	

	//支付前得确认是否还有空座位
	@RequestMapping("/confirmCabin/seatInfo.action")
	@ResponseBody
	public Map<String, Object> confirmCabin(String chufCity,String daodCity,String chufDate,String flightNo,String cabin){
		Map<String, Object> map = new HashMap<String, Object>();
		OptimizeECUtils op = new OptimizeECUtils();
		int seatNum = op.confirmCabin(chufCity, daodCity, chufDate, flightNo, cabin);
		if(0<seatNum){
			map.put("seatNum",seatNum);			
		}else{
			map.put("msg",0);
			System.out.println("该座位已被订完");
		}
		return map;
	}
	
	//根据（出发地、到达地、航班号、出发时间、舱位）查找是否有座位。在改签中需要查找是否有位置才能预定
	@RequestMapping("/find/planTekOne.action")
	@ResponseBody
	public Map<String, Object> planTekOne(String chufCity,String daodCity,String chufDate, String fildNo, String canbin){
		Map<String, Object> map = new HashMap<String, Object>();
		String airCode = fildNo.substring(0, 2);
		System.out.println(airCode);
		List<FlightInfo> list = new OptimizeECUtils().query(chufCity, daodCity, chufDate, airCode, null);
		List<FlightInfo> tempFlil = PlanTekServ.removeRepeat(list); //这个链表剔除重复数据
		List<FlightInfo> canbinList = new ArrayList<FlightInfo>();//这个链表是保存所有含有与 变量（canbin）相同的航班数据
		if(tempFlil != null && tempFlil.size() > 0){
			for(FlightInfo f : tempFlil){				
				for(SeatInfo info : f.getSeatList()){
					if(info.getCangwei().equals(canbin)){
						//System.out.println("> " + f.getFlightNo() + ". " + f.getOrgCity() + " ( " + f.getDepTime() + " ) " + " : " + f.getDstCity() + " ( " + f.getArrTime() + " ) " + f.getPlaneStyle());
						//System.out.println(info.getCangwei() + " (" + SeatUtils.getSeatType(info.getBasicCabin()) + ")" + " : " + SeatUtils.getSeatNum(info.getCangwei_data()) + " OP: " + info.getOnewayPrice() + "\t\t\t\t\t RP: " + info.getRoundtripPrice());
						canbinList.add(f);
					}					
				}
			}
		}
		map.put("dataList", canbinList);
		return map;		
	}
	
	//查询国内运价
	/*@RequestMapping("/find/patPNR.action")
	@ResponseBody
	public Map<String, Object> patPNR(String pnrNo){
		Map<String, Object> map=new HashMap<String, Object>();
		PATFareItem[] segmentInfos = new ECUtils().patPNR(pnrNo, "A", null, 1, null, null, null, null);
		System.out.println("长度："+segmentInfos.length);
		map.put("SEG", segmentInfos); 
		return map;
	}
	
	//删除单个中航信pnrNo的方法（程序调试时使用）
	@RequestMapping("/deletes/PNRno.action")
	@ResponseBody
	public Map<String, Object> deletePnrNo(String pnrNo){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean YesOrNo = new ECUtils().cancelPnr(pnrNo);//删除中航信系统中刚刚预定的数据
		System.out.println("删除是否成功："+YesOrNo);
		return map;
	}*/
}
