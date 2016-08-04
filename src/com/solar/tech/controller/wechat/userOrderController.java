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

import com.travelsky.sbeclient.obe.book.BookContact;
import com.travelsky.sbeclient.obe.book.OSIInfo;
import com.travelsky.sbeclient.obe.book.PassengerInfo;
import com.travelsky.sbeclient.obe.book.RMKInfo;
import com.travelsky.sbeclient.obe.book.SegmentInfo;
import com.travelsky.sbeclient.obe.response.PnrResponse;
import com.solar.tech.bean.entity.userOrderInfo;
import com.solar.tech.utils.ECUtils;
import com.solar.tech.utils.saveCost;
import com.solar.tech.service.userOrderService;

@Controller
@RequestMapping("/userOrderController")
public class userOrderController {
	@Autowired
	private userOrderService OrderService;
	
	@RequestMapping("/add/order.action")
	@ResponseBody
	public Map<String, Object> addOrder(String ChufDate,String ChufTime,String ChufCity,String DaodCity, String cabin, String DaodTime,String QishiPlan,String airCode, String hangbanNum,String DaodPlan,String lishiTime,String CostPay,String LinkName,String Sex,String iDcaseType,String iDcase,String PhoneNum,String YiwaiBX,String YanwuBX,HttpSession session){
		saveCost getCost = new saveCost();
		Map<String, Object> map = new HashMap<String, Object>();
		userOrderInfo oderInfo = new userOrderInfo();
		oderInfo.setChufDate(ChufDate);
		oderInfo.setChufTime(ChufTime);
		oderInfo.setDaodTime(DaodTime);
		oderInfo.setChufCity(ChufCity);
		oderInfo.setDaodCity(DaodCity);
		oderInfo.setCabin(cabin);
		oderInfo.setUserName((String) session.getAttribute("userName"));
		oderInfo.setOpenID((String) session.getAttribute("openId"));
		oderInfo.setQishiPlaneCode((String) session.getAttribute("qishiPlanCode"));//在查找订单中的方法就已经定义了 PlanTekController.java 中能找到
		oderInfo.setDaodPlaneCode((String) session.getAttribute("daodPlanCode"));//在查找订单中的方法就已经定义了 PlanTekController.java 中能找到
		oderInfo.setQishiPlane(QishiPlan);
		oderInfo.setHangbanNum(hangbanNum);
		oderInfo.setDaodPlane(DaodPlan);
		oderInfo.setCuntTime(lishiTime);
		//String lastpayCout=getCost.getpay("CAN", "PEK", ChufDate, airCode, hangbanNum, cabin, CostPay);
		//System.out.println("执行吧皮卡丘："+lastpayCout);
		oderInfo.setCostMoney(CostPay);
		oderInfo.setLinkName(LinkName);
		oderInfo.setLinkPhoneNum(PhoneNum);
		oderInfo.setLinkSex(Sex); 
		oderInfo.setIDcase(iDcase);
		oderInfo.setIDcaseType(iDcaseType);
		oderInfo.setYiwaiBX(YiwaiBX);
		oderInfo.setYanwuBX(YanwuBX);
		oderInfo.setAdminDel("0");//0代表不删除 1代表删除
		oderInfo.setStutisPay("0");//未支付
		oderInfo.setTakePlane("0");//未登机
		int MaxNum = Integer.parseInt(OrderService.fingMaxNum());
		oderInfo.setIntNum((MaxNum+1)+"");
		String maxOrderNum = OrderService.fingMaxOrderNum();
		String orderNum = OrderService.getNum("RDOD", maxOrderNum);//生成预约编号
		oderInfo.setOrderNum(orderNum); 
		
		//联系组实体类
		BookContact bookContact = new BookContact();
		bookContact.setCity("CAN");//城市
		bookContact.setContact("18729034712");//联系电话
		bookContact.setPsgId("Zhang/Hong");//旅客序号
		
		//航段组实体类
		SegmentInfo s = new SegmentInfo();
		s.setDeparture("CAN");//起飞城市
		s.setArrival("PEK");//到达城市
		s.setFlightNo("CZ3103");//航班号	
		s.setCabin("W");//舱位
		s.setDepartureDate("2017-01-31");//起飞日期，格式如：yyyy-MM-dd
		s.setDepartureTime("11:00");//起飞时间，格式如：HH:mm
		s.setActionCode("NN");//行动代码
		s.setType("HK");//航线类型(国内/国际)	
		SegmentInfo[] segmentInfos = new SegmentInfo[]{s};
		
		//旅客组实体类（是否可以添加多个旅客）
		PassengerInfo psg = new PassengerInfo();
		psg.setName("李四");//旅客姓名
		psg.setAge(22);//年龄
		psg.setGender("男"); //性别
		psg.setBirthDay("1991-01-02");//出生日期
		psg.setPsgType("ADT");//旅客类型  ADT 成人,CHD 儿童,INF 婴儿
		psg.setCertNo("612429199107214641");//证件号码
		psg.setCertType("NI");//证件类型PP,NI		
		PassengerInfo[] passengerInfos = new PassengerInfo[]{psg};
		
		//OSI组实体类 
		OSIInfo osi = new OSIInfo();
		//osi.setIdx("");
		osi.setAirCode("CZ");//航空公司代码
		osi.setOsi("CTCT18729034712");//OSI内容
		OSIInfo[] osis = new OSIInfo[]{osi};

		//RMK组实体类
		RMKInfo rmk = new RMKInfo();
		rmk.setPsgName("李四");//旅客姓名
		rmk.setRmkType("");//RMK类型
		rmk.setRmkInfo("rmk 内容");//RMK内容
		RMKInfo[] rmks = new RMKInfo[]{rmk};
		
		//以下代码在开发的过程中请不要取消注释掉，因为会产生真实的订票系统。需要付款的
		/*PnrResponse response = new ECUtils().booking(bookContact, segmentInfos, passengerInfos, "2017-01-30 09:00:00", null, osis, rmks, null, null, null);
		System.out.println("----------------以下信息是订票成功之后返回的数据--------------");
		System.out.println("预定的编号："+response.getPnrNo());
		System.out.println("起飞城市："+response.getSegList().get(0).getDeparture());
		System.out.println("到达城市："+response.getSegList().get(0).getArrival());
		System.out.println("航班号："+response.getSegList().get(0).getFlightNo());
		System.out.println("舱位级别："+response.getSegList().get(0).getCabin());
		System.out.println("起飞日期："+response.getSegList().get(0).getDepartureDate());
		System.out.println("起飞时间："+response.getSegList().get(0).getDepartureTime());
		System.out.println("到达日期："+response.getSegList().get(0).getArrivalDate());
		System.out.println("到达时间："+response.getSegList().get(0).getArrivalTime());
		System.out.println("行动代码："+response.getSegList().get(0).getActionCode());
		System.out.println("航线类型："+response.getSegList().get(0).getType());
		System.out.println("-----------------------到这信息全部返回成功-------------------");*/
		//System.out.println(response.toJson());//返回的json数据		
		
		//oderInfo.setPNR(response.getPnrNo());//将获得的编号保存到数据库中
		oderInfo.setGetTeickTime("2017-01-30");//出票期限
		
		//这个if是只有在中航信系统生成预定编号之后才能存到我们的数据库中。不然不能存
		int num=0;
		//if(response.getPnrNo()==""||response.getPnrNo().equals("")||response.getPnrNo()==null){
			//System.out.println("订票失败");
		//}else{
			num=OrderService.addOrder(oderInfo);//保存信息到数据库		
		//}
		if(num==1){
			System.out.println("数据插入成功");
			//map.put("planMsg", response.toJson());
		}else if(num==0){
			System.out.println("数据插入失败");
		}else{
			System.out.println("数据错误");
		}
		//new ECUtils().cancelPnr(response.getPnrNo());//删除中航信系统中刚刚预定的数据
		return map;
	}
	
