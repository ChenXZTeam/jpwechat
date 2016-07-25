package com.solar.tech.bean.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * @Title userOrderInfo (保存订单的信息)
 * @author solarpc1
 *
 */
@Entity
@Table(name = "userOrderInfo")
public class userOrderInfo {	

	//用户id
	@Id
	@GeneratedValue(generator = "uuid")
	@GenericGenerator(name = "uuid", strategy = "uuid")
	@Column(name = "ID", length=100)
	private String ID;
		
	//用户对应的openid
	@Column(name="openID",length=100)
	private String openID;
	
	//用户名
	@Column(name = "UserName", length=100)
	private String UserName;
	
	//订单预约编号
	@Column(name="orderNum",length=100)
	private String orderNum;
	
	//出发日期
	@Column(name="chufDate",length=25)
	private String chufDate;
	
	//出发时间
	@Column(name="chufTime",length=25)
	private String chufTime;
	
	//到达时间
	@Column(name="daodTime",length=25)
	private String daodTime;
	
	//起始机场
	@Column(name="qishiPlane",length=50)
	private String qishiPlane;
	
	//到达机场
	@Column(name="daodPlane",length=50)
	private String daodPlane;
	
	//航班号
	@Column(name="hangbanNum",length=25)
	private String hangbanNum;
	
	//历时多少时间
	@Column(name="cuntTime",length=25)
	private String cuntTime;
	
	//出发城市
	@Column(name="chufCity",length=100)
	private String chufCity;
	
	//到达城市
	@Column(name="daodCity",length=100)
	private String daodCity;
	
	//订单人姓名
	@Column(name="linkName",length=50)
	private String linkName;
	
	//性别
	@Column(name="linkSex",length=6)
	private String linkSex;
	
	//联系人手机号码
	@Column(name="linkPhoneNum",length=25)
	private String linkPhoneNum;
	
	//证件
	@Column(name="IDcase",length=100)
	private String IDcase;
	
	//证件类型
	@Column(name="IDcaseType",length=20)
	private String IDcaseType;
	
	//是否购买意外险
	@Column(name="yiwaiBX",length=6)
	private String yiwaiBX;
	
	//是否购买延误险
	@Column(name="yanwuBX",length=6)
	private String yanwuBX;
	
	//总共金额
	@Column(name="costMoney",length=50)
	private String costMoney;
	
	//付款状态(0:未付  1:已付)
	@Column(name="stutisPay",length=6)
	private String stutisPay;
	
	//是否已登机(0:未登机  1:已登机)
	@Column(name="takePlane",length=6)
	private String takePlane;
	
	
	public String getID() {
		return ID;
	}

	public void setID(String iD) {
		ID = iD;
	}

	public String getOpenID() {
		return openID;
	}

	public void setOpenID(String openID) {
		this.openID = openID;
	}

	public String getUserName() {
		return UserName;
	}

	public void setUserName(String userName) {
		UserName = userName;
	}

	public String getChufDate() {
		return chufDate;
	}

	public void setChufDate(String chufDate) {
		this.chufDate = chufDate;
	}

	public String getChufTime() {
		return chufTime;
	}

	public void setChufTime(String chufTime) {
		this.chufTime = chufTime;
	}	

	public String getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}

	public String getDaodTime() {
		return daodTime;
	}

	public void setDaodTime(String daodTime) {
		this.daodTime = daodTime;
	}

	public String getQishiPlane() {
		return qishiPlane;
	}

	public void setQishiPlane(String qishiPlane) {
		this.qishiPlane = qishiPlane;
	}

	public String getDaodPlane() {
		return daodPlane;
	}

	public void setDaodPlane(String daodPlane) {
		this.daodPlane = daodPlane;
	}

	public String getHangbanNum() {
		return hangbanNum;
	}

	public void setHangbanNum(String hangbanNum) {
		this.hangbanNum = hangbanNum;
	}

	public String getCuntTime() {
		return cuntTime;
	}

	public void setCuntTime(String cuntTime) {
		this.cuntTime = cuntTime;
	}

	public String getChufCity() {
		return chufCity;
	}

	public void setChufCity(String chufCity) {
		this.chufCity = chufCity;
	}

	public String getDaodCity() {
		return daodCity;
	}

	public void setDaodCity(String daodCity) {
		this.daodCity = daodCity;
	}

	public String getLinkName() {
		return linkName;
	}

	public void setLinkName(String linkName) {
		this.linkName = linkName;
	}

	public String getLinkSex() {
		return linkSex;
	}

	public void setLinkSex(String linkSex) {
		this.linkSex = linkSex;
	}

	public String getLinkPhoneNum() {
		return linkPhoneNum;
	}

	public void setLinkPhoneNum(String linkPhoneNum) {
		this.linkPhoneNum = linkPhoneNum;
	}

	public String getIDcase() {
		return IDcase;
	}

	public void setIDcase(String iDcase) {
		IDcase = iDcase;
	}

	public String getIDcaseType() {
		return IDcaseType;
	}

	public void setIDcaseType(String iDcaseType) {
		IDcaseType = iDcaseType;
	}

	public String getYiwaiBX() {
		return yiwaiBX;
	}

	public void setYiwaiBX(String yiwaiBX) {
		this.yiwaiBX = yiwaiBX;
	}

	public String getYanwuBX() {
		return yanwuBX;
	}

	public void setYanwuBX(String yanwuBX) {
		this.yanwuBX = yanwuBX;
	}

	public String getCostMoney() {
		return costMoney;
	}

	public void setCostMoney(String costMoney) {
		this.costMoney = costMoney;
	}

	public String getStutisPay() {
		return stutisPay;
	}

	public void setStutisPay(String stutisPay) {
		this.stutisPay = stutisPay;
	}

	public String getTakePlane() {
		return takePlane;
	}

	public void setTakePlane(String takePlane) {
		this.takePlane = takePlane;
	}
	
}