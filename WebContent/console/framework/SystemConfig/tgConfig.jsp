<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>退改政策配置</title>
	<link rel="stylesheet" type="text/css"href="<%=basePath%>scripts/common/jquery-easyui/themes/default/easyui.css"/>
	<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css"/>
	<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/default/datagrid.css"/>
	<script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript"src="<%=basePath%>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript"src="<%=basePath %>console/js/airCodeVScity.js"></script>
</head>
<body>
<script>
$(function(){
	$("#grideBox").css("height",$(window).height()-41);
	$('#numListBox').datagrid({
	    height: '100%',
	    fit:true,
	    url: '<%=basePath%>framework/tgConfig/numList.action',
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
	        { field: 'airCode', title: '航空公司', width: '30%' ,formatter:findByCode},
	        { field: 'commit', title: '退改政策', width: '40%' },
	        { field: 'upTime', title: '更新时间',align:'center', width: '28%',formatter:fotmateDate}
	    ]]
	});
	
	<%-- $.post("<%=basePath%>framework/LinkMan/getuserList.action",{},function(result){

	}); --%>
	
	
	//alert(getAircode()[0].3K);
	var data = [];
	var airCompany = JSON.stringify(getAircode());
	airCompany = airCompany.substring(1,airCompany.length-1);
	var chCompany = airCompany.split(",");
	for(var i=0; i<chCompany.length; i++){
		var codeAndName = chCompany[i].split(":");
		data.push({"value":codeAndName[0].substring(1,codeAndName[0].length-1),"text":codeAndName[0].substring(1,codeAndName[0].length-1)+"("+codeAndName[1].substring(1,codeAndName[1].length-1)+")"});
	}
	$("#airCode").combobox("loadData", data);

});

var numUrl="";
function news(){
	$('#lvkeInfoForm').form('clear');
	numUrl = "<%=basePath%>framework/tgConfig/addInfo.action";
	$('#lvkeInfoBox').dialog('open').dialog('setTitle','输入退改政策');
}

function toUpdate(){
	var rows = $('#numListBox').datagrid('getChecked');	
	if(rows.length<1||rows.length>1){
		$.messager.alert('操作提示', "请选择一条数据！", 'warning');
		return false;
	}
	$('#lvkeInfoForm').form('load',rows[0]);
	numUrl = "<%=basePath%>framework/tgConfig/upInfo.action";
	$('#lvkeInfoBox').dialog('open').dialog('setTitle','修改退改政策');
}

function saveBean(){
	 $('#lvkeInfoForm').form('submit',{
		   url: numUrl,
		   onSubmit: function(){
		        return $(this).form('validate');
		   },
		   success: function(data){
			   if(data==1||data=="1"){
				   $('#lvkeInfoBox').dialog('close');        // close the dialog
				    $('#numListBox').datagrid('reload');    // reload the user data
			   }else{
				   $.messager.alert('操作提示', "操作失败", 'warning');
			   }
		   }
	 }); 
}

function findCodeCompany(){
	var fno = $("#keyValue").textbox("getValue").trim();
	$('#numListBox').datagrid({
	    height: '100%',
	    fit:true,
	    url: '<%=basePath%>framework/tgConfig/findNumList.action',
	    method: 'POST',
	    queryParams:{num:fno},	 
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
	        { field: 'airCode', title: '航空公司', width: '15%' ,formatter:findByCode},
	        { field: 'commit', title: '退改政策', width: '35%' },
	        { field: 'upTime', title: '更新时间',align:'center', width: '10%',formatter:fotmateDate}
	    ]]
	});
}

function removeit(){
	var rows = $('#numListBox').datagrid('getChecked');	
	if(rows.length<1){
		$.messager.alert('操作提示', "请操作数据！", 'warning');
		return false;
	}
	var numStr = "";
	for(var i=0; i<rows.length; i++){
		numStr += rows[i].uuid+",";
	}
	$.post("<%=basePath%>framework/tgConfig/delInfo.action",{"num":numStr.substring(0,numStr.length-1)},function(result){
		if(result==1||result=="1"){
			$('#numListBox').datagrid('reload');
		}else{
			$.messager.alert('操作提示', "删除失败", 'warning');
		}
		
	});
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
<div>
	<table cellspacing="10" style="font-size:13px;">
		<tr>
			<td><label>航空公司二字码：</label><input id="keyValue" class="easyui-textbox" data-options="prompt:'请输入航空公司二字码'"/></td>
			<td><a href="javascript:void(0)" class="easyui-linkbutton" onclick="findCodeCompany()" id="saveCancel" style="width:90px">查找</a></td>
		</tr>
	</table>
</div>
<div style="height:25px; background-color:#fff;">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="news()">新增退改政策</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cut',plain:true" onclick="removeit()">删除退改政策</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="toUpdate()">修改退改政策</a>
</div>
<div id="grideBox" style="width:100%;">
	<div id="numListBox" style="width:100%;height:100%;"></div>
</div>
<div id="lvkeInfoBox" class="easyui-dialog" style="width:520px; padding:30px;" closed="true" buttons="#dlg-buttons">
	<form id="lvkeInfoForm">
		<table>
			<tr style="display:none;">
				<td colspan="2"><input name="uuid" class="easyui-textbox"/></td>
			</tr>
			<tr>
				<td>航空公司：</td>
				<td><input id="airCode" name="airCode" class="easyui-combobox" data-options="panelHeight:'276',valueField:'value', textField:'text'"/></td>
			</tr>
			<tr>
				<td>备注：</td>
				<td><input name="commit" class="easyui-textbox" data-options="multiline:true" style="width:350px; height:150px;"/></td>
			</tr>
		</table>
	</form>
</div>
<div id="dlg-buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton c6" id="saveBean"	iconCls="icon-ok" onclick="saveBean()" style="displaly:block;width: 90px">保存</a> 
	<a href="javascript:void(0)" class="easyui-linkbutton" id="saveCancel" iconCls="icon-cancel" onclick="javascript:$('#lvkeInfoBox').dialog('close')" style="width:90px">取消</a>
</div>
</body>
</html>