	/**
	 * @title updateCorder 修改出票时间
	 * @param pnrNo
	 * @param tktl(新出票的时间) yyyy-MM-dd HH:mm:ss
	 * @return
	 */
	//修改出票时限
	@RequestMapping("/update/Corder.action")
	@ResponseBody
	public Map<String, Object> updateCorder(String pnrNo, String tktl, String uuid, String orderNum){
		Map<String, Object> map = new HashMap<String, Object>();
		//boolean YesOrNo = new ECUtils().tktl("JZCBY9", tktl);//修改出票时间
		//if(YesOrNo){
			userOrderInfo uinfo = new userOrderInfo();
			uinfo.setGetTeickTime(tktl);
			uinfo.setID(uuid);
			uinfo.setOrderNum(orderNum);
			int i=OrderService.updateGetTeickTime(uinfo);
			if(i==1){
				map.put("msg", 1);
				System.out.println("出票时限修改成功");
			}else{
				map.put("msg", 0);
				System.out.println("出票时限修改失败");
			}
		//}
		return map;
	}
	
	//修改航段信息（未付款的时候，付款的时候就只能改舱了）
	@RequestMapping("/update/changeAirSegment.action")
	@ResponseBody
	public Map<String, Object> changeAirSegment(String pnrNo, String fltNoOld, String fltDateOld ,String orderNum, String departure, String arrival, String flightNo ,String cabin, String departureDate, String DepartureTime, String actionCode){
		Map<String, Object> map = new HashMap<String, Object>();
		//航段组实体类
		SegmentInfo s = new SegmentInfo();
		s.setDeparture(departure);//起飞城市
		s.setArrival(arrival);//到达城市
		s.setFlightNo(flightNo);//航班号	
		s.setCabin(cabin);//舱位
		s.setDepartureDate(departureDate);//起飞日期，格式如：yyyy-MM-dd
		s.setDepartureTime(DepartureTime);//起飞时间，格式如：HH:mm
		s.setActionCode("NN");//行动代码
		s.setType("HK");//航线类型(国内/国际)
		SegmentInfo[] segmentInfos = new SegmentInfo[]{s};
		//boolean YesOrNo = new ECUtils().changeAirSegment(pnrNo, fltNoOld, fltDateOld, segmentInfos);//执行中航信修改航段方法
		//if(YesOrNo){
			userOrderInfo uinfo = new userOrderInfo();
			uinfo.setPNR(pnrNo);
			uinfo.setOrderNum(orderNum);
			uinfo.setChufCity(departure);
			uinfo.setDaodCity(arrival);
			uinfo.setHangbanNum(flightNo);
			uinfo.setCabin(cabin);
			uinfo.setChufDate(departureDate);
			uinfo.setChufTime(DepartureTime);
			uinfo.setActionCode("NN");
			int i = OrderService.changeAirSegment(uinfo);
			if(i==1){
				map.put("msg", 1);
				System.out.println("修改航段成功");
			}else{
				map.put("msg", 0);
				System.out.println("修改航段失败");
			}
		//}
		return map;
	}
	
