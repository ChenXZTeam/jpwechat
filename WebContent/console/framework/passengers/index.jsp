<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>常用旅客</title>
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
	    url: '<%=basePath%>framework/LinkMan/numList.action',
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
	        { field: 'userName', title: '客户账号', width: '5%' },
	        { field: 'userNamePhone', title: '绑定的手机',align:'center', width: '10%' },
	        { field: 'linkman', title: '乘机人',align:'center', width: '10%' },
	        { field: 'linkNumber', title: '手机号码',align:'center', width: '10%' },
	        { field: 'birthday', title: '生日',align:'center', width: '10%'},
	        { field: 'caseType', title: '证件类型', width: '8%',
	        	formatter:function(value,rec,index){  
	                if(value=="NI"){
	               	 	return "身份证";
	                }else if(value=="PP"){
	               	 	return "护照";
	                }else{
	                	return "其他证件";
	                }
          	  	}
	        }, 
	        { field: 'caseNum', title: '证件号码', width: '10%'},
	        { field: 'peopleType', title: '旅客类型',align:'center', width: '5%',
	        	formatter:function(value,rec,index){  
	                if(value=="ADT"){
	               	 	return "成人";
	                }else if(value=="CHD"){
	               	 	return "儿童";
	                }else if(value=="INF"){
	                	return "婴儿";
	                }
          	  	}
	        },
	        { field: 'sex', title: '性别',align:'center', width: '5%'},
	        { field: 'belongCtry', title: '国籍',align:'center', width: '5%'},
	        { field: 'openID', title: '微信openID',align:'center', width: '15%'},
	        { field: 'createTime', title: '创建时间',align:'center', width: '10%',formatter:fotmateDate}
	    ]]
	});
	
	$.post("<%=basePath%>framework/LinkMan/getuserList.action",{},function(result){
		var userDate = JSON.parse(result);
		
		var data,json;
		data = [];
		for(var i=0; i<userDate.length; i++){
			data.push({"id":userDate[i].userName,"text":userDate[i].userName});
		}
		$("#userName").combobox("loadData", data);
	});
	
	$('#birthday').datetimebox({  
		   showSeconds:false,  
		   required:true,  
		   onSelect:function(date){  
		        var y = date.getFullYear();  
		        var m = date.getMonth() + 1;  
		        var d = date.getDate();  
		        var time=$('#birthday').datetimebox('spinner').spinner('getValue');  
		        var dateTime = y + "-" + (m < 10 ? ("0" + m) : m) + "-" + (d < 10 ? ("0" + d) : d);  
		        $('#birthday').datetimebox('setText', dateTime);  
		        $('#birthday').datetimebox('hidePanel');  
		   }  
	});
	
	$('#caseTime').datetimebox({  
		   showSeconds:false,  
		   required:true,  
		   onSelect:function(date){  
		        var y = date.getFullYear();  
		        var m = date.getMonth() + 1;  
		        var d = date.getDate();  
		        var time=$('#caseTime').datetimebox('spinner').spinner('getValue');  
		        var dateTime = y + "-" + (m < 10 ? ("0" + m) : m) + "-" + (d < 10 ? ("0" + d) : d);  
		        $('#caseTime').datetimebox('setText', dateTime);  
		        $('#caseTime').datetimebox('hidePanel');  
		   }  
	});
});

var numUrl="";
function news(){
	$('#lvkeInfoForm').form('clear');
	$("#createTime").textbox("setValue","2017-01-01 00:00:00");
	numUrl = "<%=basePath%>framework/LinkMan/addInfo.action";
	$('#lvkeInfoBox').dialog('open').dialog('setTitle','输入旅客信息');
}

