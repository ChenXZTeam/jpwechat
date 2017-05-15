package com.solar.tech.bean.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 将搜索出来的运价保存到数据库中
 * @author solarpc1
 *
 */

@Entity
@Table(name="FW_SEATPRICEDATA")
public class SeatPriceData {
	//主键
    @Id
    @GenericGenerator(name="uuid", strategy="uuid")
    @GeneratedValue(generator="uuid")
    @Column(name="uuid")
	private String uuid; 
    
    //航空公司
    @Column(name="airline")
    private String airline;
    
    //机场建设费
    @Column(name="airportTax")
    private String airportTax;
    
    //舱位类型：经济舱、商务舱、头等舱
    @Column(name="basicCabin")
    private String basicCabin;
    
    //舱位类别
    @Column(name="cabin")
    private String cabin;
    
    //出发城市三字码
    @Column(name="orgCity")
    private String orgCity;
    
    //到达城市三字码
    @Column(name="dstCity")
    private String dstCity;
    
    //燃油费
    @Column(name="fueltax")
    private String fueltax;
    
    //单程价格
    @Column(name="onewayPrice")
    private String onewayPrice;
    
    //往返价格
    @Column(name="roundtripPrice")
    private String roundtripPrice;
    
    //创建时间
    @Column(name="createTime")
    private Timestamp createTime;
    
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public String getAirline() {
		return airline;
	}
	public void setAirline(String airline) {
		this.airline = airline;
	}
	public String getAirportTax() {
		return airportTax;
	}
	public void setAirportTax(String airportTax) {
		this.airportTax = airportTax;
	}
	public String getBasicCabin() {
		return basicCabin;
	}
	public void setBasicCabin(String basicCabin) {
		this.basicCabin = basicCabin;
	}
	public String getCabin() {
		return cabin;
	}
	public void setCabin(String cabin) {
		this.cabin = cabin;
	}
	public String getOrgCity() {
		return orgCity;
	}
	public void setOrgCity(String orgCity) {
		this.orgCity = orgCity;
	}
	public String getDstCity() {
		return dstCity;
	}
	public void setDstCity(String dstCity) {
		this.dstCity = dstCity;
	}
	public String getFueltax() {
		return fueltax;
	}
	public void setFueltax(String fueltax) {
		this.fueltax = fueltax;
	}
	public String getOnewayPrice() {
		return onewayPrice;
	}
	public void setOnewayPrice(String onewayPrice) {
		this.onewayPrice = onewayPrice;
	}
	public String getRoundtripPrice() {
		return roundtripPrice;
	}
	public void setRoundtripPrice(String roundtripPrice) {
		this.roundtripPrice = roundtripPrice;
	}
	public Timestamp getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}
    
}
