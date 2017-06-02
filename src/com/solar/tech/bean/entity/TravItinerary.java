package com.solar.tech.bean.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 行程单
 * @author solarpc1
 *
 */
@Entity
@Table(name="FW_TravItinerary")
public class TravItinerary {

	@Id
    @GenericGenerator(name="uuid", strategy="uuid")
    @GeneratedValue(generator="uuid")
    @Column(name="uuid", length=50)
	private String uuid;
	
	//乘机人
    @Column(name="filghtMan")
	private String filghtMan;
	
	//航班日期
    @Column(name="filghtDate", length=20)
	private String filghtDate;
    
    //配送日期
    @Column(name="sandDate", length=20)
    private String sandDate;
    
    //配送地址
    @Column(name="sandAdd")
    private String sandAdd;
    
    //联系手机
    @Column(name="linkPhone")
    private String linkPhone;
    
    //匹配机票订单的uuid字段
    @Column(name="orderUuid")
    private String orderUuid;
    
    //票号
    @Column(name="ticketNum")
    private String ticketNum;
    
    //打印状态
    @Column(name="consoleStutas")
    private String consoleStutas;
    
    //更新时间
    @Column(name="createTime")
    private Timestamp createTime;

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getFilghtMan() {
		return filghtMan;
	}

	public void setFilghtMan(String filghtMan) {
		this.filghtMan = filghtMan;
	}

	public String getFilghtDate() {
		return filghtDate;
	}

	public void setFilghtDate(String filghtDate) {
		this.filghtDate = filghtDate;
	}

	public String getSandDate() {
		return sandDate;
	}

	public void setSandDate(String sandDate) {
		this.sandDate = sandDate;
	}

	public String getSandAdd() {
		return sandAdd;
	}

	public void setSandAdd(String sandAdd) {
		this.sandAdd = sandAdd;
	}

	public String getLinkPhone() {
		return linkPhone;
	}

	public void setLinkPhone(String linkPhone) {
		this.linkPhone = linkPhone;
	}

	public String getOrderUuid() {
		return orderUuid;
	}

	public void setOrderUuid(String orderUuid) {
		this.orderUuid = orderUuid;
	}

	public String getConsoleStutas() {
		return consoleStutas;
	}

	public void setConsoleStutas(String consoleStutas) {
		this.consoleStutas = consoleStutas;
	}

	public String getTicketNum() {
		return ticketNum;
	}

	public void setTicketNum(String ticketNum) {
		this.ticketNum = ticketNum;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}
    
}
