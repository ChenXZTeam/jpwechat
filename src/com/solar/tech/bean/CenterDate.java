package com.solar.tech.bean;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "FW_CENTERDATE")
public class CenterDate {
	@Id
	@GeneratedValue(generator = "uuid")
	@GenericGenerator(name = "uuid", strategy = "uuid")
	@Column(name = "uuid", length=100)
	private String uuid;
	
	@Column(name = "status", length=20)
	private String status;
	
	@Column(name = "isgetmap", length=20)
	private String isgetmap;
	
	@Column(name = "htmlUuid", length=100)
	private String htmlUuid;
	
	@Column(name = "createTime", length=100)
	private Timestamp createTime;

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getHtmlUuid() {
		return htmlUuid;
	}

	public void setHtmlUuid(String htmlUuid) {
		this.htmlUuid = htmlUuid;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public String getIsgetmap() {
		return isgetmap;
	}

	public void setIsgetmap(String isgetmap) {
		this.isgetmap = isgetmap;
	}
	
	
}
