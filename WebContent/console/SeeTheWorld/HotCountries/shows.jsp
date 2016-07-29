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
		$('#hotCountriesList').datagrid({
			height: '100%',
		    fit:true,
		    url: '<%= basePath %>framework/visa/getHotCountriesList.action',
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
				        { field: 'countryID', title: '国际域名代码', width: 80},
				        { field: 'countryName', title: '国家名称', width: 100},
				        { field: 'imagePath', title: '图片', width: 100},
				        { field: 'priority', title: '排列顺序', width: 80},
				   
			]],	        
		    checkOnSelect:false,
		    selectOnCheck:false,
			onDblClickRow:function(rowIndex, rowData){
				$("#fm").form("clear");
				$("#ftitle").html("修改热门国家");
				$("#countryID").val(rowData.countryID);			
				$("#imgOld").val(rowData.imagePath);
				$("#countryName").combobox('disable').combobox('setValue',rowData.countryName);				    	
				$("#priority").textbox('setValue',rowData.priority);
				$("#iamge").filebox('setText',rowData.imagePath);
				$("#image").filebox({
					required:false,
					onChange:function(newValue, oldValue){
						$("#imagePath").val(newValue);
						console.log(oldValue);
						console.log(newValue);
					}
				});
				$("#dlg").dialog("open").dialog("setTitle","");
			}
		});
	});
	
	function addHotCountries(){
		$("#fm").form("clear");
		$("#ftitle").html("添加热门国家");	
		$("#countryName").combobox({
			url:"<%=basePath%>console/json/countries_EN.json",
		    valueField:'id',
		    textField:'name',
		    onSelect:function(record){
		    	var data = $("#hotCountriesList").datagrid('getData');
		    	var flag = true;
		    	for(var i=0;i<data.rows.length;i++){
		    		if(data.rows[i].countryID==record.id){
		    			flag = false;
		    			$("#countryName").combobox('clear');
		    			$.messager.alert("提示消息","此国家已存在！");
		    		}
		    	}
		    	$("#countryID").val(record.id);
		    	if(flag){
			    	$("#countryName").combobox('setValue',record.name);
		    	}
		    }
		});
		$("#image").filebox({
			onChange:function(newValue, oldValue){
				$("#imagePath").val(newValue);
				console.log(newValue);
			}
		});
		$("#dlg").dialog("open").dialog('setTitle','');
	}
	
	function saveBean(){
		var title = $("#ftitle").html();
		var url;
		var msg;
		if(title.indexOf("添加")>=0){
			url = "<%=basePath%>framework/visa/addHotCountries.action";
			msg = "添加成功！";
		}else {
			url = "<%=basePath%>framework/visa/updateHotCountries.action";
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
	            $('#hotCountriesList').datagrid('reload');    // reload the user data
	        }
	    });
	}
	
	function deleteHotCountries(){
		var rows = $('#hotCountriesList').datagrid('getChecked');
	    if (rows.length>0){
	    	$.messager.confirm('温馨提示','你真的要删除么?',function(r){
	            if (r){
	            	var arr = new Array();
	            	for(var i=0; i<rows.length; i++){
	            		arr[i] = rows[i].countryID;
	            	}
	            	$.ajax({
                        url: "<%=basePath%>framework/visa/deleteHotCountries.action",
                        type: "POST",
                        dataType: "json",
                        data: { "ids": JSON.stringify(arr) },
                        success: function (res) {	
                           if(res>0){
                        	   $("#hotCountriesList").datagrid('reload');
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
	<div id="hotCountriesList" style="width:100%;height:100%"></div>

	<!-- 功能按钮 -->
	<div id="toolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="addHotCountries()">添加</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true" onclick="deleteHotCountries()">删除</a>
	</div>
	
	<!-- 对话框 -->
	<div id="dlg" class="easyui-dialog" style="width: 35%; height: 250px; 
	padding: 10px 20px" closed="true" buttons="#dlg-buttons">
		<div class="ftitle" id="ftitle"></div>
		<form id="fm" method="post" enctype="multipart/form-data">
			<input type="text" name="countryID" hidden="hidden" id="countryID"/>
			<input type="text" name="imagePath" hidden="hidden" id="imagePath"/>
			<input type="text" name="imgOld" hidden="hidden" id="imgOld"/>
			<div class="fitem">
				<label>国家:</label>
				<input id="countryName" name="countryName" class="easyui-combobox" data-options="required:true">
			</div>
			<div class="fitem">
				<label>图片:</label>
				<input id="image" name="image" class="easyui-filebox" data-options="required:true">
			</div>
			<div class="fitem">
				<label>排列顺序:</label>
				<input id="priority" name="priority" class="easyui-textbox" data-options="required:true">
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