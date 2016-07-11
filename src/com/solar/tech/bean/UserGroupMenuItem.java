package com.solar.tech.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.GenerationType;
import javax.persistence.GeneratedValue;

import org.hibernate.annotations.GenericGenerator;
@Entity
@Table(name = "FW_UserGroupMenuItem")
public class UserGroupMenuItem{
	@Id
	@GenericGenerator (name="idgene",strategy="native")
	@GeneratedValue(generator="idgene")
	@Column(name = "UGIID")
	private Integer uGIID;

	@Column(name = "GroupId")
	private Integer groupId;

	@Column(name = "ItemId")
	private Integer itemId;


	public Integer getUGIID(){
		return this.uGIID;
	}

	public void setUGIID(Integer uGIID){
		this.uGIID=uGIID;
	}

	public Integer getGroupId(){
		return this.groupId;
	}

	public void setGroupId(Integer groupId){
		this.groupId=groupId;
	}

	public Integer getItemId(){
		return this.itemId;
	}

	public void setItemId(Integer itemId){
		this.itemId=itemId;
	}

}