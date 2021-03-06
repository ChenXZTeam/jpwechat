<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<title>国内资讯</title>
<link rel="stylesheet" type="text/css"href="<%=basePath%>scripts/common/jquery-easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css">
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/default/datagrid.css">
<link rel="stylesheet" href="<%=basePath %>kinder/themes/default/default.css" />
<link rel="stylesheet" href="<%=basePath %>kinder/plugins/code/prettify.css" />
<script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
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
<script>
		KindEditor.ready(function(K) {
			var editor1 = K.create('textarea[name="info",id="contText"]', {
				cssPath : '<%=basePath %>kinder/plugins/code/prettify.css',
				uploadJson : '<%=basePath %>kinder/upload_json.jsp',
				fileManagerJson : '<%=basePath %>kinder/file_manager_json.jsp',
				allowFileManager : true,
				afterBlur:function(){this.sync();}
			});
		});
</script>
</head>
<body>
<div class="seachBox">
	<ul>
		<li><span></span><input type="text" id="title" placeholder="请输入标题关键字"/></li>
		<li><a onclick="query()">搜索</a></li>
	</ul>
</div>
<div style="height:25px; background-color:#fff;">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cut',plain:true" onclick="removeit(this)">删除</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="toUpdate()">修改</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="shows()">查看</a>
	<a href="<%=basePath%>console/framework/contryNews/addinfo.jsp" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新增</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="sendInfo()">推送消息</a>
</div>
<div id="grideBox" style="width:100%;">
	<div id="zixunListBox" style="width:100%;height:100%;"></div>
</div>
<div id="upInfoBox" class="easyui-dialog" style="width:720px; height:550px; padding: 10px 20px" closed="true" buttons="#dlg-buttons" iconCls="icon-edit">
	<form id="fm" method="post" enctype="multipart/form-data" novalidate>
		<table border="0" cellpadding="0" cellspacing="10">
			<tr class="dispayNoneClass">
				<td colspan="4"><input name="infoID"/></td>
			</tr>
			<tr>
				<td class="titleClass">文章标题：</td>
				<td colspan="3"><input name="title"/></td>
			</tr>
			<tr>
				<td class="titleClass">简介：</td>
				<td colspan="3"><input name="introduction"/></td>
			</tr>
			<tr>
				<td class="titleClass">文章内容：</td>
				<td colspan="3"><textarea id="info" name="info"  style="width:500px; height:394px;"/></textarea></td>
			</tr>
		</table>
	</form>
</div>
<div id="dlg-buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton c6" id="saveBean"	iconCls="icon-ok" onclick="saveBean()" style="displaly:block;width: 90px">保存</a> 
	<a href="javascript:void(0)" class="easyui-linkbutton" id="saveCancel" iconCls="icon-cancel" onclick="javascript:$('#upInfoBox').dialog('close')" style="width:90px">取消</a>
</div>

<div id="wxMessBox" class="easyui-dialog" style="width:600px; height:500px; padding: 10px 20px" closed="true" buttons="#wxMes-buttons" iconCls="icon-edit">
	<form id="wxMesfm" method="post" enctype="multipart/form-data" novalidate>
		<table border="0" cellpadding="0" cellspacing="10">
			<tr>
				<td>图文标题：</td>
				<td><input type="text" name="mittitle" id="mittitle" style="width:300px;"/></td>
			</tr>
			<tr>
				<td>封面图路径：</td>
				<td><input type="text" name="fmUrl" id="fmUrl" style="width:300px;"/></td>
			</tr>
			<tr>
				<td>图文描述：</td>
				<td><input type="text" name="mitcont" id="mitcont" style="width:420px;"/></td>
			</tr>
			<tr>
				<td style="vertical-align:top;">图文内容：</td>
				<td><textarea name="contText" id="contText" style="width:420px; height:300px;"></textarea></td>
			</tr>
		</table>
	</form>
</div>
<div id="wxMes-buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton c6" id="wxMesSaveBean" iconCls="icon-ok" onclick="wxMesBean()" style="displaly:block;width: 90px">确认推送</a> 
	<a href="javascript:void(0)" class="easyui-linkbutton" id="wxMesSaveCancel" iconCls="icon-cancel" onclick="javascript:$('#wxMessBox').dialog('close')" style="width:90px">取消</a>
