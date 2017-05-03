<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<title>手机号码</title>
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
		<li><span></span><input type="text" id="phoneNumber" placeholder="请输入手机号码"/></li>
		<li><a onclick="query()">搜索</a></li>
	</ul>
</div>
<div style="height:25px; background-color:#fff;">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cut',plain:true" onclick="removeit(this)">删除</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="toUpdate()">修改</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="shows()">查看</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="toImportExcel()">导入</a>
</div>
<div id="grideBox" style="width:100%;">
	<div id="phoneNumListBox" style="width:100%;height:100%;"></div>
</div>
<div id="phoneNumBox" class="easyui-dialog" style="width:720px; height:550px; padding: 10px 20px" closed="true" buttons="#dlg-buttons" iconCls="icon-edit">
	<form id="fm" method="post" enctype="multipart/form-data" novalidate>
		<table border="0" cellpadding="0" cellspacing="10">
			<tr class="dispayNoneClass">
				<td colspan="4"><input name="phoneID"/></td>
			</tr>
			<tr class="dispayNoneClass">
				<td colspan="4"><input name="userName"/></td>
			</tr>
			<tr>
				<td class="titleClass">手机号：</td>
				<td colspan="3"><input name="phoneNumber"/></td>
			</tr>
		</table>
	</form>
</div>

<div id="dlg-buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton c6" id="saveBean"	iconCls="icon-ok" onclick="saveBean()" style="displaly:block;width: 90px">保存</a> 
	<a href="javascript:void(0)" class="easyui-linkbutton" id="saveCancel" iconCls="icon-cancel" onclick="javascript:$('#upInfoBox').dialog('close')" style="width:90px">取消</a>
</div>

<div id="importdlg" class="easyui-dialog" style="margin-top:40px; width: 300px; height: 150px; padding: 10px 20px" closed="true">
	  <form id="importfm" method="post"  enctype="multipart/form-data"novalidate >
		 <input class="easyui-filebox" id="importfile" name="file" data-options="prompt:'选择文件路径'" style="width:100%">
	  </form>
	   <a href="javascript:void(0)" class="easyui-linkbutton c6" id="importExcel"
			iconCls="icon-ok" style="margin-top:20px;width: 90px">确定</a> 
		 <a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#importdlg').dialog('close')"
			style="width: 90px; margin-top:20px">取消</a>
	  </div>
	  
	  <div id="loadBox" style="display:none; position:absolute; top:30%; left:45%; background:rgba(0,0,0,0.5); z-index:99999; font-size:12px; padding:10px; border-radius:5px; color:#ffffff;">
	  	正在导入...
	  </div>
<script>
$(function(){
	$("#grideBox").css("height",$(window).height()-83);
	$('#phoneNumListBox').datagrid({
	    height: '100%',
	    fit:true,
	    url: '<%=basePath%>framework/phoneNum/getPhoneNumList.action',
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
	        { field: 'phoneNumber', title: '手机号码', width: '25%' },
	        { field: 'userName', title: '用户名', width: '22.5%' },
	        { field: 'createTime', title: '创建时间', width: '50%',formatter:fotmateDate}
	       
	    ]]
	});
});

