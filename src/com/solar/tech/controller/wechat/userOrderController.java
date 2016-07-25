package com.solar.tech.controller.wechat;

import java.util.HashMap;
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
import com.solar.tech.service.userOrderService;

@Controller
@RequestMapping("/userOrderController")
public class userOrderController {
	@Autowired
	private userOrderService OrderService;
	
	@RequestMapping("/add/order.action")
	@ResponseBody
	public Map<String, Object> addOrder(String ChufDate,String ChufTime,String ChufCity,String DaodCity,String DaodTime,String QishiPlan,String hangbanNum,String DaodPlan,String lishiTime,String CostPay,String LinkName,String Sex,String iDcaseType,String iDcase,String PhoneNum,String YiwaiBX,String YanwuBX,HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		userOrderInfo oderInfo = new userOrderInfo();
		oderInfo.setChufDate(ChufDate);
		oderInfo.setChufTime(ChufTime);
		oderInfo.setDaodTime(DaodTime);
		oderInfo.setChufCity(ChufCity);
		oderInfo.setDaodCity(DaodCity);
		oderInfo.setUserName((String) session.getAttribute("userName"));
		oderInfo.setQishiPlane(QishiPlan);
		oderInfo.setHangbanNum(hangbanNum);
		oderInfo.setDaodPlane(DaodPlan);
		oderInfo.setCuntTime(lishiTime);
		oderInfo.setCostMoney(CostPay);
		oderInfo.setLinkName(LinkName);
		oderInfo.setLinkPhoneNum(PhoneNum);
		oderInfo.setLinkSex(Sex); 
		oderInfo.setIDcase(iDcase);
		oderInfo.setIDcaseType(iDcaseType);
		oderInfo.setYiwaiBX(YiwaiBX);
		oderInfo.setYanwuBX(YanwuBX);
		String OrderNum=null;
		OrderNum = OrderService.createOrderNum("RDOD", 8);
		oderInfo.setOrderNum(OrderNum);
		oderInfo.setStutisPay("0");//未支付
		oderInfo.setTakePlane("0");//未登机
		
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
		s.setCabin("E");//舱位
		s.setDepartureDate("2017-01-31");//起飞日期，格式如：yyyy-MM-dd
		s.setDepartureTime("11:00");//起飞时间，格式如：HH:mm
		s.setActionCode("NN");//行动代码
		s.setType("HK");//航线类型(国内/国际)
		SegmentInfo[] segmentInfos = new SegmentInfo[]{s};
		
		//旅客组实体类
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
		
		//PnrResponse response = new ECUtils().booking(bookContact, segmentInfos, passengerInfos, "2017-01-30 09:00:00", null, osis, rmks, null, null, null);
		
		//System.out.println("预定的编号："+response.getPnrNo());
		//System.out.println(response.toJson());//返回的json数据
		int num=OrderService.addOrder(oderInfo);//保存信息到数据库
		if(num==1){
			System.out.println("数据插入成功");
			//map.put("planMsg", response.toJson());
		}else if(num==0){
			System.out.println("数据插入失败");
		}else{
			System.out.println("数据错误");
		}
		return map;
	}
}
