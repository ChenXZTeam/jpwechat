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
	.titleClass{width:100px; font-size:12px; color:#666666;}
	textarea{width:100%; height:100px; color:#777777;}
	input{height:20px; color:#777777;}
	select{width:164px; height:23px; color:#777777;}
	.dispayNoneClass{display:none;}
	#fenziLi li{line-height:25px; overflow:hidden;}
	#fenziLi li label{margin-top:-3px; cursor:pointer;}
	.fzUUID{display:none;}
	
	.checkDisplayNot{display:none;}
	.checkDisplay{display:line;}
	
	.xialaPoint-colse{background:url(<%=basePath%>scripts/common/jquery-easyui/themes/default/images/tree_icons.png) no-repeat 0px 0px;}
  	.xialaPoint-open{background:url(<%=basePath%>scripts/common/jquery-easyui/themes/default/images/tree_icons.png) no-repeat -18px 0px;}
  	.fileImage-colse{background:url(<%=basePath%>scripts/common/jquery-easyui/themes/default/images/tree_icons.png) no-repeat -208px 0;}
  	.fileImage-open{background:url(<%=basePath%>scripts/common/jquery-easyui/themes/default/images/tree_icons.png) no-repeat -224px 0;}
  	
  	.fileImagePush{margin-right:2px; display:block; width:15px; height:20px; float:left; background:url(<%=basePath%>scripts/common/jquery-easyui/themes/default/images/tree_icons.png) no-repeat -240px 0}
</style>

</head>
<body style="margin:0px;padding:0px;">
<div id="leftBox" style="border-right:1px solid #ccc; border-bottom:1px solid #ccc; float:left; width:14%; padding:10px;">
	<a href="javascript:void(0)" class="easyui-linkbutton" style="width:60px; height:28px; outline:none;" onclick="newFz()">新建分组</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" style="width:60px; height:28px; outline:none;" onclick="upFenZu()">修改分组</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" style="width:60px; height:28px; outline:none;" onclick="delFenZu()">删除分组</a>
	<div id="fenzuBox" style="font-size:14px; margin-top:30px; margin-left:20px;">
		<div id="btn1" style="cursor:pointer;">
			<span class="xialaPoint-open" style="display:block; width:15px; height:15px; float:left;"></span>
			<span class="fileImage-open" style="display:block; width:15px; height:15px; float:left;"></span>
			<span style="display:block; float:left; margin-left: 3px; margin-top: 1px;">分组列表</span>
			<span style="display:block; clear:both;"></span>
		</div>
		<ul id="fenziLi" style="list-style-type:none; margin:0px; margin-top:10px; max-height:330px; overflow-x: auto;"></ul>
		<div><a href="javascript:void(0)" class="easyui-linkbutton" style="width:60px; height:28px; outline:none; margin:15px 42px;" onclick="sureBtn()">确定选择</a></div>
	</div>
</div> 
<div style="float:left; width:84.6%;">
	<div style="height:25px; background-color:#fff; padding:10px;">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="removeit()" style="width:80px;">删除</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="toUpdate()" style="width:80px;">修改</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="shows()" style="width:80px;">查看</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="toImportExcel()" style="width:80px;">导入</a>
	</div>
	<div class="seachBox">
		<ul>
			<li><span></span><input type="text" id="phoneNumber" placeholder="请输入手机号码" style="border-radius:5px;"/></li>
			<li><a href="javascript:void(0)" class="easyui-linkbutton" style="width:120px; height:28px; outline:none;" onclick="query()">搜索</a></li>
		</ul>
	</div>
	<div id="grideBox" style="width:100%;">
		<div id="phoneNumListBox" style="width:100%;height:100%;"></div>
	</div>
</div>
<div style="clear:both;"></div>
<div id="fzNameBox" class="easyui-dialog" style="width:360px; padding:30px;" closed="true" buttons="#dlg-buttons2">
	<form id="newFz">
		<label>组名称：</label><input name="fzName" class="easyui-textbox"/>
	</form>
</div>
<div id="dlg-buttons2">
	<a href="javascript:void(0)" class="easyui-linkbutton c6" id="saveBean"	iconCls="icon-ok" onclick="saveFz()" style="displaly:block;width: 90px">保存</a> 
	<a href="javascript:void(0)" class="easyui-linkbutton" id="saveCancel" iconCls="icon-cancel" onclick="javascript:$('#fzNameBox').dialog('close')" style="width:90px">取消</a>
</div>
<div id="phoneNumBox" class="easyui-dialog" style="width:360px; height:400px; padding:20px;" closed="true" buttons="#dlg-buttons" iconCls="icon-edit">
	<form id="fm" method="post" enctype="multipart/form-data" novalidate>
		<table border="0" cellpadding="0" cellspacing="10">
			<tr class="dispayNoneClass">
				<td colspan="2"><input name="phoneID"/></td>
			</tr>
			<tr class="dispayNoneClass">
				<td colspan="2"><input name="userName"/></td>
			</tr>
			<tr>
				<td class="titleClass">联系用户：</td>
				<td><input name="linkName"/></td>
			</tr>
			<tr>
				<td class="titleClass">手机号：</td>
				<td><input name="phoneNumber"/></td>
			</tr>
		</table>
	</form>
</div>
<div id="lookAllMess" class="easyui-dialog" style="width:360px; height:400px; padding:20px;" closed="true" buttons="#dlg-buttons1">
	<form id="lookAllForm">
		<table>
			<tr>
				<td>联系用户：</td>
				<td><input name="linkName" style="border:none; outline:none;" readonly/></td>
			</tr>
			<tr>
				<td>手机号码：</td>
				<td><input name="phoneNumber" style="border:none; outline:none;" readonly/></td>
			</tr>
		</table>
	</form>
</div>
<div id="dlg-buttons1">
	<a href="javascript:void(0)" class="easyui-linkbutton" id="saveCancel" iconCls="icon-cancel" onclick="javascript:$('#lookAllMess').dialog('close')" style="width:90px">取消</a>
</div>

<div id="dlg-buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton c6" id="saveBean"	iconCls="icon-ok" onclick="saveBean()" style="displaly:block;width: 90px">保存</a> 
	<a href="javascript:void(0)" class="easyui-linkbutton" id="saveCancel" iconCls="icon-cancel" onclick="javascript:$('#upInfoBox').dialog('close')" style="width:90px">取消</a>
</div>

<div id="importdlg" class="easyui-dialog" style="margin-top:40px; width: 300px; height: 150px; padding: 10px 20px" closed="true">
	 <form id="importfm" method="post"  enctype="multipart/form-data"novalidate >
		<input class="easyui-filebox" id="importfile" name="file" data-options="prompt:'选择文件路径'" style="width:100%">
	 </form>
	 <a href="javascript:void(0)" class="easyui-linkbutton c6" id="importExcel" iconCls="icon-ok" style="margin-top:20px;width: 90px">确定</a> 
	 <a href="javascript:void(0)" class="easyui-linkbutton"	iconCls="icon-cancel" onclick="javascript:$('#importdlg').dialog('close')" style="width: 90px; margin-top:20px">取消</a>
</div>
	  
<div id="loadBox" style="display:none; position:absolute; top:30%; left:45%; background:rgba(0,0,0,0.5); z-index:99999; font-size:12px; padding:10px; border-radius:5px; color:#ffffff;">
	  正在导入...
</div>
<script>
$(function(){
	$("#grideBox").css("height",$(window).height()-93);
	$("#leftBox").css("height",$(window).height()-21);
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
	        { field: 'linkName',title: '联系用户',width: '25%'},
	        { field: 'phoneNumber', title: '手机号码', width: '25%' },
	        { field: 'fzName', title: '所属分组', width: '15%' },
	        { field: 'userName', title: '用户名', width: '22.5%' },
	        { field: 'createTime', title: '创建时间', width: '10%',formatter:fotmateDate}
	       
	    ]]
	});
	
	$("#btn1").click(function(){
		  if($(this).children("span").hasClass("xialaPoint-open")){
			  $(".xialaPoint-open").addClass("xialaPoint-colse").removeClass("xialaPoint-open");
			  $(".fileImage-open").addClass("fileImage-colse").removeClass("fileImage-open");
		  }else{
			  $(".xialaPoint-colse").addClass("xialaPoint-open").removeClass("xialaPoint-colse");
			  $(".fileImage-colse").addClass("fileImage-open").removeClass("fileImage-colse");
		  }
		  $("#fenziLi").slideToggle(100);
	});
	
	loadFz();
});

