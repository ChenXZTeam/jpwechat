package com.solar.tech.controller.wechat;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.Test;
import com.solar.tech.bean.entity.FlightInfo;
import com.solar.tech.bean.entity.SeatInfo;
import com.solar.tech.service.PlanTekService;
import com.solar.tech.service.userOrderService;
import com.solar.tech.utils.ECUtils;
import com.solar.tech.utils.OptimizeECUtils;
import com.solar.tech.utils.SeatUtils;
import com.solar.tech.utils.CityUtils;
import com.solar.tech.utils.saveCost;
import com.travelsky.sbeclient.obe.response.AVDoubleResponse;
import com.travelsky.sbeclient.obe.response.AvSegment;
import com.travelsky.sbeclient.obe.response.PATFareItem;
import com.travelsky.sbeclient.obe.response.PataFareResponse;


@Controller
@RequestMapping("/wechatController")
public class PlanTekController {
	private static Logger log = Logger.getLogger(PlanTekController.class);
	@Autowired
	private PlanTekService PlanTekServ;
	@Autowired
	private userOrderService OrderService;
	
	@RequestMapping("/find/planTek.action")
	@ResponseBody
	public Map<String, Object> FindPlanTek(String chufCity,String daodCity,String cangW,String dateTime, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		//CityUtils p1=new CityUtils();
		session.setAttribute("qishiPlanCode", chufCity);
		session.setAttribute("daodPlanCode", daodCity);
		System.out.println(chufCity+", "+daodCity+", "+cangW+", "+dateTime);
		List<FlightInfo> fliL = PlanTekServ.findHB(chufCity, daodCity, null, dateTime, null, null, null); //出发城市、到达城市、航空公司、出发时间、航班号、是否直达、是否有经停点
		if(fliL.size()<1||fliL==null){
			map.put("msg", 0);
		}
		List<FlightInfo> tempFlil = PlanTekServ.removeRepeat(fliL); //剔除重复的数据
		List<FlightInfo> newFlil = new ArrayList<FlightInfo>();  //剔除座位为空的数据
		List<FlightInfo> zhidFil = new ArrayList<FlightInfo>();  //直达的航班
		List<FlightInfo> zhongzFil = new ArrayList<FlightInfo>();  //中转的航班
		//剔除座位为空的方法
		if(tempFlil != null && tempFlil.size() > 0){
			for(FlightInfo f : tempFlil){
				if(f.getSeatList().size()!=0){
					int hasNum = 0;
					for(SeatInfo info : f.getSeatList()){
						if(SeatUtils.getSeatType(info.getBasicCabin()).equals(cangW)){
							if(hasNum==0){
								newFlil.add(f);  //将符合的航班加入新的数组链表里面
								hasNum++;
							}
						}
					}
				}
			}
		}
		//获得直达的航班
		if(newFlil != null && newFlil.size() > 0){
			for(FlightInfo fli : newFlil){
				if(fli.getOrgCity().equals(chufCity)&&fli.getDstCity().equals(daodCity)){
					zhidFil.add(fli);  //重构直达的链表
					System.out.println("直达航班："+zhidFil);
				}
			}
		}
		System.out.println("直达航班的数量："+zhidFil.size());
		
		//初步获得中转的链表
		if(newFlil != null && newFlil.size() > 0){
			for(FlightInfo zfli : newFlil){
				if((zfli.getOrgCity().equals(chufCity)||zfli.getDstCity().equals(daodCity))&&!(zfli.getOrgCity().equals(chufCity)&&zfli.getDstCity().equals(daodCity))){ //只保留中转的航班，剔除直达航班
					zhongzFil.add(zfli);  //重构中转的链表
					System.out.println("中转航班："+zfli);
				}
			}
		}			
		System.out.println("中转航班数组的长度："+zhongzFil.size());
		
		if(zhidFil.size()==0&&zhongzFil.size()==0){
			map.put("msg", 0);
		}else{
			map.put("msg", 1);
			map.put("listDate", zhidFil);
			map.put("zzListDate", zhongzFil);
		}
		return map;
	}
	
	//查询往返的机票
	@RequestMapping("/find/planTekTo.action")
	@ResponseBody
	public Map<String, Object> planTekTo(String org, String dst, String date, String returnDate, String airline, Integer page){
		log.info(org+", "+dst+", "+date+", "+returnDate+", "+airline+", "+page); 
		Map<String, Object> map = new OptimizeECUtils().roundtripAv(org, dst, date, returnDate, airline, page);
		//System.out.println("去程航班的数量："+avd.getDepartItemsCount());
		//System.out.println("返程航班的数量："+avd.getReturnItemsCount());
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
