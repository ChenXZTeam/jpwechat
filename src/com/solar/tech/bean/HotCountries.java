package com.solar.tech.bean;

import java.util.Arrays;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;

import org.springframework.beans.factory.annotation.Configurable;

@Entity
@Table(name="fw_HotCounties")
public class HotCountries {

	@Id
	@Column(name="countryID",length=10)
	//国家域名代码
	private String countryID;
	
	@Column(name="countryName",length=20)
	//国家名称
	private String countryName;
	
	@Column(name="imagePath",length=100)
	//图片
	private String imagePath; 
	
	//优先级
	private int priority;

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

	public int getPriority() {
		return priority;
	}

	public void setPriority(int priority) {
		this.priority = priority;
	}


	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	@Override
	public String toString() {
		return "HotCountries [countryID=" + countryID + ", countryName=" + countryName + ", imagePath=" + imagePath
				+ ", priority=" + priority + "]";
	}
}
