package com.solar.tech.bean.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 保险价格配置模块
 * @author solarpc1
 *
 */
@Entity
@Table(name="FW_Insurance")
public class Insurance {
	//编号
	@Id
    @GenericGenerator(name="uuid", strategy="uuid")
    @GeneratedValue(generator="uuid")
    @Column(name="uuid", length=50)
	private String uuid;
	
	//保险单号
	/*@Column(name="bxNum")
	private String bxNum;*/
	
	//使用情况(0、未使用  1、已使用)
	/*@Column(name="isUse")
    private String isUse;*/
	
	//保险的类型
	@Column(name="bxType")
	private String bxType;
	
	//使用开关（开的时候，当用户勾选保险的时候就会随机获取到。关的时候相反）(0、关  1、开)
	/*@Column(name="isOpen")
    private String isOpen;*/
	
	//保险的价格
	@Column(name="cost")
	private String cost;
	
	//创建时间
	@Column(name="createTime")
	private Timestamp createTime;

	//保险的描述
	@Column(name="commit",length=1000)
	private String commit;
	
	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public String getBxType() {
		return bxType;
	}

	public void setBxType(String bxType) {
		this.bxType = bxType;
	}

	public String getCost() {
		return cost;
	}

	public void setCost(String cost) {
		this.cost = cost;
	}

	public String getCommit() {
		return commit;
	}

	public void setCommit(String commit) {
		this.commit = commit;
	}
	
}
