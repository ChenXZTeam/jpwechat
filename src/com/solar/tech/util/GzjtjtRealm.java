 package com.solar.tech.util;
 
 import com.solar.tech.bean.AbstractLdapConfig;
 import com.solar.tech.bean.GzjtjtUser;
 import com.solar.tech.dao.IDao;
 import java.net.ConnectException;
 import java.net.UnknownHostException;
 import java.util.ArrayList;
 import java.util.List;
 import javax.naming.NamingException;
 import org.apache.shiro.authc.AuthenticationException;
 import org.apache.shiro.authc.AuthenticationInfo;
 import org.apache.shiro.authc.AuthenticationToken;
 import org.apache.shiro.authc.SimpleAuthenticationInfo;
 import org.apache.shiro.authc.UsernamePasswordToken;
 import org.slf4j.Logger;
 import org.springframework.beans.factory.annotation.Autowired;
 
 public class GzjtjtRealm extends AbstractRealm
 {
   private static final String LDAPUSER = "LDAPUSER:";
 
   @Autowired
   private LdapUtil ldapUtil;
 
   protected AuthenticationInfo _doGetAuthenticationInfo(AuthenticationToken token)
     throws AuthenticationException
   {
     UsernamePasswordToken _token = (UsernamePasswordToken)token;
     String username = _token.getUsername();
     String password = String.valueOf(_token.getPassword());
     GzjtjtUser user = new GzjtjtUser();
     if (username.startsWith("LDAPUSER:"))
       user.setDnName(username.replace("LDAPUSER:", ""));
     else {
       user.setCName(username);
     }
     List users = getDao().findExample(user);
 
     if (users.size() == 0)
       throw new AuthenticationException("该用户不存在");
     if (users.size() == 1) {
       user = (GzjtjtUser)users.get(0);
       if (!"ADMIN".equals(user.getUserType())) {
         throw new AuthenticationException("非管理员不能登录");
       }
       if ("SYST".equals(user.getUserClass())) {
         if (!password.equals(user.getPassword()))
           throw new AuthenticationException("密码错误");
       }
       else if ("LDAP".equals(user.getUserClass())) {
         List cfgs = getDao().findAll(AbstractLdapConfig.class);
         if (cfgs.size() == 0)
           throw new AuthenticationException("ldap配置缺失");
         AbstractLdapConfig cfg = (AbstractLdapConfig)cfgs.get(0);
         try {
           this.ldapUtil.authenticate(cfg.getHost() + ":" + cfg.getPort(), user.getDnName(), password);
         } catch (NamingException e) {
           Current.log().error("", e);
 
           if (e.getRootCause()
             .getClass()
             .equals(ConnectException.class)) {
             throw new AuthenticationException("ldap连接异常");
           }
 
           if (e.getRootCause()
             .getClass()
             .equals(UnknownHostException.class)) {
             throw new AuthenticationException("无法连接ldap服务器：" + e.getRootCause().getMessage());
           }
           throw new AuthenticationException("密码错误");
         }
       }
       else {
         throw new AuthenticationException("用户类型不明确");
       }
     } else {
       ArrayList dns = new ArrayList();
      // for (GzjtjtUser _user : users)
       for(int i=0;i<users.size();i++){
         if ("SYST".equals(user.getUserClass())) {
           throw new AuthenticationException("用户不明确");
         }
         GzjtjtUser _user =(GzjtjtUser)users.get(i);
         dns.add(_user.getDnName());
       }
       String _temp = "请选择一个dn进行登录：<select id='dn' name='dn'>";
 
      // for (String dn : dns) 
       for(int i=0;i<dns.size();i++){
         _temp = _temp + "<option value=" + dns.get(i) + ">" + dns.get(i) + "</option>";
       }
       _temp = _temp + "</select>";
       throw new AuthenticationException(_temp);
     }
     SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(user, password.toCharArray(), user.getCName());
     return info;
   }
 }

