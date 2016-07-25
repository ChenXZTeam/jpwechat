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
		$('#visaList').datagrid({
			height: '100%',
		    fit:true,
		    url: '<%= basePath %>framework/visa/getVisaList.action',
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
				        { field: 'visaID', title: '签证ID', width: 70},
				        { field: 'visaTitle', title: '签证标题', width: 200},
				        { field: 'visaType', title: '签证类型', width: 80},
				        { field: 'country', title: '国家', width: 50},
				        { field: 'immigrationOfTimes', title: '入境次数', width: 80},
				        { field: 'sojournTime', title: '逗留天数', width: 80},
				        { field: 'periodOfValidity', title: '有效期限', width: 100},
				        { field: 'earlyDates', title: '最早可定日期', width: 80},
				        { field: 'elapsedTime', title: '办理时长', width: 200},
				        { field: 'serviceContent', title: '服务内容', width: 200},
				        { field: 'scopeOfAcceptance', title: '受理范围', width: 200},
				        { field: 'immigrationFlow', title: '办理流程', width: 200},
				        { field: 'visaPrice', title: '签证价格', width: 80}
				        
			]],	        
		    checkOnSelect:false,
		    selectOnCheck:false,
			onDblClickRow:function(rowIndex, rowData){
				console.log(rowData);
				$("#visaList").form('clear');
				$("#immigrationOfTimes").textbox("setValue",rowData.immigrationOfTimes);
				$("#periodOfValidity").textbox("setValue",rowData.periodOfValidity);
				$("#visaType").textbox("setValue",rowData.visaType);
				$("#earlyDates").textbox("setValue",rowData.earlyDates);
				$("#elapsedTime").textbox("setValue",rowData.elapsedTime);
				$("#serviceContent").textbox("setValue",rowData.serviceContent);
				$("#scopeOfAcceptance").textbox("setValue",rowData.scopeOfAcceptance);
				$("#immigrationFlow").textbox("setValue",rowData.immigrationFlow);
				$("#visaPrice").textbox("setValue",rowData.visaPrice);
				$("#sojournTime").textbox("setValue",rowData.sojournTime);
				$("#visaID").attr("value",rowData.visaID);
				$("#visaTitle").textbox("setValue",rowData.visaTitle);
				$('#countries').combobox({
				    url:'<%= basePath %>console/json/countries.json',
				    valueField:'id',
				    textField:'name',
				    onLoadSuccess:function(){
				    	$("#countries").combobox('setValue',rowData.country);
				    }
				});
				
				$("#dlg").dialog("open").dialog('setTitle','');
				$('#ftitle').html("修改签证");
			}
		});
	});
	function addVisa(){
		$("#dlg").dialog("open").dialog('setTitle','');
		$('#ftitle').html("添加签证");
		$('#fm').form('clear');
		$('#countries').combobox({
		    url:'<%= basePath %>console/json/countries_EN.json',
		    valueField:'id',
		    textField:'name'
		});
	}
	
	function saveBean(){
		var title = $("#ftitle").html();
		var url;
		var msg;
		if(title.indexOf("添加")>=0){
			url = "<%=basePath%>framework/visa/addVisa.action";
			msg = "添加成功！";
		}else {
			url = "<%=basePath%>framework/visa/updateVisa.action";
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
	            $('#visaList').datagrid('reload');    // reload the user data
	        }
	    });
	}
	
	function deleteVisa(){
		var rows = $('#visaList').datagrid('getChecked');
	    if (rows.length>0){
	    	$.messager.confirm('温馨提示','你真的要删除么?',function(r){
	            if (r){
	            	var arr = new Array();
	            	for(var i=0; i<rows.length; i++){
	            		arr[i] = rows[i].visaID;
	            	}
	            	$.ajax({
                        url: "<%=basePath%>framework/visa/deleteVisa.action",
                        type: "POST",
                        dataType: "json",
                        data: { "ids": JSON.stringify(arr) },
                        success: function (res) {
                           if(res>0){
                        	   $("#visaList").datagrid('reload');
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
	<div id="visaList" style="width: 100%;height:100%"></div>

	<!-- 功能按钮 -->
	<div id="toolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="addVisa()">添加</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true" onclick="deleteVisa()">删除</a>
	</div>
	
	<!-- 对话框 -->
	<div id="dlg" class="easyui-dialog" style="width: 60%; height: 450px; 
	padding: 10px 20px" closed="true" buttons="#dlg-buttons">
		<div class="ftitle" id="ftitle"></div>
		<form id="fm" method="post" enctype="multipart/form-data">
			<input tyep="text" name="visaID" hidden="hidden" id="visaID"/>
			<div class="fitem">
				<label>签证标题:</label>		
				<input name="visaTitle" class="easyui-textbox" data-options="required:true" id="visaTitle" style="width:400px;"/>
			</div>
			<div class="fitem">
				<label>签证价格:</label> 		
				<input name="visaPrice" class="easyui-textbox" data-options="required:true" id="visaPrice" style="width:400px;"/>
			</div>
			<div class="fitem">
				<label>国家：</label>
				<input id="countries" name="country">
			</div>
			<div class="fitem">
				<label>入境次数:</label> 		
				<input name="immigrationOfTimes" class="easyui-textbox" value="" style="width:400px;" id="immigrationOfTimes"/>
			</div>
			<div class="fitem">
				<label>逗留天数:</label> 		
				<input name="sojournTime" class="easyui-textbox" style="width:400px;" id="sojournTime" data-options="required:true"/>
			</div>
			<div class="fitem">
				<label>有效期限:</label> 		
				<input name="periodOfValidity" class="easyui-textbox" style="width:400px;" id="periodOfValidity" data-options="required:true"/>
			</div>
			<div class="fitem">
				<label>签证类型:</label> 		
				<input name="visaType" class="easyui-textbox" style="width:400px;" id="visaType" data-options="required:true"/>
			</div>
			<div class="fitem">
				<label>最早可定日期:</label> 		
				<input name="earlyDates" class="easyui-datebox" style="width:400px;" id="earlyDates" data-options="required:true"/>
			</div>
			<div class="fitem">
				<label>办理时长:</label> 		
				<input name="elapsedTime" class="easyui-textbox" style="width:400px;" id="elapsedTime" data-options="required:true"/>
			</div>
			<div class="fitem">
				<label>服务内容:</label> 		
				<input name="serviceContent" class="easyui-textbox" style="width:400px;height:150px;" id="serviceContent" data-options="required:true,multiline:true"/>
			</div>
			<div class="fitem">
				<label>受理范围:</label> 		
				<input name="scopeOfAcceptance" class="easyui-textbox" style="width:400px;height:150px;" id="scopeOfAcceptance" data-options="required:true,multiline:true"/>
			</div>
			<div class="fitem">
				<label>办理流程:</label> 		
				<input name="immigrationFlow" class="easyui-textbox" style="width:400px;height:150px;" id="immigrationFlow" data-options="required:true,multiline:true"/>
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