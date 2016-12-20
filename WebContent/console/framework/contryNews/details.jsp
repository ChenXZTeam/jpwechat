<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String str = new String(request.getParameter("str").getBytes("ISO-8859-1"),"utf-8");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>查看国内资讯详情</title>
<script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
<style>
	.titleStyle{width:120px;}
	table{border-right:#ccc solid 1px; border-bottom:#ccc solid 1px;}
	table tr td{_height:40px; padding:15px; font-size:#666666; font-size:14px; padding-left:15px; border:1px solid #ccc; border-bottom:none; border-right:none;}
	.contTextStyle{color:#777;}
</style>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" width="1000">
	<tr>
		<td class="titleStyle">文章标题：</td>
		<td class="contTextStyle title"></td>
		
	</tr>
	<tr>
		<td>文章内容：</td>
		<td class="contTextStyle info"></td>
	
	</tr>
	
</table>

</body>
<script>
$(function(){
	 var jsonstr = '<%=str%>';
	 var obj = JSON.parse(jsonstr);
	 console.log(obj);
	 $(".title").text(obj.title);
	 $(".info").text(obj.info);
	
});
</script>
</html>