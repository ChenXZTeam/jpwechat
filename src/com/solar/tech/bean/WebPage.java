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
@Table(name = "FW_WebPage")
public class WebPage{
	@Id
	@GenericGenerator (name="idgene",strategy="native")
	@GeneratedValue(generator="idgene")
	@Column(name = "PageId")
	private Integer pageId;

	@Column(name = "PageName", length=50)
	private String pageName;
	
	@Column(name="PageNum", length=50)
	private String pageNum;

	@Column(name = "PageUrl", length=100)
	private String pageUrl;

	@Column(name = "SortNum")
	private Integer sortNum;

	@Column(name = "ModuleId")
	private Integer moduleId;
	
	@Column(name = "pageType",length=10)
    private  String pageType;
	
	@Column(name = "needAclCtrl")
    private  String needAclCtrl;
	
	
	public String getNeedAclCtrl() {
		return needAclCtrl;
	}

	public void setNeedAclCtrl(String needAclCtrl) {
		this.needAclCtrl = needAclCtrl;
	}

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


	public Integer getPageId(){
		return this.pageId;
	}

	public void setPageId(Integer pageId){
		this.pageId=pageId;
	}

	public String getPageName(){
		return this.pageName;
	}

	public void setPageName(String pageName){
		this.pageName=pageName;
	}

	public String getPageUrl(){
		return this.pageUrl;
	}

	public void setPageUrl(String pageUrl){
		this.pageUrl=pageUrl;
	}

	public Integer getSortNum(){
		return this.sortNum;
	}

	public void setSortNum(Integer sortNum){
		this.sortNum=sortNum;
	}

	public Integer getModuleId(){
		return this.moduleId;
	}

	public void setModuleId(Integer moduleId){
		this.moduleId=moduleId;
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

	public String getPageNum() {
		return pageNum;
	}

	public void setPageNum(String pageNum) {
		this.pageNum = pageNum;
	}

	public String getPageType() {
		return pageType;
	}

	public void setPageType(String pageType) {
		this.pageType = pageType;
	}

}