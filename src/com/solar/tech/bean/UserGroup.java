package com.solar.tech.bean;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.solar.tech.bean.AbstractUserGroup;

@Entity
@Table(name = "FW_UserGroup")
public class UserGroup extends AbstractUserGroup{

}