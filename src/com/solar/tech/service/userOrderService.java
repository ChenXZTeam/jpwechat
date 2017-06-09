package com.solar.tech.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.InvitationCode;
import com.solar.tech.bean.VisaOrder;
import com.solar.tech.bean.entity.LinkMan;
import com.solar.tech.bean.entity.RD_wechatUser;
import com.solar.tech.bean.entity.airport;
import com.solar.tech.bean.entity.userOrderInfo;
import com.solar.tech.dao.GenericDao;
import com.solar.tech.utils.ECUtils;
import com.travelsky.sbeclient.obe.book.BookContact;
import com.travelsky.sbeclient.obe.book.OSIInfo;
import com.travelsky.sbeclient.obe.book.PassengerInfo;
import com.travelsky.sbeclient.obe.book.RMKInfo;
import com.travelsky.sbeclient.obe.book.SSRInfo;
import com.travelsky.sbeclient.obe.book.SegmentInfo;
import com.travelsky.sbeclient.obe.response.PnrResponse;
import com.travelsky.sbeclient.obe.response.rt.RTResponse;

/**
 * @title 执行订单数据的service方法
 * @author solarpc1
 *
 */
@Service
@Transactional
public class userOrderService {
	@Resource
	private GenericDao gDao;
	/**
	 * @Title addOrder(用户的订票订单)
	 * @param orderInfo
	 * @return
	 */
	public int addOrder(userOrderInfo orderInfo){
		try {
			gDao.save(orderInfo);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	
	/**
	 * 保存多个订单信息
	 * @param orderInfo
	 * @return
	 */
	public int addOrder(List<userOrderInfo> orderInfo){
		try {
			gDao.save(orderInfo);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	
	/**
	 * @title 查找最新插入的数据
	 * @return map
	 */
	public String fingMaxNum(){
		 String hql = "SELECT MAX(uinfo.intNum) FROM userOrderInfo as uinfo";
		 List<String> MaxorderNum = this.gDao.find(hql);
		 String MaxNum = MaxorderNum.get(0);
		 return MaxNum;
	}
	
	/**
	 * @title 查找最大的编号
	 * @return map
	 */
	public String fingMaxOrderNum(){ 
		 String hql = "SELECT (uOrder.orderNum) FROM userOrderInfo as uOrder WHERE intNum = (SELECT MAX(uinfo.intNum) FROM userOrderInfo as uinfo)";
		 List<String> MaxorderNum = this.gDao.find(hql);
		 String MaxNum = null;
		 if(MaxorderNum.size()==0){
			 MaxNum = "YHOD20151205000001";
		 }else{
			 MaxNum = MaxorderNum.get(0);
		 }
		 return MaxNum;
	}
	
	/**
	 * 
	 * @Title: createOrderNum
	 * @Description: 生成预约号
	 * @param PreString
	 * @param length
	 * @return: String
	 */
	public String createOrderNum(String PreString, int length) {

		List<Object> params = new ArrayList<Object>();
		params.add(PreString);
		params.add(length);
		String sql = "{Call generate_orderNo(?,?,@orderNo)}";
		List<String> list = gDao.getListByCall(sql, params);

		return list.get(0).toString();
	}
	
	/**
	 * 产生随机且唯一的标识，标识关联两条数据的标志
	 * @return
	 */
	/*public String getRandomString(String sign){
		long time = System.currentTimeMillis();//加上时间戳
		String[] storeChars = {"0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};
		Random random = new Random();
		String codesign = "";
		for(int i=0; i<10; i++){
			int index = random.nextInt(35);
			codesign += storeChars[index];
		}
		return sign+codesign+time;
	}*/
	
	/**
	  * 
	  * 在用此类时，必须先明确自己模块编号的开头
	  * @param start编号开头，
	  * @param num从数据库查询出的最大编号
	  * @return
	  */
	 public String getNum(String start,String num){
		  //String n=num.substring(0,4);
		  String strDate="";//流水号时间
		  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		  Date date = new Date();
		  //格式化当前时间，并按字符'-'分割
		  String[] sd=sdf.format(date).split("-");
		  //截取编号中的日期
		  String time=num.substring(4,12).toString();
		  for(int i=0;i<sd.length;i++){
			  strDate+=sd[i];
		  }
		  //如果当天或者表中没有记录，返回当天第一条记录
		  if(!time.equals(strDate)||num.equals("")||num==null||num==""){
			  String numNo=start+strDate+"000001";
			  return numNo;
		  }
		  // 截取编号最后的流水号
		  String end=num.substring(12, 18);
		  String s2="";
		  int lg=Integer.parseInt(end);
		  //对流水号结尾的四位数字进行判断，以便增加
		  if(lg>0&&lg<9){
			  s2="00000"+(lg+1);
		  }else if(lg>=9&&lg<99){
			  s2="0000"+(lg+1);
		  }else if(lg>=99&&lg<999){
			  s2="000"+(lg+1);
		  }else if(lg>=999&&lg<9999){
			  s2="00"+(lg+1);
		  }else if(lg>=9999&&lg<99999){
			  s2="0"+(lg+1);
		  }else if(lg>=99999&&lg<999999){
			  s2=""+(lg+1);
		  }else{
			  System.out.println("当天生成的预约编号已满");
		  }
		  //返回自动生成后的流水号
		  return start+=strDate+s2;
	}
	 
	 /**
	  * @Title updateGetTeickTime 修改出票期限
	  * @param oInfo
	  * @return
	  */
	 public int updateGetTeickTime(userOrderInfo oInfo){
		 String sql = "UPDATE userorderinfo SET getTeickTime = '"+oInfo.getGetTeickTime()+"' WHERE orderNum = '"+oInfo.getOrderNum()+"' AND PNR = '"+oInfo.getPNR()+"'";
		 int i = gDao.executeJDBCSql(sql);
		 if(i > 0){
			return 1;
		 }
		 return 0;
	 }
	 
	 /**
	  * @Title changeAirSegment 修改航段信息
	  * @param oInfo
	  * @return
	  */
	 public int changeAirSegment(userOrderInfo oInfo){
		 String sql = "UPDATE userorderinfo SET chufCity = '"+oInfo.getChufCity()+"', daodCity = '"+oInfo.getDaodCity()+"', hangbanNum = '"+oInfo.getHangbanNum()+"', cabin = '"+oInfo.getCabin()+"', chufDate = '"+oInfo.getChufDate()+"', actionCode = '"+oInfo.getActionCode()+"' WHERE orderNum = '"+oInfo.getOrderNum()+"' AND PNR='"+oInfo.getPNR()+"'";
			int i = gDao.executeJDBCSql(sql);
			if(i > 0){
				return 1;
			}
			return 0;
	 }
	 
	 /**
	  * @Title changeCertificate(修改旅客信息)
	  * @param oInfo
	  * @return
	  */	 
	 public int changeCertificate(userOrderInfo oInfo){
		String sql = "UPDATE userorderinfo SET linkName = '"+oInfo.getLinkName()+"', age = '"+oInfo.getAge()+"', linkSex = '"+oInfo.getLinkSex()+"', birthday = '"+oInfo.getBirthday()+"', psgType = '"+oInfo.getPsgType()+"', IDcase = '"+oInfo.getIDcase()+"', IDcaseType = '"+oInfo.getIDcaseType()+"' WHERE orderNum = '"+oInfo.getOrderNum()/*+"' AND PNR='"+oInfo.getPNR()*/+"'";
		int i = gDao.executeJDBCSql(sql);
		if(i > 0){
			return 1;
		}
		return 0;
	 }
	 
	 /**
	  * @Title updateChufDateSer(同舱改签)
	  * @param oInfo
	  * @return
	  */	 
	 public int updateChufDateSer(userOrderInfo oInfo){
		String sql = "UPDATE userorderinfo SET hangbanNum = '"+oInfo.getHangbanNum()+"', chufDate = '"+oInfo.getChufDate()+"', chufTime = '"+oInfo.getChufTime()+"', daodTime = '"+oInfo.getDaodTime()+"' WHERE orderNum = '"+oInfo.getOrderNum()+"' AND PNR='"+oInfo.getPNR()+"'";
		int i = gDao.executeJDBCSql(sql);
		if(i > 0){
			return 1;
		}
		return 0;
	 }
	 
		/**
		 * 
		 * @Title: deleteOrder 
		 * @Description: 删除订单业务数据--将AdminDel值设为1
		 * @param orderNum
		 * @return: void
		 */
		public int deleteOrder(String ID) {
			try {
				String sql = "UPDATE userorderinfo SET AdminDel = 1 WHERE ID = '"+ID+"'";
				gDao.executeJDBCSql(sql);
				return 1;  
			}catch (Exception e) {
				return -1;
			}
		}  
		
		/**
		 * 加载用户订单
		 * @param userName
		 * @param openId
		 * @return
		 */
		public List<userOrderInfo> loadOrder(String userName,String openId){
			List<Object> params = new ArrayList<Object>();
			params.add(userName);
			params.add(openId);
			String sql="from userOrderInfo where AdminDel=0 AND UserName=? AND openID=? ORDER BY updateTime DESC";
			List<userOrderInfo> list = gDao.getListByHql(userOrderInfo.class, sql, params);
			if(list.size()>0){
				return list;
			}
			return null;
		}
		
		/**
		 * 加载用户订单的信息
		 * @param userName
		 * @param openId
		 * @return
		 */
		public List<userOrderInfo> loadUserMsg(String orderNum){
			List<Object> params = new ArrayList<Object>();
			params.add(orderNum);
			String sql="from userOrderInfo where orderNum=?";
			List<userOrderInfo> list = gDao.getListByHql(userOrderInfo.class, sql, params);
			if(list.size()>0){
				return list;
			}
			return null;
		}
		
		/**
		 * 根据机场公司的三字码查找所在的城市
		 */
		public String findCity(String code){
			String cityName = null;
			//String sql="select * from b_airport where AIRPORTCODE = '"+code+"'";
			//List<Object> list = new ArrayList<Object>();
			List<Object> params = new ArrayList<Object>();
			params.add(code);
			String sql="from airport ai where ai.AIRPORTCODE= ?";
			List<airport> list = gDao.getListByHql(airport.class, sql, params);
			//list = this.gDao.executeJDBCSqlQuery(sql);
			if(list.size()>0){
				for(int i=0; i<list.size(); i++){
					cityName = list.get(i).getCITYNAMECN();
				}
				return cityName;
			}
			else{
				return null;
			}
		}

		/**
		 * 加载我的签证信息的订单
		 */
		public List<VisaOrder> loadVisaOrder(String opendID, String phoneNumber, String userName) {
			List<Object> params = new ArrayList<Object>();
			params.add(opendID);
			params.add(phoneNumber);
			params.add(userName);
			String sql="from VisaOrder where opendID = ? OR contactsPhone = ? OR userName = ? ORDER BY createTime DESC";
			List<VisaOrder> list = gDao.getListByHql(VisaOrder.class, sql, params);
			if(list.size()>0){
				return list;
			}
			return null;
		}

		/**
		 * 加载我的邀请码
		 */
		public List<RD_wechatUser> myInviteCore(String userName, String openId) {
			List<Object> params = new ArrayList<Object>();
			params.add(userName);
			params.add(openId);
			String sql="from RD_wechatUser where UserName=? AND openID=? ORDER BY BindTime DESC";
			List<RD_wechatUser> list = gDao.getListByHql(RD_wechatUser.class, sql, params);
			if(list.size()>0){
				return list;
			}
			return null;
		}

		/**
		 * 加载我的优惠券
		 */
		public List<InvitationCode> myDiscount(String inCode) {
			List<Object> params = new ArrayList<Object>();
			params.add(inCode);
			String sql="from InvitationCode where invitationCode=? ORDER BY deadline DESC";
			List<InvitationCode> list = gDao.getListByHql(InvitationCode.class, sql, params);
			if(list.size()>0){
				return list;
			}
			return null;
		}

		/**
		 * 微信端用户订票的时候查找常用联系人
		 */
		public List<LinkMan> findLinman(String userName, String openId) {
			List<Object> params = new ArrayList<Object>();
			params.add(userName);
			params.add(openId);
			String sql="from LinkMan where UserName=? AND openID=? ORDER BY createTime DESC";
			List<LinkMan> list = gDao.getListByHql(LinkMan.class, sql, params);
			if(list.size()>0){
				return list;
			}
			return null;
		}

		/**
		 * 加载常用联系人
		 */
		public List<LinkMan> loadLinkman(String id) {
			List<Object> params = new ArrayList<Object>();
			params.add(id);
			String sql="from LinkMan where ID=?";
			List<LinkMan> list = gDao.getListByHql(LinkMan.class, sql, params);
			if(list.size()>0){ 
				return list;
			}
			return null;
		}

		/**
		 * 微信用户更新常用联系人
		 */
		public int updateLinkman(LinkMan linfo) {
			try{
				gDao.update(linfo);
				return 1;
			}catch(Exception e){
				return 0;
			}
		}

		/**
		 * 微信用户添加常用联系人
		 */
		public int addLinkman(LinkMan linkInfo) {
			try {
				gDao.save(linkInfo);
				return 1;
			} catch (Exception e) {
				return 0;
			}
		}

		/**
		 * 微信用户删除常用联系人
		 */
		public int deleteLinkman(String id) {
			try {
				gDao.deleteById(LinkMan.class, id);
				return 1;
			} catch (Exception e) {
				return 0;
			}
		}

		/**
		 * 微信用户修改签证信息
		 */
		public int upqzInfo(VisaOrder vinfo) {
			String sql = "UPDATE fw_VisaOrder SET contactsName = '"+vinfo.getContactsName()+"',contactsSex = '"+vinfo.getContactsSex()+"',contactsPhone = '"+vinfo.getContactsPhone()+"',contactsEmail = '"+vinfo.getContactsEmail()+"',customerType = '"+vinfo.getCustomerType()+"',IDcase = '"+vinfo.getIDcase()+"',deliveryMethod = '"+vinfo.getDeliveryMethod()+"',deliveryAddress = '"+vinfo.getDeliveryAddress()+"',trayTypeIpnt = '"+vinfo.getTrayTypeIpnt()+"' WHERE visaOrderID = '"+vinfo.getVisaOrderID()+"'";
			System.out.println(sql);
			int i = gDao.executeJDBCSql(sql);
			if(i > 0){
				return 1;
			}
			return 0;
		}

		/**
		 * 微信用户删除签证订单
		 */
		public int deleteVisa(String id) {
			try {
				gDao.deleteById(VisaOrder.class, id);
				return 1;
			} catch (Exception e) {
				return 0;
			}
		}

		/**
		 * 提取pnr内容
		 */
		public static void rtPnr(String pnrNo){
			RTResponse response = new ECUtils().rt(pnrNo);
			System.out.println(response.toString());
		}
		
		/**
		 * 预定中航信系统的机票
		 * @param seatInfo
		 * @return
		 */
		public PnrResponse Reserve(userOrderInfo fildInfo){
			//联系组实体类
			BookContact bookContact = new BookContact();
			bookContact.setCity(fildInfo.getChufCity());//城市
			bookContact.setContact(fildInfo.getLinkPhoneNum());//联系电话
			bookContact.setPsgId(fildInfo.getLinkName());
			
			//航段组实体类
			SegmentInfo s = new SegmentInfo();
			s.setDeparture(fildInfo.getChufCity());//起飞城市
			s.setArrival(fildInfo.getDaodCity());//到达城市
			s.setFlightNo(fildInfo.getHangbanNum());//航班号	
			s.setCabin(fildInfo.getCabin());//舱位
			s.setDepartureDate(fildInfo.getChufDate());//起飞日期，格式如：yyyy-MM-dd
			String timeStr = fildInfo.getChufTime();
			s.setDepartureTime(timeStr.substring(0,2)+":"+timeStr.substring(2,4));//起飞时间，格式如：HH:mm
			SegmentInfo[] segmentInfos = new SegmentInfo[]{s};
			
			//旅客组实体类（是否可以添加多个旅客）
			PassengerInfo psg = new PassengerInfo();
			psg.setName(fildInfo.getLinkName());//旅客姓名
			psg.setAge(Integer.parseInt(fildInfo.getAge()));//年龄
			psg.setGender("M"); //性别
			psg.setBirthDay(fildInfo.getBirthday());//出生日期
			psg.setPsgType(fildInfo.getPsgType());//旅客类型  ADT 成人,CHD 儿童,INF 婴儿
			psg.setCertNo(fildInfo.getIDcase());//证件号码
			psg.setCertType(fildInfo.getIDcaseType());//证件类型PP,NI		
			PassengerInfo[] passengerInfos = new PassengerInfo[]{psg};
			
			//OSI组实体类 
			OSIInfo osi = new OSIInfo();
			//osi.setIdx("");
			osi.setAirCode(fildInfo.getHangbanNum().substring(0, 2));//航空公司代码
			osi.setOsi("CTCT18729034712");//OSI内容
			OSIInfo[] osis = new OSIInfo[]{osi};
			
			//RMK组实体类
			/*RMKInfo rmk = new RMKInfo();
			rmk.setPsgName(fildInfo.getLinkName());//旅客姓名
			rmk.setRmkType("");//RMK类型
			rmk.setRmkInfo("rmk 仁德机票出售中心");//RMK内容
			RMKInfo[] rmks = new RMKInfo[]{rmk};*/
			
			//开始在中信航系统产生订票的订单
			PnrResponse response = new ECUtils().booking(bookContact, segmentInfos, passengerInfos, "2017-06-10 00:00:00", null, osis, null, null, null, null);
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
			System.out.println("-----------------------到这信息全部返回成功-------------------");
			return response;
		}
		
		public static void main(String[] args) {
			rtPnr("JM8RKQ");
		}

}