</div>
<script>
$(function(){
	$("#grideBox").css("height",$(window).height()-85);
	$('#zixunListBox').datagrid({
	    height: '100%',
	    fit:true,
	    url: '<%=basePath%>framework/info/getInfoList.action',
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
	        { field: 'title', title: '文章标题', width: '33%' },
	        { field: 'introduction', title: '简介', width: '33%' },
	        { field: 'createTime', title: '创建时间',align:'center', width: '31%',formatter:fotmateDate}
	       
	    ]]
	});
});

//删除方法
function removeit(){  //删除
	var rows = $('#zixunListBox').datagrid('getSelections');	
	var row = $('#zixunListBox').datagrid('getSelected');
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
	$.messager.confirm('确认', '真的要删除<'+row.title+'>吗?', function (r) {
          if (r) {
                	var infoID = row.infoID;
                    console.log("infoID: "+infoID);
                    if (row) {
                        $.ajax({
                            cache: false,
                            async: false,
                            type: "POST",
                            data:{"infoID":infoID},
                            dataType: 'json',
                            url: "<%=basePath%>framework/info/deleteInfo.action",
                            success: function (data) {
                                console.log(data);
                                if (data.state == 1) {
                                    $('#zixunListBox').datagrid('reload');                                    
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

//修改信息
function toUpdate(){  //弹出修改框
           var row = $('#zixunListBox').datagrid('getSelected');
           var rows = $('#zixunListBox').datagrid('getSelections');	
           console.log(row);
           //alert(row.info);
           $(document.getElementsByTagName("iframe")[0].contentWindow.document.body).html(row.info);
           if (row == undefined||row == null||row=="") {
             	$.messager.alert('操作提示', "没有选择被操作的记录！", 'warning');
             	return;
            } 
            if(rows.length>1){
            	$.messager.alert('操作提示', "请选择一条数据！", 'warning');
             	return false;
            } 	 
	        $('#upInfoBox').dialog('open').dialog('setTitle','修改资讯信息');
	        $('#fm').form('load',row);
}
//确认修改信息的保存按钮	    
function saveBean(){ 	
      $('#fm').form('submit',{
		       url: "<%=basePath%>framework/info/updateInfo.action",
		       onSubmit: function(){
		           return $(this).form('validate');
		       },
		       success: function(data){
		       	var obj = JSON.parse(data);
		       	console.log(data+", "+obj+", "+obj.state);
		       	   if(obj.state == 1){
			           $('#upInfoBox').dialog('close');        // close the dialog
			           $('#zixunListBox').datagrid('reload');    // reload the user data
		           }else{
		           	   $.messager.alert('操作提示', "修改不成功！", 'warning');
		           }
		       }
	 }); 
}

function shows(){ //查看
		    var row = $('#zixunListBox').datagrid('getSelected');
		    var rows = $('#zixunListBox').datagrid('getSelections');
		    if (row == undefined) {
             		$.messager.alert('操作提示', "没有选择被操作的记录！", 'warning');
             		return;
             	 } 
            if(rows.length>1){
            	$.messager.alert('操作提示', "请选择一条数据！", 'warning');
             	return false;
            }  
			if (row){
				window.location.href="<%=basePath%>console/framework/contryNews/details.jsp?title="+row.infoID;
			}
}

//查找的方法
function query(){
	var title = $("#title").val();	
	$('#zixunListBox').datagrid({
		height: '100%',
		fit:true,
		url: '<%=basePath %>framework/info/findInfo.action?title='+title,
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
			       { field: 'title', title: '文章标题', width: '33%' },
			       { field: 'introduction', title: '简介', width: '33%'},
			       { field: 'createTime', title: '创建时间',align:'center', width: '31%',formatter:fotmateDate}
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

function sendInfo(){
	$('#wxMessBox').dialog('open').dialog('setTitle','微信图文消息推送');
}

function wxMesBean(){ 	
     $('#wxMesfm').form('submit',{
		       url: "<%=basePath%>framework/wxInfo/wxTsMesgess.action",
		       onSubmit: function(){
		           return $(this).form('validate');
		       },
		       success: function(data){
		       		var obj = JSON.parse(data);
					alert(obj.msg);
		       }
	 });
}
		
</script>
</body>
</html>