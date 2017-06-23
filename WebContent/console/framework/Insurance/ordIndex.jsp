<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>保险列表</title>
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
	$("#grideBox").css("height",$(window).height()-87);
	$('#numListBox').datagrid({
	    height: '100%',
	    fit:true,
	    url: '<%=basePath%>framework/bxList/numList.action',
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
	        { field: 'orderNum', title: '机票订单号', width: '15%' }, 
	        { field: 'customer', title: '客户名称',align:'center', width: '7%'},
	        { field: 'idCard', title: '客户证件',align:'center', width: '7%'},
	        { field: 'yiwaiBX', title: '航意险',align:'center', width: '15%' ,
	        	formatter:function(value,rec,index){  
	                if(value=="1"){
	               	 	return "已购买";
	                }else{
	               	 	return "未购买";
	                }
          	  	}
	        },
	        { field: 'yiwaiNum', title: '航意险单号',align:'center', width: '7%'},
	        { field: 'yanwuBX', title: '延误险',align:'center', width: '15%' ,
	        	formatter:function(value,rec,index){  
	                if(value=="1"){
	               	 	return "已购买";
	                }else{
	               	 	return "未购买";
	                }
          	  	}
	        },
	        { field: 'yanwuNum', title: '延误险单号',align:'center', width: '7%'},
	        { field: 'bxMoney', title: '价格/元',align:'center', width: '5%' },
	        { field: 'createTime', title: '创建时间',align:'center', width: '10%',formatter:fotmateDate}
	    ]]
	});
});

function sreach(){
	var on = $("#orderNum").textbox("getValue").trim();
	var ct = $("#customer").textbox("getValue").trim();
	$('#numListBox').datagrid({
	    height: '100%',
	    fit:true,
	    url: '<%=basePath%>framework/bxList/seach.action',
	    method: 'POST',
	    queryParams:{on:on,ct:ct},
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
	        { field: 'orderNum', title: '机票订单号', width: '15%' }, 
	        { field: 'customer', title: '客户名称',align:'center', width: '7%'},
	        { field: 'idCard', title: '客户证件',align:'center', width: '7%'},
	        { field: 'yiwaiBX', title: '航意险',align:'center', width: '15%' ,
	        	formatter:function(value,rec,index){  
	                if(value=="1"){
	               	 	return "已购买";
	                }else{
	               	 	return "未购买";
	                }
          	  	}
	        },
	        { field: 'yiwaiNum', title: '航意险单号',align:'center', width: '7%'},
	        { field: 'yanwuBX', title: '延误险',align:'center', width: '15%' ,
	        	formatter:function(value,rec,index){  
	                if(value=="1"){
	               	 	return "已购买";
	                }else{
	               	 	return "未购买";
	                }
          	  	}
	        },
	        { field: 'yanwuNum', title: '延误险单号',align:'center', width: '7%'},
	        { field: 'bxMoney', title: '价格/元',align:'center', width: '5%' },
	        { field: 'createTime', title: '创建时间',align:'center', width: '10%',formatter:fotmateDate}
	    ]]
	});
}

var doUrl = "";
function fpNum(){
	var rows = $('#numListBox').datagrid('getChecked');	
	if(rows.length<1||rows.length>1){
		$.messager.alert('操作提示', "请选择一条数据！", 'warning');
		return false;
	}
	$("#uuid").textbox("setValue",rows[0].uuid);
	doUrl = "<%=basePath%>framework/bxList/configNum.action";
	$('#inputNum').dialog('open').dialog('setTitle','分配保险单号');
}

function saveBean(){ 	
    $('#inputNumForm').form('submit',{
		   url: doUrl,
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

function seeInfo(){
	$.post("<%=basePath%>framework/bxList/reload.action",{},function(res){
		if(res=="1"){
			history.go(0);
		}else{
			$.messager.alert('操作提示', "没有购买保险的订单！", 'warning');
		}
	});
	<%-- $('#numListBox').datagrid({
	    height: '100%',
	    fit:true,
	    url: '<%=basePath%>framework/bxList/reload.action',
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
	    onLoadSuccess:function(data){
	    	console.log(data);
	    	if(data.total==0){
	    		$.messager.alert('操作提示', "没有购买保险的订单！", 'warning');
	    	}
	    },
	    singleSelect: false,
		rownumbers:true,
	    columns: [[
	        { field: 'ck', checkbox: true },
	        { field: 'orderNum', title: '机票订单号', width: '15%' }, 
	        { field: 'customer', title: '客户名称',align:'center', width: '7%'},
	        { field: 'idCard', title: '客户证件',align:'center', width: '7%'},
	        { field: 'yiwaiBX', title: '航意险',align:'center', width: '15%' ,
	        	formatter:function(value,rec,index){  
	                if(value=="1"){
	               	 	return "已购买";
	                }else{
	               	 	return "未购买";
	                }
          	  	}
	        },
	        { field: 'yiwaiNum', title: '航意险单号',align:'center', width: '7%'},
	        { field: 'yanwuBX', title: '延误险',align:'center', width: '15%' ,
	        	formatter:function(value,rec,index){  
	                if(value=="1"){
	               	 	return "已购买";
	                }else{
	               	 	return "未购买";
	                }
          	  	}
	        },
	        { field: 'yanwuNum', title: '延误险单号',align:'center', width: '7%'},
	        { field: 'bxMoney', title: '价格/元',align:'center', width: '5%' },
	        { field: 'createTime', title: '创建时间',align:'center', width: '10%',formatter:fotmateDate}
	    ]]
	}); --%>
}

function reset(){
	$("#orderNum").textbox("setValue","");
	$("#customer").textbox("setValue","");
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
			<td><label>订单号：</label><input id="orderNum" class="easyui-textbox"/></td>
			<td><label>客户名称：</label><input id="customer" class="easyui-textbox"/></td>
			<td><a href="javascript:void(0)" class="easyui-linkbutton" onclick="sreach()" style="width:90px; margin-left:15px;">查 询</a></td>
			<td><a href="javascript:void(0)" class="easyui-linkbutton" onclick="reset()" style="width:90px; margin-left:15px;">重 置</a></td>
		</tr>
	</table>
</div>
<div style="height:25px; background-color:#fff;">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" onclick="seeInfo()">刷新</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="fpNum()">分配保险单号</a>
</div>
<div id="grideBox" style="width:100%;">
	<div id="numListBox" style="width:100%;height:100%;"></div>
</div>
<div id="inputNum" class="easyui-dialog" style="width:366px; padding:30px;" closed="true" buttons="#dlg-buttons">
	<form id="inputNumForm">
		<table>
			<tr style="display:none;">
				<td colspan="2"><input id="uuid" name="uuid" class="easyui-textbox"/></td>
			</tr>
			<tr>
				<td>输入保险单号：</td>
				<td><input id="bxNum" name="bxNum" class="easyui-textbox"/></td>
			</tr>
		</table>
	</form>
</div>
<div id="dlg-buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton" id="saveBean" iconCls="icon-ok" onclick="saveBean()" style="displaly:block;width: 90px">保存</a> 
	<a href="javascript:void(0)" class="easyui-linkbutton" id="saveCancel" iconCls="icon-cancel" onclick="javascript:$('#inputNum').dialog('close')" style="width:90px">取消</a>
</div>
</body>
</html>