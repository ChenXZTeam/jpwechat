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

	
  	
}  	
	