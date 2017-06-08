package com.solar.tech.bean.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="FW_BXORDER")
public class bxOrder {
	//uuid
	@Id
	@GeneratedValue(generator = "uuid")
	@GenericGenerator(name = "uuid", strategy = "uuid")
	@Column(name = "uuid", length=100)
	private String uuid;
		
	//机票单号
	@Column(name = "orderNum")
	private String orderNum;
	
	//客户名称
	@Column(name = "customer")
	private String customer;
	
	//保险单号
	@Column(name = "bxNum")
	private String bxNum;
	
	//险种
	@Column(name = "bxType")
	private String bxType;
	
	//保险价格
	@Column(name = "bxMoney")
	private String bxMoney;
	
	//创建时间
	@Column(name = "createTime")
	private Timestamp createTime;

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}

	public String getCustomer() {
		return customer;
	}

	public void setCustomer(String customer) {
		this.customer = customer;
	}

	public String getBxType() {
		return bxType;
	}

	public void setBxType(String bxType) {
		this.bxType = bxType;
	}

	public String getBxMoney() {
		return bxMoney;
	}

	public void setBxMoney(String bxMoney) {
		this.bxMoney = bxMoney;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public String getBxNum() {
		return bxNum;
	}

	public void setBxNum(String bxNum) {
		this.bxNum = bxNum;
	}
	
}
