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
	private static Logger log = Logger.getLogger(PlanTekController.class);
	@Autowired
	private PlanTekService PlanTekServ;
	@Autowired
	private userOrderService OrderService;
	
	//之前用的  现在先放着（测试用的）
	@RequestMapping("/find/planTek.action")
	@ResponseBody
	public Map<String, Object> FindPlanTek(String chufCity,String daodCity,String cangW,String dateTime, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		session.setAttribute("qishiPlanCode", chufCity);
		session.setAttribute("daodPlanCode", daodCity);
		System.out.println(chufCity+", "+daodCity+", "+cangW+", "+dateTime);
		List<FlightInfo> fliL = PlanTekServ.findHB(chufCity, daodCity, null, dateTime, null, "true", null); //出发城市、到达城市、航空公司、出发时间、航班号、是否直达、是否有经停点
		
		//获得中转的链表
		/*fd_av af = new fd_av();
		if(newFlil != null && newFlil.size() > 0){
			for(FlightInfo zfli : newFlil){
				if((zfli.getOrgCity().equals(chufCity)||zfli.getDstCity().equals(daodCity))&&!(zfli.getOrgCity().equals(chufCity)&&zfli.getDstCity().equals(daodCity))){ //只保留中转的航班，剔除直达航班
					System.out.println("<<<<=====>>>> "+zfli.getOrgCity()+", "+zfli.getDstCity()+", "+af.getNextDate(dateTime, zfli.getDepTime(), Calendar.DATE, "yyyy-MM-dd")+", "+zfli.getAirCode()+", "+zfli.getFlightNo());
					zfli.setSeatList(af.seatInfo(zfli.getOrgCity(), zfli.getDstCity(), af.getNextDate(dateTime, zfli.getDepTime(), Calendar.DATE, "yyyy-MM-dd"), zfli.getAirCode(), zfli.getFlightNo()));
					zhongzFil.add(zfli);  //重构中转的链表
					System.out.println("中转航班："+zfli);
				}
			}
		}*/
		
		System.out.println("符合条件的航班："+fliL.size());
		List<FlightInfo> zhfliL = new ArrayList<FlightInfo>();
		if(fliL.size()==0){
			map.put("msg", 0);
		}else{
			map.put("msg", 1);
			map.put("listDate", fliL);
			map.put("zzListDate", zhfliL);
		}
		return map;
	}
	
	//查找航班的另一种方式（测试用的）
	@RequestMapping("/find/query.action")
	@ResponseBody
	public Map<String, Object> FindPek(String chufCity,String daodCity,String cangW,String dateTime){
		Map<String, Object> map = new HashMap<String, Object>();
		map = PlanTekServ.findflight(chufCity, daodCity, cangW, dateTime);
		map.put("msg", 1);
		List<FlightInfo> zhfliL = new ArrayList<FlightInfo>();
		map.put("zzListDate", zhfliL);
		return map;
	}
	

	//查找航班的又一种方式（正在用的）
	@RequestMapping("/find/OtherQuery.action")
	@ResponseBody
	public Map<String, Object> otherFindPek(String chufCity,String daodCity,String cangW,String dateTime){
		System.out.println("开始查询（出发城市："+chufCity+", 到达城市："+daodCity+", 到达时间："+dateTime+"）");
		Map<String, Object> map = new HashMap<String, Object>();
		List<SeatInfoData> avList = PlanTekServ.SreachSeat(chufCity,daodCity,dateTime);
		List<FlightInfo> flightInfo = new ArrayList<FlightInfo>();
		for(SeatInfoData avs : avList){
			List<SeatPriceData> spList = PlanTekServ.seachPrice(avs.getOrgcity(),avs.getDstcity(),dateTime); //一个航班查找一次才符合
			List<SeatInfo> seatList = new ArrayList<SeatInfo>(); // 航班座位信息
			FlightInfo finf = new FlightInfo();
			finf.setUuid(avs.getSignFilghtNum());
			finf.setAirCode(avs.getAirline().substring(0,2));
			finf.setArrTime(avs.getArriTime());
			finf.setDepTime(avs.getDepTime());
			finf.setDstCity(avs.getDstcity());
			finf.setOrgCity(avs.getOrgcity());
			finf.setFlightNo(avs.getAirline());
			finf.setPlaneStyle(avs.getPlanestyle());
			
			String cwNum = avs.getCangwei_data(); //舱位的数量
			String[] cwNum_Org = cwNum.split(","); 
			String cwIndex = avs.getCangwei_index(); //舱位的类别
			String[] cwIndex_Org = cwIndex.split(",");

			for(int i=0; i<cwIndex_Org.length; i++){
				SeatInfo seatInfo = new SeatInfo();
				String cwChiled = cwIndex_Org[i];
				String cwNumChild = cwNum_Org[i];
				seatInfo.setCangwei(cwChiled);
				seatInfo.setCangwei_data(cwNumChild);
				for(SeatPriceData spdata : spList){
					if(finf.getAirCode().equals(spdata.getAirline())&&cwChiled.equals(spdata.getCabin())){ //如果航空公司和舱位对得上。就说明查找到结果
						seatInfo.setBasicCabin(spdata.getBasicCabin());
						seatInfo.setOnewayPrice(spdata.getOnewayPrice());
						seatInfo.setRoundtripPrice((Double.parseDouble(spdata.getOnewayPrice())*2)+"");
					}
				}
				seatList.add(seatInfo);
			}
			finf.setSeatList(seatList);
			flightInfo.add(finf);
		}
		
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
		map = PlanTekServ.findByUUID(uuid,canbin);
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
