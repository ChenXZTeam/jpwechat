package com.solar.tech.controller.wechat;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.CenterDate;
import com.solar.tech.bean.entity.FlightInfo;
import com.solar.tech.bean.entity.Insurance;
import com.solar.tech.bean.entity.SeatInfo;
import com.solar.tech.bean.entity.SeatInfoData;
import com.solar.tech.bean.entity.SeatPriceData;
import com.solar.tech.bean.entity.kdCost;
import com.solar.tech.service.PlanTekService;
import com.solar.tech.service.userOrderService;
import com.solar.tech.utils.ECUtils;
import com.solar.tech.utils.OptimizeECUtils;
import com.travelsky.sbeclient.obe.request.PataFareInfo;
import com.travelsky.sbeclient.obe.response.PataFarePriceInfo;

@Controller
@RequestMapping("/wechatController")
public class PlanTekController {
	private static Logger log = Logger.getLogger(PlanTekController.class);
	private static List<String> uuidList = new ArrayList<String>();
	private static List<String> uuidListwf = new ArrayList<String>();
	@Autowired
	private PlanTekService PlanTekServ;
	@Autowired
	private userOrderService OrderService;
	
	//查找航班的又一种方式
	@RequestMapping(value = {"/find/OtherQuery.action"}, method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> findTest(String chufCity, String daodCity, String dateTime,String uuid, HttpSession session){
		log.info("开始查询（出发城市："+chufCity+", 到达城市："+daodCity+", 出发时间："+dateTime+"）");
		session.setAttribute("qishiPlanCode", chufCity);
		session.setAttribute("daodPlanCode", daodCity);
		Map<String,Object> map = new HashMap<String,Object>();
		boolean isResAgain = true;
		for(String uuidCh : uuidList){
			if(uuid.equals(uuidCh)){
				isResAgain = false;
				break;
			}
		}
		//如果等于true的话就是第一次请求
		if(isResAgain){
			System.out.println("第一次请求");
			PlanTekServ.addCenterDate(uuid);
			synchronized(uuidList){
				uuidList.add(uuid); //把生成的uuid放到uuid链表里面
			}
			//开始查找航班
			map = PlanTekServ.findFilght(chufCity, daodCity, dateTime, 0);
			PlanTekServ.upCenterDate(uuid);
			CenterDate cted = PlanTekServ.findCenterDate(uuid);
			if("Yes".equals(cted.getIsgetmap())){
				map.clear(); //清空第一次请求的map
			}
		}else{
			System.out.println("第二次请求");
			PlanTekServ.upCenterDateSta(uuid);
			CenterDate cted = PlanTekServ.findCenterDate(uuid);
			if("waiting...".equals(cted.getStatus())){
				System.out.println("等待10秒");
				try {
					Thread.sleep(10000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				CenterDate cted2 = PlanTekServ.findCenterDate(uuid);
				if("waiting...".equals(cted2.getStatus())){
					System.out.println("真的等不了了，请求超时");
					map.put("msg", "2");
					map.put("listDate", null);
					map.put("zzListDate", null);
				}else if("overfinsh".equals(cted2.getStatus())){
					map = PlanTekServ.findFilght(chufCity, daodCity, dateTime, 0);
				}
			}else if("overfinsh".equals(cted.getStatus())){
				map = PlanTekServ.findFilght(chufCity, daodCity, dateTime, 0);
			}
		}
		
		synchronized(uuidList){
			for(int j = 0; j<uuidList.size(); j++){
		        if(uuid.equals(uuidList.get(j))){
		        	uuidList.remove(j);
		        	break;
		        }
		    }
		}
		
		System.out.println("最后返回的map："+map.toString());
		return map;
	}
	
	//查询往返的机票
	@RequestMapping("/find/planTekTo.action")
	@ResponseBody
	public Map<String, Object> planTekTo(String org, String dst, String date, String retDate, String uuidwf){
		System.out.println("开始查找往返："+org+","+dst+","+date+","+retDate+","+uuidwf);
		Map<String, Object> map = new HashMap<String, Object>();
		boolean isResAgain = true;
		for(String uuidCh : uuidListwf){
			if(uuidwf.equals(uuidCh)){
				isResAgain = false;
				break;
			}
		}
		if(isResAgain){
			System.out.println("往返第一次请求");
			//hcPropertiesDate.writeData(uuidwf+"_WF.properties", uuidwf, "waiting...");//创建临时存储文件
			PlanTekServ.addCenterDate(uuidwf);
			synchronized(uuidListwf){
				uuidListwf.add(uuidwf); //把生成的uuid放到uuid链表里面
			}
			System.out.println("=================开始处理去程航班1=====================");
			List<FlightInfo> wFlightInfo = PlanTekServ.findFilghtWf(org, dst, date, 1);
			wFlightInfo = PlanTekServ.doDateCity(wFlightInfo,org,dst);
			System.out.println("=================开始处理回程航班1=====================");
			List<FlightInfo> fFlightInfo = PlanTekServ.findFilghtWf(dst, org, retDate, 1);
			fFlightInfo = PlanTekServ.doDateCity(fFlightInfo,dst,org);
			if(wFlightInfo.size()==0&&fFlightInfo.size()==0){
				map.put("msg", "0");
				map.put("departAv", wFlightInfo);
				map.put("returnAv", fFlightInfo);
			}else{
				map.put("msg", "1");
				map.put("departAv", wFlightInfo);
				map.put("returnAv", fFlightInfo);
			}
			//hcPropertiesDate.writeData(uuidwf+"_WF.properties", uuidwf, "overfinsh");//修改properties文件的值为结束
			PlanTekServ.upCenterDate(uuidwf);
			CenterDate cted = PlanTekServ.findCenterDate(uuidwf);
			if("Yes".equals(cted.getIsgetmap())){
				map.clear(); //清空第一次请求的map
			}
			
		}else{
			System.out.println("往返第二次请求");
			PlanTekServ.upCenterDateSta(uuidwf);
			CenterDate cted = PlanTekServ.findCenterDate(uuidwf);
			//String mapValue = hcPropertiesDate.jsonHc(uuidwf+"_WF.properties", uuidwf);
			if("waiting...".equals(cted.getStatus())){
				System.out.println("等待15秒：往返");
				try {
					Thread.sleep(15000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				//String mapValue2 = hcPropertiesDate.jsonHc(uuidwf+"_WF.properties", uuidwf); //再次找一遍
				CenterDate cted2 = PlanTekServ.findCenterDate(uuidwf);
				if("waiting...".equals(cted2.getStatus())){
					map.put("msg", "2");
					map.put("departAv", null);
					map.put("returnAv", null);
				}else if("overfinsh".equals(cted2.getStatus())){
					System.out.println("=================开始处理去程航班2=====================");
					List<FlightInfo> wFlightInfo = PlanTekServ.findFilghtWf(org, dst, date, 1);
					wFlightInfo = PlanTekServ.doDateCity(wFlightInfo,org,dst);
					System.out.println("=================开始处理回程航班2=====================");
					List<FlightInfo> fFlightInfo = PlanTekServ.findFilghtWf(dst, org, retDate, 1);
					fFlightInfo = PlanTekServ.doDateCity(fFlightInfo,dst,org);
					if(wFlightInfo.size()==0&&fFlightInfo.size()==0){
						map.put("msg", "0");
						map.put("departAv", wFlightInfo);
						map.put("returnAv", fFlightInfo);
					}else{
						map.put("msg", "1");
						map.put("departAv", wFlightInfo);
						map.put("returnAv", fFlightInfo);
					}
				}
			}else if("overfinsh".equals(cted.getStatus())){
				System.out.println("=================开始处理去程航班3=====================");
				List<FlightInfo> wFlightInfo = PlanTekServ.findFilghtWf(org, dst, date, 1);
				wFlightInfo = PlanTekServ.doDateCity(wFlightInfo,org,dst);
				System.out.println("=================开始处理回程航班3=====================");
				List<FlightInfo> fFlightInfo = PlanTekServ.findFilghtWf(dst, org, retDate, 1);
				fFlightInfo = PlanTekServ.doDateCity(fFlightInfo,dst,org);
				if(wFlightInfo.size()==0&&fFlightInfo.size()==0){
					map.put("msg", "0");
					map.put("departAv", wFlightInfo);
					map.put("returnAv", fFlightInfo);
				}else{
					map.put("msg", "1");
					map.put("departAv", wFlightInfo);
					map.put("returnAv", fFlightInfo);
				}
			}
		}
		
		synchronized(uuidListwf){
			for(int j = 0; j<uuidListwf.size(); j++){
		        if(uuidwf.equals(uuidListwf.get(j))){
		        	uuidListwf.remove(j);
		        	break;
		        }
		     }
		}
		System.out.println("最终返回的数据："+map.toString());
		return map;
	}
	
	//根据uuid获取到航班的数据
	@RequestMapping("/find/byuuid.action")
	@ResponseBody
	public Map<String,Object> findByid(String uuid,String canbin){
		Map<String,Object> map = new HashMap<String,Object>();
		List<SeatInfoData> sinfo = PlanTekServ.findByUUID(uuid);
		List<SeatPriceData> spd = PlanTekServ.findByCanbin(sinfo.get(0).getOrgcity(),sinfo.get(0).getDstcity(),canbin,sinfo.get(0).getAirline());
		List<Insurance> bxCost = PlanTekServ.findByBx(); //保险价格
		List<kdCost> kdCost = PlanTekServ.kdCost();
		map.put("bxCost", bxCost);
		map.put("kdCost", kdCost);
		map.put("canbin", canbin);
		map.put("cost", spd.get(0).getOnewayPrice());
		//map.put("cost_test", PlanTekServ.pataFare(sinfo.get(0).getAirline(), canbin, sinfo.get(0).getOrgcity(), sinfo.get(0).getDstcity(), dateTime));
		map.put("dataObj", sinfo);
		return map;
	}
	
	//获取儿童和婴儿的运价（单个）
	@RequestMapping("/find/findBybb.action")
	@ResponseBody
	public List<PataFarePriceInfo> findBybb(String airline, String canbin, String org, String dst, String dateTime, String pstType){
		System.out.println("查找儿童或者婴儿票");
		try {
			List<PataFarePriceInfo> sdas = PlanTekServ.pataFare(airline, canbin, org, dst, dateTime, pstType);
			return sdas;
		} catch (Exception e) {}
		return null;
	}
	
	//获取儿童和婴儿的运价（多段个）
	@RequestMapping("/find/findBytwo.action")
	@ResponseBody
	public List<PataFarePriceInfo> findByTwo(String airline1, String canbin1, String org1, String dst1, String dateTime1, String airline2, String canbin2, String org2, String dst2, String dateTime2, String pstType){
		try {
			PataFareInfo pf1 = new PataFareInfo();
			pf1.setFlightNo(airline1);
			pf1.setCabin(canbin1);
			pf1.setDate(dateTime1);
			pf1.setOrg(org1);
			pf1.setDst(dst1);
			
			PataFareInfo pf2 = new PataFareInfo();
			pf2.setFlightNo(airline2);
			pf2.setCabin(canbin2);
			pf2.setDate(dateTime2);
			pf2.setOrg(org2);
			pf2.setDst(dst2);
			
			PataFareInfo[] pataFareInfos = new PataFareInfo[]{pf1,pf2};
			return new ECUtils().pataFare(pataFareInfos, pstType);
		} catch (Exception e) {}
		return null;
	}
	
	//根据uuid获取到航班的数据
	@RequestMapping("/find/byuuidTwo.action")
	@ResponseBody
	public Map<String,Object> findByidTwo(String uuid1,String uuid2,String canbin,String canbin2){
		Map<String,Object> map = new HashMap<String,Object>();
		List<Insurance> bxCost = PlanTekServ.findByBx(); //保险价格
		List<kdCost> kdCost = PlanTekServ.kdCost();
		map.put("bxCost", bxCost);
		map.put("kdCost", kdCost);
		for(int i=1; i<=2; i++){
			if(i==1){
				List<SeatInfoData> sinfo = PlanTekServ.findByUUID(uuid1);
				List<SeatPriceData> spd = PlanTekServ.findByCanbin(sinfo.get(0).getOrgcity(),sinfo.get(0).getDstcity(),canbin,sinfo.get(0).getAirline());
				map.put("canbin1", canbin);
				map.put("cost1", spd.get(0).getOnewayPrice());
				map.put("dataObj1", sinfo);
			}else if(i==2){
				List<SeatInfoData> sinfo = PlanTekServ.findByUUID(uuid2);
				List<SeatPriceData> spd = PlanTekServ.findByCanbin(sinfo.get(0).getOrgcity(),sinfo.get(0).getDstcity(),canbin2,sinfo.get(0).getAirline());
				map.put("canbin2", canbin2);
				map.put("cost2", spd.get(0).getOnewayPrice());
				map.put("dataObj2", sinfo);
			}
		}
		return map;
	}
	
	/*//查询往返的机票（另一种方法）
	@RequestMapping("/find/planTekToRe.action")
	@ResponseBody
	public Map<String, Object> planTekToRe(String org, String dst, String date, String retDate){
		System.out.println(org+", "+dst+", "+date+", "+retDate); 
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("departAv", PlanTekServ.reAvfilght(org,dst,date,retDate));
		map.put("returnAv", "");
		return map;
	}*/

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
