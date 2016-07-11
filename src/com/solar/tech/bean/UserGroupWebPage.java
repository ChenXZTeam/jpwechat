package com.solar.tech.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.GenerationType;
import javax.persistence.GeneratedValue;

import org.hibernate.annotations.GenericGenerator;
@Entity
@Table(name = "FW_UserGroupWebPage")
public class UserGroupWebPage{
	@Id
	@GenericGenerator (name="idgene",strategy="native")
	@GeneratedValue(generator="idgene")
	@Column(name = "GWPID")
	private Integer gWPID;

	@Column(name = "GroupId")
	private Integer groupId;

	@Column(name = "PageId")
	private Integer pageId;

	@Column(name = "Allow", length=10)
	private String allow;


	public Integer getGWPID(){
		return this.gWPID;
	}

	public void setGWPID(Integer gWPID){
		this.gWPID=gWPID;
	}

	public Integer getGroupId(){
		return this.groupId;
	}

	public void setGroupId(Integer groupId){
		this.groupId=groupId;
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