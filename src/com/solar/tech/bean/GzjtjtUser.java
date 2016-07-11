 package com.solar.tech.bean;
 
 import javax.persistence.Column;
 import javax.persistence.Entity;
 import javax.persistence.Table;
 
 @Entity
 @Table(name="FW_User_2")
 public class GzjtjtUser extends AbstractUser
 {
   private static final long serialVersionUID = -3744046527216706406L;
 
   @Column(name="DnName", length=200)
   private String dnName;
 
   @Column(name="CName", length=50)
   private String cName;
 
   public String getDnName()
   {
     return this.dnName;
   }
 
   public void setDnName(String dnName) {
     this.dnName = dnName;
   }
 
   public String getCName() {
     return this.cName;
   }
 
   public void setCName(String cName) {
     this.cName = cName;
   }
 
   public static class UserClass
   {
     public static final String SYST = "SYST";
     public static final String LDAP = "LDAP";
   }
 }

