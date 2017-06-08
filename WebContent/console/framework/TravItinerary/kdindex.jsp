<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>快递单查询</title>
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
	$("#grideBox").css("height",$(window).height()-84);
	$('#numListBox').datagrid({
	    height: '100%',
	    fit:true,
	    url: '<%=basePath%>framework/kdorder/getOrderList.action',
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
	        { field: 'kdOrderNum', title: '快递单号', width: '15%' },
	        { field: 'kdCompany', title: '快递公司',align:'center', width: '10%' },
	        { field: 'isUsed', title: '是否使用',align:'center', width: '10%',
	        	formatter:function(value,rec,index){  
	                if(value=="0"){
	               	 	return "未使用";
	                }else if(value=="1"){
	               	 	return "已使用";
	                }
          	  	}
	        },
	        { field: 'createTime', title: '创建时间',align:'center', width: '10%', formatter:fotmateDate}
	    ]]
	});

});

var doUrl = ""
function news(){
	$('#lvkeInfoForm').form('clear');
	$('#lvkeInfoBox').dialog('open').dialog('setTitle','新增单号');
	$("#createTime").textbox("setValue","2017-05-25 00:00:00");
	doUrl = "<%=basePath%>framework/kdorder/addkdNum.action";
}
function updateBtn(){
		var rows = $('#numListBox').datagrid('getChecked');	
		if(rows.length<1||rows.length>1){
			$.messager.alert('操作提示', "请选择一条数据！", 'warning');
			return false;
		}
		rows[0].createTime = fotmateDate(rows[0].createTime);
		console.log(rows[0]);
		$('#lvkeInfoForm').form('load',rows[0]);
		doUrl = "<%=basePath%>framework/kdorder/upkdNum.action";
		$('#lvkeInfoBox').dialog('open').dialog('setTitle','修改单号');
}

function delBtn(){
		var rows = $('#numListBox').datagrid('getChecked');	
		if(rows.length<1){
			$.messager.alert('操作提示', "请操作数据！", 'warning');
			return false;
		}
		var numStr = "";
		for(var i=0; i<rows.length; i++){
			numStr += rows[i].uuid+",";
		}
		$.post("<%=basePath%>framework/kdorder/delkdNum.action",{"num":numStr.substring(0,numStr.length-1)},function(result){
			console.log(result);
			if(result==1||result=="1"){
				$('#numListBox').datagrid('reload'); 
			}else{
				$.messager.alert('操作提示', "删除失败", 'warning');
			}
			
		});
}

function saveBean(){
		$('#lvkeInfoForm').form('submit',{
			   url: doUrl,
			   onSubmit: function(){
			        return $(this).form('validate');
			   },
			   success: function(data){
				   if(data==1||data=="1"){
					   $('#lvkeInfoBox').dialog('close');  
					   $('#numListBox').datagrid('reload'); 
				   }else{
					   $.messager.alert('操作提示', "操作失败", 'warning');
				   }
			   }
		 }); 
}
function reset(){
	$("#KdOrder").textbox("setValue","");
	$("#isUsedsd").combobox("setValue","");
}

function find(){
	var fno = $("#KdOrder").textbox("getValue");
	var isusd = $("#isUsedsd").combobox("getValue");
	$('#numListBox').datagrid({
	    height: '100%',
	    fit:true,
	    url: '<%=basePath%>framework/kdorder/findkdNum.action',
	    method: 'POST',
	    queryParams:{num:fno,isusd:isusd},
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
	        { field: 'kdOrderNum', title: '快递单号', width: '15%' },
	        { field: 'kdCompany', title: '快递公司',align:'center', width: '10%' },
	        { field: 'isUsed', title: '是否使用',align:'center', width: '10%',
	        	formatter:function(value,rec,index){  
	                if(value=="0"){
	               	 	return "未使用";
	                }else if(value=="1"){
	               	 	return "已使用";
	                }
          	  	}
	        },
	        { field: 'createTime', title: '创建时间',align:'center', width: '10%', formatter:fotmateDate}
	    ]]
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
			<td><label>快递单号：</label><input id="KdOrder" class="easyui-textbox" data-options="prompt:'快递单号'"/></td>
			<td><label>订单号：</label>
				<select id="isUsedsd" name="isUsed" class="easyui-combobox" style="width:173px;" panelHeight="auto">
						<option value=""></option>
						<option value="0">未使用</option>
						<option value="1">已使用</option>
				</select>
			</td>
			<td><a href="javascript:void(0)" class="easyui-linkbutton" onclick="find()" style="width:90px">查 询</a></td>
			<td><a href="javascript:void(0)" class="easyui-linkbutton" onclick="reset()" style="width:90px">重 置</a></td>
		</tr>
	</table>
</div> 
<div>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="news()">新增单号</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cut',plain:true" onclick="delBtn()">删除单号</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="updateBtn()">修改单号</a>
</div>
<div id="grideBox" style="width:100%;"> 
	<div id="numListBox" style="width:100%;height:100%;"></div>
</div>
<div id="lvkeInfoBox" class="easyui-dialog" style="width:510px; padding:30px;" closed="true" buttons="#dlg-buttons">
	<form id="lvkeInfoForm">
		<table>
			<tr>
				<td><input name="uuid" class="easyui-textbox"/></td>
				<td><input id="createTime" name="createTime" class="easyui-textbox"/></td>
			</tr>
			<tr>
				<td>快递单号：</td>
				<td><input id="kdOrderNum" name="kdOrderNum" class="easyui-textbox"/></td>
			</tr>
			<tr>
				<td>快递公司：</td>
				<td><input id="kdCompany" name="kdCompany" class="easyui-textbox"/></td>
			</tr>
			<tr>
				<td>是否已使用：</td>
				<td>
					<select id="isUsed" name="isUsed" class="easyui-combobox" style="width:173px;" panelHeight="auto">
						<option value="0">未使用</option>
						<option value="1">已使用</option>
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
</body>
</html>