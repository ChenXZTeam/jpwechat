package com.solar.tech.bean.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="FW_TGCONFIG")
public class tgConfig {
	//主键
    @Id
    @GenericGenerator(name="uuid", strategy="uuid")
    @GeneratedValue(generator="uuid")
    @Column(name="uuid")
	private String uuid; 
    
    //航空公司
    @Column(name="airCode")
    private String airCode;
    
    //起飞时间规定
    @Column(name="filgTime")
    private String filgTime;
    
    //机票类型
    @Column(name="tickType")
    private String tickType;
    
    //退票扣费
    @Column(name="tpMoney")
    private String tpMoney;
    
    //同舱改期费
    @Column(name="tcgqMoney")
    private String tcgqMoney;
    
    //签转
    @Column(name="isQz")
    private String isQz;
    
    //备注
    @Column(name="commit")
    private String commit;
    
    //更新时间
    @Column(name="upTime")
    private Timestamp upTime;

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getAirCode() {
		return airCode;
	}

	public void setAirCode(String airCode) {
		this.airCode = airCode;
	}

	public String getTickType() {
		return tickType;
	}

	public void setTickType(String tickType) {
		this.tickType = tickType;
	}

	public String getTpMoney() {
		return tpMoney;
	}

	public void setTpMoney(String tpMoney) {
		this.tpMoney = tpMoney;
	}

	public String getTcgqMoney() {
		return tcgqMoney;
	}

	public void setTcgqMoney(String tcgqMoney) {
		this.tcgqMoney = tcgqMoney;
	}

	public String getIsQz() {
		return isQz;
	}

	public void setIsQz(String isQz) {
		this.isQz = isQz;
	}

	public String getCommit() {
		return commit;
	}

	public void setCommit(String commit) {
		this.commit = commit;
	}

	public Timestamp getUpTime() {
		return upTime;
	}

	public void setUpTime(Timestamp upTime) {
		this.upTime = upTime;
	}

	public String getFilgTime() {
		return filgTime;
	}

	public void setFilgTime(String filgTime) {
		this.filgTime = filgTime;
	}
    
}
