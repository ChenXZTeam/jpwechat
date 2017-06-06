<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>CTCT项设置</title>
	<script type="text/javascript" src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
</head>
<body>
<script>
$(function(){
	$.ajax({
        type: "POST",
        url: "<%=basePath%>framework/ctct/numList.action",
        data: {},
        dataType: "json",
        success: function(data){
        	$("#uuid").text(data[0].uuid);
        	$("#oldNum").text(data[0].phoneNum);
        }
   });
});

function updateCode(){
	var uuid = $("#uuid").text();
	var oldNum = $("#newsNum").val();
	$.ajax({
        type: "POST",
        url: "<%=basePath%>framework/ctct/update.action",
        data: {"uuid":uuid,"phone":oldNum},
        dataType: "json",
        success: function(data){
        	if(data == "1"||data==1){
        		window.location.reload();
        	}else{
        		alert("修改失败");
        	}
        	 
        },error:function(){

        }
   });
}
</script>
<table style="width:100%; margin-top:100px;" border="0"  cellspacing="10">
	<tr>
		<td style="width:30%;"><span id="uuid" style="display:none;"></span></td>
		<td><span style="font-size:18px; font-weight:bold;">当前CTCT：</span></td>
		<td><span id="oldNum" style="font-size:14px; color:#999999;">13678546895</span></td>
	</tr>
	<tr>
		<td></td>
		<td style="width:120px;"><span style="font-size:18px; font-weight:bold;">新CTCT：</span></td>
		<td><input type="text" id="newsNum"/></td>
	</tr>
	<tr>
		<td></td>
		<td><a style="display:block; width:90px; text-align:center; padding:5px; border-radius:5px; background-color:blue; color:#fff; cursor:pointer;" onclick="reset()">重置</a></td>
		<td><a style="display:block; width:90px; text-align:center; padding:5px; border-radius:5px; background-color:blue; color:#fff; cursor:pointer;" onclick="updateCode()">保存</a></td>
	</tr>
</table>
</body>
</html>