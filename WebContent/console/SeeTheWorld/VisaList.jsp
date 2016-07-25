<%@page import="com.solar.tech.bean.Visa"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	List<Visa> list = (List<Visa>)request.getAttribute("list");
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<table>
		<tr>
			<th>标题</th>
			<th>价格</th>
		<tr>
		<%
			for(Visa visa : list){
		%>
			<tr>
				<td><a href="<%= basePath %>framework/visa/findByID.action?id=<%= visa.getVisaID() %>"><%= visa.getVisaTitle() %></a></td>
				<td><%= visa.getVisaPrice() %></td>
			</tr>
		<%
			}
		%>
	</table>
</body>
</html>