<%@ page import="com.solar.tech.bean.VisaOrder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    VisaOrder visaOrder = (VisaOrder)request.getAttribute("visaOrder");
%>     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/jquery.min.js"></script>
</head>
<body>
	<table>
		<tr>
			<td>签证产品名:</td>
			<td><%=visaOrder.getVisaTitle() %></td>
		</tr>
		<tr>
			<td>订单ID:</td>
			<td><%=visaOrder.getVisaOrderID() %></td>
		</tr>
		<tr>
			<td>申请人:</td>
			<td><%=visaOrder.getProposer() %></td>
		</tr>
		<tr>
			<td>客户类型:</td>
			<td><%=visaOrder.getCustomerType() %></td>
		</tr>
		<tr>
			<td>联系人名称:</td>
			<td><%=visaOrder.getContactsName() %></td>
		</tr>
		<tr>
			<td>联系人电话:</td>
			<td><%=visaOrder.getContactsPhone() %></td>
		</tr>
		<tr>
			<td>联系人邮箱:</td>
			<td><%=visaOrder.getContactsEmail() %></td>
		</tr>
		<tr>
			<td>配送方式</td>
			<td><%=visaOrder.getDeliveryMethod() %></td>
		</tr>
		<tr>
			<td>配送地址</td>
			<td><%=visaOrder.getDeliveryAddress() %></td>
		</tr>
		<tr>
			<td>总费用:</td>
			<td><%=visaOrder.getTotalCost() %></td>
		</tr>
	</table>
</body>
</html>