package com.solar.tech.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.Test;
import com.solar.tech.utils.ECUtils;
import com.solar.tech.utils.OptimizeECUtils;
import com.solar.tech.bean.entity.FlightInfo;
import com.solar.tech.dao.GenericDao;
import com.travelsky.sbeclient.obe.response.AVDoubleResponse;

/**
 * @title PlanTekService 处理机票的查询、预定的类
 * @author solarpc1
 *
 */
@Service
@Transactional
public class PlanTekService {
	@Resource
	private GenericDao gDao;
	
	/**
	 * @title 传入出发城市、到达城市、日期、航班号及舱位，返回该舱位可用座位数 
	 */
	//传入出发城市、到达城市、日期及航空公司代码  例如："CAN", "PEK", "2016-12-01", "CZ"
	public List<FlightInfo> findHB(String chufCity,String daodCity,String airCode, String dateTime, String filgNo, String direct, String noStop){//cancelPnr
		List<FlightInfo> list = new OptimizeECUtils().query(chufCity, daodCity, dateTime, airCode , filgNo, direct, noStop); // 传入出发城市、到达城市、日期、航空公司代码是否直达、是否有经停点
		if(list.size()<1){
			return null;
		}
		return list;
	}
	
	//返回往返的全部航班信息
	/*public Map<String,Object> roundtripAv(String org, String dst, String date, String returnDate, String airline, Integer page){
			Map<String,Object> map  = new OptimizeECUtils().roundtripAv(org, dst, date, returnDate, airline, page);
			return map;
	}*/
	
	
	// 剔除重复的数据
	public List<FlightInfo> removeRepeat(List<FlightInfo> list){
		List<FlightInfo> resultList = new ArrayList<FlightInfo>();
		
		if(list != null && list.size() > 0){
			for(FlightInfo info : list){
				boolean flag = true;
				for(FlightInfo rInfo : resultList){
					if(info.getFlightNo().equals(rInfo.getFlightNo())){
						flag = false;
						break;
					}
				}
				if(flag){
					resultList.add(info);
				}
			}
		}
		
		return resultList;
	}
	
	/**
	 * 组合中转航班的方法
	 */
	public List<FlightInfo> zuhe(List<FlightInfo> list){
		List<FlightInfo> resultList = new ArrayList<FlightInfo>();
		Random random = new Random();
		for(int i=0; i<list.size(); i++){
			for(int j=list.size()-1; j>i; j--){
				if((list.get(i).getDstCity()).equals(list.get(j).getOrgCity())&&(list.get(i).getAirCode()).equals(list.get(j).getAirCode())&&changeSS(list.get(i).getArrTime(),list.get(j).getDepTime())>3600){
					String[] storeInvitationChars={"A","B","C","D","1","E","F","G","H","2","I","0","J","K","3","L","M","8","N","4","O","P","5","Q","R","9","S","T","U","V","6","W","X","Y","7","Z"};
					String sign = ""; //为两个符合的航班加上标识，以便在前台组合
					for(int k=0; k<20; k++){
		    			int index = random.nextInt(35);
		    			sign += storeInvitationChars[index];
		    		}
					resultList.add(list.get(i));
					resultList.add(list.get(j));
				}
			}
		}
		return resultList;
	}
	
	/**
	 * 将时间化成秒
	 * @param start
	 * @param overt
	 * @return
	 */
	public static int changeSS(String start, String overt){
		//将时间转换成秒来比较
		String shh=null,smm=null,sdd=null;
		int scount;
		int ocount; //定义总时间的两个变量
		String ohh=null,omm=null,odd=null;
		
		if(start.indexOf("+")>0){
			shh = start.substring(0,2);
			smm = start.substring(2,4);
			sdd = start.substring(4,start.length());
			scount = (Integer.parseInt(shh)*3600)+(Integer.parseInt(smm)*60)+(24*3600);
		}else{
			shh = start.substring(0,2);
			smm = start.substring(2,start.length());
			sdd = "0";
			scount = (Integer.parseInt(shh)*3600)+(Integer.parseInt(smm)*60);
		}
		
		if(overt.indexOf("+")>0){
				ohh = overt.substring(0,2);
				omm = overt.substring(2,4);
				odd = overt.substring(4,overt.length());
				ocount = (Integer.parseInt(ohh)*3600)+(Integer.parseInt(omm)*60)+(24*3600);
		}else{
				ohh = overt.substring(0,2);
				omm = overt.substring(2,overt.length());
				odd = "0";
				ocount = (Integer.parseInt(ohh)*3600)+(Integer.parseInt(omm)*60);
		}
		return ocount-scount;
	}
	
	/*//临时方法
	public List getPlanList(){
		String sql = "select CODE,cn_name from b_airways";
		return this.gDao.executeJDBCSqlQuery(sql);
	}*/
}
