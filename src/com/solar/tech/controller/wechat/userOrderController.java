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
		System.out.println((String) session.getAttribute("openId"));
		oderInfo.setOpenID((String) session.getAttribute("openId"));
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
		oderInfo.setStutisPay("0");//未支付
		oderInfo.setTakePlane("0");//未登机
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
		//这个if是只有在中航信系统生成预定编号之后才能存到我们的数据库中。不然不能存
		int num=0;
		//if(response.getPnrNo()==""||response.getPnrNo().equals("")||response.getPnrNo()==null){
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
}
