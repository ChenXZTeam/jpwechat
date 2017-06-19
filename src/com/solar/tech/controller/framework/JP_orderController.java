package com.solar.tech.controller.framework;

import java.io.IOException;
import java.net.MalformedURLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.telkMen;
import com.solar.tech.bean.entity.phoneMess;
import com.solar.tech.bean.entity.userOrderInfo;
import com.solar.tech.service.userOrderService;
import com.solar.tech.service.framework.JP_orderService;
import com.solar.tech.util.Current;
import com.solar.tech.utils.ECUtils;
import com.solar.tech.utils.Send106msg;
import com.travelsky.sbeclient.obe.book.PassengerInfo;
import com.travelsky.sbeclient.obe.book.SegmentInfo;

@Controller
@RequestMapping("/framework/order")
public class JP_orderController {
	Logger log = Logger.getLogger(JP_orderController.class);
	@Autowired
	private JP_orderService jporderService;
	@Autowired
	private userOrderService OrderService;
	
	@RequestMapping("/getOrderList.action")
	@ResponseBody
	public Map<String, Object> getOrderList(int page, int rows){
		Map<String, Object> map = new HashMap<String, Object>();
		map = jporderService.loadOrder(page, rows);
		if(map.size()>0){
			map.put("msg", 1);
		}else{
			map.put("msg", 0);
		}
		return map;
	}
	
