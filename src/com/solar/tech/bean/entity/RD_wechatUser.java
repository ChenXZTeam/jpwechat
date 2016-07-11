package com.solar.tech.bean.entity;

import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Column;

import org.hibernate.annotations.GenericGenerator;

/**
 * 
 * @ClassName: RD_wechatUser （微信用户登录表）
 * @Description: TODO
 * @author: solarpc1
 * @date: 2016年7月11日 上午11:32:46
 */
@Entity
@Table(name = "RD_wechatUser")
public class RD_wechatUser {
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
	
	//用户密码
	@Column(name = "PassWord", length=100)
	private String PassWord;
	
	//绑定时间
	@Column(name = "BindTime")
	private Timestamp BindTime;
	
	//联系电话
	@Column(name = "PhoneNum", length=20)
	private String PhoneNum;
	
	//邀请码
	@Column(name="InCode",length=10)
	private String InCode;

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

	public String getPassWord() {
		return PassWord;
	}

	public void setPassWord(String passWord) {
		PassWord = passWord;
	}

	public Timestamp getBindTime() {
		return BindTime;
	}

	public void setBindTime(Timestamp bindTime) {
		BindTime = bindTime;
	}

	public String getPhoneNum() {
		return PhoneNum;
	}

	public void setPhoneNum(String phoneNum) {
		PhoneNum = phoneNum;
	}

	public String getInCode() {
		return InCode;
	}

	public void setInCode(String inCode) {
		InCode = inCode;
	}
	
	
}
