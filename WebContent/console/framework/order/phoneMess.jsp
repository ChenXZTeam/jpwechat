<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<style type="text/css">
#fm {
	margin: 0;
	padding: 10px 20px;
	height: 190px;
}
.ftitle {
	font-size: 14px;
	font-weight: bold;
	padding: 5px 0;
	margin-bottom: 10px;
	border-bottom: 1px solid #ccc;
}
.fitem{
	height: 20px;
}

</style>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>短信发送记录</title>
	<link rel="stylesheet" type="text/css"href="<%=basePath%>scripts/common/jquery-easyui/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css" />
	<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/default/datagrid.css" />
	<script type="text/javascript"src="<%=basePath%>scripts/common/jquery-1.8.3.min.js"></script>
	<script type="text/javascript"src="<%=basePath%>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>

<!-- 查找手机号码 -->
<div id="findBox" style="padding:5px; overflow:hidden;">
	<div style="float:left;"><input type="text" id="phoneNumBox" placeholder="请输入手机号码" style="height:25px; padding-left:10px; outline:none;"/></div>
	<div style="float:left; margin-left:15px;"><button id="findBtn" style="height:31px; padding:0px 25px; cursor:pointer; background-color:blue; color:#fff; border:none;">查找</button></div>
</div>

<!-- 短信的按钮 -->
	<div id="toolbar" style="height:25px; background-color:#fff;">
		<a id="SMSBtn_qx" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="sendMess()">短信发送</a>
	</div>

<!-- 短信发送页面 -->
	<div id="sendMesBox" class="easyui-dialog"
		style="width: 460px; height: 350px; padding: 10px 20px; background-color:#fff; border:1px solid #ccc;" closed="true" buttons="#dlg-buttons">
		<div class="ftitle" id="ftitle"></div>
		<form id="fm" method="post" enctype="multipart/form-data" novalidate>
				<div id="sq" class="fitem" style="margin-top:10px;">
					<label style="color:#999999;float:left;">手机号码：</label>
					<input type="text" id="phoneNumList" data-options="validType:['length[0,25]']" style="padding:2px 8px; border:1px solid #ccc; width:254px; height:20px; float:left;"/>
				</div>
				<div id="sq" style="margin-top:20px;">
					<label style="color:#999999; float:left;"> &nbsp;&nbsp;内容：</label>
					<textarea id="textareaText" style="width:265px;float:right-10px; height:120px;" ></textarea>
				</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" id="tosend" iconCls="icon-redo" style="padding:3px 20px; cursor:pointer;" onclick="sendTo()">发送</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton" id="exit" iconCls="icon-cancel" style="padding:3px 20px; margin-left:10px; cursor:pointer;" onclick="quxiao()">取消</a>
	</div>

<!-- 数据展示页 -->
<div style="width:100%;height:420px;">
	<div id="dg" style="width:100%;height:420px;"></div>
</div>

<!-- 查看错误信息文本 -->
<div id="LookErrorInfo" class="easyui-dialog" style="width:300px; height:300px; padding: 10px 10px" closed="true" buttons="#dlg-buttons">
	<ul id="lookReason" style="list-style-type:none; overflow:hidden; padding:0px; margin:0px;">
	</ul>
