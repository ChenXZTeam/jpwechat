package com.solar.tech.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.GenerationType;
import javax.persistence.GeneratedValue;

import org.hibernate.annotations.GenericGenerator;
@Entity
@Table(name = "FW_UserWebPage")
public class UserWebPage{
	@Id
	@GenericGenerator (name="idgene",strategy="native")
	@GeneratedValue(generator="idgene")
	@Column(name = "UWPID")
	private Integer uWPID;

	@Column(name = "USERUID", length=50)
	private String uSERUID;

	@Column(name = "PageId")
	private Integer pageId;

	@Column(name = "Allow", length=10)
	private String allow;


	public Integer getUWPID(){
		return this.uWPID;
	}

	public void setUWPID(Integer uWPID){
		this.uWPID=uWPID;
	}

	public String getUSERUID(){
		return this.uSERUID;
	}

	public void setUSERUID(String uSERUID){
		this.uSERUID=uSERUID;
	}

	public Integer getPageId(){
		return this.pageId;
	}

	public void setPageId(Integer pageId){
		this.pageId=pageId;
	}

	public String getAllow(){
		return this.allow;
	}

	public void setAllow(String allow){
		this.allow=allow;
	}

}