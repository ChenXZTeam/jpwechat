package com.solar.tech.bean.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="FW_FREIGHT")
public class Freight {
    @Id
    @GenericGenerator(name="uuid", strategy="uuid")
    @GeneratedValue(generator="uuid")
    @Column(name="uuid", length=50)
	private String uuid;
    
    //出发城市
    @Column(name="orgCity", length=5)
	private String orgCity;
    
    //出发城市
    @Column(name="dstCity", length=5)
	private String dstCity;
    
    //缓存创建时间
    @Column(name="createTime", length=50)
	private Timestamp createTime;
    
    //缓存过期时间
    @Column(name="overTime", length=50)
   	private Timestamp overTime;
    
    //缓存手动更新时间
    @Column(name="updateTime", length=50)
	private Timestamp updateTime;
    
    //是否过期
    @Column(name="isOver", length=5)
   	private String isOver;

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

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

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public Timestamp getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Timestamp updateTime) {
		this.updateTime = updateTime;
	}

	public String getIsOver() {
		return isOver;
	}

	public void setIsOver(String isOver) {
		this.isOver = isOver;
	}

	public Timestamp getOverTime() {
		return overTime;
	}

	public void setOverTime(Timestamp overTime) {
		this.overTime = overTime;
	}
}
