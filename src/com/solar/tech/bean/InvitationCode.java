package com.solar.tech.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name="FW_InvitationCodeList")
public class InvitationCode {
	public static final String PREFERENTIAL = "preferential";
	public static final String DISCOUNT = "discount";
	
	@Id
    @Column(name="invitationCode", length=50)
	//邀请码
	private String invitationCode;
	
	//使用邀请码的用户
	@Column(name="userName", length=50) 
	private String userName;
	
	//邀请码类型
	@Column(name="type", length=20)
	private String type;
	
	//备注
	@Column(name="remarks", length=100)
	private String remarks;
	
	//优惠金额
	@Column(name="sum", length=10)
	private double sum;
	
	//折扣
	@Column(name="discount", length=10)
	private double discount;
	
	//到期时间
	@Column(name="deadline", length=10)
	private Date deadline;
	
	//使用次数
	@Column(name="times", length=10)
	private int times;
	
	public int getTimes() {
		return times;
	}
	public void setTimes(int times) {
		this.times = times;
	}
	public String getInvitationCode() {
		return invitationCode;
	}
	public void setInvitationCode(String invitationCode) {
		this.invitationCode = invitationCode;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public double getSum() {
		return sum;
	}
	public void setSum(double sum) {
		this.sum = sum;
	}
	public double getDiscount() {
		return discount;
	}
	public void setDiscount(double discount) {
		this.discount = discount;
	}
	public Date getDeadline() {
		return deadline;
	}
	public void setDeadline(Date deadline) {
		this.deadline = deadline;
	}
	@Override
	public String toString() {
		return "InvitationCode [invitationCode=" + invitationCode + ", userName=" + userName + ", type=" + type
				+ ", remarks=" + remarks + ", sum=" + sum + ", discount=" + discount + ", deadline=" + deadline
				+ ", times=" + times + "]";
	}
	
}
