 package com.solar.tech.util;
 
 import com.solar.tech.bean.AbstractUser;
 import com.solar.tech.dao.IDao;
 import java.util.List;
 import javax.naming.NamingException;
 import org.apache.shiro.authc.AuthenticationException;
 import org.apache.shiro.authc.AuthenticationInfo;
 import org.apache.shiro.authc.AuthenticationToken;
 import org.apache.shiro.authc.SimpleAuthenticationInfo;
 import org.apache.shiro.authc.UsernamePasswordToken;
 import org.slf4j.Logger;
 import org.springframework.beans.factory.annotation.Autowired;
 
 public class DatsRealm extends AbstractRealm
 {
   private static final String LDAPUSER = "LDAPUSER:";
 
   @Autowired
   private LdapUtil ldapUtil;
   private String ldapAdServer;
 
   protected AuthenticationInfo _doGetAuthenticationInfo(AuthenticationToken token)
     throws AuthenticationException
   {
     UsernamePasswordToken _token = (UsernamePasswordToken)token;
     String username = _token.getUsername();
     String password = String.valueOf(_token.getPassword());
     AbstractUser user = new AbstractUser();
    // System.out.println("user: "+username);
     user.setUserName(username);
     List users = getDao().findExample(user);
     //System.out.println("size: "+users.size());
     String tmpuser=username;
    if (users.size() == 0)
       try {
    	   
         username = "uid=" + username + ",cn=users,DC=DATSERVICE,DC=CN";
         this.ldapUtil.authenticate(this.ldapAdServer, username, password);
         return new SimpleAuthenticationInfo(user, password.toCharArray(), username);
       }
       catch (NamingException e) {
         Current.log().error("", e);
         throw new AuthenticationException(Error.PASSWORD(tmpuser));
       }
     
     if (users.size() == 1) {
       user = (AbstractUser)users.get(0);
       if (!Current.md5(password).equals(user.getPassword()))
         throw new AuthenticationException(Error.PASSWORD(tmpuser));
       SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(user, password.toCharArray(), username);
       return info;
     }
     throw new AuthenticationException(Error.PASSWORD(tmpuser));
   }
 
   public void setLdapAdServer(String ldapAdServer)
   {
     this.ldapAdServer = ldapAdServer;
   }
 }

