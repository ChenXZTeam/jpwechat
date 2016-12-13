package com.solar.tech.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.solar.tech.bean.entity.SeatInfo;
import com.travelsky.sbeclient.obe.response.AvSegment;
import com.travelsky.sbeclient.obe.response.FDItem;

/**
 * 根据出发地、目的地、出发时间、航空公司二字码 条件搜索对应的座位和运价 并重构座位信息
 * @author solarpc1
 */
public class fd_av {
	
	public List<SeatInfo> seatInfo(String org, String dst, String date, String airCode, String flighNo){
		List<SeatInfo> sInfo = new ArrayList<SeatInfo>();
		List<FDItem> fdList = new ECUtils().fd(org, dst, date, airCode, null, null, null); // 查询运价
		List<AvSegment> avList = new ECUtils().av(org, dst, date, null, airCode, null, null, null, null); // 查询座位可用
		
		String[] data = avList.get(0).getCangwei_data(); // 初始化座位数据
		char[] index = avList.get(0).getCangwei_index(); // 初始化座位信息
		
		AvSegment avSeg = null;
		for(AvSegment as : avList){
			// 根据当前航班号、起始城市及到达城市，得到对应的座位信息
			if(flighNo.equals(as.getAirline()) && org.equals(as.getOrgcity()) && dst.equals(as.getDstcity())){
				avSeg = as;
			}
		}
		
		if(avSeg != null){
			data = avSeg.getCangwei_data(); // 得到对应的座位信息
			index = avSeg.getCangwei_index(); // 得到对应的座位信息
		}
		
		if(index != null && index.length > 0){
			for(int i=0;i<index.length;i++){
				SeatInfo seatInfo = new SeatInfo();
				
				seatInfo.setCangwei(index[i] + ""); // 设置舱位
				seatInfo.setCangwei_data(data[i]); // 设置舱位信息
				
				if(SeatUtils.getSeatNum(data[i]) != null){
					if(fdList != null && fdList.size() > 0){
						for(FDItem item : fdList){
							// 根据当前航司代码、及舱位获取对应的运价信息
							if(airCode.equals(item.getAirline()) && (index[i] + "").equals(item.getCabin())){
								if(!StringUtils.isEmpty(item.getOnewayPrice())){
									seatInfo.setOnewayPrice(item.getOnewayPrice()); // 设置单程运价
								}
								if(!StringUtils.isEmpty(item.getRoundtripPrice())){
									seatInfo.setRoundtripPrice(item.getRoundtripPrice()); // 设置往返运价
								}
								if(!StringUtils.isEmpty(item.getBasicCabin())){
									seatInfo.setBasicCabin(item.getBasicCabin()); // 设置基础舱位信息
								}
							}
						}
					}
				}
				if(!StringUtils.isEmpty(seatInfo.getOnewayPrice()) && !StringUtils.isEmpty(seatInfo.getRoundtripPrice())){
					sInfo.add(seatInfo); // 添加可用舱位信息
				}
			}
		}

		return sInfo;
	}
	
	public String getNextDate(String sDate, String datstr, int iCal, String sStr){  
        String sNextDate = "";  
        Calendar calendar = Calendar.getInstance();  
        int iDate = 0;
        if(datstr.indexOf("+")>=0){
        	iDate = 1;
        }
        SimpleDateFormat formatter = new SimpleDateFormat(sStr);  
        Date date = null;  
        try {  
            date = formatter.parse(sDate);  
        } catch (ParseException e) {  
            e.printStackTrace();  
        }  
        calendar.setTime(date);  
        calendar.add(iCal, iDate);  
        sNextDate = formatter.format(calendar.getTime());  
        return sNextDate ;  
	} 
	
}
