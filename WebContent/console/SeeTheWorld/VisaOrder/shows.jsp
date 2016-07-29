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
	var progressArr = new Array({"id":"签证完成","name":"签证完成"},{"id":"处理中","name":"处理中"});
	$(function(){
		$('#visaOrderList').datagrid({
			height: '100%',
		    fit:true,
		    url: '<%= basePath %>framework/visa/getVisaOrderList.action',
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
				        { field: 'visaOrderID', title: '订单ID', width: 80},
				        { field: 'visaTitle', title: '签证标题', width: 100},
				        { field: 'proposer', title: '申请人', width: 80},
				        { field: 'customerType', title: '客户类型', width: 80},
				        { field: 'contactsName', title: '联系人名称', width: 80},
				        { field: 'contactsPhone', title: '联系人电话', width: 80},
				        { field: 'contactsEmail', title: '联系人邮箱', width: 80},
				        { field: 'deliveryMethod', title: '配送方式', width: 80},
				        { field: 'deliveryAddress', title: '配送地址', width: 80},
				        { field: 'totalCost', title: '总费用', width: 80},
				        { field: 'visaID', title: '签证ID', width: 80},
				        { field: 'userID', title: '用户ID', width: 80},
				        { field: 'progress', title: '签证进度', width: 80},
			]],	        
		    checkOnSelect:false,
		    selectOnCheck:false,
			onDblClickRow:function(rowIndex, rowData){
				$("#fm").form("clear");
				$("#ftitle").html("修改订单信息");
				$("#visaOrderID").val(rowData.visaOrderID);			
				$("#proposer").textbox("setValue",rowData.proposer);
				$("#contactsName").textbox("setValue",rowData.contactsName);
				$("#contactsPhone").textbox("setValue",rowData.contactsPhone);
				$("#contactsEmail").textbox("setValue",rowData.contactsEmail);
				$("#deliveryMethod").textbox("setValue",rowData.deliveryMethod);
				$("#deliveryAddress").textbox("setValue",rowData.deliveryAddress);
				$("#userID").textbox("setValue",rowData.userID);
				$("#totalCost").textbox("setValue",rowData.totalCost);
				$("#visaID").combobox({
					url:'<%=basePath%>/framework/visa/getVisaList.action',
				    valueField:'visaID',
				    textField:'visaTitle',
				    onLoadSuccess:function(){
				    	$("#visaID").combobox('setValue',rowData.visaID);
				    }
				});
				$("#customerType").combobox({
					url:"<%=basePath%>/console/json/customerType.json",
				    valueField:'id',
				    textField:'name',
				    onLoadSuccess:function(){
				    	$("#customerType").combobox('setValue',rowData.customerType);
				    }
				});
				$("#progress").combobox({
					valueField:'id',
				    textField:'name',
				    data:progressArr
				});
				$("#dlg").dialog("open").dialog("setTitle","");
			}
		});
	});
	function addVisaOrder(){
		$("#fm").form("clear");
		$("#ftitle").html("添加订单信息");
		$("#visaID").combobox({
			url:'<%=basePath%>/framework/visa/getVisaList.action',
		    valueField:'visaID',
		    textField:'visaTitle'
		});
		
		$("#customerType").combobox({
			url:"<%=basePath%>/console/json/customerType.json",
		    valueField:'id',
		    textField:'name'
		});		
		
		$("#progress").combobox({
			valueField:'id',
		    textField:'name',
		    data:progressArr
		});
		$("#dlg").dialog("open").dialog('setTitle','');
	}
	
	function saveBean(){
		var title = $("#ftitle").html();
		var url;
		var msg;
		if(title.indexOf("添加")>=0){
			url = "<%=basePath%>framework/visa/addVisaOrder.action";
			msg = "添加成功！";
		}else {
			url = "<%=basePath%>framework/visa/updateVisaOrder.action";
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
	            $('#visaOrderList').datagrid('reload');    // reload the user data
	        }
	    });
	}
	
	function deleteVisaOrder(){
		var rows = $('#visaOrderList').datagrid('getChecked');
	    if (rows.length>0){
	    	$.messager.confirm('温馨提示','你真的要删除么?',function(r){
	            if (r){
	            	var arr = new Array();
	            	for(var i=0; i<rows.length; i++){
	            		arr[i] = rows[i].visaOrderID;
	            	}
	            	$.ajax({
                        url: "<%=basePath%>framework/visa/deleteVisaOrder.action",
                        type: "POST",
                        dataType: "json",
                        data: { "ids": JSON.stringify(arr) },
                        success: function (res) {	
                           if(res>0){
                        	   $("#visaOrderList").datagrid('reload');
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
	<div id="visaOrderList" style="width:100%;height:100%"></div>

	<!-- 功能按钮 -->
	<div id="toolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="addVisaOrder()">添加</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true" onclick="deleteVisaOrder()">删除</a>
	</div>
	
	<!-- 对话框 -->
	<div id="dlg" class="easyui-dialog" style="width: 35%; height: 450px; 
	padding: 10px 20px" closed="true" buttons="#dlg-buttons">
		<div class="ftitle" id="ftitle"></div>
		<form id="fm" method="post" enctype="multipart/form-data">
			<input tyep="text" name="visaOrderID" hidden="hidden" id="visaOrderID"/>
			<div class="fitem">
				<label>签证ID:</label>
				<input id="visaID" name="visaID" class="easyui-combobox" data-options="required:true">
			</div>
			<div class="fitem">
				<label>申请人:</label>
				<input id="proposer" name="proposer" class="easyui-textbox" data-options="required:true">
			</div>
			<div class="fitem">
				<label>客户类型:</label>
				<input id="customerType" name="customerType" class="easyui-combobox" data-options="required:true">
			</div>
			<div class="fitem">
				<label>联系人名称:</label>
				<input id="contactsName" name="contactsName" class="easyui-textbox" data-options="required:true">
			</div>
			<div class="fitem">
				<label>联系人电话:</label>
				<input id="contactsPhone" name="contactsPhone" class="easyui-textbox" data-options="required:true">
			</div>
			<div class="fitem">
				<label>联系人邮箱:</label>
				<input id="contactsEmail" name="contactsEmail" class="easyui-textbox" data-options="required:true">
			</div>
			<div class="fitem">
				<label>配送方式:</label>
				<input id="deliveryMethod" name="deliveryMethod" class="easyui-textbox" data-options="required:true">
			</div>
			<div class="fitem">
				<label>配送地址:</label>
				<input id="deliveryAddress" name="deliveryAddress" class="easyui-textbox" data-options="required:true">
			</div>
			<div class="fitem">
				<label>用户ID:</label>
				<input id="userID" name="userID" class="easyui-textbox" data-options="required:true">
			</div>
			<div class="fitem">
				<label>总费用:</label>
				<input id="totalCost" name="totalCost" class="easyui-textbox" data-options="required:true">
			</div>
			<div class="fitem">
				<label>签证进度:</label>
				<input id="progress" name="progress" class="easyui-combobox">
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