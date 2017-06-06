<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>运价缓存配置</title>
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
	$("#grideBox").css("height",$(window).height()-111);
	$('#numListBox').datagrid({
	    height: '100%',
	    fit:true,
	    url: '<%=basePath%>framework/freight/numList.action',
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
	        { field: 'orgCity', title: '出发城市', width: '15%' ,formatter:findByCity},
	        { field: 'dstCity', title: '到达城市', width: '15%' ,formatter:findByCity},
	        { field: 'createTime', title: '缓存创建时间',align:'center', width: '10%' ,formatter:fotmateDate},
	        { field: 'overTime', title: '缓存过期时间',align:'center', width: '10%' ,formatter:fotmateDate},
	        { field: 'isOver', title: '是否过期',align:'center', width: '10%',
	        	formatter:function(value,rec,index){  
	                if(value=="0"){
	               	 	return "已过期";
	                }else if(value=="1"){
	               	 	return "未过期";
	                }
          	  	}
	        },
	        { field: 'updateTime', title: '管理员更新时间',align:'center', width: '10%' ,formatter:fotmateDate}
	    ]]
	});
	
	var data = [];
	var airCompany = JSON.stringify(getCityCode());
	airCompany = airCompany.substring(1,airCompany.length-1);
	var chCompany = airCompany.split(",");
	for(var i=0; i<chCompany.length; i++){
		var codeAndName = chCompany[i].split(":");
		data.push({"value":codeAndName[0].substring(1,codeAndName[0].length-1),"text":codeAndName[1].substring(1,codeAndName[1].length-1)+"("+codeAndName[0].substring(1,codeAndName[0].length-1)+")"});
	}
	$("#orgCity").combobox("loadData", data);
	$("#dstCity").combobox("loadData", data);
	$("#orgCityBox").combobox("loadData", data);
	$("#dstCityBox").combobox("loadData", data);
	
	
	$('#dateBox').datetimebox({  
		   showSeconds:false,  
		   required:true,  
		   onSelect:function(date){  
		        var y = date.getFullYear();  
		        var m = date.getMonth() + 1;  
		        var d = date.getDate();  
		        var time=$('#dateBox').datetimebox('spinner').spinner('getValue');  
		        var dateTime = y + "-" + (m < 10 ? ("0" + m) : m) + "-" + (d < 10 ? ("0" + d) : d);   
		        $('#dateBox').datetimebox('setValue', dateTime);
		        $('#dateBox').datetimebox('setText', dateTime);   
		        $('#dateBox').datetimebox('hidePanel');  
		   }  
	});
});

function upHcDate(){
	$('#numListBox').datagrid({
	    height: '100%',
	    fit:true,
	    url: '<%=basePath%>framework/freight/reloadHc.action',
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
			        { field: 'orgCity', title: '出发城市', width: '15%' ,formatter:findByCity},
			        { field: 'dstCity', title: '到达城市', width: '15%' ,formatter:findByCity},
			        { field: 'createTime', title: '缓存创建时间',align:'center', width: '10%' ,formatter:fotmateDate},
			        { field: 'overTime', title: '缓存过期时间',align:'center', width: '10%' ,formatter:fotmateDate},
			        { field: 'isOver', title: '是否过期',align:'center', width: '10%',
			        	formatter:function(value,rec,index){  
			                if(value=="0"){
			               	 	return "已过期";
			                }else if(value=="1"){
			               	 	return "未过期";
			                }
		          	  	}
			        },
			        { field: 'updateTime', title: '管理员更新时间',align:'center', width: '10%' ,formatter:fotmateDate}
			    ]]
	});
}

function updateHc(){
	var rows = $('#numListBox').datagrid('getChecked');
	var sign = "";
	if(rows.length==0){
		$.messager.confirm('确认', '确定要更新全部缓存吗（耗时较长）？', function (r) {
			if (r) {
				sign = "all";
				$.messager.alert('操作提示', "待开发！部分缓存的已开发，可以进行测试！", 'warning');
				<%-- $.post("<%=basePath%>framework/hcConfig/relUpHc.action",{"sign":sign},function(result){
					
				}); --%>
			}
		});
	}else{
		for(var i=0; i<rows.length; i++){
			sign+=rows[i].uuid+",";
		}
		sign = sign.substring(0,sign.length-1);
		$.ajax({
             type: "POST",
             url: "<%=basePath%>framework/freight/relUpHc.action",
             data: {"sign":sign},
             dataType: "json",
             beforeSend:function(){
                 $("#loadBox").css("display","block");
             },
             success: function(data){
            	 console.log("更新缓存结果："+data);
            	 if(data==1||data=="1"){
            		 window.location.reload();
            	 }else if(data==0||data=="0"){
            		 $.messager.alert('操作提示', "更新失败！", 'warning');
            	 }
             },error:function(){
            	 $.messager.alert('操作提示', "更新失败！系统出错", 'warning');
             }
        });
		
	}
}

