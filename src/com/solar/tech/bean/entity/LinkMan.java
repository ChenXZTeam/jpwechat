package com.solar.tech.bean.entity;

import java.sql.Timestamp;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 常用联系人
 * @author solarpc1
 *
 */
@Entity
@Table(name="FW_linkman")
public class LinkMan {
	//签证ID
    @Id
    @GenericGenerator(name="uuid", strategy="uuid")
    @GeneratedValue(generator="uuid")
    @Column(name="ID", length=50)
	private String ID;
    
   //联系人
    @Column(name="linkman", length=200)
	private String linkman;
    
    //联系电话
    @Column(name="linkNumber", length=50)
    private String linkNumber;
    
    //证件类型
    @Column(name="caseType", length=15)
    private String caseType; 
    
    //证件类型
    @Column(name="caseNum", length=50)
    private String caseNum;
    
    //生日
    @Column(name="birthday", length=15)
    private String birthday;
    
    //生日
    @Column(name="sex", length=15)
    private String sex;
    
    //旅客类型
    @Column(name="peopleType",length=10)
    private String peopleType;
    
    //用户对应的openid
  	@Column(name="openID",length=100)
  	private String openID;
  	
  	//用户名
  	@Column(name = "UserName", length=100)
  	private String UserName;
    
   //创建时间
  	@Column(name = "createTime")
  	private Timestamp createTime;

	public String getID() {
		return ID;
	}

	public void setID(String iD) {
		ID = iD;
	}

	public String getLinkman() {
		return linkman;
	}

	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}

	public String getLinkNumber() {
		return linkNumber;
	}

	public void setLinkNumber(String linkNumber) {
		this.linkNumber = linkNumber;
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

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public String getCaseType() {
		return caseType;
	}

	public void setCaseType(String caseType) {
		this.caseType = caseType;
	}

	public String getCaseNum() {
		return caseNum;
	}

	public void setCaseNum(String caseNum) {
		this.caseNum = caseNum;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getPeopleType() {
		return peopleType;
	}

	public void setPeopleType(String peopleType) {
		this.peopleType = peopleType;
	}

}  	
	