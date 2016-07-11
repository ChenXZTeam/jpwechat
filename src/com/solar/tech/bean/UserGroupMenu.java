package com.solar.tech.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.GenerationType;
import javax.persistence.GeneratedValue;

import org.hibernate.annotations.GenericGenerator;
@Entity
@Table(name = "FW_UserGroupMenu")
public class UserGroupMenu{
	@Id
	@GenericGenerator (name="idgene",strategy="native")
	@GeneratedValue(generator="idgene")
	@Column(name = "UGID")
	private Integer uGID;

	@Column(name = "GroupId")
	private Integer groupId;

	@Column(name = "MenuId")
	private Integer menuId;


	public Integer getUGID(){
		return this.uGID;
	}

	public void setUGID(Integer uGID){
		this.uGID=uGID;
	}

	public Integer getGroupId(){
		return this.groupId;
	}

	public void setGroupId(Integer groupId){
		this.groupId=groupId;
	}

	public Integer getMenuId(){
		return this.menuId;
	}

	public void setMenuId(Integer menuId){
		this.menuId=menuId;
	}

}