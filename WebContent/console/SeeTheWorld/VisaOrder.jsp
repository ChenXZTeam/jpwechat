<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String visaID = request.getParameter("visaID");
	String visaPrice = request.getParameter("visaPrice");
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/jquery.min.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
	$(function(){
		$("#totalCost").val("<%= visaPrice %>");
		$("#visaID").val("<%= visaID %>");
	});
</script>
</head>
<body>
	<form method="post"  action="<%=basePath %>framework/visa/addVisaOrder.action">
		<table>
			<tr>
				<td>申请人：</td>
				<td><input id="proposer" name="proposer" type="text"></td>
			</tr>
			<tr>
				<td>客户类型：</td>
				<td><input id="customerType" name="customerType" type="text"></td>
			</tr>
			<tr>
				<td>联系人名称：</td>
				<td><input id="contactsName" name="contactsName" type="text"></td>
			</tr>
			<tr>
				<td>联系人电话：</td>
				<td><input id="contactsPhone" name="contactsPhone" type="text"></td>
			</tr>
			<tr>
				<td>联系人邮箱：</td>
				<td><input id="contactsEmail" name="contactsEmail" type="text"></td>
			</tr>
			<tr>
				<td>配送方式：</td>
				<td><input id="deliveryMethod" name="deliveryMethod" type="text"></td>
			</tr>
			<tr>
				<td>配送地址：</td>
				<td><input id="deliveryAddress" name="deliveryAddress" type="text"></td>
			</tr>
			<tr>
				<td>总费用：</td>
				<td><input id="totalCost" name="totalCost" type="text"></td>
			</tr>
			<tr>
				<td></td>
				<td><input id="visaID" name="visaID" type="text" hidden="hidden"></td>
			</tr>
			<tr>
				<td></td>
				<td><input id="submit" name="submit" type="submit" value="提交"></td>
			</tr>
		</table>
	</form>
</body>
</html>