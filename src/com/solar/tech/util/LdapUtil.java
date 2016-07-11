 package com.solar.tech.util;
 
 import com.solar.tech.bean.AbstractLdapConfig;
import com.solar.tech.bean.AbstractUser;
import com.solar.tech.bean.AbstractUser.UserStatus;
 import com.solar.tech.bean.GzjtjtUser;
 import com.solar.tech.dao.HibernateDao;
 import com.solar.tech.dao.IDao;
 import java.util.Hashtable;
 import java.util.List;
 import java.util.Timer;
 import java.util.TimerTask;
 import javax.annotation.Resource;
 import javax.naming.NamingEnumeration;
 import javax.naming.NamingException;
 import javax.naming.directory.Attribute;
 import javax.naming.directory.Attributes;
 import javax.naming.directory.SearchControls;
 import javax.naming.directory.SearchResult;
 import javax.naming.ldap.InitialLdapContext;
 import javax.naming.ldap.LdapContext;
 import org.apache.commons.logging.Log;
 import org.apache.commons.logging.LogFactory;
 import org.springframework.stereotype.Component;
 
 @Component
 public class LdapUtil
 {
 
   @Resource(type=HibernateDao.class)
   private IDao dao;
   public String ldapAdServer;
   private String ldapUsername;
   private String ldapPassword;
   private String ldapPersonClass;
   private String ldapGroupClass;
   private LdapContext ldapContext;
   private Timer ldapTimer;
   private Integer ldapFreq = Integer.valueOf(0);
   private static final Log log = LogFactory.getLog(LdapUtil.class);
 
   public void loadConfig(LdapUtil _ldapUtil) throws NamingException
   {
     List cfgs = this.dao.findAll(AbstractLdapConfig.class);
     if (cfgs.size() == 0)
       throw new RuntimeException("ldap配置缺失");
     AbstractLdapConfig cfg = (AbstractLdapConfig)cfgs.get(0);
 
     this.ldapAdServer = (cfg.getHost() + ":" + cfg.getPort());
     this.ldapUsername = cfg.getUsername();
     this.ldapPassword = cfg.getPassword();
     this.ldapPersonClass = cfg.getPersonClass();
     this.ldapGroupClass = cfg.getGroupClass();
     this.ldapContext = authenticate(this.ldapAdServer, this.ldapUsername, this.ldapPassword);
 
     this.ldapFreq = cfg.getFreq();
     if (this.ldapFreq != null)
       if (this.ldapFreq.intValue() == 0)
         stopLdapSync();
       else if (this.ldapFreq.intValue() > 0)
         startLdapSync(_ldapUtil);
   }
 
   private void startLdapSync(final LdapUtil _ldapUtil)
   {
     if (this.ldapTimer == null) {
       this.ldapTimer = new Timer();
       this.ldapTimer.schedule(new TimerTask()
       {
         public void run() {
           try {
             _ldapUtil.updateUsers();
           } catch (NamingException e) {
             LdapUtil.log.error("", e);
           }
         }
       }
       , 0L, this.ldapFreq.intValue() * 24 * 60 * 60 * 1000);
     }
   }
 
   public void stopLdapSync() {
     if (this.ldapTimer != null) {
       this.ldapTimer.cancel();
       this.ldapTimer = null;
     }
   }
 
   public void updateUsers()
     throws NamingException
   {
     log.debug("updateUsers:started:" + Current.time());
     NamingEnumeration rs = get("(objectClass=" + this.ldapPersonClass + ")");
     while (rs.hasMoreElements()) {
       SearchResult r = (SearchResult)rs.nextElement();
       GzjtjtUser user = new GzjtjtUser();
       user.setDnName(
         r.getName());
       List beans = this.dao.findExample(user);
       if (beans.size() > 0) {
         user = (GzjtjtUser)beans.get(0);
       } else {
         user.setUserStatus(AbstractUser.UserStatus.ACT);
         user.setUserType("USER");
       }
       Attribute cn = r.getAttributes()
         .get("cn");
       user.setCName(cn == null ? "" : cn
         .get()
         .toString());
       Attribute mail = r.getAttributes()
         .get("mail");
       user.setEmail(mail == null ? "" : mail
         .get()
         .toString());
       user.setUserClass("LDAP");
       this.dao.saveOrUpdate(user);
     }
     log.debug("updateUsers:finished:" + Current.time());
   }
 
   private NamingEnumeration<SearchResult> get(String searchFilter)
     throws NamingException
   {
     SearchControls searchControls = new SearchControls();
     searchControls.setSearchScope(2);
     return this.ldapContext.search("", searchFilter, searchControls);
   }
 
   public InitialLdapContext authenticate(String ldapAdServer, String ldapUsername, String ldapPassword)
     throws NamingException
   {
     Hashtable env = new Hashtable();
     env.put("java.naming.factory.initial", "com.sun.jndi.ldap.LdapCtxFactory");
     env.put("java.naming.provider.url", "ldap://" + ldapAdServer);
     env.put("java.naming.security.authentication", "simple");
     env.put("java.naming.security.principal", ldapUsername);
     env.put("java.naming.security.credentials", ldapPassword);
     return new InitialLdapContext(env, null);
   }
 
   public void setDao(IDao Dao) {
     this.dao = Dao;
   }
 
   public static void main(String[] args)
     throws InterruptedException, NamingException
   {
     LdapUtil lu = new LdapUtil();
     lu.authenticate("120.25.62.2:389", "cn=root", "datservice2015");
/*     */   }
/*     */ }

