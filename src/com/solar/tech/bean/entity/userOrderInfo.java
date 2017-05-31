package com.solar.tech.bean.entity;

import java.sql.Timestamp;

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
	
	//到达日期
	@Column(name="daodDate",length=25)
	private String daodDate;
	
	//到达时间
	@Column(name="daodTime",length=25)
	private String daodTime;
		
	//航班号
	@Column(name="hangbanNum",length=25)
	private String hangbanNum;
	
	//出发城市
	@Column(name="chufCity",length=100)
	private String chufCity;
	
	//到达城市
	@Column(name="daodCity",length=100)
	private String daodCity;
	
	//行动代码
	@Column(name="actionCode",length=10)
	private String actionCode;

	//舱位
	@Column(name="cabin",length=10)
	private String cabin;

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
	
	//出生日期
	@Column(name="birthday",length=15)
	private String birthday;
	
	//年龄
	@Column(name="age",length=10)
	private String age;

	//旅客的类型（旅客类型 ADT 成人,CHD 儿童, UM 无人陪伴儿童）
	@Column(name="psgType",length=5)
	private String psgType;
	
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
	
	//中航信预定成功之后的编号
	@Column(name="PNR",length=25)
	private String PNR;
	
	//出票时间
	@Column(name="getTeickTime",length=25)
	private String getTeickTime;
	
	//用户删除
	@Column(name="AdminDel",length=5)
	private String AdminDel;
	
	//餐饮
	@Column(name="meal",length=5)
	private String meal;
	
	//出发航楼
	@Column(name="depTerm",length=5)
	private String depTerm;
	
	//到达航楼
	@Column(name="arriTerm",length=5)
	private String arriTerm;
	
	// 修改这条数据的时间
	@Column(name = "updateTime")
	private Timestamp updateTime;
	
	//创建时间
	@Column(name = "createTime")
	private Timestamp createTime;
	
	//票号
	@Column(name = "telNum")
	private String telNum;
	
	//记录中航信接口是否预定成功
	@Column(name="isSuccess",length=5)
	private String isSuccess;

	public String getGetTeickTime() {
		return getTeickTime;
	}

	public void setGetTeickTime(String getTeickTime) {
		this.getTeickTime = getTeickTime;
	}

	public String getPNR() {
		return PNR;
	}

	public void setPNR(String pNR) {
		PNR = pNR;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getActionCode() {
		return actionCode;
	}

	public void setActionCode(String actionCode) {
		this.actionCode = actionCode;
	}	
	
	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}
	
	public String getCabin() {
		return cabin;
	}

	public void setCabin(String cabin) {
		this.cabin = cabin;
	}

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

	public String getPsgType() {
		return psgType;
	}

	public void setPsgType(String psgType) {
		this.psgType = psgType;
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

	public String getHangbanNum() {
		return hangbanNum;
	}

	public void setHangbanNum(String hangbanNum) {
		this.hangbanNum = hangbanNum;
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
	
	public String getAdminDel() {
		return AdminDel;
	}

	public void setAdminDel(String adminDel) {
		AdminDel = adminDel;
	}

	public Timestamp getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Timestamp updateTime) {
		this.updateTime = updateTime;
	}

	public String getTelNum() {
		return telNum;
	}

	public void setTelNum(String telNum) {
		this.telNum = telNum;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public String getMeal() {
		return meal;
	}

	public void setMeal(String meal) {
		this.meal = meal;
	}

	public String getDepTerm() {
		return depTerm;
	}

	public void setDepTerm(String depTerm) {
		this.depTerm = depTerm;
	}

	public String getArriTerm() {
		return arriTerm;
	}

	public void setArriTerm(String arriTerm) {
		this.arriTerm = arriTerm;
	}

	public String getDaodDate() {
		return daodDate;
	}

	public void setDaodDate(String daodDate) {
		this.daodDate = daodDate;
	}

	public String getIsSuccess() {
		return isSuccess;
	}

	public void setIsSuccess(String isSuccess) {
		this.isSuccess = isSuccess;
	}

}
