package com.solar.tech.bean.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 国内资讯字段
 * @author solarpc1
 *
 */
@Entity
@Table(name="FW_info")
public class Info {
	//签证ID
    @Id
    @GenericGenerator(name="uuid", strategy="uuid")
    @GeneratedValue(generator="uuid")
    @Column(name="infoID", length=50)
	private String infoID;
    
   //文章标题
    @Column(name="title", length=50)
	private String title;
    
   //文字内容
    @Column(name="info", length=150)
	private String info;
  //创建时间
  	@Column(name = "createTime")
  	private Timestamp createTime;

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public String getInfoID() {
		return infoID;
	}

	public void setInfoID(String infoID) {
		this.infoID = infoID;
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
    
    
}
