package com.solar.tech.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "FW_VisaFree")
public class VisaFree {

	//国家id
	@Id
	@Column(name="countryID",length=10)
	private String countryID;

	//国家名称
	@Column(name="countryName",length=20)
	private String countryName;

	//免签信息
	@Column(name="content",length=1000)
	private String content;
	
	public String getCountryID() {
		return countryID;
	}
	public void setCountryID(String countryID) {
		this.countryID = countryID;
	}
	public String getCountryName() {
		return countryName;
	}
	public void setCountryName(String countryName) {
		this.countryName = countryName;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Override
	public String toString() {
		return "VisaFree [countryID=" + countryID + ", countryName=" + countryName + ", content=" + content + "]";
	}
	
	
}
