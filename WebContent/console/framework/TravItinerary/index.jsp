<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>行程单打印辅助</title>
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
	$("#grideBox").css("height",$(window).height()-41);
	$('#numListBox').datagrid({
	    height: '100%',
	    fit:true,
	    url: '<%=basePath%>framework/travItinerary/getInfoList.action',
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
	        { field: 'filghtMan', title: '乘机人', width: '5%' },
	        { field: 'filghtDate', title: '航班日期',align:'center', width: '10%' },
	        { field: 'sandDate', title: '配送日期',align:'center', width: '10%' },
	        { field: 'sandAdd', title: '配送地址', width: '10%' },
	        { field: 'linkPhone', title: '联系手机',align:'center', width: '10%'},
	        { field: 'ticketNum', title: '票号',align:'center', width: '10%'},
	        { field: 'consoleStutas', title: '打印状态',align:'center', width: '5%',
	        	formatter:function(value,rec,index){  
	                if(value=="0"){
	               	 	return "未打印";
	                }else if(value=="1"){
	               	 	return "已打印";
	                }
          	  	}
	        },
	        { field: 'orderUuid', title: '机票订单ID',align:'center', width: '18%'}, 
	        { field: 'createTime', title: '更新时间',align:'center', width: '10%',formatter:fotmateDate}
	    ]]
	});

});

function reloadDate(){
	$('#numListBox').datagrid({
	    height: '100%',
	    fit:true,
	    url: '<%=basePath%>framework/travItinerary/getreload.action',
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
	        { field: 'filghtMan', title: '乘机人', width: '5%' },
	        { field: 'filghtDate', title: '航班日期',align:'center', width: '10%' },
	        { field: 'sandDate', title: '配送日期',align:'center', width: '10%' },
	        { field: 'sandAdd', title: '配送地址', width: '10%' },
	        { field: 'linkPhone', title: '联系手机',align:'center', width: '10%'},
	        { field: 'ticketNum', title: '票号',align:'center', width: '10%'},
	        { field: 'consoleStutas', title: '打印状态',align:'center', width: '5%',
	        	formatter:function(value,rec,index){  
	                if(value=="0"){
	               	 	return "未打印";
	                }else if(value=="1"){
	               	 	return "已打印";
	                }
          	  	}
	        },
	        { field: 'orderUuid', title: '机票订单ID',align:'center', width: '18%'}, 
	        { field: 'createTime', title: '更新时间',align:'center', width: '10%',formatter:fotmateDate}
	    ]]
	});
}

var doUrl = ""
function updateBtn(){
	var rows = $('#numListBox').datagrid('getChecked');	
	if(rows.length<1||rows.length>1){
		$.messager.alert('操作提示', "请选择一条数据！", 'warning');
		return false;
	}
	rows[0].createTime = fotmateDate(rows[0].createTime);
	console.log(rows[0]);
	$('#lvkeInfoForm').form('load',rows[0]);
	doUrl = "<%=basePath%>framework/travItinerary/upInfo.action";
	$('#lvkeInfoBox').dialog('open').dialog('setTitle','修改打印信息');
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
	$.post("<%=basePath%>framework/travItinerary/delInfo.action",{"num":numStr.substring(0,numStr.length-1)},function(result){
		console.log(result);
		if(result==1||result=="1"){
			window.location.reload();
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
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="reloadDate()">更新打印行程数据</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="updateBtn()">修改打印信息</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-no',plain:true" onclick="delBtn()">删除</a>
</div>
<div id="grideBox" style="width:100%;">
	<div id="numListBox" style="width:100%;height:100%;"></div>
</div>
<div id="lvkeInfoBox" class="easyui-dialog" style="width:510px; padding:30px;" closed="true" buttons="#dlg-buttons">
	<form id="lvkeInfoForm">
		<table>
			<tr>
				<td><input name="uuid" class="easyui-textbox"/></td>
				<td><input name="createTime" class="easyui-textbox"/></td>
			</tr>
			<tr>
				<td>配送日期：</td>
				<td><input name="sandDate" class="easyui-textbox"/></td>
			</tr>
			<tr>
				<td>配送地址：</td>
				<td><input name="sandAdd" class="easyui-textbox"/></td>
			</tr>
			<tr>
				<td>联系手机：</td>
				<td><input name="linkPhone" class="easyui-textbox"/></td>
			</tr>
			<tr>
				<td>打印状态：</td>
				<td>
					<select name="consoleStutas" class="easyui-combobox" style="width:173px;" panelHeight="auto">
						<option value="0">未打印</option>
						<option value="1">已打印</option>
					</select>
				</td>
			</tr>
		</table>
	</form>
</div>
<div id="dlg-buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton" id="saveBean"	iconCls="icon-ok" onclick="saveBean()" style="displaly:block;width: 90px">保存</a> 
	<a href="javascript:void(0)" class="easyui-linkbutton" id="saveCancel" iconCls="icon-cancel" onclick="javascript:$('#lvkeInfoBox').dialog('close')" style="width:90px">取消</a>
</div>
</body>
</html>