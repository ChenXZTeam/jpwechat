package com.solar.tech.bean.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 国际资讯
 * @author solarpc1
 *
 */
@Entity
@Table(name="FW_outinfo")
public class OutInfo {
	//签证ID
    @Id
    @GenericGenerator(name="uuid", strategy="uuid")
    @GeneratedValue(generator="uuid")
    @Column(name="outinfoID", length=50)
	private String outinfoID;
    
   //文章标题
    @Column(name="title", length=200)
	private String title;
    
   //简介
    @Column(name="introduction", length=200)
    private String introduction;
    
   //文字内容
   @Column(name="info")
   private String info;
   
   //封面路径
   @Column(name="fmUrl")
   private String fmUrl;
    
   //创建时间
   @Column(name = "createTime")
   private Timestamp createTime;

   //不需要创建数据库字段的变量（用于传递参数用的,在InfoService中用于传参数一次而已）
   private String webPath;
   
	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	
	public String getOutinfoID() {
		return outinfoID;
	}

	public void setOutinfoID(String outinfoID) {
		this.outinfoID = outinfoID;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
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
