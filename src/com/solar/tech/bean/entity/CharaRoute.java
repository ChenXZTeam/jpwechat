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
	@Column(name = "routeID", length=100)
	private String routeID;
	
	//特色路线标题
	@Column(name = "title", length=100)
	private String title;
	
	//简介
    @Column(name="introduction", length=200)
    private String introduction;
    
	//文本内容
	@Column(name="conText")
	private String conText;
	
	//用户名
	@Column(name = "UserName", length=100)
	private String UserName;
	
	//创建时间
	@Column(name = "createTime")
	private Timestamp createTime;

	//封面路径
	@Column(name="fmUrl")
	private String fmUrl;
	
	//不需要创建数据库字段的变量（用于传递参数用的,在InfoService中用于传参数一次而已）
	private String webPath;

	public String getRouteID() {
		return routeID;
	}

	public void setRouteID(String routeID) {
		this.routeID = routeID;
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

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public String getFmUrl() {
		return fmUrl;
	}

	public void setFmUrl(String fmUrl) {
		this.fmUrl = fmUrl;
	}

	public String getWebPath() {
		return webPath;
	}

	public void setWebPath(String webPath) {
		this.webPath = webPath;
	}

}
