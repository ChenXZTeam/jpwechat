package com.solar.tech.bean.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 短信发送记录模块
 * 
 * @author solarpc1
 *
 */
@Entity
@Table(name = "dx_phoneMess")
public class phoneMess {
	// 订单id
	@Id
	@GeneratedValue(generator = "uuid")
	@GenericGenerator(name = "uuid", strategy = "uuid")
	@Column(name = "ID", length = 100)
	private String ID;
	public static final String OID = "ID";

	@Column(name = "phoneNumber")
	private String phoneNumber; // 发送的手机

	@Column(name = "userName", length = 50)
	private String userName; // 操作员

	@Column(name = "text")
	private String text; // 发送的内容

	@Column(name = "userMode")
	private int userMode; // 信息模板

	@Column(name = "createTime")
	private Timestamp createTime; // 发送的时间

	@Column(name = "zuNumber", length = 100)
	private String zuNumber;//

	//1.发送成功  0、发送失败
	@Column(name = "sendType")
	private int sendType; //发送状态
	
	public int getSendType() {
		return sendType;
	}

	public void setSendType(int sendType) {
		this.sendType = sendType;
	}

	public String getID() {
		return ID;
	}

	public void setID(String iD) {
		ID = iD;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getUserMode() {
		return userMode;
	}

	public void setUserMode(int userMode) {
		this.userMode = userMode;
	}

	public String getZuNumber() {
		return zuNumber;
	}

	public void setZuNumber(String zuNumber) {
		this.zuNumber = zuNumber;
	}
	
}