	//修改旅客证件
	@RequestMapping("/update/changeCertificate.action")
	@ResponseBody
	public Map<String, Object> changeCertificate(String pnrNo, String orderNum, String username, String userage, String usergender, String userBirth, String usertype, String userIDnum, String userIDtype){
		Map<String, Object> map = new HashMap<String, Object>();		
		PassengerInfo psg = new PassengerInfo();
		psg.setName(username);//旅客姓名
		int ageNum = Integer.parseInt(userage);
		psg.setAge(ageNum);//年龄
		psg.setGender(usergender); //性别
		psg.setBirthDay(userBirth);//出生日期yyyy-mm-dd
		psg.setPsgType(usertype);//旅客类型  ADT 成人,CHD 儿童,INF 婴儿
		psg.setCertNo(userIDnum);//证件号码
		psg.setCertType(userIDtype);//证件类型(NI 身份证,PP 护照,ID其他证件)
		PassengerInfo[] passengerInfos = new PassengerInfo[]{psg};		
		//boolean YesOrNo = new ECUtils().changeCertificate(pnrNo, passengerInfos);//执行中航信修改航段方法
		//if(YesOrNo){
			userOrderInfo uinfo = new userOrderInfo();
			uinfo.setOrderNum(orderNum);
			uinfo.setPNR(pnrNo);
			uinfo.setLinkName(username);
			uinfo.setAge(userage);
			uinfo.setLinkSex(usergender);
			uinfo.setBirthday(userBirth);
			uinfo.setPsgType(usertype);
			uinfo.setIDcase(userIDnum);
			uinfo.setIDcaseType(userIDtype);
			int i = OrderService.changeCertificate(uinfo);
			if(i==1){
				map.put("msg", 1);
				System.out.println("修改乘机人信息成功");
			}else{
				map.put("msg", 0);
				System.out.println("修改乘机人信息失败");
			}
		//}
		return map;
	}
	
