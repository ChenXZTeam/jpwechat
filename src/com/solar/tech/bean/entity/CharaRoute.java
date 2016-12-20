package com.solar.tech.bean.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 特色路线
 * @author solarpc1
 *
 */
@Entity
@Table(name = "RD_charaRoute")
public class CharaRoute {
	//用户id
	@Id
	@GeneratedValue(generator = "uuid")
	@GenericGenerator(name = "uuid", strategy = "uuid")
	@Column(name = "ID", length=100)
	private String ID;
	
	//特色路线标题
	@Column(name = "title", length=100)
	private String title;
	
	//文本内容
	@Column(name="conText")
	private String conText;
	
	//用户名
	@Column(name = "UserName", length=100)
	private String UserName;
	
	//创建时间
	@Column(name = "createTime")
	private Timestamp createTime;

	public String getID() {
		return ID;
	}

	public void setID(String iD) {
		ID = iD;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getConText() {
		return conText;
	}

	public void setConText(String conText) {
		this.conText = conText;
	}

	public String getUserName() {
		return UserName;
	}

	public void setUserName(String userName) {
		UserName = userName;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

}
