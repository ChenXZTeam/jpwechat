package com.solar.tech.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="FW_Countries")
public class Countries {
	
	//国家国际域名代码
	@Id
	@Column(name="id",length=10)
	private String id;
	//国家名称
	@Column(name="name",length=20)
	private String name;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	@Override
	public String toString() {
		return "Countries [id=" + id + ", name=" + name + "]";
	}
	
}
