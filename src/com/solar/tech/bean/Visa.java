package com.solar.tech.bean;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="FW_visa")
public class Visa {
    @Id
    @GenericGenerator(name="uuid", strategy="uuid")
    @GeneratedValue(generator="uuid")
    @Column(name="visaID", length=50)
	//签证ID
	private String visaID;
    
    @Column(name="immigrationOfTimes", length=50)
	//入境次数
	private String immigrationOfTimes;
    
    @Column(name="sojournTime", length=50)
	//逗留天数
	private String sojournTime;
    
    @Column(name="periodOfValidity", length=50)
	//有效期限
	private String periodOfValidity;
    
    @Column(name="visaType", length=50)
	//签证类型
	private String visaType;
    
	//最早可定日期
	private Date earlyDates ;
	
	@Column(name="elapsedTime", length=50)
	//办理时长
	private String elapsedTime;
	
	@Column(name="serviceContent", length=500)
	//服务内容
	private String serviceContent;
	
	@Column(name="scopeOfAcceptance", length=500)
	//受理范围
	private String scopeOfAcceptance;
	
	@Column(name="immigrationFlow", length=1000)
	//办理流程
	private String immigrationFlow;
	
	@Column(name="visaTitle", length=100)
	//签证标题
	private String visaTitle;
	
	//签证价格
	private double visaPrice;
	
	//国家
	@Column(name="country", length=20)
	private String country;
	
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getVisaTitle() {
		return visaTitle;
	}
	public void setVisaTitle(String visaTitle) {
		this.visaTitle = visaTitle;
	}
	public double getVisaPrice() {
		return visaPrice;
	}
	public void setVisaPrice(double visaPrice) {
		this.visaPrice = visaPrice;
	}
	public String getVisaID() {
		return visaID;
	}
	public void setVisaID(String visaID) {
		this.visaID = visaID;
	}
	public String getImmigrationOfTimes() {
		return immigrationOfTimes;
	}
	public void setImmigrationOfTimes(String immigrationOfTimes) {
		this.immigrationOfTimes = immigrationOfTimes;
	}
	public String getSojournTime() {
		return sojournTime;
	}
	public void setSojournTime(String sojournTime) {
		this.sojournTime = sojournTime;
	}
	public String getPeriodOfValidity() {
		return periodOfValidity;
	}
	public void setPeriodOfValidity(String periodOfValidity) {
		this.periodOfValidity = periodOfValidity;
	}
	public String getVisaType() {
		return visaType;
	}
	public void setVisaType(String visaType) {
		this.visaType = visaType;
	}
	public Date getEarlyDates() {
		return earlyDates;
	}
	public void setEarlyDates(Date earlyDates) {
		this.earlyDates = earlyDates;
	}
	public String getElapsedTime() {
		return elapsedTime;
	}
	public void setElapsedTime(String elapsedTime) {
		this.elapsedTime = elapsedTime;
	}
	public String getServiceContent() {
		return serviceContent;
	}
	public void setServiceContent(String serviceContent) {
		this.serviceContent = serviceContent;
	}
	public String getScopeOfAcceptance() {
		return scopeOfAcceptance;
	}
	public void setScopeOfAcceptance(String scopeOfAcceptance) {
		this.scopeOfAcceptance = scopeOfAcceptance;
	}
	public String getImmigrationFlow() {
		return immigrationFlow;
	}
	public void setImmigrationFlow(String immigrationFlow) {
		this.immigrationFlow = immigrationFlow;
	}
	@Override
	public String toString() {
		return "Visa [visaID=" + visaID + ", immigrationOfTimes=" + immigrationOfTimes + ", sojournTime=" + sojournTime
				+ ", periodOfValidity=" + periodOfValidity + ", visaType=" + visaType + ", earlyDates=" + earlyDates
				+ ", elapsedTime=" + elapsedTime + ", serviceContent=" + serviceContent + ", scopeOfAcceptance="
				+ scopeOfAcceptance + ", immigrationFlow=" + immigrationFlow + ", visaTitle=" + visaTitle
				+ ", visaPrice=" + visaPrice + ", country=" + country + "]";
	}
 }