var fzUrl = "";
var upORdel = "";
//新建分组
function newFz(){
	fzUrl = "<%=basePath%>framework/phoneGroup/newFz.action";
	$('#fzNameBox').dialog('open').dialog('setTitle','新建分组');
}

//修改分组
function upFenZu(){
	$(".checkBoxFz").attr("checked",false);
	if($(".checkBoxFz").hasClass("checkDisplayNot")){
		$(".checkBoxFz").removeClass("checkDisplayNot").addClass("checkDisplay");
	}else{
		$(".checkBoxFz").removeClass("checkDisplay").addClass("checkDisplayNot");
	}
	upORdel = "1";
}

//删除分组
function delFenZu(){
	$(".checkBoxFz").attr("checked",false);
	if($(".checkBoxFz").hasClass("checkDisplayNot")){
		$(".checkBoxFz").removeClass("checkDisplayNot").addClass("checkDisplay");
	}else{
		$(".checkBoxFz").removeClass("checkDisplay").addClass("checkDisplayNot");
	}
	upORdel = "0";
}

function sureBtn(){
	if(upORdel=="1"||"1"==upORdel){
		alert("你点击的是修改");
	}else if(upORdel=="0"||"0"==upORdel){
		alert("你点击的是删除");
	}
}

//加载全部分组
function loadFz(){
	$.post("<%=basePath%>framework/phoneGroup/getGroupList.action",{},function(res){
		var obj = JSON.parse(res);
		var data = obj.rows;
		for(var i=0; i<data.length; i++){
			var li = '<li><input class="checkBoxFz checkDisplayNot" type="checkbox" style="float:left; margin-top:-0.5px;"/><span class="fileImagePush"></span><label class="lookSee" style="float:left;">'+data[i].fzName+'</label><div class="fzUUID" style="clear:both;">'+data[i].uuid+'</div></li>';
			$("#fenziLi").append(li);
		}
	});
}

