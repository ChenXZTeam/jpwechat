<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>飞机机型</title>
<style>
	*{padding:0px; margin:0px;}
	body{text-align:center; font:normal Helvetica, Arial, sans-serif; background-color:#F9F9F9; font-family:Microsoft JhengHei;}
	#bigTable{width:100%; border:none; text-align:center; margin-left:auto; margin-right:auto; font-size:14px;}
	.title{height:40px; background-color:#E3E3E3;}
	.title td{border-bottom:#B7B7B7 solid 1px;}
	.cententTR{height:40px;}
	.cententTD{border-bottom:#E3E3E3 solid 1px;}
</style>
<script src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script>
	$(function(){
		for(var i=0;i<8;i++){
			$("#bigTable").append("<tr class='cententTR'><td class='cententTD'>空客A320</td><td class='cententTD'>大型飞机</td><td class='cententTD'>空中客车A320</td><td class='cententTD'>约180人</td></tr>");
		}
	});
</script>
</head>

<body>
<table id="bigTable" cellpadding="0" cellspacing="0">
	<tr class="title">
		<td>机号</td>
		<td>机型</td>
		<td>飞机名称</td>
		<td>飞机容量</td>
	</tr>
</table>
</body>
</html>
