package com.solar.tech.utils;

import org.apache.commons.lang.StringUtils;

public class SeatUtils {

	// 根据舱位信息，返回可利用座位数
	public static Integer getSeatNum(String data){
		if("A".equals(data)){
			return 9;
		}else if("L".equals(data) || "Q".equals(data) || "S".equals(data) || "C".equals(data) || "X".equals(data) || "Z".equals(data)){
			return null;
		}else if(!StringUtils.isEmpty(data)){
			return Integer.parseInt(data);
		}
		return null;
	}
	
	// 根据基础舱位类型，返回舱位类型名
	public static String getSeatType(String basicCabin){
		if("F".equals(basicCabin)){
			return "头等舱";
		}else if("C".equals(basicCabin)){
			return "公务舱";
		}else if("Y".equals(basicCabin)){
			return "经济舱";
		}
		return null;
	}
}
