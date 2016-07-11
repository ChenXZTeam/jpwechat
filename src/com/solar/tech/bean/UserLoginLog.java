package com.solar.tech.bean;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
@Entity
@Table(name = "FW_UserLoginLog")
public class UserLoginLog {
@Id
@GenericGenerator (name="idgene",strategy="native")
@GeneratedValue(generator="idgene")
@Column(name = "logId")
private int logId;
@Column(name = "USERUID", length=50)
private String USERUID;
@Column(name = "userName", length=50)
private String userName;
private Timestamp loginTime;
@Column(name = "logintResult", length=10)
private String logintResult;
@Column(name = "redirectTo", length=200)
private String redirectTo;

}
