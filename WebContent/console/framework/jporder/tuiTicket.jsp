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
	<link rel="stylesheet" type="text/css"href="<%=basePath%>scripts/common/jquery-easyui/themes/default/easyui.css"/>
    <link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css"/>
    <link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/default/datagrid.css"/>
    <script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
    <script src="<%=basePath%>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
    <script src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="<%=basePath %>console/js/airCodeVScity.js"></script>
</head>
<body>
    <div id="contain">
         <table border="0" cellspacing="10">
         	<tr>
         		<td>乘机人姓名：</td>
         		<td><input id="person" class="easyui-textbox" data-options="prompt:'请输入乘机人姓名'" style="width:150px;height:25px"/></td>
         		<td>航班号：</td>
         		<td><input id="hangbannumber" class="easyui-textbox" data-options="prompt:'请输入航班号'" style="width:150px;height:25px"/></td>
         		<td>票号：</td>
         		<td><input id="pnumber" class="easyui-textbox" data-options="prompt:'请输入票号'" style="width:150px;height:25px"/></td>
         		<td>
         			<a href="javascript:void(0)" class="btn_find" onclick="query()" style="width:100px;text-align:center;background-color:#01B5E6;border:none;cursor:pointer;outline:none;margin-left:5px;color:#fff;display:block;float:left;line-height:30px;text-decoration:none;border-radius:5px;">
						 查找
                    </a>
         		</td>
         	</tr>
         	<tr>
         		<td>PNR码：</td>
         		<td><input id="pnr" class="easyui-textbox" data-options="prompt:'请输入PNR值'" style="width:150px;height:25px"/></td>
         		<td>手机号：</td>
         		<td><input id="telNumber" class="easyui-textbox" data-options="prompt:'请输入手机号码'" style="width:150px;height:25px"/></td>
         		<td>退票状态：</td>
         		<td>
         			<select id="tpstatus" class="easyui-combobox" panelHeight="auto" style="width:150px;">
					       <option value=""></option>
                           <option value="1">退票进行中</option>
                           <option value="2">退票已完成</option>
                     </select>
                </td>
         		<td></td>
         	</tr>
         </table>
         <div style="height:25px; background-color:#fff;">
              <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" onclick="born()">刷新</a>
              <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="upstatus()">修改退票状态</a> 
         </div>
        <div id="grideBox" style="width:100%;">
               <div id="dg" style="width:100%;height:100%;"></div>
        </div>
    </div>
    <div id="lvkeInfoBox" class="easyui-dialog" style="width:350px; padding:30px;" closed="true" buttons="#dlg-buttons">
		<form id="lvkeInfoForm">
			<table cellspacing="10">
				<tr style="display:none;">
					<td><input name="matherUuid" class="easyui-textbox"/></td>
					<td><input name="id" class="easyui-textbox"/></td>
				</tr>
				<tr>
					<td>退票状态：</td>
					<td>
						<select name="tpStatus" class="easyui-combobox" style="width:173px;" panelHeight="auto">
							<option value="1">退票进行中</option>
							<option value="2">退票已完成</option>
						</select>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" id="saveBean" iconCls="icon-ok" onclick="saveBean()" style="displaly:block;width: 90px">保存</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton" id="saveCancel" iconCls="icon-cancel" onclick="javascript:$('#lvkeInfoBox').dialog('close')" style="width:90px">取消</a>
	</div>
    <script type="text/javascript">
        $(function(){
           $("#grideBox").css("height",$(window).height()-135);
           $("#dg").datagrid({
               height:'100%',
               url:'<%=basePath%>framework/tuipiao/loadDate.action',
               fit:true,
               method:'POST',
               striped:true,
               nowrap:true,
               pageSize:20,
               pageNumber:1,
               pageList:[10,20,50,100,150,200],
               pagination: true,
               showFooter: true,
               onLoadSuccess: function (data) {
                   if (data.total == 0) {
                   		$.messager.alert('操作提示', "退票申请表为空", 'info');
                   }
               },
               loadMsg:'数据加载中请稍后......',
               toolbar:'#tb',
               singleSelect: false,
               rownumbers:true,
               columns:[[
                      { field:'ck',checkbox:true},
                      { field:'linkName',title:'乘机人姓名',width:'7%'},
                      { field:'pnumber',title:'电话号码',width:'10%'},
                      { field:'pnr',title:'PNR',align:'center',width:'6%'},
                      { field:'telNumber',title:'票号',align:'center',width:'10%'},
                      { field:'hangbanNum',title:'航班号',align:'center',width:'6%'},
                      { field:'idcase',title:'证件号码',width:'13%',align:'center'},
                      { field:'chufCity',title:'出发城市',width:'7%',align:'center',formatter:findByCity},
                      { field:'daodCity',title:'到达城市',width:'7%',align:'center',formatter:findByCity},
                      { field:'chufTime',title:'出发时间',width:'7%',align:'center',
         	        	 formatter:function(value){
         	        		 if(value=="undefined"||value==undefined){
         	        			 return value;
         	        		 }else{
         	        			return changeType(value);
         	        		 }
                         }
                      },
                      { field:'tpStatus',title:'退票状态',width:'10%',
         	        	 formatter:function(value,rec,index){  
                             if(value == '1'){
        							return "退票进行中";
        					 }else if(value == '2'){
        							return "退票已完成";
        					 }
                         }
                      },
                      { field:'createTime',title:'创建时间',width:'15%',align:'center', formatter:fotmateDate}
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
               onLoadSuccess: function (data) {
                   if (data.total == 0) {
                   		$.messager.alert('操作提示', "没有申请退票的订单或者已处理完成", 'info');
                   }
               },
               loadMsg:'数据加载中请稍后......',
               toolbar:'#tb',
               singleSelect: false,
               rownumbers:true,
               columns:[[
                         { field:'ck',checkbox:true},
                         { field:'linkName',title:'乘机人姓名',width:'7%'},
                         { field:'pnumber',title:'电话号码',width:'10%'},
                         { field:'pnr',title:'PNR',align:'center',width:'6%'},
                         { field:'telNumber',title:'票号',align:'center',width:'10%'},
                         { field:'hangbanNum',title:'航班号',align:'center',width:'6%'},
                         { field:'idcase',title:'证件号码',width:'13%',align:'center'},
                         { field:'chufCity',title:'出发城市',width:'7%',align:'center',formatter:findByCity},
                         { field:'daodCity',title:'到达城市',width:'7%',align:'center',formatter:findByCity},
                         { field:'chufTime',title:'出发时间',width:'7%',align:'center',
            	        	 formatter:function(value){
            	        		 if(value=="undefined"||value==undefined){
            	        			 return value;
            	        		 }else{
            	        			return changeType(value);
            	        		 }
                            }
                         },
                         { field:'tpStatus',title:'退票状态',width:'10%',
            	        	 formatter:function(value,rec,index){  
                                if(value == '1'){
           							return "退票进行中";
           					 }else if(value == '2'){
           							return "退票已完成";
           					 }
                            }
                         },
                         { field:'createTime',title:'创建时间',width:'15%',align:'center', formatter:fotmateDate}
                  ]]
               
           });
          
     }   
        
     function query(){
         var linkName=$("#person").textbox('getValue').trim();
         var hangbanNum=$("#hangbannumber").textbox('getValue').trim();
         var telNumber=$("#telNumber").textbox('getValue').trim();
         var pnumber=$("#pnumber").textbox('getValue').trim();
         var pnr=$("#pnr").textbox('getValue').trim();
         var tpstatus = $("#tpstatus").combobox('getValue').trim();
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
            onLoadSuccess: function (data) {
                if (data.total == 0) {
                	$.messager.alert('操作提示', "没有符合条件的数据", 'info');
                }
            },
            showFooter: true,
            loadMsg: '数据加载中请稍后……',
            toolbar:"#tb",
            singleSelect: false,
            rownumbers:true,
            columns:[[
                      { field:'ck',checkbox:true},
                      { field:'linkName',title:'乘机人姓名',width:'7%'},
                      { field:'pnumber',title:'电话号码',width:'10%'},
                      { field:'pnr',title:'PNR',align:'center',width:'6%'},
                      { field:'telNumber',title:'票号',align:'center',width:'10%'},
                      { field:'hangbanNum',title:'航班号',align:'center',width:'6%'},
                      { field:'idcase',title:'证件号码',width:'13%',align:'center'},
                      { field:'chufCity',title:'出发城市',width:'7%',align:'center',formatter:findByCity},
                      { field:'daodCity',title:'到达城市',width:'7%',align:'center',formatter:findByCity},
                      { field:'chufTime',title:'出发时间',width:'7%',align:'center',
         	        	 formatter:function(value){
         	        		 if(value=="undefined"||value==undefined){
         	        			 return value;
         	        		 }else{
         	        			return changeType(value);
         	        		 }
                         }
                      },
                      { field:'tpStatus',title:'退票状态',width:'10%',
         	        	 formatter:function(value,rec,index){  
                             if(value == '1'){
        							return "退票进行中";
        					 }else if(value == '2'){
        							return "退票已完成";
        					 }
                         }
                      },
                      { field:'createTime',title:'创建时间',width:'15%',align:'center', formatter:fotmateDate}
               ]]
            
         });
     }
     
     function upstatus(){
    	 var rows = $('#dg').datagrid('getChecked');	
    	if(rows.length<1||rows.length>1){
    		$.messager.alert('操作提示', "请选择一条数据！", 'warning');
    		return false;
    	}
    	console.log(rows[0]);
    	$('#lvkeInfoForm').form('load',rows[0]);
 		$('#lvkeInfoBox').dialog('open').dialog('setTitle','修改退票状态');
     }
     
     function saveBean(){
    	 $('#lvkeInfoForm').form('submit',{
	  		   url: "<%=basePath%>framework/tuipiao/upstatus.action",
	  		   onSubmit: function(){
	  		        return $(this).form('validate');
	  		   },
	  		   success: function(data){
	  			   if(data==1||data=="1"){
	  				   $('#lvkeInfoBox').dialog('close');
	  				   $('#dg').datagrid('reload');
	  				   $.messager.alert('操作提示', "操作成功");
	  			   }else{
	  				   $.messager.alert('操作提示', "操作失败", 'warning');
	  			   }
	  		   }
	  	 });
     }
     
   //改变出发时间和到达时间的类型
 	function changeType(GoTime){	
 		if(4<GoTime.length){
 			var firstTime=GoTime.substring(0,2);
 			var conterTime=GoTime.substring(2,4);
 			var lastTime=GoTime.substring(4,GoTime.length);
 			return firstTime+":"+conterTime+"<span style='color:#ff0000; font-size:10px;'>+"+lastTime+"</span>";
 		}else{			
 			var firstTime=GoTime.substring(0,2);
 			var lastTime=GoTime.substring(2,GoTime.length);
 			return firstTime+":"+lastTime;
 		}
 	}
   
 	//格式化时间
 	function fotmateDate(value){
 		var dateStr = "";
 		if(value=="undefined"||value=="null"||value==null){}else{
 			var date = new Date(value);
 			dateStr = date.format("yyyy-MM-dd HH:mm:ss");
 		}
 	    return dateStr;    
 	}

 	//js格式化日期插件代码
 	Date.prototype.format = function (format) {  
 			 var o = {  
 			        "M+": this.getMonth() + 1, // month  
 			        "d+": this.getDate(), // day  
 			        "H+": this.getHours(), // hour  
 			        "m+": this.getMinutes(), // minute  
 			        "s+": this.getSeconds(), // second  
 			        "q+": Math.floor((this.getMonth() + 3) / 3), // quarter  
 			        "S": this.getMilliseconds()  
 			        // millisecond  
 			 }
 			 if (/(y+)/.test(format)){
 			        format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length)); 
 			 } 
 			 for (var k in o){  
 			      if (new RegExp("(" + k + ")").test(format)){
 			            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length)); 
 			 	  }
 			 } 
 			 return format;  
 	} 
      
    </script>
     
</body>
</html>