	//改签（已付款的时候）我的订单中的 同舱改期功能调用的方法
	@RequestMapping("/update/changeDate.action")
	@ResponseBody
	public Map<String, Object> updateChufDate(String pnrNo, String orderNum, String fltNoOld, String fltDateOld, String fltNoNew, String fltDateNew, String chufTime, String daodTime){
		Map<String, Object> map = new HashMap<String, Object>();
		
		System.out.println(pnrNo+"/"+orderNum+"/"+fltNoOld+"/"+fltDateOld+"/"+fltNoNew+"/"+fltDateNew+"/"+chufTime+"/"+daodTime);
		//boolean YesOrNo = new ECUtils().changeTKTAirSegment(pnrNo,fltNoOld,fltDateOld,fltNoNew,fltDateNew);//执行中航信同舱改期的方法
		//if(YesOrNo){
			userOrderInfo uinfo = new userOrderInfo();
			uinfo.setPNR(pnrNo);
			uinfo.setOrderNum(orderNum);
			uinfo.setHangbanNum(fltNoNew); 
			uinfo.setChufDate(fltDateNew);
			uinfo.setChufTime(chufTime);
			uinfo.setDaodTime(daodTime);
			int i = OrderService.updateChufDateSer(uinfo);
			if(i==1){
				map.put("msg", 1);
				System.out.println("改签成功");				
			}else{
				map.put("msg", 0);
				System.out.println("改签失败");		
			}
		//}
		return map;
	}
	
	//删除订单同时得删除中航信中的订单
	@RequestMapping("/delete/order.action")
	@ResponseBody
	public Map<String, Object> deleteOrder(String pnrNo, String orderNum, String ID){
		Map<String, Object> map = new HashMap<String, Object>();
		//boolean YesOrNo = new ECUtils().cancelPnr(pnrNo); //执行中航信删除订单的方法
		//if(YesOrNo){
			int i = OrderService.deleteOrder(ID, orderNum);
			if(i==1){
				map.put("msg",1);
				System.out.println("订单删除成功");
			}else{
				map.put("msg",0);
				System.out.println("订单删除出错");
			}
		//}
		return map;
	}
	
	//加载该用户的全部订单
	@RequestMapping("/loading/order.action")
	@ResponseBody
	public Map<String, Object> loadOrder(HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		/*session.setAttribute("openId", "oI6f2wDvj5glUkde-sQBTSyoyyZ4");
		session.setAttribute("userName", "kkk");*/
		String openId = (String) session.getAttribute("openId");
		String userName = (String) session.getAttribute("userName");
		List<userOrderInfo> orderList = OrderService.loadOrder(userName,openId);
		if(orderList.size()>0){
			map.put("orderList",orderList);
			System.out.println("数据不为空");
			map.put("msg",1);
		}else{
			map.put("msg",0);
			System.out.println("数据为空");
		}
		return map;
	}
	
	//反馈信息到用户修改的输入框里面
	@RequestMapping("/loading/userMsg.action")
	@ResponseBody
	public Map<String, Object> loaduserMsg(String orderNum, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		List<userOrderInfo> orderList = OrderService.loadUserMsg(orderNum);
		if(orderList.size()>0){
			map.put("orderList",orderList);
			map.put("msg",1);
		}else{
			map.put("msg",0);
			System.out.println("该订单的用户资料为空");
		}
		return map;
	}
	
}
