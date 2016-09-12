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
	//签证ID
    @Id
    @GenericGenerator(name="uuid", strategy="uuid")
    @GeneratedValue(generator="uuid")
    @Column(name="visaID", length=50)
	private String visaID;

	//入境次数
    @Column(name="immigrationOfTimes", length=50)
	private String immigrationOfTimes;

	//逗留天数
    @Column(name="sojournTime", length=50)
	private String sojournTime;

	//有效期限
    @Column(name="periodOfValidity", length=50)
	private String periodOfValidity;

	//签证类型
    @Column(name="visaType", length=50)
	private String visaType;
    
	//最早可定日期
    @Column(name="earlyDates", length=50)
	private String earlyDates ;

	//办理时长
	@Column(name="elapsedTime", length=50)
	private String elapsedTime;

	//服务内容
	@Column(name="serviceContent", length=500)
	private String serviceContent;

	//受理范围
	@Column(name="scopeOfAcceptance", length=500)
	private String scopeOfAcceptance;

	//办理流程
	@Column(name="immigrationFlow", length=1000)
	private String immigrationFlow;

	//签证标题
	@Column(name="visaTitle", length=100)
	private String visaTitle;
	
	//签证价格
	@Column(name="visaPrice", length=100)
	private String visaPrice;
	
	//国家
	@Column(name="country", length=20)
	private String country;
	
	//国家编号
	@Column(name="countryID", length=20)
	private String countryID;
	
	//国家属于的大洲范围
	@Column(name="cotryBelongWhat", length=20)
	private String cotryBelongWhat;
	
	//签证方式(3.免签、2.落地签、1.热门推荐、4.无)
	@Column(name="qzMode", length=5)
	private String qzMode;
	
	//该国家旅游风景介绍
	@Column(name="TouryIntro", length=1000)
	private String TouryIntro;
	
	//标识数据是否最新插入
	@Column(name="newDataNum", length=10)
	private String newDataNum;
	
	public String getNewDataNum() {
		return newDataNum;
	}
	public void setNewDataNum(String newDataNum) {
		this.newDataNum = newDataNum;
	}
	public String getTouryIntro() {
		return TouryIntro;
	}
	public void setTouryIntro(String touryIntro) {
		TouryIntro = touryIntro;
	}
	public String getQzMode() {
		return qzMode;
	}
	public void setQzMode(String qzMode) {
		this.qzMode = qzMode;
	}
	public String getCotryBelongWhat() {
		return cotryBelongWhat;
	}
	public void setCotryBelongWhat(String cotryBelongWhat) {
		this.cotryBelongWhat = cotryBelongWhat;
	}
	
	public String getCountryID() {
		return countryID;
	}
	public void setCountryID(String countryID) {
		this.countryID = countryID;
	}
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
	
	public void setVisaPrice(String visaPrice) {
		this.visaPrice = visaPrice;
	}
	
	public String getVisaPrice() {
		return visaPrice;
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
	
	public String getEarlyDates() {
		return earlyDates;
	}
	public void setEarlyDates(String earlyDates) {
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
