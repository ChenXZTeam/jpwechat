package com.solar.tech.controller.wechat;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.FilghUser;
import com.solar.tech.bean.InvitationCode;
import com.solar.tech.bean.MessgesAlert;
import com.solar.tech.bean.VisaOrder;
import com.solar.tech.bean.entity.LinkMan;
import com.solar.tech.bean.entity.RD_wechatUser;
import com.solar.tech.bean.entity.SeatInfoData;
import com.solar.tech.bean.entity.tpRecords;
import com.solar.tech.bean.entity.userOrderInfo;
import com.solar.tech.service.PlanTekService;
import com.solar.tech.service.TpRecordsServices;
import com.solar.tech.service.userOrderService;
import com.solar.tech.utils.ECUtils;

@Controller
@RequestMapping("/userOrderController")
public class userOrderController {
	@Autowired
	private userOrderService OrderService;
	@Autowired
	private PlanTekService PlanTekServ;
	@Autowired
	private TpRecordsServices tprecords;	
	
	/**
	 * 来自用户自己新建的
	 * @param num
	 * @return
	 */
	@RequestMapping("/addInfoForUser.action")
	@ResponseBody
	public int addInfoForUser(LinkMan lma,HttpSession session){
		try {
			String userName = (String) session.getAttribute("userName"); 
			String openID = (String) session.getAttribute("openId");
			String phoneNumber = (String) session.getAttribute("phoneNumber"); 
			/*String userName = "ttt"; 
			String openID = "oI6f2wDvj5glUkde-sQBTSyoyyZ4";
			String phoneNumber = "15799024022"; */
			lma.setUserNamePhone(phoneNumber);
			lma.setOpenID(openID);
			lma.setUserName(userName);
			lma.setCreateTime(new Timestamp(new Date().getTime()));
			List<LinkMan> lman = OrderService.isRepeat(lma.getCaseNum(),userName);
			if(lman.size()>0){ //说明重复了
				return 2;
			}
			OrderService.addLinkman(lma);
			return 1;
		} catch (Exception e) {
			return 0;
		}
		
	}
	
	@RequestMapping("/add/order.action")
	@ResponseBody
	public Map<String, Object> addOrder(String jsStr,HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MessgesAlert mAl = new MessgesAlert();
		/*String userName = (String) session.getAttribute("userName"); 
		String openID = (String) session.getAttribute("openId"); //很重要。订票没有这个就无法查看订单
		String phoneNumber = (String) session.getAttribute("phoneNumber");*/
		String userName = "ttt";
		String openID = "oI6f2wDvj5glUkde-sQBTSyoyyZ4";
		String phoneNumber = "15799024022";
		if("".equals(openID)||null==openID){
			map.put("msg","0");
			map.put("planMsg","订单生成失败3，系统出错");
			return map;
		}
		
		JSONObject jsonObject=JSONObject.fromObject(jsStr);
		String cangBin = jsonObject.get("cangwei")+""; //获取舱位
		String uuid = jsonObject.get("uuid")+""; //航班的UUID
		String depDate = jsonObject.get("depDate")+""; //出发日期
		
		//获取乘机人信息
		String ridePersonInfo = jsonObject.get("telkInfo")+"";
		ridePersonInfo = ridePersonInfo.substring(1, ridePersonInfo.length()-1);
		JSONObject personInfo = JSONObject.fromObject(ridePersonInfo);
		String LinkName = personInfo.get("LinkName")+""; //获取乘机人姓名
		String Sex = personInfo.get("Sex")+""; //获取乘机人性别
		String iDcaseType = personInfo.get("iDcaseType")+""; //获取乘机人证件类型
		String iDcase = personInfo.get("iDcase")+""; //获取乘机人证件号码 
		String PhoneNum = personInfo.get("PhoneNum")+""; //获取乘机人联系电话 
		String YiwaiBX = personInfo.get("YiwaiBX")+""; //获取乘机人是否购买意外险
		String YanwuBX = personInfo.get("YanwuBX")+""; //获取乘机人是否购买延误险
		String bxiaoOr = personInfo.get("bxiaoOr")+""; //报销单是否打印
		String sendAddren = personInfo.get("sendAddren")+""; //配送地址
		String birthDay = personInfo.get("birthDay")+"";  //获取乘机人生日 
		String age = personInfo.get("age")+"";  //获取乘机人年龄
		String menType = personInfo.get("menType")+"";  //获取乘机人类型
		
		/*保存常用联系人信息*/
		List<LinkMan> lman = OrderService.isRepeat(iDcase,userName);
		if(lman.size()>0){ //说明重复了
		}else{
			LinkMan linkInfo = new LinkMan();
			linkInfo.setLinkman(LinkName);
			linkInfo.setLinkNumber(PhoneNum);
			linkInfo.setOpenID(openID);
			linkInfo.setUserName(userName);
			linkInfo.setSex(Sex);
			linkInfo.setBirthday(birthDay);
			linkInfo.setPeopleType(menType);
			linkInfo.setCaseType(iDcaseType);
			linkInfo.setCaseNum(iDcase);
			linkInfo.setUserNamePhone(phoneNumber);
			linkInfo.setCreateTime(new Timestamp(new Date().getTime()));
			OrderService.addLinkman(linkInfo);
		}
		
		//根据uuid从数据库中查找航班的信息
		List<SeatInfoData> filedInfo = PlanTekServ.findByUUID(uuid);
		if(filedInfo.size()==1){
			FilghUser fu = new FilghUser();
			fu.setAge(age);
			fu.setBirthDay(birthDay);
			fu.setiDcase(iDcase);
			fu.setiDcaseType(iDcaseType);
			fu.setLinkName(LinkName);
			fu.setMenType(menType);
			fu.setOpenID(openID);
			fu.setPhoneNum(PhoneNum);
			fu.setSex(Sex);
			fu.setUserName(userName);
			fu.setYanwuBX(YanwuBX);
			fu.setYiwaiBX(YiwaiBX);
			fu.setBxiaoOr(bxiaoOr);
			fu.setSendAdd(sendAddren);
			mAl = OrderService.saveOrder(fu,cangBin,filedInfo.get(0),depDate,0);
			map.put("resAlert", mAl);
		}else{
			System.out.println("您搜索的航班已过期，请重新搜索！");
			mAl.setIsOk("0");
			mAl.setCommit("您搜索的航班已过期，请重新搜索！");
			map.put("resAlert", mAl);
		}

		return map;
	}
	
