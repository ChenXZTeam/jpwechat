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
@Table(name = "FW_Menu")
public class Menu{
	@Id
	@GenericGenerator (name="idgene",strategy="native")
	@GeneratedValue(generator="idgene")
	@Column(name = "MenuId")
	private Integer menuId;

	@Column(name = "MenuName", length=50)
	private String menuName;

	@Column(name = "MenuUrl", length=100)
	private String menuUrl;

	@Column(name = "MenuType", length=10)
	private String menuType;

	@Column(name = "MenuTarget", length=50)
	private String menuTarget;

	@Column(name = "MenuStatus")
	private Integer menuStatus;

	@Column(name = "SortNum")
	private Integer sortNum;

	@Column(name = "MenuIcon", length=100)
	private String menuIcon;

	@Column(name = "Description", length=300)
	private String description;

	@Column(name = "CreateTime")
	private Date createTime;

	@Column(name = "CreateBy", length=50)
	private String createBy;

	@Column(name = "UpdateTime")
	private Date updateTime;

	@Column(name = "UpdateBy", length=50)
	private String updateBy;


	public Integer getMenuId(){
		return this.menuId;
	}

	public void setMenuId(Integer menuId){
		this.menuId=menuId;
	}

	public String getMenuName(){
		return this.menuName;
	}

	public void setMenuName(String menuName){
		this.menuName=menuName;
	}

	public String getMenuUrl(){
		return this.menuUrl;
	}

	public void setMenuUrl(String menuUrl){
		this.menuUrl=menuUrl;
	}

	public String getMenuType(){
		return this.menuType;
	}

	public void setMenuType(String menuType){
		this.menuType=menuType;
	}

	public String getMenuTarget(){
		return this.menuTarget;
	}

	public void setMenuTarget(String menuTarget){
		this.menuTarget=menuTarget;
	}

	public Integer getMenuStatus(){
		return this.menuStatus;
	}

	public void setMenuStatus(Integer menuStatus){
		this.menuStatus=menuStatus;
	}

	public Integer getSortNum(){
		return this.sortNum;
	}

	public void setSortNum(Integer sortNum){
		this.sortNum=sortNum;
	}

	public String getMenuIcon(){
		return this.menuIcon;
	}

	public void setMenuIcon(String menuIcon){
		this.menuIcon=menuIcon;
	}

	public String getDescription(){
		return this.description;
	}

	public void setDescription(String description){
		this.description=description;
	}

	public Date getCreateTime(){
		return this.createTime;
	}

	public void setCreateTime(Date createTime){
		this.createTime=createTime;
	}

	public String getCreateBy(){
		return this.createBy;
	}

	public void setCreateBy(String createBy){
		this.createBy=createBy;
	}

	public Date getUpdateTime(){
		return this.updateTime;
	}

	public void setUpdateTime(Date updateTime){
		this.updateTime=updateTime;
	}

	public String getUpdateBy(){
		return this.updateBy;
	}

	public void setUpdateBy(String updateBy){
		this.updateBy=updateBy;
	}

}