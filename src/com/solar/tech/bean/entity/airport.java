package com.solar.tech.bean.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "b_airport")
public class airport {
	//机场数据id
	@Id
	@GeneratedValue(generator = "uuid")
	@GenericGenerator(name = "uuid", strategy = "uuid")
	@Column(name = "ID", length=100)
	private String ID;
	
	//机场中文名
	@Column(name="AIRPORTNAMECN",length=100)
	private String AIRPORTNAMECN;
	
	//机场拼音名
	@Column(name="PINYINNAME",length=100)
	private String PINYINNAME;
	
	//机场英文名
	@Column(name="AIRPORTNAMEEN",length=100)
	private String AIRPORTNAMEEN;
	
	//机场拼音简拼
	@Column(name="PINYINSHORTNAME",length=50)
	private String PINYINSHORTNAME;
		
	//机场三字码
	@Column(name="AIRPORTCODE",length=3)
	private String AIRPORTCODE;
	
	//所在国家中文名
	@Column(name="COUNTRYNAMECN",length=100)
	private String COUNTRYNAMECN;
	
	//所在国家英文名
	@Column(name="COUNTRYNAMEEN",length=100)
	private String COUNTRYNAMEEN;
	
	//所在国家二字码
	@Column(name="COUNTRYCODE",length=2)
	private String COUNTRYCODE;
	
	//所在区域名称
	@Column(name="AREANAMECN",length=100)
	private String AREANAMECN;
	
	//所在区域英文名
	@Column(name="AREANAMEEN",length=100)
	private String AREANAMEEN;
	
	//所在城市名称
	@Column(name="CITYNAMECN",length=100)
	private String CITYNAMECN;
	
	//所在城市三字码
	@Column(name="CITYCODE",length=3)
	private String CITYCODE;
	
	//是否国内
	@Column(name="ISDOMESTIC",length=1)
	private Integer ISDOMESTIC;
	
	//
	@Column(name="AIRPORTABREVNAMECN",length=100)
	private String AIRPORTABREVNAMECN;

	public String getAIRPORTABREVNAMECN() {
		return AIRPORTABREVNAMECN;
	}

	public void setAIRPORTABREVNAMECN(String aIRPORTABREVNAMECN) {
		AIRPORTABREVNAMECN = aIRPORTABREVNAMECN;
	}

	public String getID() {
		return ID;
	}

	public void setID(String iD) {
		ID = iD;
	}

	public String getAIRPORTNAMECN() {
		return AIRPORTNAMECN;
	}

	public void setAIRPORTNAMECN(String aIRPORTNAMECN) {
		AIRPORTNAMECN = aIRPORTNAMECN;
	}

	public String getPINYINNAME() {
		return PINYINNAME;
	}

	public void setPINYINNAME(String pINYINNAME) {
		PINYINNAME = pINYINNAME;
	}

	public String getAIRPORTNAMEEN() {
		return AIRPORTNAMEEN;
	}

	public void setAIRPORTNAMEEN(String aIRPORTNAMEEN) {
		AIRPORTNAMEEN = aIRPORTNAMEEN;
	}

	public String getPINYINSHORTNAME() {
		return PINYINSHORTNAME;
	}

	public void setPINYINSHORTNAME(String pINYINSHORTNAME) {
		PINYINSHORTNAME = pINYINSHORTNAME;
	}

	public String getAIRPORTCODE() {
		return AIRPORTCODE;
	}

	public void setAIRPORTCODE(String aIRPORTCODE) {
		AIRPORTCODE = aIRPORTCODE;
	}

	public String getCOUNTRYNAMECN() {
		return COUNTRYNAMECN;
	}

	public void setCOUNTRYNAMECN(String cOUNTRYNAMECN) {
		COUNTRYNAMECN = cOUNTRYNAMECN;
	}

	public String getCOUNTRYNAMEEN() {
		return COUNTRYNAMEEN;
	}

	public void setCOUNTRYNAMEEN(String cOUNTRYNAMEEN) {
		COUNTRYNAMEEN = cOUNTRYNAMEEN;
	}

	public String getCOUNTRYCODE() {
		return COUNTRYCODE;
	}

	public void setCOUNTRYCODE(String cOUNTRYCODE) {
		COUNTRYCODE = cOUNTRYCODE;
	}

	public String getAREANAMECN() {
		return AREANAMECN;
	}

	public void setAREANAMECN(String aREANAMECN) {
		AREANAMECN = aREANAMECN;
	}

	public String getAREANAMEEN() {
		return AREANAMEEN;
	}

	public void setAREANAMEEN(String aREANAMEEN) {
		AREANAMEEN = aREANAMEEN;
	}

	public String getCITYNAMECN() {
		return CITYNAMECN;
	}

	public void setCITYNAMECN(String cITYNAMECN) {
		CITYNAMECN = cITYNAMECN;
	}

	public String getCITYCODE() {
		return CITYCODE;
	}

	public void setCITYCODE(String cITYCODE) {
		CITYCODE = cITYCODE;
	}

	public Integer getISDOMESTIC() {
		return ISDOMESTIC;
	}

	public void setISDOMESTIC(Integer iSDOMESTIC) {
		ISDOMESTIC = iSDOMESTIC;
	}
	
	
}
