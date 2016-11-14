package com.solar.tech.controller.wechat;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

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
	public Map<String, Object> addOrder(String ChufDate,String ChufTime,String ChufCity,String DaodCity, String cabin, String DaodTime,String QishiPlan,String airCode, String hangbanNum,String DaodPlan,String lishiTime,String CostPay,String LinkName,String Sex,String iDcaseType,String iDcase,String PhoneNum,String YiwaiBX,String YanwuBX,String birthday,String menType,String age, String chufCode, String daodCode, HttpSession session){
		saveCost getCost = new saveCost();
		Map<String, Object> map = new HashMap<String, Object>();
		userOrderInfo oderInfo = new userOrderInfo();
		oderInfo.setChufDate(ChufDate);
		oderInfo.setChufTime(ChufTime);
		oderInfo.setDaodTime(DaodTime);
		//oderInfo.setDaodCity(DaodCity);
		oderInfo.setCabin(cabin);
		oderInfo.setUserName((String) session.getAttribute("userName"));
		oderInfo.setOpenID((String) session.getAttribute("openId"));
		oderInfo.setQishiPlaneCode((String) session.getAttribute("qishiPlanCode"));
		oderInfo.setDaodPlaneCode((String) session.getAttribute("daodPlanCode"));
		oderInfo.setChufCity(ChufCity);
		oderInfo.setDaodCity(DaodCity);
		oderInfo.setQishiPlane(QishiPlan);
		oderInfo.setHangbanNum(hangbanNum);
		oderInfo.setDaodPlane(DaodPlan);
		oderInfo.setCuntTime(lishiTime);
		//String lastpayCout=getCost.getpay("CAN", "PEK", ChufDate, airCode, hangbanNum, cabin, CostPay ,"true", "true");
		//System.out.println("执行吧皮卡丘："+lastpayCout);
		oderInfo.setCostMoney(CostPay);
		oderInfo.setLinkName(LinkName);
		oderInfo.setLinkPhoneNum(PhoneNum);
		oderInfo.setLinkSex(Sex); 
		oderInfo.setBirthday(birthday);
		oderInfo.setAge(age);//乘机人年龄
		oderInfo.setPsgType(menType);//乘机人类型
		oderInfo.setIDcase(iDcase);
		oderInfo.setIDcaseType(iDcaseType);
		oderInfo.setYiwaiBX(YiwaiBX);
		oderInfo.setYanwuBX(YanwuBX);
		oderInfo.setAirCode(airCode);//航空公司的二字码 
		oderInfo.setAdminDel("0");//0代表不删除 1代表删除
		oderInfo.setStutisPay("0");//未支付
		oderInfo.setTakePlane("0");//未登机
		String maxNum = OrderService.fingMaxNum();
		int MaxNum=0;
		if(maxNum==null||maxNum.equals("")||maxNum.equals(" ")){
			MaxNum = 0;
		}else{
			MaxNum = Integer.parseInt(maxNum);
		}
		oderInfo.setIntNum((MaxNum+1)+"");
		String maxOrderNum = OrderService.fingMaxOrderNum();
		String orderNum = OrderService.getNum("RDOD", maxOrderNum);//生成预约编号
		oderInfo.setOrderNum(orderNum);
		//System.out.println("===>>>>预约编号："+oderInfo.getOrderNum());
		System.out.println(
				"出发日期："+oderInfo.getChufDate()+
				"，出发时间："+oderInfo.getChufTime()+
				"，到达时间："+oderInfo.getDaodTime()+
				"，出发城市："+oderInfo.getChufCity()+
				"，到达城市："+oderInfo.getDaodCity()+
				"，舱位："+oderInfo.getCabin()+
				"，用户名："+oderInfo.getUserName()+
				"，openId："+oderInfo.getOpenID()+
				"，起始机场的三字码："+oderInfo.getQishiPlaneCode()+
				"，到达机场的三字码："+oderInfo.getDaodPlaneCode()+
				"，起始机场："+oderInfo.getQishiPlane()+
				"，航班号："+oderInfo.getHangbanNum()+
				"，到达机场："+oderInfo.getDaodPlane()+
				"，历时多长时间："+oderInfo.getCuntTime()+
				"，付款金额："+oderInfo.getCostMoney()+
				"，联系人："+oderInfo.getLinkName()+
				"，联系电话："+oderInfo.getLinkPhoneNum()+
				"，联系人性别："+oderInfo.getLinkSex()+
				"，出生时间："+oderInfo.getBirthday()+
				"，乘机人年龄："+oderInfo.getAge()+
				"，乘机人类型："+oderInfo.getPsgType()+
				"，联系人证件号码："+oderInfo.getIDcase()+
				", 联系人证件类型："+oderInfo.getIDcaseType()+
				"，是否购买意外保险："+oderInfo.getYiwaiBX()+
				"，是否购买延误保险："+oderInfo.getYanwuBX()+
				"，航空公司："+oderInfo.getAirCode()+
				"，订单编号："+oderInfo.getOrderNum()); 
		//联系组实体类
		BookContact bookContact = new BookContact();
		bookContact.setCity(oderInfo.getQishiPlaneCode());//城市
		bookContact.setContact(oderInfo.getLinkPhoneNum());//联系电话
		bookContact.setPsgId("Zhang/Hong");//旅客序号
		
		//航段组实体类
		SegmentInfo s = new SegmentInfo();
		s.setDeparture(oderInfo.getQishiPlaneCode());//起飞城市
		s.setArrival(oderInfo.getDaodPlaneCode());//到达城市
		s.setFlightNo(oderInfo.getHangbanNum());//航班号	
		s.setCabin(oderInfo.getCabin());//舱位
		s.setDepartureDate(oderInfo.getChufDate());//起飞日期，格式如：yyyy-MM-dd
		s.setDepartureTime(oderInfo.getChufTime());//起飞时间，格式如：HH:mm
		s.setActionCode("NN");//行动代码
		s.setType("HK");//航线类型(国内/国际)	
		SegmentInfo[] segmentInfos = new SegmentInfo[]{s};
		
		//旅客组实体类（是否可以添加多个旅客）
		PassengerInfo psg = new PassengerInfo();
		psg.setName(oderInfo.getLinkName());//旅客姓名
		psg.setAge(Integer.parseInt(oderInfo.getAge()));//年龄
		psg.setGender(oderInfo.getLinkSex()); //性别
		psg.setBirthDay(oderInfo.getBirthday());//出生日期
		psg.setPsgType(oderInfo.getPsgType());//旅客类型  ADT 成人,CHD 儿童,INF 婴儿
		psg.setCertNo(oderInfo.getIDcase());//证件号码
		psg.setCertType(oderInfo.getIDcaseType());//证件类型PP,NI		
		PassengerInfo[] passengerInfos = new PassengerInfo[]{psg};
		
		//OSI组实体类 
		OSIInfo osi = new OSIInfo();
		//osi.setIdx("");
		osi.setAirCode(oderInfo.getAirCode());//航空公司代码
		osi.setOsi("CTCT18729034712");//OSI内容
		OSIInfo[] osis = new OSIInfo[]{osi};

		//RMK组实体类
		RMKInfo rmk = new RMKInfo();
		rmk.setPsgName(oderInfo.getLinkName());//旅客姓名
		rmk.setRmkType("");//RMK类型
		rmk.setRmkInfo("rmk 仁德机票出售中心");//RMK内容
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
			map.put("c", orderNum);
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
	 * 预定中转和往返航班
	 */
	@RequestMapping("/add/zrorder.action")
	@ResponseBody
	public int addzhz_res(String jsStr,String firstFild,String sconedFild,HttpSession session){
		JSONObject jsonObject=JSONObject.fromObject(jsStr);
        firstFild = jsonObject.get("firstFild")+"";
        sconedFild = jsonObject.get("sconedFild")+"";
        firstFild = firstFild.substring(1,firstFild.length()-1);
        sconedFild = sconedFild.substring(1,sconedFild.length()-1);
        JSONObject firstFildlist = JSONObject.fromObject(firstFild);
        JSONObject sconedFildlist = JSONObject.fromObject(sconedFild);
        userOrderInfo oderInfo = new userOrderInfo();
        String depcityCode1 = firstFildlist.get("depcityCode1")+"";
        String arrcityCode1 = firstFildlist.get("arrcityCode1")+"";
		oderInfo.setChufDate(firstFildlist.get("ChufDate")+"");
		oderInfo.setChufTime(firstFildlist.get("ChufTime")+"");
		oderInfo.setDaodTime(firstFildlist.get("DaodTime")+"");
		oderInfo.setCabin(firstFildlist.get("cangweiType")+"");
		oderInfo.setUserName((String) session.getAttribute("userName"));
		oderInfo.setOpenID((String) session.getAttribute("openId"));
		oderInfo.setQishiPlaneCode(depcityCode1); //起始机场的三字码
		oderInfo.setDaodPlaneCode(arrcityCode1); //到达机场的三字码
		oderInfo.setChufCity(firstFildlist.get("ChufCity")+""); //起始城市
		oderInfo.setDaodCity(firstFildlist.get("DaodCity")+""); //到达城市
		oderInfo.setQishiPlane(firstFildlist.get("QishiPlan")+"");
		oderInfo.setHangbanNum(firstFildlist.get("hangbanNum")+"");
		oderInfo.setDaodPlane(firstFildlist.get("DaodPlan")+"");
		oderInfo.setCuntTime(firstFildlist.get("lishiTime")+"");
		oderInfo.setCostMoney(firstFildlist.get("CostPay")+"");
		oderInfo.setLinkName(firstFildlist.get("LinkName")+"");
		oderInfo.setLinkPhoneNum(firstFildlist.get("PhoneNum")+"");
		oderInfo.setLinkSex(firstFildlist.get("Sex")+""); 
		oderInfo.setBirthday(firstFildlist.get("birthDay")+"");
		oderInfo.setAge(firstFildlist.get("age")+"");//乘机人年龄
		oderInfo.setPsgType(firstFildlist.get("menType")+"");//乘机人类型
		oderInfo.setIDcase(firstFildlist.get("iDcase")+"");
		oderInfo.setIDcaseType(firstFildlist.get("iDcaseType")+"");
		oderInfo.setYiwaiBX(firstFildlist.get("YiwaiBX")+"");
		oderInfo.setYanwuBX(firstFildlist.get("YanwuBX")+"");
		oderInfo.setAirCode(firstFildlist.get("airCode")+"");//航空公司的二字码 
		oderInfo.setAdminDel("0");//0代表不删除 1代表删除
		oderInfo.setStutisPay("0");//未支付
		oderInfo.setTakePlane("0");//未登机
		String maxNum = OrderService.fingMaxNum();
		int MaxNum=0;
		if(maxNum==null||maxNum.equals("")||maxNum.equals(" ")){
			MaxNum = 0;
		}else{
			MaxNum = Integer.parseInt(maxNum);
		}
		oderInfo.setIntNum((MaxNum+1)+"");
		String maxOrderNum = OrderService.fingMaxOrderNum();
		String orderNum = OrderService.getNum("RDOD", maxOrderNum);//生成预约编号
		oderInfo.setOrderNum(orderNum);
		
		//联系组实体类
		BookContact bookContact = new BookContact();
		bookContact.setCity(oderInfo.getQishiPlaneCode());//城市
		bookContact.setContact(oderInfo.getLinkPhoneNum());//联系电话
		bookContact.setPsgId("Zhang/Hong");//旅客序号
				
		//航段组实体类
		SegmentInfo s = new SegmentInfo();
		s.setDeparture(oderInfo.getQishiPlaneCode());//起飞城市
		s.setArrival(oderInfo.getDaodPlaneCode());//到达城市
		s.setFlightNo(oderInfo.getHangbanNum());//航班号	
		s.setCabin(oderInfo.getCabin());//舱位
		s.setDepartureDate(oderInfo.getChufDate());//起飞日期，格式如：yyyy-MM-dd
		s.setDepartureTime(oderInfo.getChufTime());//起飞时间，格式如：HH:mm
		s.setActionCode("NN");//行动代码
		s.setType("HK");//航线类型(国内/国际)	
		SegmentInfo[] segmentInfos = new SegmentInfo[]{s};
				
		//旅客组实体类（是否可以添加多个旅客）
		PassengerInfo psg = new PassengerInfo();
		psg.setName(oderInfo.getLinkName());//旅客姓名
		psg.setAge(Integer.parseInt(oderInfo.getAge()));//年龄
		psg.setGender(oderInfo.getLinkSex()); //性别
		psg.setBirthDay(oderInfo.getBirthday());//出生日期
		psg.setPsgType(oderInfo.getPsgType());//旅客类型  ADT 成人,CHD 儿童,INF 婴儿
		psg.setCertNo(oderInfo.getIDcase());//证件号码
		psg.setCertType(oderInfo.getIDcaseType());//证件类型PP,NI		
		PassengerInfo[] passengerInfos = new PassengerInfo[]{psg};
				
		//OSI组实体类 
		OSIInfo osi = new OSIInfo();
		//osi.setIdx("");
		osi.setAirCode(oderInfo.getAirCode());//航空公司代码
		osi.setOsi("CTCT18729034712");//OSI内容
		OSIInfo[] osis = new OSIInfo[]{osi};

		//RMK组实体类
		RMKInfo rmk = new RMKInfo();
		rmk.setPsgName(oderInfo.getLinkName());//旅客姓名
		rmk.setRmkType("");//RMK类型
		rmk.setRmkInfo("rmk 仁德机票出售中心");//RMK内容
		RMKInfo[] rmks = new RMKInfo[]{rmk};
		
		//开始在中信航系统产生订票的订单
		//PnrResponse response = new ECUtils().booking(bookContact, segmentInfos, passengerInfos, "2017-01-30 09:00:00", null, osis, rmks, null, null, null);
		//if(response.getPnrNo()==""||response.getPnrNo().equals("")||response.getPnrNo()==null){
		//	System.out.println("中信航第一段航班订票失败 userOrderController.java");
		//	return 0;
		//}else{
			int num=OrderService.addOrder(oderInfo);
			if(num==1){ //第一航班入库成功之后再将第二航班入库
		        String depcityCode2 = sconedFildlist.get("depcityCode2")+"";
		        String arrcityCode2 = sconedFildlist.get("arrcityCode2")+"";
				oderInfo.setChufDate(sconedFildlist.get("ChufDate")+"");
				oderInfo.setChufTime(sconedFildlist.get("ChufTime")+"");
				oderInfo.setDaodTime(sconedFildlist.get("DaodTime")+"");
				oderInfo.setCabin(sconedFildlist.get("cangweiType")+"");
				oderInfo.setUserName((String) session.getAttribute("userName"));
				oderInfo.setOpenID((String) session.getAttribute("openId"));
				oderInfo.setQishiPlaneCode(depcityCode2); //起始机场的三字码
				oderInfo.setDaodPlaneCode(arrcityCode2); //到达机场的三字码
				oderInfo.setChufCity(sconedFildlist.get("ChufCity")+""); //起始城市
				oderInfo.setDaodCity(sconedFildlist.get("DaodCity")+""); //到达城市
				oderInfo.setQishiPlane(sconedFildlist.get("QishiPlan")+"");
				oderInfo.setHangbanNum(sconedFildlist.get("hangbanNum")+"");
				oderInfo.setDaodPlane(sconedFildlist.get("DaodPlan")+"");
				oderInfo.setCuntTime(sconedFildlist.get("lishiTime")+"");
				oderInfo.setCostMoney(sconedFildlist.get("CostPay")+"");
				oderInfo.setLinkName(sconedFildlist.get("LinkName")+"");
				oderInfo.setLinkPhoneNum(sconedFildlist.get("PhoneNum")+"");
				oderInfo.setLinkSex(sconedFildlist.get("Sex")+""); 
				oderInfo.setBirthday(sconedFildlist.get("birthDay")+"");
				oderInfo.setAge(sconedFildlist.get("age")+"");//乘机人年龄
				oderInfo.setPsgType(sconedFildlist.get("menType")+"");//乘机人类型
				oderInfo.setIDcase(sconedFildlist.get("iDcase")+"");
				oderInfo.setIDcaseType(sconedFildlist.get("iDcaseType")+"");
				oderInfo.setYiwaiBX(sconedFildlist.get("YiwaiBX")+"");
				oderInfo.setYanwuBX(sconedFildlist.get("YanwuBX")+"");
				oderInfo.setAirCode(sconedFildlist.get("airCode")+"");//航空公司的二字码 
				oderInfo.setAdminDel("0");//0代表不删除 1代表删除
				oderInfo.setStutisPay("0");//未支付
				oderInfo.setTakePlane("0");//未登机
				maxNum = OrderService.fingMaxNum();
				MaxNum=0;
				if(maxNum==null||maxNum.equals("")||maxNum.equals(" ")){
					MaxNum = 0;
				}else{
					MaxNum = Integer.parseInt(maxNum);
				}
				oderInfo.setIntNum((MaxNum+1)+"");
				maxOrderNum = OrderService.fingMaxOrderNum();
				orderNum = OrderService.getNum("RDOD", maxOrderNum);//生成预约编号
				oderInfo.setOrderNum(orderNum);
				
				//联系组实体类
				BookContact bookContact2 = new BookContact();
				bookContact2.setCity(oderInfo.getQishiPlaneCode());//城市
				bookContact2.setContact(oderInfo.getLinkPhoneNum());//联系电话
				bookContact2.setPsgId("Zhang/Hong");//旅客序号
						
				//航段组实体类
				SegmentInfo s2 = new SegmentInfo();
				s2.setDeparture(oderInfo.getQishiPlaneCode());//起飞城市
				s2.setArrival(oderInfo.getDaodPlaneCode());//到达城市
				s2.setFlightNo(oderInfo.getHangbanNum());//航班号	
				s2.setCabin(oderInfo.getCabin());//舱位
				s2.setDepartureDate(oderInfo.getChufDate());//起飞日期，格式如：yyyy-MM-dd
				s2.setDepartureTime(oderInfo.getChufTime());//起飞时间，格式如：HH:mm
				s2.setActionCode("NN");//行动代码
				s2.setType("HK");//航线类型(国内/国际)	
				SegmentInfo[] segmentInfos2 = new SegmentInfo[]{s2};
						
				//旅客组实体类（是否可以添加多个旅客）
				PassengerInfo psg2 = new PassengerInfo();
				psg2.setName(oderInfo.getLinkName());//旅客姓名
				psg2.setAge(Integer.parseInt(oderInfo.getAge()));//年龄
				psg2.setGender(oderInfo.getLinkSex()); //性别
				psg2.setBirthDay(oderInfo.getBirthday());//出生日期
				psg2.setPsgType(oderInfo.getPsgType());//旅客类型  ADT 成人,CHD 儿童,INF 婴儿
				psg2.setCertNo(oderInfo.getIDcase());//证件号码
				psg2.setCertType(oderInfo.getIDcaseType());//证件类型PP,NI		
				PassengerInfo[] passengerInfos2 = new PassengerInfo[]{psg2};
						
				//OSI组实体类 
				OSIInfo osi2 = new OSIInfo();
				//osi.setIdx("");
				osi.setAirCode(oderInfo.getAirCode());//航空公司代码
				osi.setOsi("CTCT18729034712");//OSI内容
				OSIInfo[] osis2 = new OSIInfo[]{osi2};

				//RMK组实体类
				RMKInfo rmk2 = new RMKInfo();
				rmk2.setPsgName(oderInfo.getLinkName());//旅客姓名
				rmk2.setRmkType("");//RMK类型
				rmk2.setRmkInfo("rmk 仁德机票出售中心");//RMK内容
				RMKInfo[] rmks2 = new RMKInfo[]{rmk2};
				
				//开始在中信航系统产生订票的订单
				//PnrResponse response2 = new ECUtils().booking(bookContact2, segmentInfos2, passengerInfos2, "2017-01-30 09:00:00", null, osis2, rmks2, null, null, null);
				//if(response2.getPnrNo()==""||response2.getPnrNo().equals("")||response2.getPnrNo()==null){
				//	System.out.println("中信航第二段航班订票失败 userOrderController.java"); 
					//return 0;
				//}else{
					num=OrderService.addOrder(oderInfo);
					if(num==1){
						return 1;
					}else{
						return 0;
					}
				//}
			}else{
				return 0;
			}
			
		//}
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
		session.setAttribute("userName", "ttt");*/ 
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
