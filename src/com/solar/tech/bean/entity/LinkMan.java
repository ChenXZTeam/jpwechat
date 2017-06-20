package com.solar.tech.bean.entity;

import java.sql.Timestamp;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 常用联系人
 * @author solarpc1
 *
 */
@Entity
@Table(name="FW_linkman")
public class LinkMan {
	//ID
    @Id
    @GenericGenerator(name="uuid", strategy="uuid")
    @GeneratedValue(generator="uuid")
    @Column(name="ID", length=50)
	private String ID;
    
   //联系人
    @Column(name="linkman", length=200)
	private String linkman;
    
    //联系电话
    @Column(name="linkNumber", length=50)
    private String linkNumber;
    
    //证件类型
    @Column(name="caseType", length=15)
    private String caseType; 
    
    //证件号码
    @Column(name="caseNum", length=50)
    private String caseNum;
    
    //生日
    @Column(name="birthday", length=15)
    private String birthday;
    
    //性别
    @Column(name="sex", length=15)
    private String sex;
    
    //旅客类型
    @Column(name="peopleType",length=10)
    private String peopleType;
    
    //用户对应的openid
  	@Column(name="openID",length=100)
  	private String openID;
  	
  	//中文名
  	@Column(name="chinaName",length=100)
  	private String chinaName;
  	
  	//证件有效期
  	@Column(name="caseTime",length=50)
  	private String caseTime;
  	
  	//国籍
  	@Column(name="belongCtry",length=100)
  	private String belongCtry;
  	
  	//用户名
  	@Column(name = "UserName", length=100)
  	private String UserName;
  	
  	//用户名绑定的电话
  	@Column(name = "userNamePhone", length=100)
  	private String userNamePhone;
    
    //创建时间
  	@Column(name = "createTime")
  	private Timestamp createTime;
  	
  	//备注
  	@Column(name = "commit",length=1000)
  	private String commit;

	public String getID() {
		return ID;
	}

	public void setID(String iD) {
		ID = iD;
	}

	public String getLinkman() {
		return linkman;
	}

	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}

	public String getLinkNumber() {
		return linkNumber;
	}

	public void setLinkNumber(String linkNumber) {
		this.linkNumber = linkNumber;
	}

	public String getOpenID() {
		return openID;
	}

	public void setOpenID(String openID) {
		this.openID = openID;
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

	public String getCaseType() {
		return caseType;
	}

	public void setCaseType(String caseType) {
		this.caseType = caseType;
	}

	public String getCaseNum() {
		return caseNum;
	}

	public void setCaseNum(String caseNum) {
		this.caseNum = caseNum;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getPeopleType() {
		return peopleType;
	}

	public void setPeopleType(String peopleType) {
		this.peopleType = peopleType;
	}

	public String getChinaName() {
		return chinaName;
	}

	public void setChinaName(String chinaName) {
		this.chinaName = chinaName;
	}

	public String getCaseTime() {
		return caseTime;
	}

	public void setCaseTime(String caseTime) {
		this.caseTime = caseTime;
	}

	public String getBelongCtry() {
		return belongCtry;
	}

	public void setBelongCtry(String belongCtry) {
		this.belongCtry = belongCtry;
	}

	public String getCommit() {
		return commit;
	}

	public void setCommit(String commit) {
		this.commit = commit;
	}

	public String getUserNamePhone() {
		return userNamePhone;
	}

	public void setUserNamePhone(String userNamePhone) {
		this.userNamePhone = userNamePhone;
	}

	@Override
	public String toString() {
		return "LinkMan [ID=" + ID + ", linkman=" + linkman + ", linkNumber="
				+ linkNumber + ", caseType=" + caseType + ", caseNum="
				+ caseNum + ", birthday=" + birthday + ", sex=" + sex
				+ ", peopleType=" + peopleType + ", openID=" + openID
				+ ", chinaName=" + chinaName + ", caseTime=" + caseTime
				+ ", belongCtry=" + belongCtry + ", UserName=" + UserName
				+ ", createTime=" + createTime + ", commit=" + commit + "]";
	}

}  	
	