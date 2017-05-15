package com.solar.tech.bean.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 把搜索出来的航班信息入库
 * @author solarpc1
 *
 */
@Entity
@Table(name="FW_FLIGHTMESSAGE")
public class FlightMessage {
	//主键
    @Id
    @GenericGenerator(name="uuid", strategy="uuid")
    @GeneratedValue(generator="uuid")
    @Column(name="uuid", length=50)
	private String uuid; 
    
    // 航空公司二字码
    @Column(name="airCode", length=50)
	private String airCode;
    
    // 航班号
    @Column(name="flightNo", length=50)
	private String flightNo;
    
    // 机型
    @Column(name="planeStyle", length=50)
	private String planeStyle;
    
    @Column(name="orgDate", length=50)
    private String orgDate;
    
    // 起飞时间
    @Column(name="depTime", length=50)
	private String depTime;
    
    // 起始城市
    @Column(name="orgCity", length=50)
	private String orgCity;
    
    // 到达时间
    @Column(name="arrTime", length=50)
	private String arrTime;
    
    // 到达城市
    @Column(name="dstCity", length=50)
	private String dstCity;
    
    //座位信息
    @Column(name="seatInfo", length=5000)
    private String seatInfo;
    
    //创建时间
    @Column(name="createTime", length=25)
    private Timestamp createTime;

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
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

	public String getSeatInfo() {
		return seatInfo;
	}

	public void setSeatInfo(String seatInfo) {
		this.seatInfo = seatInfo;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public String getOrgDate() {
		return orgDate;
	}

	public void setOrgDate(String orgDate) {
		this.orgDate = orgDate;
	}
	
}
