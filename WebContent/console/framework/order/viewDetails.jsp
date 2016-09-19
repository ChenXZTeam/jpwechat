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
		<td class="titleStyle">申请人：</td>
		<td class="contTextStyle contactsName"></td>
		<td class="titleStyle">联系电话：</td>
		<td class="contTextStyle contactsPhone"></td>
	</tr>
	<tr>
		<td class="titleStyle">E-mail：</td>
		<td colspan="3" class="contTextStyle contactsEmail"></td>
	</tr>
	<tr>
		<td>性别：</td>
		<td class="contTextStyle contactsSex"></td>
		<td>工作状态：</td>
		<td class="contTextStyle customerType"></td>
	</tr>
	<tr>
		<td>客户类型：</td>
		<td class="contTextStyle trayTypeIpnt"></td>
		<td>申请国家：</td>
		<td class="contTextStyle applyCountry"></td>
	</tr>
	<tr>
		<td>证件编号：</td>
		<td class="contTextStyle idcase"></td>
		<td>预约编号：</td>
		<td class="contTextStyle orderNum"></td>
	</tr>
	<tr>
		<td>支付状态：</td>
		<td class="contTextStyle paystatus"></td>
		<td>支付进度：</td>
		<td class="contTextStyle progress"></td>
	</tr>
	<tr>
		<td>签证价格：</td>
		<td colspan="3" class="contTextStyle moneyCost" style="font-size:16px; color:#f00; font-weight:bold;"></td>
	</tr>
	<tr>
		<td>配送方式：</td>
		<td class="contTextStyle deliveryMethod"></td>
		<td>配送地址：</td>
		<td class="contTextStyle deliveryAddress"></td>
	</tr>
</table>

</body>
<script>
$(function(){
	 var jsonstr = '<%=str%>';
	 var obj = JSON.parse(jsonstr);
	 console.log(obj);
	 $(".applyCountry").text(obj.applyCountry);
	 $(".contactsEmail").text(obj.contactsEmail);
	 $(".contactsName").text(obj.contactsName);
	 $(".contactsPhone").text(obj.contactsPhone);
	 $(".contactsSex").text(obj.contactsSex);
	 $(".customerType").text(obj.customerType);
	 $(".deliveryAddress").text(obj.deliveryAddress);
	 $(".deliveryMethod").text(obj.deliveryMethod);
	 $(".idcase").text(obj.idcase);
	 $(".orderNum").text(obj.orderNum);
	 $(".moneyCost").text("￥"+obj.totalCost);
	 $(".paystatus").text(payP = obj.paystatus==1?"已支付":"未支付"); //支付状态
	 $(".progress").text(proP = obj.progress == 0?"预约中":(obj.progress == 1?"进行中":"已完成"));	//订单进度
	 $(".trayTypeIpnt").text(obj.trayTypeIpnt); //客户类型
});
</script>
</html>