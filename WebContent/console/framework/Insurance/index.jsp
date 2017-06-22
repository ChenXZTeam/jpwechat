<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>保险价格配置</title>
	<link rel="stylesheet" type="text/css"href="<%=basePath%>scripts/common/jquery-easyui/themes/default/easyui.css"/>
	<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css"/>
	<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/default/datagrid.css"/>
	<script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript"src="<%=basePath%>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
<script>
$(function(){
	$("#grideBox").css("height",$(window).height()-42);
	$('#numListBox').datagrid({
	    height: '100%',
	    fit:true,
	    url: '<%=basePath%>framework/insurance/numList.action',
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
	        { field: 'bxType', title: '保险类型',align:'center', width: '5%' ,
	        	formatter:function(value,rec,index){  
	                if(value=="1"){
	               	 	return "意外险";
	                }else if(value=="2"){
	               	 	return "延误险";
	                }
          	  	}
	        },
	        { field: 'cost', title: '价格/元',align:'center', width: '5%' },
	        { field: 'commit', title: '内容描述', width: '50%'},
	        { field: 'createTime', title: '创建时间',align:'center', width: '10%',formatter:fotmateDate}
	    ]]
	});
});
var numUrl = "";
function toUpdate(){
	var rows = $('#numListBox').datagrid('getChecked');	
	if(rows.length<1||rows.length>1){
		$.messager.alert('操作提示', "请选择一条数据！", 'warning');
		return false;
	}
	$("#isOpen").combobox({ disabled: false });
	rows[0].createTime = fotmateDate(rows[0].createTime);
	$('#inputNumForm').form('load',rows[0]);
	$('#inputNum').dialog('open').dialog('setTitle','配置价格和备注信息');
	numUrl = "<%=basePath%>framework/insurance/updateNum.action";
}

//确认修改信息的保存按钮	    
function saveBean(){ 	
      $('#inputNumForm').form('submit',{
		   url: numUrl,
		   onSubmit: function(){
		        return $(this).form('validate');
		   },
		   success: function(data){
			   console.log(data);
			   if(data==1||data=="1"){
				   $('#inputNum').dialog('close');        // close the dialog
				    $('#numListBox').datagrid('reload');    // reload the user data
			   }else{
				   $.messager.alert('操作提示', "操作失败", 'warning');
			   }
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
<div style="height:25px; background-color:#fff;">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="toUpdate()">配置价格与备注</a>
</div>
<div id="grideBox" style="width:100%;">
	<div id="numListBox" style="width:100%;height:100%;"></div>
</div>
<div id="inputNum" class="easyui-dialog" style="width:510px; padding:30px;" closed="true" buttons="#dlg-buttons">
	<form id="inputNumForm">
		<table>
			<tr style="display:none;">
				<td colspan="2"><input name="uuid" class="easyui-textbox"/></td>
			</tr>
			<tr style="display:none;">
				<td colspan="2"><input name="createTime" class="easyui-textbox"/></td>
			</tr>
			<tr style="display:none;">
				<td colspan="2">
					<select name="bxType" class="easyui-combobox" style="width:173px;" panelHeight="75">
						<option value="1">意外险</option>
						<option value="2">延误险</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>保险价格：</td>
				<td><input name="cost" class="easyui-textbox" style="maring-left:11px;"/></td>
			</tr>
			<tr>
				<td>保险描述：</td>
				<td><input name="commit" class="easyui-textbox" data-options="multiline:true" style="width:350px; height:150px;"/></td>
			</tr>
		</table>
	</form>
</div>
<div id="dlg-buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton c6" id="saveBean"	iconCls="icon-ok" onclick="saveBean()" style="displaly:block;width: 90px">保存</a> 
	<a href="javascript:void(0)" class="easyui-linkbutton" id="saveCancel" iconCls="icon-cancel" onclick="javascript:$('#inputNum').dialog('close')" style="width:90px">取消</a>
</div>
</body>
</html>