	/**
	 * 预定组合的航班
	 */
	@RequestMapping("/add/zrorder.action")
	@ResponseBody
	public Map<String, Object> addzhz_res(String jsStr,HttpSession session){
		List<MessgesAlert> malert = new ArrayList<MessgesAlert>();  //记录是否两个全部预定成功或者只有一个，用于反馈前台提示用户
		Map<String, Object> map = new HashMap<String, Object>();
		/*String userName = (String) session.getAttribute("userName");
		String openID = (String) session.getAttribute("openId"); //很重要。订票没有这个就无法查看订单	
		String phoneNumber = (String) session.getAttribute("phoneNumber");*/
		String userName = "ttt";
		String openID = "oI6f2wDvj5glUkde-sQBTSyoyyZ4";
		String phoneNumber = "15799024022";
		if("".equals(openID)||null==openID){
			map.put("msg","0");
			map.put("planMsg","订单生成失败3，系统出错");
			return map;
		}
		JSONObject jsonObject=JSONObject.fromObject(jsStr);
		String cangBin = jsonObject.get("cangwei")+""; //获取第一航段舱位
		String cangBin2 = jsonObject.get("canbin2")+""; //获取第二航段舱位
		String uuid1 = jsonObject.get("uuid1")+""; //第一段航班的uuid
		String uuid2 = jsonObject.get("uuid2")+""; //第二段航班的uuid
		String depDate = jsonObject.get("depDate")+""; //出发日期
		String sign = jsonObject.get("sign")+""; //标志
		String rdate = jsonObject.get("rdate")+""; //返程的日期

		//获取乘机人信息
		String ridePersonInfo = jsonObject.get("telkInfo")+"";
		ridePersonInfo = ridePersonInfo.substring(1, ridePersonInfo.length()-1);
		JSONObject personInfo = JSONObject.fromObject(ridePersonInfo);
		String LinkName = personInfo.get("LinkName")+""; //获取乘机人姓名
		String Sex = personInfo.get("Sex")+""; //获取乘机人性别
		String iDcaseType = personInfo.get("iDcaseType")+""; //获取乘机人证件类型
		String iDcase = personInfo.get("iDcase")+""; //获取乘机人证件号码 
		String PhoneNum = personInfo.get("PhoneNum")+""; //获取乘机人联系电话 
		String YiwaiBX = personInfo.get("YiwaiBX")+""; //获取乘机人是否购买意外险
		String YanwuBX = personInfo.get("YanwuBX")+""; //获取乘机人是否购买延误险
		String bxiaoOr = personInfo.get("bxiaoOr")+""; //报销单是否打印
		String sendAddren = personInfo.get("sendAddren")+""; //配送地址
		String birthDay = personInfo.get("birthDay")+"";  //获取乘机人生日 
		String age = personInfo.get("age")+"";  //获取乘机人年龄
		String menType = personInfo.get("menType")+"";  //获取乘机人类型
		
		/*保存常用联系人信息*/
		List<LinkMan> lman = OrderService.isRepeat(iDcase,userName);
		if(lman.size()>0){ //说明重复了
		}else{
			LinkMan linkInfo = new LinkMan();
			linkInfo.setLinkman(LinkName);
			linkInfo.setLinkNumber(PhoneNum);
			linkInfo.setOpenID(openID);
			linkInfo.setUserName(userName);
			linkInfo.setSex(Sex);
			linkInfo.setBirthday(birthDay);
			linkInfo.setPeopleType(menType);
			linkInfo.setCaseType(iDcaseType);
			linkInfo.setCaseNum(iDcase);
			linkInfo.setUserNamePhone(phoneNumber);
			linkInfo.setCreateTime(new Timestamp(new Date().getTime()));
			OrderService.addLinkman(linkInfo);
		}
		
		//从数据库查找航班信息(第一航段)
		List<SeatInfoData> filedInfo = PlanTekServ.findByUUID(uuid1);
		if(filedInfo.size()==1){
			FilghUser fu = new FilghUser();
			fu.setAge(age);
			fu.setBirthDay(birthDay);
			fu.setiDcase(iDcase);
			fu.setiDcaseType(iDcaseType);
			fu.setLinkName(LinkName);
			fu.setMenType(menType);
			fu.setOpenID(openID);
			fu.setPhoneNum(PhoneNum);
			fu.setSex(Sex);
			fu.setUserName(userName);
			fu.setYanwuBX(YanwuBX);
			fu.setYiwaiBX(YiwaiBX);
			fu.setBxiaoOr(bxiaoOr);
			fu.setSendAdd(sendAddren);
			MessgesAlert mal1 = OrderService.saveOrder(fu,cangBin,filedInfo.get(0),depDate,1);
			malert.add(mal1);
		}else{
			MessgesAlert mal1 = new MessgesAlert();
			mal1.setIsOk("0");
			mal1.setCommit("第一航段已过期，请重新操作");
			malert.add(mal1);
		}
		
		//从数据库查找航班信息(第二航段)
		List<SeatInfoData> filedInfo2 = PlanTekServ.findByUUID(uuid2);
		if(filedInfo2.size()==1){
			FilghUser fu = new FilghUser();
			fu.setAge(age);
			fu.setBirthDay(birthDay);
			fu.setiDcase(iDcase);
			fu.setiDcaseType(iDcaseType);
			fu.setLinkName(LinkName);
			fu.setMenType(menType);
			fu.setOpenID(openID);
			fu.setPhoneNum(PhoneNum);
			fu.setSex(Sex);
			fu.setUserName(userName);
			fu.setYanwuBX(YanwuBX);
			fu.setYiwaiBX(YiwaiBX);
			fu.setBxiaoOr(bxiaoOr);
			fu.setSendAdd(sendAddren);
			MessgesAlert mal2 = new MessgesAlert();
			if("1".equals(sign)){ //就说明是往返的航班
				mal2 = OrderService.saveOrder(fu,cangBin2,filedInfo2.get(0),rdate,1);
			}else{ //否则就是中转的航班
				mal2 = OrderService.saveOrder(fu,cangBin2,filedInfo2.get(0),depDate,1);
			}
			malert.add(mal2);
		}else{
			MessgesAlert mal2 = new MessgesAlert();
			mal2.setIsOk("0");
			mal2.setCommit("第二航段已过期，请重新操作");
			malert.add(mal2);
		}
		map.put("resAlert", malert);
		return map;
	}
	
