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
	
	//到达时间
	@Column(name="daodTime",length=25)
	private String daodTime;
	
	//起始机场
	@Column(name="qishiPlane",length=50)
	private String qishiPlane;
	
	//起始机场的三字码
	@Column(name="qishiPlaneCode",length=5)
	private String qishiPlaneCode;
	
	//到达机场
	@Column(name="daodPlane",length=50)
	private String daodPlane;
	
	//到达机场的三字码
	@Column(name="daodPlaneCode",length=5)
	private String daodPlaneCode;
		
	//航班号
	@Column(name="hangbanNum",length=25)
	private String hangbanNum;
	
	//航空公司的code
	@Column(name="airCode",length=10)
	private String airCode;

	//历时多少时间
	@Column(name="cuntTime",length=25)
	private String cuntTime;
	
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
	
	//用于预约编号识别最大的
	@Column(name = "intNum", length=20)
	private String intNum;
	 
	//中航信预定成功之后的编号
	@Column(name="PNR",length=25)
	private String PNR;
	
	//出票时间
	@Column(name="getTeickTime",length=25)
	private String getTeickTime;
	
	//用户删除
	@Column(name="AdminDel",length=5)
	private String AdminDel;
	
	// 修改这条数据的时间
	@Column(name = "updateTime")
	private Timestamp updateTime;
	
	//创建时间
	@Column(name = "createTime")
	private Timestamp createTime;
	
	//票号
	@Column(name = "telNum")
	private String telNum;
	
	//标识两个订单之间是否是往返
	@Column(name = "wfsign")
	private String wfsign;
	
	//标识两个订单之间是否是中转
	@Column(name = "zzsign")
	private String zzsign;

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

	public String getIntNum() {
		return intNum;
	}

	public void setIntNum(String intNum) {
		this.intNum = intNum;
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
	
	public String getAirCode() {
		return airCode;
	}

	public void setAirCode(String airCode) {
		this.airCode = airCode;
	}
	
	public String getQishiPlaneCode() {
		return qishiPlaneCode;
	}

	public void setQishiPlaneCode(String qishiPlaneCode) {
		this.qishiPlaneCode = qishiPlaneCode;
	}

	public String getDaodPlaneCode() {
		return daodPlaneCode;
	}

	public void setDaodPlaneCode(String daodPlaneCode) {
		this.daodPlaneCode = daodPlaneCode;
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

	public String getWfsign() {
		return wfsign;
	}

	public void setWfsign(String wfsign) {
		this.wfsign = wfsign;
	}

	public String getZzsign() {
		return zzsign;
	}

	public void setZzsign(String zzsign) {
		this.zzsign = zzsign;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

}
