insert into fw_menu( MenuId , CreateBy , CreateTime , Description , MenuIcon , MenuName , MenuStatus , MenuTarget , MenuType , MenuUrl , SortNum , UpdateBy , UpdateTime ) values (1430,NULL,'2015-09-23 14:12:31',NULL,NULL,'系统框架管理',1,NULL,'FRMU',NULL,0,'username','2015-09-23 14:12:31'),(1435,'hejie','2015-09-29 09:32:43','阿斯达阿斯达阿斯达','ext-icon-book','测试菜单',1,'self','FRMU','阿',0,'hejie','2015-09-29 14:07:33');

insert  into fw_menuitem( ItemId , CreateBy , CreateTime , Description , ItemIcon , ItemName , ItemStatus , ItemTarget , ItemType , ItemUrl , MenuId , PageId , ParentItemId , SortNum , UpdateBy , UpdateTime ) values (1270,'username','2015-09-23 19:40:25',NULL,'icon-save','菜单列表',1,'self','FRMI','/framework/menu/index.action',1430,NULL,1440,0,'hejie','2015-09-23 19:40:25'),(1271,'username','2015-09-23 19:40:25',NULL,'ext-icon-color_swatch','菜单项列表',1,'self','FRMI','/framework/menu/item/index.action',1430,NULL,1440,1,'com.solartech.framework.bean.User@19757394','2015-09-23 19:40:25'),(1360,'username','2015-09-23 19:40:25',NULL,NULL,'页面组',1,'self','FRMI','/framework/page/group/index.action',1430,NULL,1442,0,'wwd','2015-09-23 19:40:25'),(1361,'username','2015-09-23 19:40:25',NULL,NULL,'页面',1,'self','FRMI','/framework/page/index.action',1430,NULL,1442,1,'hejie','2015-09-23 19:40:25'),(1440,'username','2015-09-23 19:40:25',NULL,NULL,'菜单管理',1,'self','FRMI',NULL,1430,NULL,0,0,'username','2015-09-23 19:40:25'),(1442,'username','2015-09-23 19:40:25',NULL,NULL,'页面管理',1,'self','FRMI',NULL,1430,NULL,0,0,'username','2015-09-23 19:40:25'),(1600,'username','2015-09-23 19:40:25',NULL,NULL,'模型管理',1,'self','FRMI',NULL,1430,NULL,0,0,'username','2015-09-23 19:40:25'),(1601,'username','2015-09-23 19:40:25',NULL,NULL,'数据域列表',1,'self','FRMI','/console/framework/model/domainlist.jsp',1430,NULL,1600,0,'hejie','2015-09-23 19:40:25'),(1602,'username','2015-09-23 19:41:44',NULL,NULL,'模型列表',1,'self','FRMI','/console/framework/model/modellist.jsp',1430,NULL,1600,0,'wwd','2015-09-23 19:41:44'),(1670,'username','2015-09-23 19:40:25',NULL,NULL,'用户管理',1,'self','FRMI',NULL,1430,NULL,0,0,'wwd','2015-09-23 19:40:25'),(1671,'username','2015-09-23 19:40:25',NULL,NULL,'用户列表',1,'self','FRMI','/console/framework/user/shows.jsp',1430,NULL,1670,0,'hejie','2015-09-23 19:40:25'),(1672,'username','2015-09-23 19:40:25',NULL,NULL,'用户组列表',1,'self','FRMI','/console/framework/group/shows.jsp',1430,NULL,1670,0,'hejie','2015-09-23 19:40:25');

/*Data for the table  fw_menuitemassignlog  */

/*Data for the table  fw_model  */

/*Data for the table  fw_pagemodule  */

insert  into fw_pagemodule( ModuleId , CreateBy , CreateTime , Description , ModuleIcon , ModuleName , ParentModuleId , SortNum , UpdateBy , UpdateTime ) values (1,'hejie','2015-09-29 09:51:28','21 21 ','112','1',0,1,'hejie','2015-09-29 09:51:28'),(2,'hejie','2015-09-29 09:51:48','请问','请问请问','请问请问',1,0,'hejie','2015-09-29 09:51:48'),(3,'hejie','2015-09-29 09:52:00','请问启动启动','请问请问','器伟请',2,3,'hejie','2015-09-29 09:52:25');

/*Data for the table  fw_user  */

insert  into  fw_user ( UserUID , CreateBy , CreateTime , Description , Email , FullName , HeadImg , Mobile , Password , UpdateBy , UpdateTime , UserClass , UserExtProps , UserLevel , UserName , UserNum , UserStatus , UserType ) values ('4028668150178a650150178b0b010002','admin','2015-09-29 13:19:59','','',NULL,NULL,'','5f4dcc3b5aa765d61d8327deb882cf99','hejie','2015-09-29 13:19:59','SYSADMIN','',NULL,'admin',NULL,1,'ADMIN'),('4028c0815017b520015017b6fe8b0000','hejie','2015-09-29 14:08:00','','',NULL,NULL,'','password','hejie','2015-09-29 14:08:00','SYSADMIN','',NULL,'wwd',NULL,1,'ADMIN');

/*Data for the table  fw_usergroup  */

insert  into  fw_usergroup ( GroupId , CreateBy , CreateTime , Description , GroupName , UpdateBy , UpdateTime ) values (1,NULL,NULL,'管理员用户组','admin','hejie','2015-09-29 14:08:53'),(2,NULL,NULL,'df sdf ','test','admin','2015-09-29 17:01:21');

/*Data for the table  fw_usergroupmenu  */

