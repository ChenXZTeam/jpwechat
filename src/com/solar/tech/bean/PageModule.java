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
@Table(name = "FW_PageModule")
public class PageModule{
	@Id
	@GenericGenerator (name="idgene",strategy="native")
	@GeneratedValue(generator="idgene")
	@Column(name = "ModuleId")
	private Integer moduleId;

	@Column(name = "ModuleName", length=50)
	private String moduleName;

	@Column(name = "ParentModuleId")
	private Integer parentModuleId;

	@Column(name = "SortNum")
	private Integer sortNum;

	@Column(name = "ModuleIcon", length=100)
	private String moduleIcon;

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


	public Integer getModuleId(){
		return this.moduleId;
	}

	public void setModuleId(Integer moduleId){
		this.moduleId=moduleId;
	}

	public String getModuleName(){
		return this.moduleName;
	}

	public void setModuleName(String moduleName){
		this.moduleName=moduleName;
	}

	public Integer getParentModuleId(){
		return this.parentModuleId;
	}

	public void setParentModuleId(Integer parentModuleId){
		this.parentModuleId=parentModuleId;
	}

	public Integer getSortNum(){
		return this.sortNum;
	}

	public void setSortNum(Integer sortNum){
		this.sortNum=sortNum;
	}

	public String getModuleIcon(){
		return this.moduleIcon;
	}

	public void setModuleIcon(String moduleIcon){
		this.moduleIcon=moduleIcon;
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