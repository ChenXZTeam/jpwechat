package com.solar.tech.bean.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="FW_HCCONFIG")
public class hcConfig {
	//主键
    @Id
    @GenericGenerator(name="uuid", strategy="uuid")
    @GeneratedValue(generator="uuid")
    @Column(name="uuid")
	private String uuid; 
	
	//出发城市
    @Column(name="orgCity")
	private String orgCity;
	
	//到达城市
    @Column(name="dstCity")
	private String dstCity;
	
	//航班时间分类
    @Column(name="hcType")
	private String hcType;
	
	//缓存过期时间（备注）
    @Column(name="overTime")
	private Timestamp overTime;
    
    //是否过期
    @Column(name="isOver")
    private String isOver;
    
    //创建时间
    @Column(name="createTime")
	private Timestamp createTime;
    
    //管理员更新时间
    @Column(name="handUpTime")
	private Timestamp handUpTime;
    
	public String getOrgCity() {
		return orgCity;
	}

	public void setOrgCity(String orgCity) {
		this.orgCity = orgCity;
	}

	public String getDstCity() {
		return dstCity;
	}

	public void setDstCity(String dstCity) {
		this.dstCity = dstCity;
	}

	public String getHcType() {
		return hcType;
	}

	public void setHcType(String hcType) {
		this.hcType = hcType;
	}

	public Timestamp getOverTime() {
		return overTime;
	}

	public void setOverTime(Timestamp overTime) {
		this.overTime = overTime;
	}

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

	public Timestamp getHandUpTime() {
		return handUpTime;
	}

	public void setHandUpTime(Timestamp handUpTime) {
		this.handUpTime = handUpTime;
	}

	public String getIsOver() {
		return isOver;
	}

	public void setIsOver(String isOver) {
		this.isOver = isOver;
	}
	
}
