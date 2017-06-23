package com.solar.tech.service;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.FilghUser;
import com.solar.tech.bean.InvitationCode;
import com.solar.tech.bean.MessgesAlert;
import com.solar.tech.bean.VisaOrder;
import com.solar.tech.bean.entity.CTCTnum;
import com.solar.tech.bean.entity.Insurance;
import com.solar.tech.bean.entity.LinkMan;
import com.solar.tech.bean.entity.RD_wechatUser;
import com.solar.tech.bean.entity.SeatInfoData;
import com.solar.tech.bean.entity.SeatPriceData;
import com.solar.tech.bean.entity.airport;
import com.solar.tech.bean.entity.kdCost;
import com.solar.tech.bean.entity.userOrderInfo;
import com.solar.tech.bean.entity.yhNum;
import com.solar.tech.dao.GenericDao;
import com.solar.tech.utils.ECUtils;
import com.solar.tech.utils.OptimizeECUtils;
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
		 String sql = "UPDATE userorderinfo SET getTeickTime = '"+oInfo.getGetTeickTime()+"' WHERE ID = '"+oInfo.getID()+"' AND PNR = '"+oInfo.getPNR()+"'";
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
		 String sql = "UPDATE userorderinfo SET chufCity = '"+oInfo.getChufCity()+"', daodCity = '"+oInfo.getDaodCity()+"', hangbanNum = '"+oInfo.getHangbanNum()+"', cabin = '"+oInfo.getCabin()+"', chufDate = '"+oInfo.getChufDate()+"', actionCode = '"+oInfo.getActionCode()+"' WHERE ID = '"+oInfo.getID()+"' AND PNR='"+oInfo.getPNR()+"'";
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
		String sql = "UPDATE userorderinfo SET linkName = '"+oInfo.getLinkName()+"', age = '"+oInfo.getAge()+"', linkSex = '"+oInfo.getLinkSex()+"', birthday = '"+oInfo.getBirthday()+"', psgType = '"+oInfo.getPsgType()+"', IDcase = '"+oInfo.getIDcase()+"', IDcaseType = '"+oInfo.getIDcaseType()+"' WHERE ID = '"+oInfo.getID()/*+"' AND PNR='"+oInfo.getPNR()*/+"'";
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
			String sql="from userOrderInfo where ID=?";
			List<userOrderInfo> list = gDao.getListByHql(userOrderInfo.class, sql, params);
			if(list.size()>0){
				return list;
			}
			return null;
		}
		
		/**
		 * 处理退票的功能
		 * @param uuid
		 * @param pnr
		 */
		public void tpServi(String uuid, String pnr){
			String sql="UPDATE userorderinfo SET tpStatus = '1' WHERE ID = '"+uuid+"' AND PNR = '"+pnr+"'";
			this.gDao.executeJDBCSql(sql);
		}
		
		public List<userOrderInfo> findbyPnr(String uuid,String pnr){
			List<userOrderInfo> luso = this.gDao.find("FROM userOrderInfo WHERE ID = '"+uuid+"' AND PNR = '"+pnr+"'");
			return luso;
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
		
		public List<LinkMan> isRepeat(String idCase,String userName){
			List<LinkMan> ulist = this.gDao.find("FROM LinkMan WHERE caseNum = '"+idCase+"' AND UserName = '"+userName+"'");
			return ulist;
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
			System.out.println("============联系组===========");
			System.out.println("城市："+fildInfo.getChufCity());
			System.out.println("联系电话："+fildInfo.getLinkPhoneNum());
			
			//航段组实体类
			SegmentInfo s = new SegmentInfo();
			s.setDeparture(fildInfo.getChufCity());//起飞城市
			s.setArrival(fildInfo.getDaodCity());//到达城市
			s.setFlightNo(fildInfo.getHangbanNum());//航班号	
			s.setCabin(fildInfo.getCabin());//舱位
			s.setDepartureDate(fildInfo.getChufDate());//起飞日期，格式如：yyyy-MM-dd
			String timeStr = fildInfo.getChufTime();
			s.setDepartureTime(timeStr.substring(0,2)+":"+timeStr.substring(2,4));//起飞时间，格式如：HH:mm
			System.out.println("============航段信息 ，航班号、 起飞机场、 到达机场、 舱位、 航班日期必填===========");
			System.out.println("起飞机场："+fildInfo.getChufCity());
			System.out.println("到达机场："+fildInfo.getDaodCity());
			System.out.println("航班号："+fildInfo.getHangbanNum());
			System.out.println("舱位："+fildInfo.getCabin());
			System.out.println("出发日期："+fildInfo.getChufDate());
			System.out.println("出发时间："+timeStr.substring(0,2)+":"+timeStr.substring(2,4));
			SegmentInfo[] segmentInfos = new SegmentInfo[]{s};
			
			//旅客组实体类（是否可以添加多个旅客）
			PassengerInfo psg = new PassengerInfo();
			psg.setName(fildInfo.getLinkName());//旅客姓名
			psg.setAge(Integer.parseInt(fildInfo.getAge()));//年龄
			psg.setGender(fildInfo.getLinkSex()); //性别
			psg.setBirthDay(fildInfo.getBirthday());//出生日期
			psg.setPsgType(fildInfo.getPsgType());//旅客类型  ADT 成人,CHD 儿童,INF 婴儿
			psg.setCertNo(fildInfo.getIDcase());//证件号码
			psg.setCertType(fildInfo.getIDcaseType());//证件类型PP,NI
			System.out.println("============旅客信息 ，婴儿旅客要有出生日期===========");
			System.out.println("姓名："+fildInfo.getLinkName());
			System.out.println("年龄："+Integer.parseInt(fildInfo.getAge()));
			System.out.println("性别："+fildInfo.getLinkSex());
			System.out.println("生日："+fildInfo.getBirthday());
			System.out.println("旅客类型："+fildInfo.getPsgType());
			System.out.println("证件号码："+fildInfo.getIDcase());
			System.out.println("证件类型："+fildInfo.getIDcaseType());
			PassengerInfo[] passengerInfos = new PassengerInfo[]{psg};
			
			//OSI组实体类 
			OSIInfo osi = new OSIInfo();
			//osi.setIdx("");
			osi.setAirCode(fildInfo.getHangbanNum().substring(0, 2));//航空公司代码
			osi.setOsi("CTCT18729034712");//OSI内容
			System.out.println("===============OSI组实体类==============");
			System.out.println("航空公司代码："+fildInfo.getHangbanNum().substring(0, 2));
			System.out.println("CTCT："+ctctNum().get(0).getPhoneNum());
			OSIInfo[] osis = new OSIInfo[]{osi};
			
			//RMK组实体类
			/*RMKInfo rmk = new RMKInfo();
			rmk.setPsgName(fildInfo.getLinkName());//旅客姓名
			rmk.setRmkType("");//RMK类型
			rmk.setRmkInfo("rmk 仁德机票出售中心");//RMK内容
			RMKInfo[] rmks = new RMKInfo[]{rmk};*/
			
			//开始在中信航系统产生订票的订单
			/*System.out.println("出票时间："+fildInfo.getGetTeickTime());
			PnrResponse response = new ECUtils().booking(bookContact, segmentInfos, passengerInfos, fildInfo.getGetTeickTime(), null, osis, null, null, null, null);
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
			
			//为了不为空而临时造的数据，别当真
			PnrResponse response = new PnrResponse();
			response.setPnrNo("JF4NG9");
			return response;
		}
		
		//计算出票日期的方法
		public static String pointDate(String orgDate){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date dates = null;
			try {
				dates = sdf.parse(orgDate+" 00:00:00");
			} catch (ParseException e) {
				e.printStackTrace();
			}
			String sdssd = sdf.format(new Date(dates.getTime()-(long)1*24*60*60*1000));
			return sdssd;
		}
		
		//封装保存订单的方法
		public MessgesAlert saveOrder(FilghUser fu, String cangBin, SeatInfoData sifd, String depDate,int numSign){
			MessgesAlert mAl = new MessgesAlert();
			//整理数据，一边要保存到数据库中，另一边整理交给中信航接口
			userOrderInfo oderInfo = new userOrderInfo();
			//整理联系人信息
			oderInfo.setIDcase(fu.getiDcase());
			oderInfo.setIDcaseType(fu.getiDcaseType());
			oderInfo.setLinkName(fu.getLinkName());
			oderInfo.setLinkPhoneNum(fu.getPhoneNum());
			oderInfo.setLinkSex(fu.getSex());
			oderInfo.setYiwaiBX(fu.getYiwaiBX());
			oderInfo.setYanwuBX(fu.getYanwuBX());
			oderInfo.setIsConsole(fu.getBxiaoOr());
			oderInfo.setSendAdd(fu.getSendAdd());
			oderInfo.setBirthday(fu.getBirthDay());
			oderInfo.setAge(fu.getAge());
			oderInfo.setPsgType(fu.getMenType());
			//整理航班信息
			oderInfo.setCabin(cangBin);
			oderInfo.setChufCity(sifd.getOrgcity());
			oderInfo.setDaodCity(sifd.getDstcity());
			oderInfo.setHangbanNum(sifd.getAirline());
			oderInfo.setChufTime(sifd.getDepTime());
			oderInfo.setDaodTime(sifd.getArriTime());
			oderInfo.setArriTerm(sifd.getArriTerm());
			oderInfo.setDepTerm(sifd.getDepTerm());
			oderInfo.setMeal(sifd.getMeal());
			//出发日期
			if("+1".equals(sifd.getDeptimemodify())){
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Date dates = null;
				try {
					dates = sdf.parse(depDate);
					String sdssd = sdf.format(new Date(dates.getTime()+(long)1*24*60*60*1000));
					oderInfo.setChufDate(sdssd);
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}else{
				oderInfo.setChufDate(depDate);
			}
			//到达日期
			if("+1".equals(sifd.getArriveTimeModify())){
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Date dates = null;
				try {
					dates = sdf.parse(depDate);
					String sdssd = sdf.format(new Date(dates.getTime()+(long)1*24*60*60*1000));
					oderInfo.setDaodDate(sdssd);
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}else{
				oderInfo.setDaodDate(depDate);
			}
			
			/*计算价格
			 *1、根据航班号和舱位从数据库里面查找基本价格
			 *2、用户是否购买双保险，购买就加上
			 */
			SeatPriceData SpInfo = findPrice(sifd.getAirline(),cangBin,sifd.getOrgcity(),sifd.getDstcity());
			double num1 = Double.valueOf(SpInfo.getOnewayPrice());
			int jbPrice = (int)num1; //这个是基本价格
			List<Insurance> bxco = findByBx(); //保险的价格
			int ywaicost = 0; //航意险价格
			int ywcost = 0; //延误险价格
			int kdcost = 0; //快递价格
			for(Insurance incost : bxco){
				if("1".equals(incost.getBxType())){
					ywaicost = Integer.parseInt(incost.getCost());
				}else if("2".equals(incost.getBxType())){
					ywcost = Integer.parseInt(incost.getCost());
				}
			}
			List<kdCost> kdco = kdCost(); //快递的价格
			kdcost = Integer.parseInt(kdco.get(0).getKdcost());
			if(fu.getYiwaiBX().equals("1")||"1".equals(fu.getYiwaiBX())){ //如果买了意外险就加上30元
				jbPrice = jbPrice+ywaicost;
			}
			if(fu.getYanwuBX().equals("1")||"1".equals(fu.getYanwuBX())){ //如果买了延误险就加上20元
				jbPrice = jbPrice+ywcost;
			}
			if(numSign==1){ //中转航班和往返航班快递费是一个航段10元钱
				if(fu.getBxiaoOr().equals("1")||"1".equals(fu.getBxiaoOr())){ //报销单快递费
					jbPrice = jbPrice+(kdcost/2);
				}
			}else{ //直达航班的快递费是一个航段20元钱
				if(fu.getBxiaoOr().equals("1")||"1".equals(fu.getBxiaoOr())){ //报销单快递费
					jbPrice = jbPrice+kdcost;
				}
			}
			if("ADT".equals(fu.getMenType())){ //最后还要加上50元成人机场建设费
				jbPrice = jbPrice+50;
			}
			oderInfo.setCostMoney(jbPrice+"");
			
			//默认的数据
			oderInfo.setStutisPay("0"); //未支付
			oderInfo.setTakePlane("0"); //是否出票
			oderInfo.setAdminDel("0"); //默认不删除
			oderInfo.setConsoleStatus("0"); //未打印
			oderInfo.setTpStatus("0"); //退票标识（未退票）
			oderInfo.setOrderNum("1"); //线上预定
			oderInfo.setCreateTime(new Timestamp(new Date().getTime()));
			String orderNumFirst = createOrderNum("RDOD", 8);
			oderInfo.setOrderNum(orderNumFirst); //设置流水号
			oderInfo.setGetTeickTime(pointDate(oderInfo.getChufDate())); //设置出票时间
			//系统数据
			oderInfo.setUserName(fu.getUserName()); //订票的账号 
			oderInfo.setOpenID(fu.getOpenID()); //订票的openId
			if(qsQidong().size()>0){
				oderInfo.setLicense(qsQidong().get(0).getNumber());
			}
			
			//预定中信航航班(先查找接口是否还有座位)
			Integer seatNum = new OptimizeECUtils().confirmCabin(oderInfo.getChufCity(), oderInfo.getDaodCity(), oderInfo.getChufDate(), oderInfo.getHangbanNum(), oderInfo.getCabin());
			if(seatNum!=null){
				PnrResponse resuletData = null;
				try {resuletData = Reserve(oderInfo);} catch (Exception e) {}
				if(resuletData==null){
					oderInfo.setIsSuccess("0");
					mAl.setDepCity(oderInfo.getDaodCity());
					mAl.setOrgCity(oderInfo.getChufCity());
					mAl.setIsOk("0");
					mAl.setCommit("系统出错，请稍后再试！");
				}else{
					oderInfo.setPNR(resuletData.getPnrNo());
					oderInfo.setIsSuccess("1");
					mAl.setDepCity(oderInfo.getDaodCity());
					mAl.setOrgCity(oderInfo.getChufCity());
					mAl.setIsOk("1");
					mAl.setPntr(resuletData.getPnrNo());
					addOrder(oderInfo); //把订单数据保存到数据库中。
				}
			}else{
				oderInfo.setIsSuccess("0");
				mAl.setDepCity(oderInfo.getChufCity());
				mAl.setOrgCity(oderInfo.getDaodCity());
				mAl.setIsOk("0");
				mAl.setCommit("座位已为空,请预定其他航班");
			}
			try {
			} catch (Exception e) {
				
			}
			
			return mAl;
		}
		
		//根据航班号和舱位查找数据库中缓存好的价格
		public SeatPriceData findPrice(String fildNum,String canbin,String cfCity,String ddCity){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar c = Calendar.getInstance();
			c.add(Calendar.DAY_OF_YEAR, -180);
			Date date = c.getTime();
			String pastTime = sdf.format(date);
			List<SeatPriceData> spd = gDao.find("FROM SeatPriceData WHERE ((orgCity = '"+cfCity+"' AND dstCity = '"+ddCity+"') OR (dstCity = '"+cfCity+"' AND orgCity = '"+ddCity+"')) AND cabin = '"+canbin+"' AND airline = '"+fildNum.substring(0,2)+"' AND DATE_FORMAT(createTime,'%Y-%m-%d') > '"+pastTime+"'");
			return spd.get(0);
		}
		
		//查找保险的价格
		public List<Insurance> findByBx(){ 
			List<Insurance> sepList = gDao.find("FROM Insurance");
			return sepList;
		}
		
		//查找快递的价格
		public List<kdCost> kdCost(){
			List<kdCost> sepList = gDao.find("FROM kdCost WHERE uuid = '4028831c5ccdf185015ccdf2dea70000'");
			return sepList;
		}

		//判断优惠码是否启动
		public List<yhNum> qsQidong(){
			List<yhNum> sepList = gDao.find("FROM yhNum WHERE ID = '402881e656b0f41a0156b0f9dc5a0000' AND status = '1'");
			return sepList;
		}
		
		//获取ctct码
		public List<CTCTnum> ctctNum(){
			List<CTCTnum> sepList = gDao.find("FROM CTCTnum WHERE uuid = '402881e656b0f41a0156b0f9dc5a0000'");
			return sepList;
		}
		
		public static void main(String[] args) {
			//rtPnr("JM8RKQ");
			pointDate("2017-05-26");
		}
		
}