	@RequestMapping("/addOrderAdmin.action")
	@ResponseBody
	public int addOrderAdmin(userOrderInfo sd, HttpServletRequest request){
		try {
			request.setCharacterEncoding("utf-8"); 
			sd.setLinkName(new String(sd.getLinkName().getBytes("ISO-8859-1"),"UTF-8"));
			sd.setOrderNum(OrderService.createOrderNum("RDOD", 8));
			sd.setStutisPay("1");
			sd.setAdminDel("0");
			sd.setChufTime(sd.getChufTime().replaceAll(":", ""));
			sd.setDaodTime(sd.getDaodTime().replaceAll(":", ""));
			sd.setUpdateTime(new Timestamp(new Date().getTime()));
			sd.setCreateTime(new Timestamp(new Date().getTime()));
			sd.setIsSuccess("1");
			jporderService.savaOrder(sd);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	
	/**
	 * 修改旅客证件
	 * @param a
	 * @return
	 */
	@RequestMapping("/upTelkMen.action")
	@ResponseBody
	public int upTelkMen(telkMen a){
		try {
			PassengerInfo psg = new PassengerInfo();
			psg.setName(a.getLinkName());//旅客姓名
			int ageNum = Integer.parseInt(a.getAge());
			psg.setAge(ageNum);//年龄
			psg.setGender(a.getLinkSex()); //性别
			psg.setBirthDay(a.getBirthday());//出生日期yyyy-mm-dd
			psg.setPsgType(a.getPsgType());//旅客类型  ADT 成人,CHD 儿童,INF 婴儿
			psg.setCertNo(a.getIdcase());//证件号码
			psg.setCertType(a.getIdcaseType());//证件类型(NI 身份证,PP 护照,ID其他证件)
			PassengerInfo[] passengerInfos = new PassengerInfo[]{psg};		
			boolean YesOrNo = new ECUtils().changeCertificate(a.getPnr(), passengerInfos);//执行中航信修改航段方法
			if(YesOrNo){
				userOrderInfo uinfo = new userOrderInfo();
				uinfo.setID(a.getId());
				uinfo.setPNR(a.getPnr());
				uinfo.setLinkName(a.getLinkName());
				uinfo.setAge(a.getAge());
				uinfo.setLinkSex(a.getLinkSex());
				uinfo.setBirthday(a.getBirthday());
				uinfo.setPsgType(a.getPsgType());
				uinfo.setIDcase(a.getIdcase());
				uinfo.setIDcaseType(a.getIdcaseType());
				int i = OrderService.changeCertificate(uinfo);
				if(i==1){
					return 1;
				}else{
					return 0;
				}
			}else{
				return 0;
			}
			
		} catch (Exception e) {
			return 0;
		}
	}
	

	/**
	 * @title updateCorder 修改出票时间
	 * @param pnrNo
	 * @param tktl(新出票的时间) yyyy-MM-dd HH:mm:ss
	 * @return
	 */
	//修改出票时限
	@RequestMapping("/Corder.action")
	@ResponseBody
	public int updateCorder(String pnr, String getTeickTime, String id){
		/*boolean YesOrNo = new ECUtils().tktl(pnr, getTeickTime);//修改出票时间
		if(YesOrNo){*/
			userOrderInfo uinfo = new userOrderInfo();
			uinfo.setGetTeickTime(getTeickTime);
			uinfo.setID(id);
			uinfo.setPNR(pnr);
			int i=OrderService.updateGetTeickTime(uinfo);
			if(i==1){
				return 1;
			}else{
				return 0;
			}
		/*}else{
			return 0;
		}*/
	}
	
	//修改航段信息（未付款的时候，付款的时候就只能改签了）
	@RequestMapping("/hangeAirSegment.action")
	@ResponseBody
	public int changeAirSegment(String id, String pnr, String hangbanNum ,String chufDate, String newFlyCity, String newFlyddCity, String newFlyNum ,String newCanbin, String newFlyDate){
			//航段组实体类
			SegmentInfo s = new SegmentInfo();
			s.setDeparture(newFlyCity);//起飞城市
			s.setArrival(newFlyddCity);//到达城市
			s.setFlightNo(newFlyNum);//航班号	
			s.setCabin(newCanbin);//舱位
			s.setDepartureDate(newFlyDate);//起飞日期，格式如：yyyy-MM-dd
			s.setActionCode("NN");//行动代码
			s.setType("HK");//航线类型(国内/国际)
			SegmentInfo[] segmentInfos = new SegmentInfo[]{s};
			boolean YesOrNo = new ECUtils().changeAirSegment(pnr, hangbanNum, chufDate, segmentInfos);//执行中航信修改航段方法
			if(YesOrNo){
				userOrderInfo uinfo = new userOrderInfo();
				uinfo.setPNR(pnr);
				uinfo.setID(id);
				uinfo.setChufCity(newFlyCity);
				uinfo.setDaodCity(newFlyddCity);
				uinfo.setHangbanNum(newFlyNum);
				uinfo.setCabin(newCanbin);
				uinfo.setChufDate(newFlyDate);
				uinfo.setActionCode("NN");
				int i = OrderService.changeAirSegment(uinfo);
				if(i==1){
					return 1;
				}else{
					return 0;
				}
			}else{
				return 0;
			}
	}
	
	@RequestMapping("/findOrder.action")
	@ResponseBody
	public Map<String, Object> findOrder(int page, int rows, String Info){
		Map<String, Object> map = new HashMap<String, Object>();
		map = jporderService.findByInfo(page, rows, Info);
		if(map.size()>0){
			map.put("msg", 1);
		}else{
			map.put("msg", 0);
		}
		return map;
	}
	
	/**
	 * 获取短信发送消息的表单
	 * @return
	 */
	@RequestMapping({"/obtainPhoneMess.action"})
    @ResponseBody
	public Map<String, Object> obtainPhoneMess(int page, int rows){
		Map<String, Object> map = new HashMap<String, Object>();
		map = jporderService.otindPhoneMes(page, rows);
		return map;
	}
	
	/**
	 * 根据手机号码查找发送的记录
	 * @param phoneNumber
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping({"/findPhoneMess.action"})
    @ResponseBody
	public Map<String, Object> findPhoneMess(String phoneNumber, int page, int rows){
		Map<String, Object> map = new HashMap<String, Object>();
		map = jporderService.findPhoneMes(phoneNumber,page, rows);
		return map;
	}
	
	@RequestMapping({"/findBy.action"})
    @ResponseBody
    public Map<String,Object> findByuuid(String a){
		Map<String,Object> map = jporderService.findbyid(a);
		return map;
	}
	
	/**
	 * 短信发送功能，在后台的订单页面使用
	 * @param phoneNumList
	 * @param text
	 * @return
	 */
	@RequestMapping({"/sendMessToUser.action"})
	@ResponseBody
	public Map<String, Object> sendMessToUser(String phoneNumList, String text, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		String userName = Current.user().getUserName();
		Send106msg sender = new Send106msg();
		phoneMess ph=new phoneMess();
		try {
			String res = sender.SendMSGtoPhone("【广州永弘】" + text,phoneNumList);
			ph.setUserName(userName);
			ph.setPhoneNumber(phoneNumList);
			ph.setText(text);
			ph.setZuNumber("187-码");;
			ph.setCreateTime(new Timestamp(new Date().getTime()));
			if(res.equals("1")||"1".equals(res)){
				ph.setSendType(1);
				map.put("mess", 1);
				log.info("==========>>>>发送短信到手机为："+phoneNumList+" 发送内容为："+text+"<<<<==============");
			}else{
				ph.setSendType(0);
				map.put("mess", 0);
				log.info("==========>>>>发送短信失败手机为："+phoneNumList+"<<<<==============");
			}
			jporderService.savaPhoneMess(ph);
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return map;
	}	
	
}