	//修改常用联系人信息
	@RequestMapping("/update/updateLinkman.action")
	@ResponseBody
	public Map<String, Object> updateLinkman(LinkMan lma,String id, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();		
		String openId = (String) session.getAttribute("openId");
		String userName = (String) session.getAttribute("userName"); 
		String phoneNumber = (String) session.getAttribute("phoneNumber");
		/*String userName = "ttt";
		String openId = "oI6f2wDvj5glUkde-sQBTSyoyyZ4";
		String phoneNumber = "15799024022";*/
		if(openId.equals("")||openId==null||userName.equals("")||userName==null){
			map.put("msg", 0);
			return map;
		}
		LinkMan linkInfo = new LinkMan();
		linkInfo.setID(id);
		linkInfo.setLinkman(lma.getLinkman());
		linkInfo.setLinkNumber(lma.getLinkNumber());
		linkInfo.setSex(lma.getSex());
		linkInfo.setBirthday(lma.getBirthday());
		linkInfo.setPeopleType(lma.getPeopleType());
		linkInfo.setCaseType(lma.getCaseType());
		linkInfo.setCaseNum(lma.getCaseNum());
		linkInfo.setOpenID(openId);
		linkInfo.setUserName(userName);
		linkInfo.setUserNamePhone(phoneNumber);
		linkInfo.setBelongCtry(lma.getBelongCtry());
		linkInfo.setChinaName(lma.getChinaName());
		linkInfo.setCaseTime(lma.getCaseTime());
		linkInfo.setCreateTime(new Timestamp(new Date().getTime()));
		int i = OrderService.updateLinkman(linkInfo);
		if(i==1){
			map.put("msg", 1);
			System.out.println("修改常用信息成功");
		}else{
			map.put("msg", 0);
			System.out.println("修改常用联系人信息失败");
		}
		return map;
	}
	