//删除方法
function removeit(){  //删除
	var rows = $('#phoneNumListBox').datagrid('getSelections');	
	var row = $('#phoneNumListBox').datagrid('getSelected');
	if (row == undefined||row == null||row == "") {
         $.messager.alert('操作提示', "没有选择被操作的记录！", 'warning');
         return false;
    } 
    if(rows.length > 1){
         $.messager.alert('操作提示', "只能删除一条数据", 'warning');
         return false;
    }
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

//保存分组
function saveFz(){
	$('#newFz').form('submit',{
	       url: fzUrl,
	       onSubmit: function(){
	           return $(this).form('validate');
	       },
	       success: function(data){
		       	if(data=='"1"'||'"1"'==data){
		       	 	location.reload();
		       	}else{
		       		$.messager.alert('操作提示', "操作分组失败", 'warning');
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
            $("#lookAllMess").dialog('open').dialog('setTitle','查看手机详情');
            $("#lookAllForm").form("clear");
            $("#lookAllForm").form("load",row);
}

//查找的方法
function query(){
	var phoneNumber = $("#phoneNumber").val().trim();	
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
			        { field: 'linkName',title: '联系用户',width: '25%'},
			        { field: 'phoneNumber', title: '手机号码', width: '25%' },
			        { field: 'fzName', title: '所属分组', width: '15%' },
			        { field: 'userName', title: '用户名', width: '22.5%' },
			        { field: 'createTime', title: '创建时间', width: '25%',formatter:fotmateDate}
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