//删除方法
function removeit(){  //删除
	var rows = $('#phoneNumListBox').datagrid('getSelections');	
	var row = $('#phoneNumListBox').datagrid('getSelected');
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
	$.messager.confirm('确认', '真的要删除<'+row.phoneNumber+'>吗?', function (r) {
          if (r) {
                	var phoneID = row.phoneID;
                    console.log("phoneID: "+phoneID);
                    if (row) {
                        $.ajax({
                            cache: false,
                            async: false,
                            type: "POST",
                            data:{"phoneID":phoneID},
                            dataType: 'json',
                            url: "<%=basePath%>framework/phoneNum/deletePhoneNum.action",
                            success: function (data) {
                                console.log(data);
                                if (data.state == 1) {
                                    $('#phoneNumListBox').datagrid('reload');                                    
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


//--------------------------导入方法----------------------------

 //JS校验form表单信息
    function checkData(){
    	var fileDir = $("#importfile").filebox('getValue');
    	var suffix = fileDir.substr(fileDir.lastIndexOf("."));
    	if("" == fileDir){
    		$.messager.alert('操作提示', "选择需要导入的Excel文件！", 'warning');
    		return false;
    	}
    	if(".xls" != suffix && ".xlsx" != suffix ){
    		$.messager.alert('操作提示', "选择Excel格式的文件导入！", 'warning');
    		return false;
    	}
    	return true;
    }
	     
function toImportExcel() {  //打开导入excel对话框
	$('#importdlg').dialog('open').dialog('setTitle','导入Excel');
}

$(document).ready(function(){
		$('#importExcel').click(function(){
 		if(checkData()){
 			$('#importfm').ajaxSubmit({  
 				url: '<%=basePath%>framework/phoneNum/importExcel.action',
 				dataType: 'text',
 				beforeSend:function(){$("#loadBox").show();},
				complete:function(){$("#loadBox").hide();},
 				success: resutlMsg,
 				error: errorMsg
 			}); 
 			function resutlMsg(msg){
 				var obj = JSON.parse(msg);
 				if(obj.state==1){
	       			$('#importdlg').dialog('close');        // close the dialog
	           		$('#phoneNumListBox').datagrid('reload');    // reload the user data
	           		 $.messager.alert("操作提示", "数据导入成功!");
	           		 <%-- $.messager.confirm('确认', '导入文件数据成功！是否查看错误数据？', function (r) {
        				if (r) {
        					window.location.href="<%=basePath%>console/framework/order/DupDataExcel.jsp";
        				}
    				}); --%>
	       		}else {
	       			$.messager.alert('操作提示', '导入excel文件失败！', 'warning');
	       		}
					
				}
				function errorMsg(){
					$.messager.alert('操作提示', "导入excel出错！", 'warning');
				}
 		}
		});
});
		//--------------------------------------结束---------------------------
		
//修改信息
function toUpdate(){  //弹出修改框
           var row = $('#phoneNumListBox').datagrid('getSelected');
           var rows = $('#phoneNumListBox').datagrid('getSelections');	
           console.log(row);
           if (row == undefined||row == null||row=="") {
             	$.messager.alert('操作提示', "没有选择被操作的记录！", 'warning');
             	return;
            } 
            if(rows.length>1){
            	$.messager.alert('操作提示', "请选择一条数据！", 'warning');
             	return false;
            } 	 
	        $('#phoneNumBox').dialog('open').dialog('setTitle','修改手机号信息');
	        $('#fm').form('load',row);
}
//确认修改信息的保存按钮	    
function saveBean(){ 	
      $('#fm').form('submit',{
		       url: "<%=basePath%>framework/phoneNum/updatePhoneNum.action",
		       onSubmit: function(){
		           return $(this).form('validate');
		       },
		       success: function(data){
		       	var obj = JSON.parse(data);
		       	console.log(data+", "+obj+", "+obj.state);
		       	   if(obj.state == 1){
			           $('#phoneNumBox').dialog('close');        // close the dialog
			           $('#phoneNumListBox').datagrid('reload');    // reload the user data
		           }else{
		           	   $.messager.alert('操作提示', "修改不成功！", 'warning');
		           }
		       }
	 }); 
}

function shows(){ //查看
		    var row = $('#phoneNumListBox').datagrid('getSelected');
		    var rows = $('#phoneNumListBox').datagrid('getSelections');
		    if (row == undefined) {
             		$.messager.alert('操作提示', "没有选择被操作的记录！", 'warning');
             		return;
             	 } 
            if(rows.length>1){
            	$.messager.alert('操作提示', "请选择一条数据！", 'warning');
             	return false;
            }  
			if (row){
				window.location.href="<%=basePath%>console/framework/duanxin/details.jsp?phoneID="+row.phoneID;
			}
}

//查找的方法
function query(){
	var phoneNumber = $("#phoneNumber").val();	
	$('#phoneNumListBox').datagrid({
		height: '100%',
		fit:true,
		url: '<%=basePath %>framework/phoneNum/findPhoneNum.action?phoneNumber='+phoneNumber,
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
		            { field: 'ck', checkbox: true },
			        { field: 'phoneNumber', title: '手机号码', width: 150 },
			        { field: 'userName', title: '用户名', width: 100 },
			        { field: 'createTime', title: '创建时间', width: 200,formatter:fotmateDate}
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