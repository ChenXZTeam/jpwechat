package com.solar.tech.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.GenerationType;
import javax.persistence.GeneratedValue;
import org.hibernate.annotations.GenericGenerator;

import java.util.Date;

@Entity
@Table(name = "FW_MenuItemAssignLog")
public class MenuItemAssignLog{
	@Id
	@GenericGenerator (name="idgene",strategy="native")
	@GeneratedValue(generator="idgene")
	@Column(name = "LogId")
	private Integer logId;

	@Column(name = "LogName", length=50)
	private String logName;

	@Column(name = "UserName", length=50)
	private String userName;

	@Column(name = "Operate", length=50)
	private String operate;

	@Column(name = "AssignType", length=10)
	private String assignType;

	@Column(name = "AssignId", length=50)
	private String assignId;

	@Column(name = "AssingName", length=50)
	private String assingName;

	@Column(name = "CreateTime")
	private Date createTime;

	@Column(name = "ItemId")
	private Integer itemId;

	@Column(name = "ItemName", length=50)
	private String itemName;


	public Integer getLogId(){
		return this.logId;
	}

	public void setLogId(Integer logId){
		this.logId=logId;
	}

	public String getLogName(){
		return this.logName;
	}

	public void setLogName(String logName){
		this.logName=logName;
	}

	public String getUserName(){
		return this.userName;
	}

	public void setUserName(String userName){
		this.userName=userName;
	}

	public String getOperate(){
		return this.operate;
	}

	public void setOperate(String operate){
		this.operate=operate;
	}

	public String getAssignType(){
		return this.assignType;
	}

	public void setAssignType(String assignType){
		this.assignType=assignType;
	}

	public String getAssignId(){
		return this.assignId;
	}

	public void setAssignId(String assignId){
		this.assignId=assignId;
	}

	public String getAssingName(){
		return this.assingName;
	}

	public void setAssingName(String assingName){
		this.assingName=assingName;
	}

	public Date getCreateTime(){
		return this.createTime;
	}

	public void setCreateTime(Date createTime){
		this.createTime=createTime;
	}

	public Integer getItemId(){
		return this.itemId;
	}

	public void setItemId(Integer itemId){
		this.itemId=itemId;
	}

	public String getItemName(){
		return this.itemName;
	}

	public void setItemName(String itemName){
		this.itemName=itemName;
	}

}