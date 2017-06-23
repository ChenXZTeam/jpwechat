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
	
	//证件号码
	@Column(name = "idCard")
	private String idCard;
	
	//航意险
	@Column(name = "yiwaiBX")
	private String yiwaiBX;
	
	//航意险单号
	@Column(name = "yiwaiNum")
	private String yiwaiNum;
	
	//延误险
	@Column(name = "yanwuBX")
	private String yanwuBX;
	
	//延误险单号
	@Column(name = "yanwuNum")
	private String yanwuNum;
	
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

	public String getYiwaiBX() {
		return yiwaiBX;
	}

	public void setYiwaiBX(String yiwaiBX) {
		this.yiwaiBX = yiwaiBX;
	}

	public String getYiwaiNum() {
		return yiwaiNum;
	}

	public void setYiwaiNum(String yiwaiNum) {
		this.yiwaiNum = yiwaiNum;
	}

	public String getYanwuBX() {
		return yanwuBX;
	}

	public void setYanwuBX(String yanwuBX) {
		this.yanwuBX = yanwuBX;
	}

	public String getYanwuNum() {
		return yanwuNum;
	}

	public void setYanwuNum(String yanwuNum) {
		this.yanwuNum = yanwuNum;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
	
}
