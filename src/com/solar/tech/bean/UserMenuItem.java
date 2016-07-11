package com.solar.tech.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.GenerationType;
import javax.persistence.GeneratedValue;

import org.hibernate.annotations.GenericGenerator;
@Entity
@Table(name = "FW_UserMenuItem")
public class UserMenuItem{
	@Id
	@GenericGenerator (name="idgene",strategy="native")
	@GeneratedValue(generator="idgene")
	@Column(name = "UMIID")
	private Integer uMIID;

	@Column(name = "USERUID", length=50)
	private String uSERUID;

	@Column(name = "ItemId")
	private Integer itemId;


	public Integer getUMIID(){
		return this.uMIID;
	}

	public void setUMIID(Integer uMIID){
		this.uMIID=uMIID;
	}

	public String getUSERUID(){
		return this.uSERUID;
	}

	public void setUSERUID(String uSERUID){
		this.uSERUID=uSERUID;
	}

	public Integer getItemId(){
		return this.itemId;
	}

	public void setItemId(Integer itemId){
		this.itemId=itemId;
	}

}