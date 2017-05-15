<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<title>短信模板</title>
<link rel="stylesheet" type="text/css"href="<%=basePath%>scripts/common/jquery-easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css">
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/default/datagrid.css">
<link rel="stylesheet" href="<%=basePath %>kinder/themes/default/default.css" />
<link rel="stylesheet" href="<%=basePath %>kinder/plugins/code/prettify.css" />
<script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript"src="<%=basePath%>console/js/jquery.form.js"></script>
<script type="text/javascript"src="<%=basePath%>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<script charset="utf-8" src="<%=basePath %>kinder/kindeditor.js"></script>
<script charset="utf-8" src="<%=basePath %>kinder/lang/zh_CN.js"></script>
<script charset="utf-8" src="<%=basePath %>kinder/plugins/code/prettify.js"></script>
<style>
	.seachBox{margin:10px 0px;}
	.seachBox ul{margin:0px; padding:0px; list-style-type:none; overflow:hidden;}
	.seachBox ul li{float:left; margin-left:10px;}
	.seachBox ul li span{}
	.seachBox ul li input{height:24px; outline:none; border:1px solid #cccccc; padding-left:10px;}
	.seachBox ul li a{padding:5px 20px; font-size:13px; border:1px solid blue; color:blue; cursor:pointer; display:block; text-align:center;}
	.titleClass{width:100px; font-size:12px; color:#666666;}
	textarea{width:100%; height:100px; color:#777777;}
	input{height:20px; color:#777777;}
	select{width:164px; height:23px; color:#777777;}
	.dispayNoneClass{display:none;}
</style>

</head>
<body>
<div class="seachBox">
	<ul>
		<li><span></span><input type="text" id="banPeople" placeholder="请输入绑定人名称"/></li>
		<li><a onclick="query()">搜索</a></li>
	</ul>
</div>
<div style="height:25px; background-color:#fff;">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cut',plain:true" onclick="removeit(this)">删除</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="toUpdate()">修改</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="newsBtn()">新增</a>
</div>
<div id="grideBox" style="width:100%;">
	<div id="ExampleListBox" style="width:100%;height:100%;"></div>
</div>
<div id="ExampleBox" class="easyui-dialog" style="width:506px; height:308px; padding: 10px 20px" closed="true" buttons="#dlg-buttons" iconCls="icon-edit">
	<form id="fm" method="post" enctype="multipart/form-data" novalidate>
		<table border="0" cellpadding="0" cellspacing="10">
			<tr class="dispayNoneClass">
				<td colspan="4"><input name="id" class="easyui-textbox"/></td>
			</tr>
			<tr class="dispayNoneClass">
				<td colspan="4"><input name="creamTime" id="creamTime" class="easyui-textbox"/></td>
			</tr>
			<tr class="dispayNoneClass">
				<td colspan="4"><input name="userName" class="easyui-textbox"/></td>
			</tr>
			<tr>
				<td class="titleClass">绑定人：</td>
				<td colspan="3"><input name="banPeople" class="easyui-textbox"/></td>
			</tr>
			<tr>
				<td class="titleClass">绑定人：</td>
				<td colspan="3"><input name="banZu" class="easyui-textbox"/></td>
			</tr>
			<tr>
				<td class="titleClass">模板内容：</td>
				<td colspan="3"><input id="Exampletext" name="text"  class="easyui-textbox" data-options="multiline:true" style="width:300px; height:100px"/></td>
			</tr>
		</table>
	</form>
</div>

<div id="dlg-buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton c6" id="saveBean"	iconCls="icon-ok" onclick="saveBean()" style="displaly:block;width: 90px">保存</a> 
	<a href="javascript:void(0)" class="easyui-linkbutton" id="saveCancel" iconCls="icon-cancel" onclick="javascript:$('#ExampleBox').dialog('close')" style="width:90px">取消</a>
</div>

<script>
$(function(){
	$("#grideBox").css("height",$(window).height()-83);
	$('#ExampleListBox').datagrid({
	    height: '100%',
	    fit:true,
	    url: '<%=basePath%>framework/duanxin/getExampleList.action',
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
	        { field: 'banPeople', title: '绑定人', width: '25%' },
	        { field: 'banZu', title: '绑定组', width: '22.5%' },
	        { field: 'text', title: '模板内容', width: '50%' }
	       
	    ]]
	});
});

//删除方法
function removeit(){  //删除
	var rows = $('#ExampleListBox').datagrid('getSelections');	
	var row = $('#ExampleListBox').datagrid('getSelected');
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
	$.messager.confirm('确认', '真的要删除<'+row.banPeople+'>吗?', function (r) {
          if (r) {
                	var exampleID = row.exampleID;
                    console.log("ExampleID: "+exampleID);
                    if (row) {
                        $.ajax({
                            cache: false,
                            async: false,
                            type: "POST",
                            data:{"ExampleID":exampleID},
                            dataType: 'json',
                            url: "<%=basePath%>framework/duanxin/deleteExample.action",
                            success: function (data) {
                                console.log(data);
                                if (data.state == 1) {
                                    $('#ExampleListBox').datagrid('reload');                                    
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

var url = "";
//新增
function newsBtn(){
	$('#fm').form('clear');
	$("#creamTime").textbox("setValue", "2017-05-16 11:19:55");
	$('#ExampleBox').dialog('open').dialog('setTitle','新增模板信息');
	url = "<%=basePath%>framework/duanxin/addExample.action";
}

//修改信息
function toUpdate(){  //弹出修改框
           var row = $('#ExampleListBox').datagrid('getSelected');
           var rows = $('#ExampleListBox').datagrid('getSelections');	
           if (row == undefined||row == null||row=="") {
             	$.messager.alert('操作提示', "没有选择被操作的记录！", 'warning');
             	return;
            } 
            if(rows.length>1){
            	$.messager.alert('操作提示', "请选择一条数据！", 'warning');
             	return false;
            } 	
            row.creamTime = fotmateDate(row.creamTime); 
	        $('#ExampleBox').dialog('open').dialog('setTitle','修改模板信息');
	        $('#fm').form('load',row);
	        url = "<%=basePath%>framework/duanxin/updateExample.action";
}
//确认修改信息的保存按钮	    
function saveBean(){ 	
      $('#fm').form('submit',{
		       url: url,
		       onSubmit: function(){
		           return $(this).form('validate');
		       },
		       success: function(data){
		       			var obj = JSON.parse(data);
			            $('#ExampleBox').dialog('close');        // close the dialog
			            $('#ExampleListBox').datagrid('reload');    // reload the user data
		       }
	 }); 
}


//查找的方法
function query(){
	var banPeople = $("#banPeople").val();	
	$('#ExampleListBox').datagrid({
		height: '100%',
		fit:true,
		url: '<%=basePath %>framework/duanxin/findExample.action?banPeople='+banPeople,
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
		           { field: 'banPeople', title: '绑定人', width: '25%' },
	        	   { field: 'banZu', title: '绑定组', width: '22.5%' },
	        	   { field: 'text', title: '模板内容', width: '50%' }
	    ]]
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
</body>
</html>