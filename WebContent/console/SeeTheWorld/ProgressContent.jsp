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
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css">
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/jquery.min.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<title>Insert title here</title>
<style type="text/css">
	#dd label{
		margin-left:20px;
	}
</style>
<script type="text/javascript">
	$(function(){
		if('<%=visaOrder.getProgress()%>'=='签证完成'){
			$('#p').progressbar('setValue', 100);
		}else{
			$('#p').progressbar('setValue', 50);
		}		
	})
</script>
</head>
<body>
	<div id="dd">
		<label>提交订单</label>
		<label>处理中</label>
		<label>签证成功</label>
	</div>
	<div id="p" class="easyui-progressbar" style="width:400px;"></div> 
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
			<td><%=visaOrder.getContactsName() %></td>
		</tr>
	</table>	
</body>
</html>