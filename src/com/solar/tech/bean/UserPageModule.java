package com.solar.tech.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.GenerationType;
import javax.persistence.GeneratedValue;

import org.hibernate.annotations.GenericGenerator;
@Entity
@Table(name = "FW_UserPageModule")
public class UserPageModule{
	@Id
	@GenericGenerator (name="idgene",strategy="native")
	@GeneratedValue(generator="idgene")
	@Column(name = "UPMID")
	private Integer uPMID;

	@Column(name = "USERUID", length=50)
	private String uSERUID;

	@Column(name = "ModuleId")
	private Integer moduleId;

	@Column(name = "Allow", length=10)
	private String allow;


	public Integer getUPMID(){
		return this.uPMID;
	}

	public void setUPMID(Integer uPMID){
		this.uPMID=uPMID;
	}

	public String getUSERUID(){
		return this.uSERUID;
	}

	public void setUSERUID(String uSERUID){
		this.uSERUID=uSERUID;
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