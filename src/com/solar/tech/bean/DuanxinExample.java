package com.solar.tech.bean;

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
    @Column(name="ID", length=50)
	private String ID;

    //编辑文本
    @Column(name="text")
    private String text;
    
    //绑定人
    @Column(name="banPeople")
    private String banPeople;
    
    
    //模板选择
	@Column(name="model")
    private String model;
    
   //登录账号
    @Column(name="userName", length=50)
    private String userName;
    
    //创建时间
    @Column(name="creamTime", length=50)
    private Timestamp creamTime;
    
    //修改时间
    @Column(name="updateTime", length=50)
    private Timestamp updateTime;

	public String getID() {
		return ID;
	}

	public void setID(String iD) {
		ID = iD;
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

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Timestamp getCreamTime() {
		return creamTime;
	}

	public void setCreamTime(Timestamp creamTime) {
		this.creamTime = creamTime;
	}

	public Timestamp getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Timestamp updateTime) {
		this.updateTime = updateTime;
	}
	
	public void setModel(String model) {
	    this.model = model;
	}
	
	 public String getModel() {
	    return model;
	}

	
 }
