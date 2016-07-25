package com.solar.tech.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="fw_RequiredMaterials")
public class RequiredMaterials {
	
	@Id
	@GenericGenerator(name="uuid", strategy="uuid")
	@GeneratedValue(generator="uuid")
	@Column(name="visaOrderID",length=50)
	//材料ID
	private String materialsID;
	
	@Column(name="customerType",length=10)
	//客户类型
	private String customerType;
	
	@Column(name="content",length=1500)
	//材料内容
	private String content;

	public String getMaterialsID() {
		return materialsID;
	}

	public void setMaterialsID(String materialsID) {
		this.materialsID = materialsID;
	}

	public String getCustomerType() {
		return customerType;
	}

	public void setCustomerType(String customerType) {
		this.customerType = customerType;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "RequiredMaterials [materialsID=" + materialsID + ", customerType=" + customerType + ", content="
				+ content + "]";
	}
	
}
