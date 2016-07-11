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
@Table(name = "FW_MenuItem")
public class MenuItem{
	@Id
	@GenericGenerator (name="idgene",strategy="native")
	@GeneratedValue(generator="idgene")
	@Column(name = "ItemId")
	private Integer itemId;

	@Column(name = "ItemName", length=50)
	private String itemName;

	@Column(name = "MenuId")
	private Integer menuId;

	@Column(name = "ParentItemId")
	private Integer parentItemId;

	@Column(name = "ItemUrl", length=100)
	private String itemUrl;

	@Column(name = "ItemTarget", length=50)
	private String itemTarget;

	@Column(name = "PageId")
	private Integer pageId;

	@Column(name = "ItemType", length=10)
	private String itemType;

	@Column(name = "ItemStatus")
	private Integer itemStatus;

	@Column(name = "SortNum")
	private Integer sortNum;

	@Column(name = "ItemIcon", length=100)
	private String itemIcon;

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

	public Integer getMenuId(){
		return this.menuId;
	}

	public void setMenuId(Integer menuId){
		this.menuId=menuId;
	}

	public Integer getParentItemId(){
		return this.parentItemId;
	}

	public void setParentItemId(Integer parentItemId){
		this.parentItemId=parentItemId;
	}

	public String getItemUrl(){
		return this.itemUrl;
	}

	public void setItemUrl(String itemUrl){
		this.itemUrl=itemUrl;
	}

	public String getItemTarget(){
		return this.itemTarget;
	}

	public void setItemTarget(String itemTarget){
		this.itemTarget=itemTarget;
	}

	public Integer getPageId(){
		return this.pageId;
	}

	public void setPageId(Integer pageId){
		this.pageId=pageId;
	}

	public String getItemType(){
		return this.itemType;
	}

	public void setItemType(String itemType){
		this.itemType=itemType;
	}

	public Integer getItemStatus(){
		return this.itemStatus;
	}

	public void setItemStatus(Integer itemStatus){
		this.itemStatus=itemStatus;
	}

	public Integer getSortNum(){
		return this.sortNum;
	}

	public void setSortNum(Integer sortNum){
		this.sortNum=sortNum;
	}

	public String getItemIcon(){
		return this.itemIcon;
	}

	public void setItemIcon(String itemIcon){
		this.itemIcon=itemIcon;
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