function toUpdate(){
	var rows = $('#numListBox').datagrid('getChecked');	
	if(rows.length<1||rows.length>1){
		$.messager.alert('操作提示', "请选择一条数据！", 'warning');
		return false;
	}
	rows[0].createTime = fotmateDate(rows[0].createTime);
	$('#lvkeInfoForm').form('load',rows[0]);
	numUrl = "<%=basePath%>framework/LinkMan/upInfo.action";
	$('#lvkeInfoBox').dialog('open').dialog('setTitle','修改旅客信息');
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

function removeit(){
	var rows = $('#numListBox').datagrid('getChecked');	
	if(rows.length<1){
		$.messager.alert('操作提示', "请操作数据！", 'warning');
		return false;
	}
	var numStr = "";
	for(var i=0; i<rows.length; i++){
		numStr += rows[i].id+",";
	}
	$.post("<%=basePath%>framework/LinkMan/delInfo.action",{"num":numStr.substring(0,numStr.length-1)},function(result){
		if(result==1||result=="1"){
			$('#numListBox').datagrid('reload');
		}else{
			$.messager.alert('操作提示', "删除失败", 'warning');
		}
		
	});
}

function ww3(date){  
    var y = date.getFullYear();  
    var m = date.getMonth()+1;  
    var d = date.getDate();  
    var h = date.getHours();  
    var min = date.getMinutes();  
    var sec = date.getSeconds();  
    var str = y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);  
    return str;  
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

$.extend($.fn.validatebox.defaults.rules, {  
	 phoneNum: { //验证手机号   
	        validator: function(value, param){ 
	         	return /^1[3-8]+\d{9}$/.test(value);
	        },    
	        message: '请输入正确的手机号码。'   
	 }

});
</script>
<div>
	<table cellspacing="10" style="font-size:13px;">
		<tr>
			<td><label>客户账号：</label><input class="easyui-textbox" data-options="prompt:'请输入客户账号'"/></td>
			<td><label>乘机人：</label><input class="easyui-textbox" data-options="prompt:'请输入乘机人'"/></td>
			<td><label>中文名：</label><input class="easyui-textbox" data-options="prompt:'请输入中文名'"/></td>
			<td><label>手机号码：</label><input class="easyui-textbox" data-options="prompt:'请输入手机号'"/></td>
			<td><a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:alert('待开发')" id="saveCancel" style="width:90px">查找</a></td>
		</tr>
	</table>
</div>
<div style="height:25px; background-color:#fff;">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="news()">新增旅客信息</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cut',plain:true" onclick="removeit()">删除旅客信息</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="toUpdate()">修改旅客信息</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="javascript:alert('待开发')">导入旅客信息</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="javascript:alert('待开发')">导出旅客信息</a>
</div>
<div id="grideBox" style="width:100%;">
	<div id="numListBox" style="width:100%;height:100%;"></div>
</div>
<div id="lvkeInfoBox" class="easyui-dialog" style="width:510px; padding:30px;" closed="true" buttons="#dlg-buttons">
	<form id="lvkeInfoForm">
		<table>
			<tr style="display:none;">
				<td><input name="id" class="easyui-textbox"/></td>
				<td><input id="createTime" name="createTime" class="easyui-textbox"/></td>
			</tr>
			<tr>
				<td>客户账号：</td>
				<td><input id="userName" name="userName" class="easyui-combobox" data-options="required:true,panelHeight:'auto',valueField:'id', textField:'text'"/></td>
			</tr>
			<tr>
				<td>乘机人姓名：</td>
				<td><input name="linkman" class="easyui-textbox" data-options="required:true"/></td>
			</tr>
			<tr>
				<td>手机号码：</td>
				<td><input name="linkNumber" class="easyui-textbox" data-options="required:true,validType:['phoneNum']"/></td>
			</tr>
			<tr>
				<td>证件类型：</td>
				<td>
					<select id="caseType" name="caseType" class="easyui-combobox" style="width:173px;" panelHeight="75">
						<option value="NI">身份证</option>
						<option value="PP">护照</option>
						<option value="ID">其他</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>证件号码：</td>
				<td><input name="caseNum" class="easyui-textbox" data-options="required:true"/></td>
			</tr>
			<tr>
				<td>中文姓名：</td>
				<td><input name="chinaName" class="easyui-textbox"/></td>
			</tr>
			<tr>
				<td>出生日期：</td>
				<td><input id="birthday" name="birthday" class="easyui-datetimebox" style="width:173px;"/></td>
			</tr>
			<tr>
				<td>证件有效期：</td>
				<td><input id="caseTime" name="caseTime" class="easyui-datetimebox" style="width:173px;"/></td>
			</tr>
			<tr>
				<td>国籍：</td>
				<td><input name="belongCtry" class="easyui-textbox"/></td>
			</tr>
			<tr>
				<td>旅客类型：</td>
				<td>
					<select id="peopleType" name="peopleType" class="easyui-combobox" style="width:173px;" panelHeight="auto">
						<option value="ADT">成人</option>
						<option value="CHD">儿童</option>
						<option value="INF">婴儿</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>性别：</td>
				<td>
					<select id="sex" name="sex" class="easyui-combobox" style="width:173px;" panelHeight="auto">
						<option value="男">男</option>
						<option value="女">女</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>备注信息：</td>
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