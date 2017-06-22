package com.solar.tech.bean.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 快递的价格，就是用户选择“报销单”的时候需要反馈的快递价格
 */
@Entity
@Table(name = "RD_KDCOST")
public class kdCost {
	//uuid
	@Id
	@GeneratedValue(generator = "uuid")
	@GenericGenerator(name = "uuid", strategy = "uuid")
	@Column(name = "uuid", length=100)
	private String uuid;
		
	//快递单号
	@Column(name = "kdcost")
	private String kdcost;

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getKdcost() {
		return kdcost;
	}

	public void setKdcost(String kdcost) {
		this.kdcost = kdcost;
	}
	
	
}
