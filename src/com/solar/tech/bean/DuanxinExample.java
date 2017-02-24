package com.solar.tech.bean;

import java.sql.Date;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="FW_duanxinExample")
public class DuanxinExample {
	//模板id
    @Id
    @GenericGenerator(name="uuid", strategy="uuid")
    @GeneratedValue(generator="uuid")
    @Column(name="exampleID", length=50)
	private String exampleID;

    //编辑文本
    @Column(name="text")
    private String text;
    
    //绑定人
    @Column(name="banPeople")
    private String banPeople;
    
    //绑定组
    @Column(name="banZu")
    private String banZu;
    
   //登录账号
    @Column(name="userName", length=50)
    private String userName;

	public String getExampleID() {
		return exampleID;
	}

	public void setExampleID(String exampleID) {
		this.exampleID = exampleID;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getBanPeople() {
		return banPeople;
	}

	public void setBanPeople(String banPeople) {
		this.banPeople = banPeople;
	}

	public String getBanZu() {
		return banZu;
	}

	public void setBanZu(String banZu) {
		this.banZu = banZu;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
    
	
 }
