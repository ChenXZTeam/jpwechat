package com.solar.tech.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.entity.airport;
import com.solar.tech.bean.entity.userOrderInfo;
import com.solar.tech.dao.GenericDao;

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
	public String getRandomString(String sign){
		long time = System.currentTimeMillis();//加上时间戳
		String[] storeChars = {"0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};
		Random random = new Random();
		String codesign = "";
		for(int i=0; i<10; i++){
			int index = random.nextInt(35);
			codesign += storeChars[index];
		}
		return sign+codesign+time;
	}
	
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
		public int deleteOrder(String ID, String orderNum) {
			try {
				if(orderNum != null){
					String sql = "UPDATE userorderinfo SET AdminDel = 1 WHERE ID = '"+ID+"' AND orderNum = '"+orderNum+"'";
					gDao.executeJDBCSql(sql);
				}
				return 1;  
			}catch (Exception e) {
				//log.info("msg", e.getCause());
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
		
}
