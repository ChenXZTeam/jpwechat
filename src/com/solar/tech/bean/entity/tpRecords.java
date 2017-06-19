package com.solar.tech.bean.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="tpRecords")
public class tpRecords {
	@Id
	@GeneratedValue(generator = "uuid")
	@GenericGenerator(name = "uuid", strategy = "uuid")
	@Column(name = "ID", length=100)
	private String ID;
    
	@Column(name="linkName",length=100)
	private String linkName;
	
	@Column(name="pnumber",length=100)
	private String pnumber;
	
	@Column(name="pnr",length=100)
	private String pnr;
	
	@Column(name="telNumber",length=100)
	private String telNumber;
	
	@Column(name="hangbanNum",length=100)
	private String hangbanNum;
	
	@Column(name="idcase",length=100)
	private String idcase;
	
	@Column(name="chufCity",length=100)
	private String chufCity;
	
	@Column(name="daodCity",length=100)
	private String daodCity;
	
	@Column(name="chufTime",length=100)
	private String chufTime;
	
	@Column(name="tpStatus",length=100)
	private String tpStatus;
	
	@Column(name="bornStatus",length=100)
	private String bornStatus;

	public String getID() {
		return ID;
	}

	public void setID(String iD) {
		ID = iD;
	}

	public String getLinkName() {
		return linkName;
	}

	public void setLinkName(String linkName) {
		this.linkName = linkName;
	}

	public String getPnumber() {
		return pnumber;
	}

	public void setPnumber(String pnumber) {
		this.pnumber = pnumber;
	}

	public String getPnr() {
		return pnr;
	}

	public void setPnr(String pnr) {
		this.pnr = pnr;
	}

	public String getTelNumber() {
		return telNumber;
	}

	public void setTelNumber(String telNumber) {
		this.telNumber = telNumber;
	}

	public String getHangbanNum() {
		return hangbanNum;
	}

	public void setHangbanNum(String hangbanNum) {
		this.hangbanNum = hangbanNum;
	}

	public String getIdcase() {
		return idcase;
	}

	public void setIdcase(String idcase) {
		this.idcase = idcase;
	}

	public String getChufCity() {
		return chufCity;
	}

	public void setChufCity(String chufCity) {
		this.chufCity = chufCity;
	}

	public String getDaodCity() {
		return daodCity;
	}

	public void setDaodCity(String daodCity) {
		this.daodCity = daodCity;
	}

	public String getChufTime() {
		return chufTime;
	}

	public void setChufTime(String chufTime) {
		this.chufTime = chufTime;
	}

	public String getTpStatus() {
		return tpStatus;
	}

	public void setTpStatus(String tpStatus) {
		this.tpStatus = tpStatus;
	}

	public String getBornStatus() {
		return bornStatus;
	}

	public void setBornStatus(String bornStatus) {
		this.bornStatus = bornStatus;
	}

	
	
}