function findBySel(){
	var orgCity = $("#orgCity").combobox("getValue");
	var dstCity = $("#dstCity").combobox("getValue");
	var isOverSel = $("#isOverSel").combobox("getValue");
	$('#numListBox').datagrid({
	    height: '100%',
	    fit:true,
	    url: '<%=basePath%>framework/freight/findBySel.action',
	    method: 'POST',
	    queryParams:{orgCity:orgCity,dstCity:dstCity,isOverSel:isOverSel},
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
			        { field: 'orgCity', title: '出发城市', width: '15%' ,formatter:findByCity},
			        { field: 'dstCity', title: '到达城市', width: '15%' ,formatter:findByCity},
			        { field: 'createTime', title: '缓存创建时间',align:'center', width: '10%' ,formatter:fotmateDate},
			        { field: 'overTime', title: '缓存过期时间',align:'center', width: '10%' ,formatter:fotmateDate},
			        { field: 'isOver', title: '是否过期',align:'center', width: '10%',
			        	formatter:function(value,rec,index){  
			                if(value=="0"){
			               	 	return "已过期";
			                }else if(value=="1"){
			               	 	return "未过期";
			                }
		          	  	}
			        },
			        { field: 'updateTime', title: '管理员更新时间',align:'center', width: '10%' ,formatter:fotmateDate}
			    ]]
	});
}

function reset(){
	$("#orgCity").combobox("setValue","");
	$("#dstCity").combobox("setValue","");
	$("#isOverSel").combobox("setValue","");
}

function newsBtn(){
	$('#lvkeInfoForm').form('clear');
	$('#lvkeInfoBox').dialog('open').dialog('setTitle','输入缓存条件');
}

function saveBean(){
	 $('#lvkeInfoForm').form('submit',{
		   url: '<%=basePath%>framework/freight/addHc.action',
		   onSubmit: function(){
		        return $(this).form('validate');
		   },
		   success: function(data){
			   if(data==1||data=="1"){
				   $('#lvkeInfoBox').dialog('close');        // close the dialog
				   window.location.reload();
			   }else{
				   $.messager.alert('操作提示', "操作失败", 'warning');
			   }
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
</script>
<div style="padding:10px; font-size:13px;">
	<table cellspacing="10">
		<tr>
			<td>出发城市:</td>
			<td>
				<select id="orgCity" class="easyui-combobox" style="width:150px;" data-options="panelHeight:'276',valueField:'value', textField:'text'"></select>
			</td>
			<td>到达城市:</td>
			<td>
				<select id="dstCity" class="easyui-combobox" style="width:150px;" data-options="panelHeight:'276',valueField:'value', textField:'text'"></select>
			</td>
			<td>是否过期:</td>
			<td>
				<select id="isOverSel" class="easyui-combobox" style="width:150px;" panelHeight="auto">
						<option value=""></option>
						<option value="0">已过期</option>
						<option value="1">未过期</option>
				</select>
			</td>
			<td><a href="javascript:void(0)" class="easyui-linkbutton" onclick="findBySel()" style="width:120px; outline:none;">搜 索</a></td>
			<td><a href="javascript:void(0)" class="easyui-linkbutton" onclick="reset()" style="width:120px; outline:none;">重 置</a></td>
		</tr>
	</table>
</div>
<div style="height:25px; background-color:#fff;">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="newsBtn()">增加运价缓存</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true" onclick="upHcDate()">生成缓存数据</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cut',plain:true" onclick="updateHc()">更新缓存数据</a>
</div>
<div id="grideBox" style="width:100%;">
	<div id="numListBox" style="width:100%;height:100%;"></div>
</div>
<div id="loadBox" style="display:none; width:100%;height:100%;position:absolute; top:0px; left:0px; background:rgba(0,0,0,0.1);">
	<div style="margin-left:auto; margin-right:auto; margin-top:20%; text-align:center; line-height:70px; width:180px; height:70px; background:rgba(0,0,0,0.5); color:#fff; border-radius:5px;">缓存更新中...</div>
</div>
<div id="lvkeInfoBox" class="easyui-dialog" style="width:350px; padding:30px;" closed="true" buttons="#dlg-buttons">
	<form id="lvkeInfoForm">
		<table cellspacing="10">
			<tr>
				<td>出发城市：</td>
				<td><input id="orgCityBox" name="orgCity" class="easyui-combobox" data-options="required:true,panelHeight:'276',valueField:'value', textField:'text'"/></td>
			</tr>
			<tr>
				<td>到达城市：</td>
				<td><input id="dstCityBox" name="dstCity" class="easyui-combobox" data-options="required:true,panelHeight:'276',valueField:'value', textField:'text'"/></td>
			</tr>
			<tr>
				<td>出发日期：</td>
				<td><input id="dateBox" name="dateBox"  class="easyui-datetimebox" style="width:173px;"/></td>
			</tr>
		</table>
	</form>
</div>
<div id="dlg-buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton" id="saveBean" iconCls="icon-ok" onclick="saveBean()" style="displaly:block;width: 90px">开始缓存</a> 
	<a href="javascript:void(0)" class="easyui-linkbutton" id="saveCancel" iconCls="icon-cancel" onclick="javascript:$('#lvkeInfoBox').dialog('close')" style="width:90px">取消</a>
</div>
</body>
</html>