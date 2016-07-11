package com.solar.tech.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.GenerationType;
import javax.persistence.GeneratedValue;

import org.hibernate.annotations.GenericGenerator;
@Entity
@Table(name = "FW_UserGroupPageModule")
public class UserGroupPageModule{
	@Id
	@GenericGenerator (name="idgene",strategy="native")
	@GeneratedValue(generator="idgene")
	@Column(name = "GPMID")
	private Integer gPMID;

	@Column(name = "GroupId")
	private Integer groupId;

	@Column(name = "ModuleId")
	private Integer moduleId;

	@Column(name = "Allow", length=10)
	private String allow;


	public Integer getGPMID(){
		return this.gPMID;
	}

	public void setGPMID(Integer gPMID){
		this.gPMID=gPMID;
	}

	public Integer getGroupId(){
		return this.groupId;
	}

	public void setGroupId(Integer groupId){
		this.groupId=groupId;
	}

	public Integer getModuleId(){
		return this.moduleId;
	}

	public void setModuleId(Integer moduleId){
		this.moduleId=moduleId;
	}

	public String getAllow(){
		return this.allow;
	}

	public void setAllow(String allow){
		this.allow=allow;
	}

}