package com.solar.tech.bean.entity;

import java.util.ArrayList;
import java.util.List;

public class FlightInfo {
	private String airCode; // 航空公司二字码
	private String flightNo; // 航班号
	private String planeStyle; // 机型
	private String depTime; // 起飞时间
	private String orgCity; // 起始城市
	private String arrTime; // 到达时间
	private String dstCity; // 到达城市
	
	private List<SeatInfo> seatList = new ArrayList<SeatInfo>(); // 可用舱位信息
	
	public List<SeatInfo> getSeatList() {
		return seatList;
	}

	public void setSeatList(List<SeatInfo> seatList) {
		this.seatList = seatList;
	}

	public String getAirCode() {
		return airCode;
	}

	public void setAirCode(String airCode) {
		this.airCode = airCode;
	}

	public String getFlightNo() {
		return flightNo;
	}

	public void setFlightNo(String flightNo) {
		this.flightNo = flightNo;
	}

	public String getPlaneStyle() {
		return planeStyle;
	}

	public void setPlaneStyle(String planeStyle) {
		this.planeStyle = planeStyle;
	}

	public String getDepTime() {
		return depTime;
	}

	public void setDepTime(String depTime) {
		this.depTime = depTime;
	}

	public String getOrgCity() {
		return orgCity;
	}

	public void setOrgCity(String orgCity) {
		this.orgCity = orgCity;
	}

	public String getArrTime() {
		return arrTime;
	}

	public void setArrTime(String arrTime) {
		this.arrTime = arrTime;
	}

	public String getDstCity() {
		return dstCity;
	}

	public void setDstCity(String dstCity) {
		this.dstCity = dstCity;
	}
}