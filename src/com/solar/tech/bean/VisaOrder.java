package com.solar.tech.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="fw_VisaOrder")
public class VisaOrder {
	
	@Id
	@GenericGenerator(name="uuid", strategy="uuid")
	@GeneratedValue(generator="uuid")
	@Column(name="visaOrderID",length=50)
	//订单ID
	private String visaOrderID;
	
	@Column(name="proposer",length=20)
	//申请人
	private String proposer;
	
	@Column(name="customerType",length=20)
	//客户类型
	private String customerType;
	
	@Column(name="contactsName",length=20)
	//联系人名称
	private String contactsName;
	
	@Column(name="contactsPhone",length=50)
	//联系人电话
	private String contactsPhone;
	
	@Column(name="contactsEmail",length=50)
	//联系人邮箱
	private String contactsEmail;
	
	@Column(name="deliveryMethod",length=50)
	//配送方式
	private String  deliveryMethod ;
	
	@Column(name="deliveryAddress",length=50)
	//配送地址
	private String deliveryAddress;
	
	@Column(name="totalCost",length=10)
	//总费用
	private String totalCost;
	
	@Column(name="visaID",length=50)
	//签证ID
	private String visaID;
	
	@Column(name="visaTitle",length=100)
	//签证标题
	private String visaTitle;
	
	@Column(name="progress",length=20)
	//进度
	private String progress;
	
	@Column(name="userID",length=50)
	//用户ID
	private String userID;
	
	public String getProgress() {
		return progress;
	}

	public void setProgress(String progress) {
		this.progress = progress;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getProposer() {
		return proposer;
	}

	public void setProposer(String proposer) {
		this.proposer = proposer;
	}

	public String getCustomerType() {
		return customerType;
	}

	public void setCustomerType(String customerType) {
		this.customerType = customerType;
	}

	public String getContactsName() {
		return contactsName;
	}

	public void setContactsName(String contactsName) {
		this.contactsName = contactsName;
	}

	public String getContactsPhone() {
		return contactsPhone;
	}

	public void setContactsPhone(String contactsPhone) {
		this.contactsPhone = contactsPhone;
	}

	public String getContactsEmail() {
		return contactsEmail;
	}

	public void setContactsEmail(String contactsEmail) {
		this.contactsEmail = contactsEmail;
	}

	public String getDeliveryMethod() {
		return deliveryMethod;
	}

	public void setDeliveryMethod(String deliveryMethod) {
		this.deliveryMethod = deliveryMethod;
	}

	public String getDeliveryAddress() {
		return deliveryAddress;
	}

	public void setDeliveryAddress(String deliveryAddress) {
		this.deliveryAddress = deliveryAddress;
	}

	public String getTotalCost() {
		return totalCost;
	}

	public void setTotalCost(String totalCost) {
		this.totalCost = totalCost;
	}
	
 	public String getVisaOrderID() {
		return visaOrderID;
	}

	public void setVisaOrderID(String visaOrderID) {
		this.visaOrderID = visaOrderID;
	}

	public String getVisaID() {
		return visaID;
	}

	public void setVisaID(String visaID) {
		this.visaID = visaID;
	}
	
	public String getVisaTitle() {
		return visaTitle;
	}

	public void setVisaTitle(String visaTitle) {
		this.visaTitle = visaTitle;
	}

	@Override
	public String toString() {
		return "VisaOrder [visaOrderID=" + visaOrderID + ", proposer=" + proposer + ", customerType=" + customerType
				+ ", contactsName=" + contactsName + ", contactsPhone=" + contactsPhone + ", contactsEmail="
				+ contactsEmail + ", deliveryMethod=" + deliveryMethod + ", deliveryAddress=" + deliveryAddress
				+ ", totalCost=" + totalCost + ", visaID=" + visaID + ", visaTitle=" + visaTitle + ", progress="
				+ progress + ", userID=" + userID + "]";
	}
	
	
}
