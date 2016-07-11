package com.solar.tech.bean;


import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "FW_Domain")
public class Domain{
	@Id
	@GenericGenerator (name="idgene",strategy="native")
	@GeneratedValue(generator="idgene")
	@Column(name = "DomainId")
	private Integer domainId;

	@Column(name = "DomainCName", length=50)
	private String domainCName;

	@Column(name = "DomainEName", length=50)
	private String domainEName;

	@Column(name = "DomainDesc", length=200)
	private String domainDesc;

	@OneToMany(mappedBy="domain",cascade=CascadeType.ALL,fetch=FetchType.LAZY)
	@JsonIgnore
	private Set<Model> models;
	public Integer getDomainId(){
		return this.domainId;
	}

	public void setDomainId(Integer domainId){
		this.domainId=domainId;
	}

	public String getDomainCName(){
		return this.domainCName;
	}

	public void setDomainCName(String domainCName){
		this.domainCName=domainCName;
	}

	public String getDomainEName(){
		return this.domainEName;
	}

	public void setDomainEName(String domainEName){
		this.domainEName=domainEName;
	}

	public String getDomainDesc(){
		return this.domainDesc;
	}

	public void setDomainDesc(String domainDesc){
		this.domainDesc=domainDesc;
	}

}