package com.solar.tech.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "FW_VisaFree")
public class VisaFree {
	
	@Id
	@Column(name="countryID",length=10)
	//国家id
	private String countryID;
	
	@Column(name="countryName",length=20)
	//国家名称
	private String countryName;
	
	@Column(name="content",length=1000)
	//免签信息
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
