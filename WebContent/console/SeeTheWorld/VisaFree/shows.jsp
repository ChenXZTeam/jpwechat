<%@page import="com.solar.tech.bean.InvitationCode"%>
<%@page import="com.solar.tech.bean.User"%>
<%@ page import="com.solar.tech.exception.ResultCode" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%  
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css">
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/jquery.min.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<title>Insert title here</title>
<style type="text/css">
* {
	padding: 0px;
	margin: 0px;
}

#fm {
	margin: 0;
	padding: 10px 30px;
}

.ftitle {
	font-size: 14px;
	font-weight: bold;
	padding: 5px 0;
	margin-bottom: 10px;
	border-bottom: 1px solid #ccc;
}

.fitem {
	margin-bottom: 5px;
}

.fitem label {
	display: inline-block;
	width: 80px;
}

.fitem input {
	width: 160px;
}

.fitem input[type=radio] {
	width: 39px;
}
.textbox .textbox-text{white-space: pre-line;}
#table-send {
	border:1px solid #DDDDDD;
	 border-collapse: collapse;
	 width:100%;
}
#table-send th{
	border:1px solid #DDDDDD;
	text-align:center;
}
#table-send td{
	border:1px solid #DDDDDD;
	text-align:center;
	width:50%;
}
</style>
<script>
	$(function(){
		$('#visaFreeList').datagrid({
			height: '100%',
		    fit:true,
		    url: '<%= basePath %>framework/visa/getVisaFreeList.action',
		    method: 'POST',
		    striped: true,
		    nowrap: true,
		    pageSize: 10,
		    pageNumber:1, 
		    pageList: [10, 20, 50, 100, 150, 200],
		    showFooter: true,
			loadMsg : '数据加载中请稍后……',
			pagination : true,
			toolbar:"#toolbar",
			 columns: [[
				        { field: 'ck', checkbox: true },
				        { field: 'countryID', title: '国家域名代码', width: 80},
				        { field: 'countryName', title: '国家名称', width: 80},
				        { field: 'content', title: '免签信息', width: 800}
			]],	        
		    checkOnSelect:false,
		    selectOnCheck:false,
			onDblClickRow:function(rowIndex, rowData){
				$("#fm").form("clear");
				$("#ftitle").html("修改免签信息");
				$("#countryID").val(rowData.countryID);			
				$("#countryName").combobox("setValue",rowData.countryName).combobox("disable");
				$("#content").textbox("setValue",rowData.content);
				$("#dlg").dialog("open").dialog("setTitle","");;
			}
		});
	});
	function addVisaFree(){
		$("#fm").form("clear");
		$("#ftitle").html("添加免签信息");
		$("#countryName").combobox({
			url:'<%=basePath%>/console/json/countries_EN.json',
		    valueField:'id',
		    textField:'name'
		});		
		$("#dlg").dialog("open").dialog('setTitle','');
	}
	
	function saveBean(){
		var title = $("#ftitle").html();
		var url;
		var msg;
		if(title.indexOf("添加")>=0){
			url = "<%=basePath%>framework/visa/addVisaFree.action";
			msg = "添加成功！";
		}else {
			url = "<%=basePath%>framework/visa/updateVisaFree.action";
			msg = "修改成功！";
		}
		$('#fm').form('submit',{
	        url: url,
	        onSubmit: function(){
	            return $(this).form('validate');
	        },
	        success: function(result){
	            $('#dlg').dialog('close');        // close the dialog
	            $.messager.alert("提示消息",msg);
	            $('#visaFreeList').datagrid('reload');    // reload the user data
	        }
	    });
	}
	
	function deleteVisaFree(){
		var rows = $('#visaFreeList').datagrid('getChecked');
	    if (rows.length>0){
	    	$.messager.confirm('温馨提示','你真的要删除么?',function(r){
	            if (r){
	            	var arr = new Array();
	            	for(var i=0; i<rows.length; i++){
	            		arr[i] = rows[i].countryID;
	            	}
	            	$.ajax({
                        url: "<%=basePath%>framework/visa/deleteVisaOrder.action",
                        type: "POST",
                        dataType: "json",
                        data: { "ids": JSON.stringify(arr) },
                        success: function (res) {	
                           if(res>0){
                        	   $("#visaFreeList").datagrid('reload');
                        	   $.messager.alert("提示消息","删除成功！");
                           }
                        },
                        error: function (error) {
                            $.messager.alert("提示消息","删除失败!");
                        }
                    });
	            }
	        });
	    }
	    if(rows.length<=0){
	    	$.messager.alert("提示消息","请选择内容！");
	    }
	}
</script>
</head>	
<body>
	<!-- 数据表格 -->
	<div id="visaFreeList" style="width: 100%;height:100%"></div>

	<!-- 功能按钮 -->
	<div id="toolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="addVisaFree()">添加</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true" onclick="deleteVisaFree()">删除</a>
	</div>
	
	<!-- 对话框 -->
	<div id="dlg" class="easyui-dialog" style="width: 35%; height: 450px; 
	padding: 10px 20px" closed="true" buttons="#dlg-buttons">
		<div class="ftitle" id="ftitle"></div>
		<form id="fm" method="post" enctype="multipart/form-data">
			<input tyep="text" name="countryID" hidden="hidden" id="countryID"/>
			<div class="fitem">
				<label>国家:</label>
				<input id="countryName" name="countryName" class="easyui-combobox" data-options="required:true">
			</div>
			<div class="fitem">
				<label>免签信息:</label><br><br>	
				<input name="content" class="easyui-textbox" style="width:300px;height:200px;" id="content" data-options="required:true,multiline:true"/>
			</div>
		</form>
	</div>
	<!-- 对话框内的按钮 -->
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="saveBean()" style="width: 90px" id="btn">保存</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" 
		onclick="javascript:$('#dlg').dialog('close')" style="width: 90px">取消</a>
	</div>
</body>
</html>