</div>
<div id="dlg-buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton" id="saveCancel" iconCls="icon-cancel" onclick="javascript:$('#LookErrorInfo').dialog('close')" style="width: 90px">取消</a>
</div>
<script>

	$(function(){
		
		$('#dg').datagrid({
		    height: '100%',
		    fit:true,
		    url: "<%=basePath%>/framework/order/obtainPhoneMess.action",
		    method: 'POST',
		    striped: true,
		    nowrap: true,
		    pageSize: 10,
		    pageNumber:1, 
		    pageList: [10, 20, 50, 100, 150, 200],
			pagination : true,
		    showFooter: true, 
			loadMsg : '数据加载中请稍后……',
		    toolbar:"#toolbar",
		    singleSelect: false,
			rownumbers:true,
		    columns: [[ 
						{ field: 'ck', checkbox: true },
		                { field: 'phoneNumber', title: '<span class="txtcenter">手机号码</span>',width: 120},
						{ field: 'text', title: '<span class="txtcenter">消息内容</span>', width: 550},
						{ field: 'sendType', title: '<span class="txtcenter">发送状态</span>', width: 120,
							formatter:function(value,rec,index){  
			                     if(value == '1' || value == 1){
									return "发送成功";
								 }else if(value == '0' || value == 0){
									return "发送失败";
								 }
							}
						},
						{ field: 'userName', title: '<span class="txtcenter">操作员</span>', width: 120},
						{ field: 'createTime', title: '<span class="txtcenter">发送时间</span>', width: 200,formatter:fotmateDate},
						{ field: 'zuNumber', title: '<span class="txtcenter">组号码</span>', width: 120,},
				        { field: 'userMode', title: '<span class="txtcenter">用户模板</span>',align:'center', width: 120}
		    ]],
               onDblClickRow :function(rowIndex,rowData){
			    	details(rowData);
			   	},
			   onLoadSuccess:function(data){
			        $(".txtcenter").parent().parent().css("text-align","center");
			    }
		});
		
		
		
		 $("#findBtn").click(function(){
			var phoneNumber = $("#phoneNumBox").val().trim();
			$('#dg').datagrid({
				    height: '100%',
				    fit:true,
				    url: '<%=basePath%>/framework/order/findPhoneMess.action?phoneNumber='+phoneNumber,
				    method: 'POST',
				    striped: true,
				    nowrap: true,
				    pageSize: 10,
				    pageNumber:1, 
				    pageList: [10, 20, 50, 100, 150, 200],
				    showFooter: true, 
					loadMsg : '数据加载中请稍后……',
					pagination : true,
				    toolbar:"#toolbar",
				    singleSelect: false,
					rownumbers:true,
				    
					columns: [[
						{ field: 'ck', checkbox: true },
				        { field: 'phoneNumber', title: '<span class="txtcenter">手机号码</span>',width: 120},
						{ field: 'text', title: '<span class="txtcenter">消息内容</span>', width: 550},
						{ field: 'sendType', title: '<span class="txtcenter">发送状态</span>', width: 120,
							formatter:function(value,rec,index){  
			                     if(value == '1' || value == 1){
									return "发送成功";
								 }else if(value == '0' || value == 0){
									return "发送失败";
								 }
							}
						},
						{ field: 'userName', title: '<span class="txtcenter">操作员</span>', width: 120},
						{ field: 'createTime', title: '<span class="txtcenter">发送时间</span>', width: 200,formatter:fotmateDate},
						{ field: 'zuNumber', title: '<span class="txtcenter">组号码</span>', width: 120,},
				        { field: 'userMode', title: '<span class="txtcenter">用户模板</span>', width: 120}
				    ]],
				    onLoadSuccess:function(data){
				        $(".txtcenter").parent().parent().css("text-align","center");
				    },
				    onDblClickRow :function(rowIndex,rowData){
				    	details(rowData);
				   	}
			});
		 
		});
	});
	
	
//取消
function quxiao(){
	$("#sendMesBox").dialog('close');
};

//短信发送的方法
var url;
function sendMess(){
	
	$("#fitemPassword").show();
    $('#sendMesBox').dialog('open').dialog('setTitle',' ');
    $('#fm').form('clear');
    $('#ftitle').html("短信发送");
	<%-- url: "<%=basePath%>framework/order/sendMessToUser.action"; --%>
    
}

//发送的方法
function sendTo(){
	var newphoneNums = $("#phoneNumList").val();
	var text = $("#textareaText").val();
	if(newphoneNums!=""&&newphoneNums!=null){
		$.ajax({
                  type: "POST",
                  data:{"phoneNumList":newphoneNums,"text":text},
                  dataType: 'json',
                  url: '<%=basePath%>framework/order/sendMessToUser.action',
                  success: function (data) {
                   		if (data.mess == 1) {
                       		alert("信息成功发送");                           		
                       		$("#phoneNumList").text("");
                       		$("#textareaText").val("");
                       		$("#sendMesBox").css("display","none");
                       		window.location.reload();
						}else {
							$("#sendMesBox").css("display","none");
                       	 	alert("信息发送失败");
                       	 	window.location.reload();
                        }
                  }
       });
    }else{
    	alert("请输入手机号码");
    }
}
function fotmateDate(value){
	var dateStr = "";
	if(value=="undefined"||value=="null"||value==null){}else{
		var date = new Date(value);
		dateStr = date.format("yyyy-MM-dd HH:mm:ss");
	}
    return dateStr;    
}

 function loadBtn(btnstr){
			var oldbtnstr = "11-0,11-1";
			var szBtnstr = oldbtnstr.split(",");
			var delBtnstr = "";
			for(var i=0; i<szBtnstr.length; i++){
				if(btnstr.indexOf(szBtnstr[i])>=0){
					if(szBtnstr[i]=="11-0"){
						return false;
					}else if(szBtnstr[i]=="11-1"){
						$("#findBox").remove();
						return false;
					}
				}
			}
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

	function details(rows){ 
		$("#lookReason").html("");
		var lookReason = rows.phoneNumber;
		alert(lookReason);
		var rs = lookReason.split(",");
		for(var i=0; i<rs.length; i++){
			var listyle = '<li style="overflow:hidden; padding:5px 0px; font-size:15px; text-align:center;"><span>'+(i+1)+'、</span><span>'+rs[i]+'</span></li>';
			$("#lookReason").append(listyle);
		}
		$('#LookErrorInfo').dialog('open').dialog('setTitle','接收的手机');
	}
</script>
</body>
</html>