	//修改常用联系人信息
	@RequestMapping("/update/upqzInfo.action")
	@ResponseBody
	public Map<String, Object> upqzInfo(String contactsName,String customerType,String contactsSex,String contactsPhone,String contactsEmail,String trayTypeIpnt,
				String IDcase,String deliveryMethod,String deliveryAddress,String visaOrderID){
		Map<String, Object> map = new HashMap<String, Object>();		
		VisaOrder vinfo = new VisaOrder();
		vinfo.setContactsName(contactsName);
		vinfo.setCustomerType(customerType);
		vinfo.setContactsSex(contactsSex);
		vinfo.setContactsPhone(contactsPhone);
		vinfo.setContactsEmail(contactsEmail);
		vinfo.setIDcase(IDcase);
		vinfo.setDeliveryMethod(deliveryMethod);
		vinfo.setDeliveryAddress(deliveryAddress);
		vinfo.setTrayTypeIpnt(trayTypeIpnt);
		vinfo.setVisaOrderID(visaOrderID);
		int i = OrderService.upqzInfo(vinfo);
		if(i==1){
			map.put("msg", 1);
			System.out.println("修改签证信息成功");
		}else{
			map.put("msg", 0);
			System.out.println("修改签证信息失败");
		}
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
	
	//删除联系人信息
	@RequestMapping("/delete/deleteLinkman.action")
	@ResponseBody
	public Map<String, Object> deleteLinkman(String id){
		Map<String, Object> map = new HashMap<String, Object>();
		int i = OrderService.deleteLinkman(id);
		if(i==1){
			map.put("msg",1);
			System.out.println("联系人删除成功");
		}else{
			map.put("msg",0);
			System.out.println("联系人删除出错");
		}
		//}
		return map;
	}
	//删除签证订单信息
	@RequestMapping("/delete/deleteVisa.action")
	@ResponseBody
	public Map<String, Object> deleteVisa(String visaOrderID){
		Map<String, Object> map = new HashMap<String, Object>();
		int i = OrderService.deleteVisa(visaOrderID);
		if(i==1){
			map.put("msg",1);
			System.out.println("签证订单删除成功");
		}else{
			map.put("msg",0);
			System.out.println("签证订单删除出错");
		}
		//}
		return map;
	}
	
	//删除订单同时得删除中航信中的订单
	@RequestMapping("/delete/order.action")
	@ResponseBody
	public Map<String, Object> deleteOrder(String pnrNo, String ID){
		Map<String, Object> map = new HashMap<String, Object>();
		String[] pnrNoStr = pnrNo.split(",");
		String[] idStr = ID.split(",");
		for(int i=0; i<idStr.length; i++){
			//boolean YesOrNo = new ECUtils().cancelPnr(pnrNoStr[i]); //执行中航信删除订单的方法
			//if(YesOrNo){
				int j = OrderService.deleteOrder(idStr[i]);
				if(j==1){
					map.put("msg",1);
					System.out.println("订单删除成功");
				}else{
					map.put("msg",0);
					System.out.println("订单删除出错");
				}
			//}
		}
		return map;
	}
	
	//退票的方法
	@RequestMapping("/signout/order.action")
	@ResponseBody
	public int tpTicket(String pnrNo, String ID){
		try {
			//更新订单表中的退票状态
			OrderService.tpServi(ID,pnrNo);
			//拿出该订单表
			List<userOrderInfo> luso = OrderService.findbyPnr(ID, pnrNo);
			userOrderInfo useror = luso.get(0);
			//把这个订单表放到退票管理的订单表中
			tpRecords trec = new tpRecords();
			trec.setMatherUuid(useror.getID());
			trec.setChufCity(useror.getChufCity());
			trec.setChufTime(useror.getChufTime());
			trec.setDaodCity(useror.getDaodCity());
			trec.setHangbanNum(useror.getHangbanNum());
			trec.setIdcase(useror.getIDcase());
			trec.setLinkName(useror.getLinkName());
			trec.setPnr(useror.getPNR());
			trec.setTelNumber(useror.getTelNum());
			trec.setPnumber(useror.getLinkPhoneNum());
			trec.setCreateTime(new Timestamp(new Date().getTime()));
			trec.setTpStatus("1");
			tprecords.addtprecords(trec);//保存
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	
	//加载该用户的全部订单
	@RequestMapping("/loading/order.action")
	@ResponseBody
	public Map<String, Object> loadOrder(HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		String openId = (String) session.getAttribute("openId");
		String userName = (String) session.getAttribute("userName");
		List<userOrderInfo> orderList = OrderService.loadOrder(userName,openId);
		if(orderList.size()>0){
			map.put("orderList",orderList);
			map.put("msg",1);
		}else{
			map.put("msg",0);
			System.out.println("机票订单数据为空");
		}
		return map;
	}
	//加载该用户的签证订单
	@RequestMapping("/loading/visaOrder.action")
	@ResponseBody
	public Map<String, Object> visaOrder(HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		String openId = (String) session.getAttribute("openId");
		String phoneNumber = (String) session.getAttribute("phoneNumber");
		String userName = (String) session.getAttribute("userName");
		List<VisaOrder> orderList = OrderService.loadVisaOrder(openId,phoneNumber,userName);
		if(orderList.size()>0){
			map.put("orderList",orderList);
			map.put("msg",1);
		}else{
			map.put("msg",0);
			System.out.println("签证订单数据为空");
		}
		return map;
	}
	//加载该用户的优惠卷
	@RequestMapping("/loading/myDiscount.action")
	@ResponseBody
	public Map<String, Object> myDiscount(HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		List<InvitationCode> orderList1=null;
		List<InvitationCode> orderList2=new ArrayList<InvitationCode>();
		String openId = (String) session.getAttribute("openId");
		String userName = (String) session.getAttribute("userName");
		List<RD_wechatUser> orderList = OrderService.myInviteCore(userName,openId);
		
		for(int i=0;i<orderList.size();i++){
			orderList1 = OrderService.myDiscount(orderList.get(i).getInCode());	
			orderList2.addAll(orderList1);
		}
		
		if(orderList.size()>0){
			map.put("orderList2",orderList2);
			map.put("msg",1);
		}else{
			map.put("msg",0);
			System.out.println("优惠券数据为空");
		}
		return map;
	}
	//加载该用户的联系人
	@RequestMapping("/loading/linkman.action")
	@ResponseBody
	public Map<String, Object> linkman(HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		String openId = (String) session.getAttribute("openId");
		String userName = (String) session.getAttribute("userName");
		/*String userName = "ttt";
		String openId = "oI6f2wDvj5glUkde-sQBTSyoyyZ4";*/
		List<LinkMan> linkList = OrderService.findLinman(userName,openId);
		if(linkList.size()>0){
			map.put("linkList",linkList);
			map.put("msg",1);
		}else{
			map.put("msg",0);
			System.out.println("常见联系人数据为空");
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
	//反馈信息到常用联系人选择框里面
	@RequestMapping("/loading/loadLinkman.action")
	@ResponseBody
	public Map<String, Object> loadLinkman(String id, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		List<LinkMan> orderList = OrderService.loadLinkman(id);
		if(orderList.size()>0){
			map.put("orderList",orderList);
			map.put("msg",1);
		}else{
			map.put("msg",0);
			System.out.println("联系人资料为空");
		}
		return map;
	}
	
	public static void main(String[] args) {
		new ECUtils().cancelPnr("JF4NG9");
	}
	
}
