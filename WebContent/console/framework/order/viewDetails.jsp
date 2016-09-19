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
<title>查看详情</title>
<script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
</head>
<body>

</body>
<script>
$(function(){
	var jsonstr = '<%=str%>';
	 var obj = JSON.parse(jsonstr);
	 console.log(obj);
});
</script>
</html>