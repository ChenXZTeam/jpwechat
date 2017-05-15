package com.solar.tech.bean.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 将搜索出来的可以用座位存入数据库中
 * @author solar-LXQ
 *
 */
@Entity
@Table(name="FW_SEATINFODATA")
public class SeatInfoData {
	//主键
    @Id
    @GenericGenerator(name="uuid", strategy="uuid")
    @GeneratedValue(generator="uuid")
    @Column(name="uuid")
	private String uuid; 
    //航班号
    @Column(name="airline")
    private String airline;
    
    //出发日期
    @Column(name="depDate")
    private String depDate;
    
    //出发日期是否+1
    @Column(name="deptimemodify")
    private String deptimemodify;
    
    //出发时间
    @Column(name="depTime")
    private String depTime;
    
    //出发机场航站楼
    @Column(name="depTerm")
    private String depTerm;
    
    //出发机场三字码
    @Column(name="orgcity")
    private String orgcity;
    
    //到达机场航站楼
    @Column(name="arriTerm")
    private String arriTerm;
    
    //到达时间
    @Column(name="arriTime")
    private String arriTime;
    
    //到达日期
    @Column(name="arriveDate")
    private String arriveDate;
    
    //到达日期是否+1
    @Column(name="arriveTimeModify")
    private String arriveTimeModify;
    
    //到达机场三字码
    @Column(name="dstcity")
    private String dstcity;
    
    //舱位的数量 A：充足，其他字母：null, 数字代表剩余的数量  这个参数跟下一个参数对应
    @Column(name="cangwei_data")
    private String cangwei_data;
    
    //舱位的下标
    @Column(name="cangwei_index")
    private String cangwei_index;
    
    //飞行历时
    @Column(name="flyTime")
    private String flyTime;
    
    //飞机机型
    @Column(name="planestyle")
    private String planestyle;
    
    //餐食
    @Column(name="meal")
    private String meal;
    
    //创建时间
    @Column(name="createTime")
    private Timestamp createTime;
    
    //该航班的唯一标识（可控）
    @Column(name="signFilghtNum")
    private String signFilghtNum;
    
    //组合航班
    /*@Column(name="friendiyFilght", length=50)
    private String friendiyFilght;*/
    
    //是否中转
    /*@Column(name="isDirect", length=50)
    private String isDirect;*/

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getAirline() {
		return airline;
	}

	public void setAirline(String airline) {
		this.airline = airline;
	}

	public String getDepDate() {
		return depDate;
	}

	public void setDepDate(String depDate) {
		this.depDate = depDate;
	}

	public String getDeptimemodify() {
		return deptimemodify;
	}

	public void setDeptimemodify(String deptimemodify) {
		this.deptimemodify = deptimemodify;
	}

	public String getDepTime() {
		return depTime;
	}

	public void setDepTime(String depTime) {
		this.depTime = depTime;
	}

	public String getDepTerm() {
		return depTerm;
	}

	public void setDepTerm(String depTerm) {
		this.depTerm = depTerm;
	}

	public String getOrgcity() {
		return orgcity;
	}

	public void setOrgcity(String orgcity) {
		this.orgcity = orgcity;
	}

	public String getArriTerm() {
		return arriTerm;
	}

	public void setArriTerm(String arriTerm) {
		this.arriTerm = arriTerm;
	}

	public String getArriTime() {
		return arriTime;
	}

	public void setArriTime(String arriTime) {
		this.arriTime = arriTime;
	}

	public String getArriveDate() {
		return arriveDate;
	}

	public void setArriveDate(String arriveDate) {
		this.arriveDate = arriveDate;
	}

	public String getArriveTimeModify() {
		return arriveTimeModify;
	}

	public void setArriveTimeModify(String arriveTimeModify) {
		this.arriveTimeModify = arriveTimeModify;
	}

	public String getDstcity() {
		return dstcity;
	}

	public void setDstcity(String dstcity) {
		this.dstcity = dstcity;
	}

	public String getCangwei_data() {
		return cangwei_data;
	}

	public void setCangwei_data(String cangwei_data) {
		this.cangwei_data = cangwei_data;
	}

	public String getCangwei_index() {
		return cangwei_index;
	}

	public void setCangwei_index(String cangwei_index) {
		this.cangwei_index = cangwei_index;
	}

	public String getFlyTime() {
		return flyTime;
	}

	public void setFlyTime(String flyTime) {
		this.flyTime = flyTime;
	}

	public String getPlanestyle() {
		return planestyle;
	}

	public void setPlanestyle(String planestyle) {
		this.planestyle = planestyle;
	}

	public String getMeal() {
		return meal;
	}

	public void setMeal(String meal) {
		this.meal = meal;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public String getSignFilghtNum() {
		return signFilghtNum;
	}

	public void setSignFilghtNum(String signFilghtNum) {
		this.signFilghtNum = signFilghtNum;
	}
	
/*
	public String getFriendiyFilght() {
		return friendiyFilght;
	}

	public void setFriendiyFilght(String friendiyFilght) {
		this.friendiyFilght = friendiyFilght;
	}

	public String getIsDirect() {
		return isDirect;
	}

	public void setIsDirect(String isDirect) {
		this.isDirect = isDirect;
	}*/
    
}
