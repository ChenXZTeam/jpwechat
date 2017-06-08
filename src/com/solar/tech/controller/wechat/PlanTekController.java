package com.solar.tech.controller.wechat;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;


//import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.entity.FlightInfo;
import com.solar.tech.bean.entity.SeatInfo;
import com.solar.tech.bean.entity.SeatInfoData;
import com.solar.tech.bean.entity.SeatPriceData;
import com.solar.tech.service.PlanTekService;
import com.solar.tech.service.userOrderService;
import com.solar.tech.utils.OptimizeECUtils;

@Controller
@RequestMapping("/wechatController")
public class PlanTekController {
	//private static Logger log = Logger.getLogger(PlanTekController.class);
	@Autowired
	private PlanTekService PlanTekServ;
	@Autowired
	private userOrderService OrderService;
	
	//查找航班的又一种方式
	@RequestMapping("/find/OtherQuery.action")
	@ResponseBody
	public Map<String, Object> otherFindPek(String chufCity,String daodCity,String dateTime, HttpSession session){
		session.setAttribute("qishiPlanCode", chufCity);
		session.setAttribute("daodPlanCode", daodCity);
		System.out.println("开始查询（出发城市："+chufCity+", 到达城市："+daodCity+", 出发时间："+dateTime+"）");
		Map<String, Object> map = new HashMap<String, Object>();
		//开始查找航班
		List<SeatInfoData> avList = PlanTekServ.SreachSeat(chufCity,daodCity,dateTime,0);
		System.out.println("查找到座位结果："+avList.size());
		List<FlightInfo> flightInfo = PlanTekServ.priceInfo(avList, dateTime); //将航班信息和座位信息整合
		System.out.println("整合了座位和运价结果："+flightInfo.size());
		//把整理好的数据分成中转和直达
		List<FlightInfo> zdList = new ArrayList<FlightInfo>(); //直达
		List<FlightInfo> zzList = new ArrayList<FlightInfo>(); //直达
		if(flightInfo.size()==0){
			map.put("msg", "0");
			map.put("listDate", zdList);
			map.put("zzListDate", zzList);
		}else{
			for(FlightInfo finfo : flightInfo){
				if(chufCity.equals(finfo.getOrgCity())&&daodCity.equals(finfo.getDstCity())){
					zdList.add(finfo);
				}else{
					zzList.add(finfo);
				}
			}
			map.put("msg", "1");
			map.put("listDate", zdList);
			map.put("zzListDate", zzList);
		}
		return map;
	}
	
	//根据uuid获取到航班的数据
	@RequestMapping("/find/byuuid.action")
	@ResponseBody
	public Map<String,Object> findByid(String uuid,String canbin){
		Map<String,Object> map = new HashMap<String,Object>();
		List<SeatInfoData> sinfo = PlanTekServ.findByUUID(uuid);
		List<SeatPriceData> spd = PlanTekServ.findByCanbin(sinfo.get(0).getOrgcity(),sinfo.get(0).getDstcity(),canbin,sinfo.get(0).getAirline());
		map.put("canbin", spd.get(0).getCabin());
		map.put("cost", spd.get(0).getOnewayPrice());
		map.put("dataObj", sinfo);
		return map;
	}
	
	//根据uuid获取到航班的数据
	@RequestMapping("/find/byuuidTwo.action")
	@ResponseBody
	public Map<String,Object> findByidTwo(String uuid1,String uuid2,String canbin){
		Map<String,Object> map = new HashMap<String,Object>();
		for(int i=1; i<=2; i++){
			if(i==1){
				List<SeatInfoData> sinfo = PlanTekServ.findByUUID(uuid1);
				List<SeatPriceData> spd = PlanTekServ.findByCanbin(sinfo.get(0).getOrgcity(),sinfo.get(0).getDstcity(),canbin,sinfo.get(0).getAirline());
				map.put("canbin1", spd.get(0).getCabin());
				map.put("cost1", spd.get(0).getOnewayPrice());
				map.put("dataObj1", sinfo);
			}else if(i==2){
				List<SeatInfoData> sinfo = PlanTekServ.findByUUID(uuid2);
				List<SeatPriceData> spd = PlanTekServ.findByCanbin(sinfo.get(0).getOrgcity(),sinfo.get(0).getDstcity(),canbin,sinfo.get(0).getAirline());
				map.put("canbin2", spd.get(0).getCabin());
				map.put("cost2", spd.get(0).getOnewayPrice());
				map.put("dataObj2", sinfo);
			}
		}
		return map;
	}
	
	//查询往返的机票
	@RequestMapping("/find/planTekTo.action")
	@ResponseBody
	public Map<String, Object> planTekTo(String org, String dst, String date, String retDate){
		System.out.println(org+", "+dst+", "+date+", "+retDate); 
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("=================开始处理去程航班=====================");
		List<SeatInfoData> wFilght = PlanTekServ.SreachSeat(org,dst,date,1);
		List<FlightInfo> wFlightInfo = PlanTekServ.priceInfo(wFilght, date); //将航班信息和座位信息整合
		System.out.println("=================开始处理回程航班=====================");
		List<SeatInfoData> fFilght = PlanTekServ.SreachSeat(dst,org,retDate,1);
		List<FlightInfo> fFlightInfo = PlanTekServ.priceInfo(fFilght, retDate); //将航班信息和座位信息整合
		
		map.put("departAv", wFlightInfo);
		map.put("returnAv", fFlightInfo);
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
		List<FlightInfo> list = new OptimizeECUtils().query(chufCity, daodCity, chufDate, airCode, null, "true", "true");
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
	public Map<String, Object> patPNR(String org, String dst, String date, String returnDate, String airline, Integer pageString pnrNo){
		Map<String, Object> map=new HashMap<String, Object>();
		//PATFareItem[] segmentInfos = new ECUtils().patPNR(pnrNo, "A", null, 1, null, null, null, null);
		AVDoubleResponse passAVR = new ECUtils().roundtripAv(org, dst, date, returnDate, airline, page);
		//System.out.println("长度："+segmentInfos.length);
		map.put("SEG", passAVR); 
		return map;
	}*/
	
	//删除单个中航信pnrNo的方法（程序调试时使用）
	/*@RequestMapping("/deletes/PNRno.action")
	@ResponseBody
	public Map<String, Object> deletePnrNo(String pnrNo){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean YesOrNo = new ECUtils().cancelPnr(pnrNo);//删除中航信系统中刚刚预定的数据
		System.out.println("删除是否成功："+YesOrNo);
		return map;
	}*/
	
	
	//临时使用的方法
	/*@RequestMapping("/find/getplanCode.action")
	@ResponseBody
	public Map<String, Object> getplanCode(){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("c", PlanTekServ.getPlanList());
		return map;
	}*/

}
