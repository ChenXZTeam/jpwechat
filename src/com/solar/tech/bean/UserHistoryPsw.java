package com.solar.tech.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.GenerationType;
import javax.persistence.GeneratedValue;

import org.hibernate.annotations.GenericGenerator;
@Entity
@Table(name = "FW_UserHistoryPsw")
public class UserHistoryPsw{
	@Id
	@GenericGenerator (name="idgene",strategy="native")
	@GeneratedValue(generator="idgene")
	@Column(name = "UHPID")
	private Integer uhPID;
	
	@Column(name="USERUID", length=50)
	private String userUID;
	
	@Column(name="CName", length=50)
	private String cName;

	@Column(name="UserClass", length=50)
	private String userClass;
	
	@Column(name="DnName", length=200)
	private String dnName;
	
	@Column(name="CreateTime")
	private Date createTime;
	
	@Column(name="CreateBy", length=50)
	private String createBy;

	public Integer getUhPID() {
		return uhPID;
	}

	public void setUhPID(Integer uhPID) {
		this.uhPID = uhPID;
	}

	public String getUserUID() {
		return userUID;
	}

	public void setUserUID(String userUID) {
		this.userUID = userUID;
	}

	public String getcName() {
		return cName;
	}

	public void setcName(String cName) {
		this.cName = cName;
	}

	public String getUserClass() {
		return userClass;
	}

	public void setUserClass(String userClass) {
		this.userClass = userClass;
	}

	public String getDnName() {
		return dnName;
	}

	public void setDnName(String dnName) {
		this.dnName = dnName;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	
	
}