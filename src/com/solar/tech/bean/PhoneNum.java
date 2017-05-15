package com.solar.tech.bean;
 
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="FW_phoneNum")
public class PhoneNum {
	//ID
    @Id
    @GenericGenerator(name="uuid", strategy="uuid")
    @GeneratedValue(generator="uuid")
    @Column(name="phoneID", length=50)
	private String phoneID;
    
    //手机用户
    @Column(name="linkName",length=100)
    private String linkName;

	//手机号
    @Column(name="phoneNumber", length=50)
	private String phoneNumber;
    
    //所属分组
    @Column(name="fzName", length=25)
    private String fzName;
    
    //登录账号
    @Column(name="userName", length=50)
    private String userName;

	//创建时间
	@Column(name = "createTime")
	private Timestamp createTime;

	public String getPhoneID() {
		return phoneID;
	}

	public void setPhoneID(String phoneID) {
		this.phoneID = phoneID;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public String getLinkName() {
		return linkName;
	}

	public void setLinkName(String linkName) {
		this.linkName = linkName;
	}

	public String getFzName() {
		return fzName;
	}

	public void setFzName(String fzName) {
		this.fzName = fzName;
	}
	
 }
