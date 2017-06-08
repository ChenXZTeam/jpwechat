package com.solar.tech.bean.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "RD_KDORDER")
public class kdOrder {
	//uuid
	@Id
	@GeneratedValue(generator = "uuid")
	@GenericGenerator(name = "uuid", strategy = "uuid")
	@Column(name = "uuid", length=100)
	private String uuid;
	
	//快递单号
	@Column(name = "kdOrderNum")
	private String kdOrderNum;
	
	//快递公司
	@Column(name = "kdCompany")
	private String kdCompany;
	
	//是否已使用
	@Column(name = "isUsed")
	private String isUsed;
	
	//创建时间
	@Column(name = "createTime")
	private Timestamp createTime;
	
	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getKdOrderNum() {
		return kdOrderNum;
	}

	public void setKdOrderNum(String kdOrderNum) {
		this.kdOrderNum = kdOrderNum;
	}

	public String getKdCompany() {
		return kdCompany;
	}

	public void setKdCompany(String kdCompany) {
		this.kdCompany = kdCompany;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public String getIsUsed() {
		return isUsed;
	}

	public void setIsUsed(String isUsed) {
		this.isUsed = isUsed;
	}
	
}