insert  into  fw_usergroupmenu ( UGID , GroupId , MenuId ) values (4,1,1430),(6,1,1435);

/*Data for the table  fw_usergroupmenuitem  */

insert  into  fw_usergroupmenuitem ( UGIID , GroupId , ItemId ) values (1,1,1440),(2,1,1270),(3,1,1271),(5,1,1670),(6,1,1360),(7,1,1361),(8,1,1601),(9,1,1602),(10,1,1671),(11,1,1672);

/*Data for the table  fw_usergrouppagemodule  */

insert  into  fw_usergrouppagemodule ( GPMID , Allow , GroupId , ModuleId ) values (9,NULL,1,1),(10,NULL,2,1);

/*Data for the table  fw_usergroupwebpage  */

insert  into  fw_usergroupwebpage ( GWPID , Allow , GroupId , PageId ) values (2,NULL,2,1),(3,NULL,2,2);

/*Data for the table  fw_userhistorypsw  */

/*Data for the table  fw_useringroup  */

insert  into  fw_useringroup ( UGID , GroupId , USERUID ) values (1,1,'4028668150178a650150178b0b010001'),(2,2,'4028668150178a650150178b0b010001');

/*Data for the table  fw_userloginlog  */

/*Data for the table  fw_usermenu  */

insert  into  fw_usermenu ( UMID , MenuId , USERUID ) values (1780,1580,'402866814e0a87d3014e0a886569002e'),(2530,1580,'402866814e0a87d3014e0a8832c50002'),(2531,1580,'402866814e0a87d3014e0a8833510003'),(2532,1580,'402866814e0a87d3014e0a8833d30004'),(2533,1580,'402866814e0a87d3014e0a8835db0008'),(2550,2040,'402866814e0a87d3014e0a8832c50002'),(2804,1430,'402866814e348f19014e3490712a0000'),(2805,1430,'402866814e0a87d3014e0a886569002e'),(2806,1430,'402866814e0a87d3014e0a8831490000'),(2807,1430,'402866814e0a87d3014e0a88604d0028'),(2960,1430,'402866814e249926014e2499715b0000'),(2961,1430,'4028c0814ffd2667014ffd2a287b0000'),(2962,1435,'4028c0814ffd2667014ffd2a287b0000');

/*Data for the table  fw_usermenuitem  */

insert  into  fw_usermenuitem ( UMIID , ItemId , USERUID ) values (2590,1430,'402866814e0a87d3014e0a8832c50002'),(2591,1430,'402866814e0a87d3014e0a8833510003'),(2603,1271,'402866814e0a87d3014e0a8832c50002'),(2604,1271,'402866814e0a87d3014e0a8833510003'),(2605,1271,'402866814e0a87d3014e0a8833d30004'),(2700,1440,'402866814e348f19014e3490712a0000'),(2701,1271,'402866814e348f19014e3490712a0000'),(2702,1270,'402866814e348f19014e3490712a0000'),(2830,1271,'402866814e249926014e2499715b0000'),(2831,1271,'402866814e0a87d3014e0a8831e90001'),(2832,1271,'402866814e0a87d3014e0a886569002e'),(2900,1360,'402866814e0a87d3014e0a8831490000'),(2901,1360,'402866814e0a87d3014e0a8831490000'),(2902,1360,'402866814e0a87d3014e0a8831e90001'),(2903,1360,'402866814e0a87d3014e0a8831490000'),(2904,1360,'402866814e0a87d3014e0a8831e90001'),(2905,1360,'402866814e0a87d3014e0a8831e90001'),(2906,1360,'402866814e0a87d3014e0a8831e90001'),(2907,1360,'402866814e0a87d3014e0a8832c50002'),(2908,1360,'402866814e0a87d3014e0a8832c50002'),(2909,1360,'402866814e0a87d3014e0a8832c50002'),(2910,1360,'402866814e0a87d3014e0a8832c50002'),(2913,1442,'4028668150178a650150178b0b010001'),(2914,1600,'4028668150178a650150178b0b010001');

/*Data for the table  fw_userpagemodule  */

insert  into  fw_userpagemodule ( UPMID , Allow , ModuleId , USERUID ) values (1,NULL,1,'4028668150178a650150178b0b010001'),(3,NULL,2,'4028c0815017b520015017b6fe8b0000'),(4,NULL,2,'4028668150178a650150178b0b010001');

/*Data for the table  fw_userwebpage  */

insert  into  fw_userwebpage ( UWPID , Allow , PageId , USERUID ) values (3,NULL,2,'4028668150178a650150178b0b010001'),(4,NULL,1,'4028668150178a650150178b0b010001');

/*Data for the table  fw_webpage  */

insert  into  fw_webpage ( PageId , CreateBy , CreateTime , Description , ModuleId , PageName , PageNum , PageUrl , SortNum , UpdateBy , UpdateTime , needAclCtrl , pageType ) values (1,'hejie','2015-09-29 11:14:50','额外',1,'电饭锅','额外','二',0,'hejie','2015-09-29 11:35:33','ON','BKGPG'),(2,'admin','2015-09-30 16:54:15','',1,'测试','','',0,'admin','2015-09-30 16:54:15','ON','BKGPG');


INSERT INTO  fw_user  VALUES ('4028668150178a650150178b0b010001','hejie','2015-09-29 13:19:59','','',NULL,NULL,'','5f4dcc3b5aa765d61d8327deb882cf99','hejie','2015-09-29 13:19:59','SYSADMIN','',NULL,'hejie',NULL,1,'ADMIN');






