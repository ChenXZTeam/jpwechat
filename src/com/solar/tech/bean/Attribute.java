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

import org.codehaus.jackson.annotate.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "FW_Attribute")
public class Attribute{
	@Id
	@GenericGenerator (name="idgene",strategy="native")
	@GeneratedValue(generator="idgene")
	@Column(name = "AttributeId")
	private Integer attributeId;


	@Column(name = "AttributeCName", length=50)
	private String attributeCName;

	@Column(name = "AttributeEName", length=50)
	private String attributeEName;

	@Column(name = "IsPrimariKey")
	private Integer isPrimariKey;

	@Column(name = "IsAllowNull")
	private Integer isAllowNull;

	@Column(name = "IsIndex")
	private Integer isIndex;

	@Column(name = "IsUnique")
	private Integer isUnique;

	@Column(name = "Length")
	private Integer length;

	@Column(name = "Type", length=20)
	private String type;





	@Column(name = "ValidataRuler", length=100)
	private String validataRuler;

	@ManyToOne
	@JoinColumn(name="ModelId")
	private Model model;

	@JsonIgnore
	@OneToMany(cascade=CascadeType.ALL,mappedBy="attri")
	private Set<ForeignKey> foreignKeys;

	public Integer getAttributeId() {
		return attributeId;
	}

	public void setAttributeId(Integer attributeId) {
		this.attributeId = attributeId;
	}

	public String getAttributeCName() {
		return attributeCName;
	}

	public void setAttributeCName(String attributeCName) {
		this.attributeCName = attributeCName;
	}

	public String getAttributeEName() {
		return attributeEName;
	}

	public void setAttributeEName(String attributeEName) {
		this.attributeEName = attributeEName;
	}

	public Integer getIsPrimariKey() {
		return isPrimariKey;
	}

	public void setIsPrimariKey(Integer isPrimariKey) {
		this.isPrimariKey = isPrimariKey;
	}

	public Integer getIsAllowNull() {
		return isAllowNull;
	}

	public void setIsAllowNull(Integer isAllowNull) {
		this.isAllowNull = isAllowNull;
	}

	public Integer getIsIndex() {
		return isIndex;
	}

	public void setIsIndex(Integer isIndex) {
		this.isIndex = isIndex;
	}

	public Integer getIsUnique() {
		return isUnique;
	}

	public void setIsUnique(Integer isUnique) {
		this.isUnique = isUnique;
	}

	public Integer getLength() {
		return length;
	}

	public void setLength(Integer length) {
		this.length = length;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getValidataRuler() {
		return validataRuler;
	}

	public void setValidataRuler(String validataRuler) {
		this.validataRuler = validataRuler;
	}

	public Model getModel() {
		return model;
	}

	public void setModel(Model model) {
		this.model = model;
	}

	public Set<ForeignKey> getForeignKeys() {
		return foreignKeys;
	}

	public void setForeignKeys(Set<ForeignKey> foreignKeys) {
		this.foreignKeys = foreignKeys;
	}
	
	

}