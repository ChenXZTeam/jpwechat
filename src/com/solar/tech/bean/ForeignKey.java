package com.solar.tech.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "FW_ForeignKey")
public class ForeignKey{
	@Id
	@GenericGenerator (name="idgene",strategy="native")
	@GeneratedValue(generator="idgene")
	@Column(name = "FKId")
	private Integer fKId;

	@Column(name = "FKCName", length=50)
	private String fKCName;

	@Column(name = "FKEName", length=50)
	private String fKEName;

	@Column(name = "FKMainAttribute", length=50)
	private String fKMainAttribute;

	@ManyToOne
	@JoinColumn(name="ModelId")
	private Model model;

	@ManyToOne
	@JoinColumn(name="AttributeId")
	private Attribute attri;

	//外键参照属性ID  用来作为新建模型时的辅助属性
	@Transient
	private Integer refAttriId;
	
	public Integer getfKId() {
		return fKId;
	}

	public void setfKId(Integer fKId) {
		this.fKId = fKId;
	}

	public String getfKCName() {
		return fKCName;
	}

	public void setfKCName(String fKCName) {
		this.fKCName = fKCName;
	}

	public String getfKEName() {
		return fKEName;
	}

	public void setfKEName(String fKEName) {
		this.fKEName = fKEName;
	}

	public String getfKMainAttribute() {
		return fKMainAttribute;
	}

	public void setfKMainAttribute(String fKMainAttribute) {
		this.fKMainAttribute = fKMainAttribute;
	}

	public Model getModel() {
		return model;
	}

	public void setModel(Model model) {
		this.model = model;
	}

	public Attribute getAttri() {
		return attri;
	}

	public void setAttri(Attribute attri) {
		this.attri = attri;
	}

	public Integer getRefAttriId() {
		return refAttriId;
	}

	public void setRefAttriId(Integer refAttriId) {
		this.refAttriId = refAttriId;
	}

	
	

	

}