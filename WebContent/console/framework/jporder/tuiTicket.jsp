<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>退票管理</title>
	<link rel="stylesheet" type="text/css"href="<%=basePath%>scripts/common/jquery-easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/demo.css">
    <link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/default/datagrid.css">
    <script src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
    <script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
    <script src="<%=basePath%>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
    <script src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
    <div id="contain">
          <form id="qfm" action="">
                <div id="jpHeader">
                     <div style="width:100%;padding-top:20px;">
                          <span>
                               
                              <lable class="font-style">乘机人姓名:</lable>
                              <input id="person" class="easyui-textbox" data-options="prompt:'请输入乘机人姓名'" style="width:150px;height:25px"></input>
                          </span>
                          
                          <span style="margin-left:30px">
                              <lable class="font-style">航&nbsp;&nbsp;班&nbsp;号&nbsp;:</lable>
                              <input id="hangbannumber" class="easyui-textbox" data-options="prompt:'请输入航班号'" style="width:150px;height:25px"></input>
                         </span>
                         
                          <span style="margin-left:30px" >
                              <lable class="font-style">票&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号&nbsp;:</lable>
                              <input id="pnumber" class="easyui-textbox" data-options="prompt:'请输入票号'" style="width:150px;height:25px"></input>
                         </span>
                         
                    </div>
                    <div style="width:100%;margin-top:30px;">
                         <span>
                             <lable class="font-style">P&nbsp;&nbsp;&nbsp;&nbsp;N&nbsp;&nbsp;&nbsp;&nbsp;R&nbsp;:&nbsp;</lable>
                             <input id="pnr" class="easyui-textbox" data-options="prompt:'请输入PNR值'" style="width:150px;height:25px"></input>
                         </span>
                        <span style="margin-left:30px;">
                            <lable class="font-style">手机号码:</lable>
                            <input id="pnumber" class="easyui-textbox" data-options="prompt:'请输入手机号码'" style="width:150px;height:25px"></input>
                        </span>
                        <span style="margin-left:30px;">
                            <lable class="font-style">退票状态&nbsp;:</lable>
                            <select id="tpstatus" style="width:150px;height:25px;border-color:#95B8E7;border-radius:5px;">
                                    <option value="0">无退票</option>
                                    <option value="1">退票进行中</option>
                                    <option value="2">退票已完成</option>
                            </select>
                        </span>
                        <span style="position:relative;margin-left:800px; text-align:center; top:-50px; display:block;  overflow:hidden;border-radius:5px;">
                               <a href="javascript:void(0)" data-options="iconCls:'icon-search',plain:false"  class="btn_find"  onclick="query()" style="width:100px;height:32px;background-color:#01B5E6;border:none;cursor:pointer;outline:none;margin-left:5px;color:#fff;display:block;float:left;line-height:30px;text-decoration:none;border-radius:5px;">
                                  <img src="<%=basePath %>/console/images/find.png" style="width:20px;height:25px;margin-left:-30px;" />
						          <span class="img_class">查找</span>
                               </a>
                         </span>
                    </div>
                </div>
                   
               
         </form>
         <div style="height:25px; background-color:#fff;">
              <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="born()">生成列表</a>
         </div>
        <div id="grideBox" style="width:100%;margin-top:10px">
               <div id="dg" style="width:100%;height:100%;"></div>
        </div>
        
    </div>
    <script type="text/javascript">
        $(function(){
           $("#grideBox").css("height",$(window).height()-100);
           $("#dg").datagrid({
               height:'100%',
               fit:true,
               method:'POST',
               striped:true,
               nowrap:true,
               pageSize:20,
               pageNumber:1,
               pageList:[10,20,50,100,150,200],
               pagination: true,
               showFooter: true,
               loadMsg:'数据加载中请稍后......',
               toolbar:'#tb',
               singleSelect: false,
               rownumbers:true,
               columns:[[
                      { field:'ck',checkbox:true},
                      { field:'linkName',title:'乘机人姓名',width:'7%'},
                      { field:'pnumber',title:'电话号码',width:'10%'},
                      { field:'pnr',title:'PNR',width:'10%'},
                      { field:'telNumber',title:'票号',width:'10%'},
                      { field:'hangbanNum',title:'航班号',width:'10%'},
                      { field:'idcase',title:'证件号码',width:'10%'},
                      { field:'chufCity',title:'出发城市',width:'10%'},
                      { field:'daodCity',title:'到达城市',width:'10%'},
                      { field:'chufTime',title:'出发时间',width:'10%'},
                      { field:'tpStatus',title:'退票状态',width:'10%'},
                      { field:'bornStatus',title:'生成状态',width:'10%'}
                     
               ]]
               
           })
          
        });
        
     function born(){
         $("#dg").datagrid({
               height:'100%',
               fit:true,
               url:'<%=basePath%>framework/tuipiao/query.action',
               method:'POST',
               striped:true,
               nowrap:true,
               pageSize:20,
               pageNumber:1,
               pageList:[10,20,50,100,150,200],
               pagination: true,
               showFooter: true,
               loadMsg:'数据加载中请稍后......',
               toolbar:'#tb',
               singleSelect: false,
               rownumbers:true,
               columns:[[
                      { field:'ck',checkbox:true},
                      { field:'linkName',title:'乘机人姓名',width:'7%'},
                      { field:'pnumber',title:'电话号码',width:'10%'},
                      { field:'pnr',title:'PNR',width:'10%'},
                      { field:'telNumber',title:'票号',width:'10%'},
                      { field:'hangbanNum',title:'航班号',width:'10%'},
                      { field:'idcase',title:'证件号码',width:'10%'},
                      { field:'chufCity',title:'出发城市',width:'10%'},
                      { field:'daodCity',title:'到达城市',width:'10%'},
                      { field:'chufTime',title:'出发时间',width:'10%'},
                      { field:'tpStatus',title:'退票状态',width:'10%'},
                      { field:'bornStatus',title:'生成状态',width:'10%'}
                     
               ]]
               
           });
          
     }   
        
     function query(){
         var linkName=$("#person").textbox('getValue').trim();
         var hangbanNum=$("#hangbannumber").textbox('getValue').trim();
         var telNumber=$("#pnumber").textbox('getValue').trim();
         var pnumber=$("#pnumber").textbox('getValue').trim();
         var pnr=$("#pnr").textbox('getValue').trim();
         var tpstatus = $("#tpstatus option:selected").text();
         $('#dg').datagrid({
            height:'100%',
            fit:true,
            url:'<%=basePath%>framework/tuipiao/chazhao.action',
            queryParams:{
                "linkName":linkName,
                "hangbanNum":hangbanNum,
                "telNumber":telNumber,
                "pnumber":pnumber,
                "pnr":pnr,
                "tpstatus":tpstatus,
            },
            method:'POST',
            striped:true,
            nowrap:true,
            pageSize:20,
            pageNumber:1,
            pageList:[10,20,50,100,150,200],
            pagination: true,
            showFooter: true,
            loadMsg: '数据加载中请稍后……',
            toolbar:"#tb",
            singleSelect: false,
            rownumbers:true,
            columns:[[
                      { field:'ck',checkbox:true},
                      { field:'linkName',title:'乘机人姓名',width:'7%'},
                      { field:'pnumber',title:'电话号码',width:'10%'},
                      { field:'pnr',title:'PNR',width:'10%'},
                      { field:'telNumber',title:'票号',width:'10%'},
                      { field:'hangbanNum',title:'航班号',width:'10%'},
                      { field:'idcase',title:'证件号码',width:'10%'},
                      { field:'chufCity',title:'出发城市',width:'10%'},
                      { field:'daodCity',title:'到达城市',width:'10%'},
                      { field:'chufTime',title:'出发时间',width:'10%'},
                      { field:'tpStatus',title:'退票状态',width:'10%'},
                      { field:'bornStatus',title:'生成状态',width:'10%'}
                     
               ]]
            
         });
         
         
     }
      
    </script>
     
</body>
</html>