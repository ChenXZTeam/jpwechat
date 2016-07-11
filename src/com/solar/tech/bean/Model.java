package com.solar.tech.bean;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "FW_Model")
public class Model{
	@Id
	@GenericGenerator (name="idgene",strategy="native")
	@GeneratedValue(generator="idgene")
	@Column(name = "ModelId")
	private Integer modelId;

	@Column(name = "ModelCName", length=50)
	private String modelCName;

	@Column(name = "ModelEName", length=50)
	private String modelEName;

	@Column(name = "ModelDesc", length=200)
	private String modelDesc;

	@Column(name = "IsMainEntity")
	private Integer isMainEntity;
	
	@ManyToOne
	@JoinColumn(name="DomainId")
	private Domain domain;
	
	@JsonIgnore
	@OneToMany(cascade=CascadeType.ALL,mappedBy="model")
	private Set<Attribute> attris;
	
	@JsonIgnore
	@OneToMany(cascade=CascadeType.ALL,mappedBy="model")
	private Set<ForeignKey> foreignKeys;

	//外键  数据域ID  用来作为新建模型时的辅助属性
	@Transient
	private Integer refDomainId;
	
	
	
	
	
	public Domain getDomain() {
		return domain;
	}


	public void setDomain(Domain domain) {
		this.domain = domain;
	}


	public Integer getRefDomainId() {
		return refDomainId;
	}


	public void setRefDomainId(Integer refDomainId) {
		this.refDomainId = refDomainId;
	}


	public Integer getModelId() {
		return modelId;
	}


	public void setModelId(Integer modelId) {
		this.modelId = modelId;
	}




	public String getModelCName() {
		return modelCName;
	}


	public void setModelCName(String modelCName) {
		this.modelCName = modelCName;
	}


	public String getModelEName() {
		return modelEName;
	}


	public void setModelEName(String modelEName) {
		this.modelEName = modelEName;
	}


	public String getModelDesc() {
		return modelDesc;
	}


	public void setModelDesc(String modelDesc) {
		this.modelDesc = modelDesc;
	}


	public Integer getIsMainEntity() {
		return isMainEntity;
	}


	public void setIsMainEntity(Integer isMainEntity) {
		this.isMainEntity = isMainEntity;
	}


	public Set<Attribute> getAttris() {
		return attris;
	}


	public void setAttris(Set<Attribute> attris) {
		this.attris = attris;
	}


	public Set<ForeignKey> getForeignKeys() {
		return foreignKeys;
	}


	public void setForeignKeys(Set<ForeignKey> foreignKeys) {
		this.foreignKeys = foreignKeys;
	}
	

	

}