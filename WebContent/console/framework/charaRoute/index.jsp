<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>特色路线</title>
	<link rel="stylesheet" href="<%=basePath %>kinder/themes/default/default.css" />
	<link rel="stylesheet" href="<%=basePath %>kinder/plugins/code/prettify.css" />
	<link rel="stylesheet" type="text/css"href="<%=basePath%>scripts/common/jquery-easyui/themes/default/easyui.css"/>
	<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css"/>
	<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/default/datagrid.css"/>
	<script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript"src="<%=basePath%>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
	<script charset="utf-8" src="<%=basePath %>kinder/kindeditor.js"></script>
	<script charset="utf-8" src="<%=basePath %>kinder/lang/zh_CN.js"></script>
	<script charset="utf-8" src="<%=basePath %>kinder/plugins/code/prettify.js"></script>
	<style>
	.titleClass{width:100px; font-size:12px; color:#666666;}
	textarea{width:100%; height:100px; color:#777777;}
	input{height:20px; color:#777777;}
	select{width:164px; height:23px; color:#777777;}
	.dispayNoneClass{display:none;}
</style>
	<script>
		KindEditor.ready(function(K) {
			var editor1 = K.create('textarea[name="conText"]', {
				cssPath : '<%=basePath %>kinder/plugins/code/prettify.css',
				uploadJson : '<%=basePath %>kinder/upload_json.jsp',
				fileManagerJson : '<%=basePath %>kinder/file_manager_json.jsp',
				allowFileManager : true,
				afterBlur:function(){this.sync();}
			});
		});
	</script>
</head>
<body>
<div style="height:25px; background-color:#fff;">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cut',plain:true" onclick="removeit(this)">删除</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="toUpdate()">修改</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="shows()">查看</a>
	<a href="<%=basePath%>console/framework/charaRoute/addRoute.jsp" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新增</a>
</div>
<div style="width:100%;height:420px;">
	<div id="chRouteBox" style="width:100%;height:420px;"></div>
</div>
<div id="upInfoBox" class="easyui-dialog" style="width:720px; height:550px; padding: 10px 20px" closed="true" buttons="#dlg-buttons" iconCls="icon-edit">
	<form id="fm" method="post" enctype="multipart/form-data" novalidate>
		<table border="0" cellpadding="0" cellspacing="10">
			<tr class="dispayNoneClass">
				<td colspan="4"><input name="routeID"/></td>
			</tr>
			<tr class="dispayNoneClass">
				<td colspan="4"><input name="username"/></td>
			</tr>
			<tr>
				<td class="titleClass">路线标题：</td>
				<td colspan="3"><input name="title"/></td>
			</tr>
			
			<tr>
				<td class="titleClass">路线内容：</td>
				<td colspan="3"><textarea id="conText" name="conText"  style="width:500px; height:394px;"/></textarea></td>
			</tr>
		</table>
	</form>
</div>
<div id="dlg-buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton c6" id="saveBean"	iconCls="icon-ok" onclick="saveBean()" style="displaly:block;width: 90px">保存</a> 
	<a href="javascript:void(0)" class="easyui-linkbutton" id="saveCancel" iconCls="icon-cancel" onclick="javascript:$('#upInfoBox').dialog('close')" style="width:90px">取消</a>
</div>
<div class="seeContryInfoBox">
	
</div>
</body>
<script>
$(function(){
	$('#chRouteBox').datagrid({
	    height: '100%',
	    fit:true,
	    url: '<%=basePath%>framework/route/getRoute.action',
	    method: 'POST',
	    striped: true,
	    nowrap: true,
	    pageSize: 10,
	    pageNumber:1, 
	    pageList: [10, 20, 50, 100, 150, 200],
		pagination : true,
	    showFooter: true, 
		loadMsg : '数据加载中请稍后……',
	    toolbar:"#tb",
	    singleSelect: false,
		rownumbers:true,
	    columns: [[
	        { field: 'ck', checkbox: true },
	        { field: 'routeID', title: '编号', width: 150},
	        { field: 'title', title: '文章标题', width: 150 },
	        { field: 'userName', title: '创建对象', width: 150},
	        { field: 'createTime', title: '创建时间', width: 200,formatter:fotmateDate}
	    ]],
	    onDblClickRow :function(rowIndex,rowData){
	    	details(rowData);
	   	}
	});
});
//删除方法
function removeit(){  //删除
	var rows = $('#chRouteBox').datagrid('getSelections');	
	var row = $('#chRouteBox').datagrid('getSelected');
	console.log(row);
	//alert(row);	
	if (row == undefined||row == null||row == "") {
         $.messager.alert('操作提示', "没有选择被操作的记录！", 'warning');
         return false;
    } 
    if(rows.length > 1){
         $.messager.alert('操作提示', "只能删除一条数据", 'warning');
         return false;
    }
    //alert(row.country);
	$.messager.confirm('确认', '真的要删除<'+row.title+'>吗?', function (r) {
          if (r) {
                	var routeID = row.routeID;
                    console.log("ID: "+routeID);
                    if (row) {
                        $.ajax({
                            cache: false,
                            async: false,
                            type: "POST",
                            data:{"routeID":routeID},
                            dataType: 'json',
                            url: "<%=basePath%>framework/route/deleteRoute.action",
                            success: function (data) {
                                console.log(data);
                                if (data.state == 1) {
                                    $('#chRouteBox').datagrid('reload');                                    
                                }
                                else {
                                    $.messager.alert('Warning', '删除不成功！'); 
                                }
                            }
                        });
                    }
                }
      });
}

//修改信息
function toUpdate(){  //弹出修改框
		   //alert(document.getElementById("info").innerHTML);
           var row = $('#chRouteBox').datagrid('getSelected');
           var rows = $('#chRouteBox').datagrid('getSelections');	
           console.log(row);
           //alert(row.id);
           $(document.getElementsByTagName("iframe")[0].contentWindow.document.body).html(row.conText);
           if (row == undefined||row == null||row=="") {
             	$.messager.alert('操作提示', "没有选择被操作的记录！", 'warning');
             	return;
            } 
            if(rows.length>1){
            	$.messager.alert('操作提示', "请选择一条数据！", 'warning');
             	return false;
            } 	 
	        $('#upInfoBox').dialog('open').dialog('setTitle','修改资讯信息');
	        $('#fm').form('load',row);
}
//确认修改信息的保存按钮	    
function saveBean(){ 	
      $('#fm').form('submit',{
		       url: "<%=basePath%>framework/route/updateRoute.action",
		       onSubmit: function(){
		           return $(this).form('validate');
		       },
		       success: function(data){
		       	var obj = JSON.parse(data);
		       	console.log(data+", "+obj+", "+obj.state);
		       	   if(obj.state == 1){
			           $('#upInfoBox').dialog('close');        // close the dialog
			           $('#chRouteBox').datagrid('reload');    // reload the user data
		           }else{
		           	   $.messager.alert('操作提示', "修改不成功！", 'warning');
		           }
		       }
	 }); 
}

//查看详情的方法
function details(row){
	if(row){
			var str = JSON.stringify(row); 
			alert(str);
			window.location.href="<%=basePath%>console/framework/zixun/details.jsp?str="+str;		
	}
}

function shows(){ //查看
		    var row = $('#chRouteBox').datagrid('getSelected');
		    var rows = $('#chRouteBox').datagrid('getSelections');
		    if (row == undefined) {
             		$.messager.alert('操作提示', "没有选择被操作的记录！", 'warning');
             		return;
             	 } 
            if(rows.length>1){
            	$.messager.alert('操作提示', "请选择一条数据！", 'warning');
             	return false;
            }  
			if (row){
				console.log(row);
				var str = JSON.stringify(row); 
				
				console.log(str);
				window.location.href="<%=basePath%>console/framework/charaRoute/details.jsp?str="+str;
			}
}

//查找的方法
function query(){
	var title = $("#title").val();	
	alert(title);
	$('#chRouteBox').datagrid({
		height: '100%',
		fit:true,
		url: '<%=basePath %>framework/route/findRoute.action?title='+title,
		method: 'POST',
		striped: true,
		nowrap: true,
		pageSize: 10,
		pageNumber:1, 
		pageList: [10, 20, 50, 100, 150, 200],
		showFooter: true, 
		loadMsg : '数据加载中请稍后……',
		pagination : true,
		toolbar:"#tb",
		singleSelect: false,
		rownumbers:true,
		columns: [[
			{ field: 'ck', checkbox: true },
			{ field: 'ID', title: '编号', width: 150},
			{ field: 'title', title: '文章标题', width: 150 },
			{ field: 'userName', title: '创建对象', width: 150},
			{ field: 'createTime', title: '创建时间', width: 200,formatter:fotmateDate}
	    ]],
		onDblClickRow :function(rowIndex,rowData){
			    details(rowData);
		}
	});
}

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
</html>