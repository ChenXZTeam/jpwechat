package com.solar.tech.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.GenerationType;
import javax.persistence.GeneratedValue;

import org.hibernate.annotations.GenericGenerator;
@Entity
@Table(name = "FW_UserMenu")
public class UserMenu{
	@Id
	@GenericGenerator (name="idgene",strategy="native")
	@GeneratedValue(generator="idgene")
	@Column(name = "UMID")
	private Integer uMID;

	@Column(name = "USERUID", length=50)
	private String uSERUID;

	@Column(name = "MenuId")
	private Integer menuId;


	public Integer getUMID(){
		return this.uMID;
	}

	public void setUMID(Integer uMID){
		this.uMID=uMID;
	}

	public String getUSERUID(){
		return this.uSERUID;
	}

	public void setUSERUID(String uSERUID){
		this.uSERUID=uSERUID;
	}

	public Integer getMenuId(){
		return this.menuId;
	}

	public void setMenuId(Integer menuId){
		this.menuId=menuId;
	}

}