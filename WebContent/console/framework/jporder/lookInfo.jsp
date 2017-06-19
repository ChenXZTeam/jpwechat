<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String uuid = new String(request.getParameter("numds").getBytes("ISO-8859-1"),"utf-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>查看订单详情</title>
	<script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript"src="<%=basePath%>console/js/airCodeVScity.js"></script>
	<style>
		.InfoTypeClass{ padding:10px; background-color:#E0ECFF; color:#0E2D5F; font-weight:bold;}
		.tableClass{ margin-top:15px; border-left:solid 1px #E0ECFF; font-size:14px;}
		.tableClass td{ border-right:solid 1px #E0ECFF; border-bottom:solid 1px #E0ECFF;}
		.titleClass{ font-weight:bold; width:100px; color:#000;}
		.btnClass{padding:5px 50px; background:none; border:1px solid #0099FF; margin-left:10px; cursor:pointer; background:#0099FF; color:#fff; border-radius:5px;}
</style>
</head>
<body>
<table class="tableClass" border="0" cellpadding="8" cellspacing="0" width="100%">
	<tr>
		<td colspan="6" class="InfoTypeClass">主要信息</td>
	</tr>
	<tr>
		<td class="titleClass">订单ID：</td>
		<td colspan="3" id="id"></td>
		<td class="titleClass">订单编号：</td>
		<td id="orderNum"></td>
	</tr>
	<tr>
		<td class="titleClass">出发城市：</td>
		<td id="chufCity"></td>
		<td class="titleClass">到达城市：</td>
		<td id="daodCity"></td>
		<td class="titleClass">航班号：</td>
		<td id="hangbanNum"></td>
	</tr>
	<tr>
		<td class="titleClass">出发日期：</td>
		<td id="chufDate"></td>
		<td class="titleClass">出发时间：</td>
		<td id="chufTime"></td>
		<td class="titleClass">到达时间：</td>
		<td id="daodTime"></td>
	</tr>
	<tr>
		<td class="titleClass">舱位：</td>
		<td id="cabin"></td>
		<td class="titleClass">登机人：</td>
		<td id="linkName"></td>
		<td class="titleClass">联系电话：</td>
		<td id="linkPhoneNum"></td>
	</tr>
	<tr>
		<td class="titleClass">票号：</td>
		<td colspan="3" id="telNum"></td>
		<td class="titleClass">PNR码：</td>
		<td id="pnrNum"></td>
	</tr>
	
	<tr>
		<td class="titleClass">机票费用：</td>
		<td colspan="3" id="costMoney" style="color:#f00; font-size:18px; font-weight:bold;"></td>
		<td class="titleClass">支付状态：</td>
		<td id="stutisPay" style="color:blue; font-weight:bold;"></td>
	</tr>
</table>
<table class="tableClass" border="0" cellpadding="8" cellspacing="0" width="100%">
	<tr>
		<td colspan="6" class="InfoTypeClass">其他订单信息</td>
	</tr>
	<tr>
		<td class="titleClass">出发机场：</td>
		<td id="qishiPlane"></td>
		<td class="titleClass">到达机场：</td>
		<td colspan="3" id="daodPlane"></td>
	</tr>
	<tr>
		<td class="titleClass">延误保险：</td>
		<td id="yanwuBX"></td>
		<td class="titleClass">意外保险：</td>
		<td colspan="3" id="yiwaiBX"></td>
	</tr>
	<tr>
		<td class="titleClass">航空公司：</td>
		<td id="airCode"></td>
		<td class="titleClass">乘客类型：</td>
		<td colspan="3" id="psgType"></td>
	</tr>
</table>
<table class="tableClass" border="0" cellpadding="8" cellspacing="0" width="100%">
	<tr>
		<td colspan="6" class="InfoTypeClass">个人信息</td>
	</tr>	
	<tr>
		<td class="titleClass">会员姓名：</td>
		<td id="userName"></td>
		<td class="titleClass" id="idcaseType">身份证：</td>
		<td id="idcase"></td>
		<td class="titleClass">性别：</td>
		<td id="linkSex"></td>
	</tr>
	<tr>
		<td class="titleClass">出生日期：</td>
		<td id="birthday"></td>
		<td class="titleClass">年龄：</td>
		<td colspan="3" id="age"></td>
	</tr>
</table>
<div style="margin-top:10px; text-align:center;">
	<button id="retrunBtn" class="btnClass" onclick="javascript:history.go(-1)">返回</button>
</div>
<script>
	$(function(){
		<%-- var strRow = '<%=strRow%>'; --%>
		var n = '<%=uuid%>';
		$.post("<%=basePath%>framework/order/findBy.action",{a:n},function(res){
			var obj = JSON.parse(res);
			var s = obj.dateStr[0];
			console.log(s);
			$("#id").text(s.id);
			$("#telNum").text(s.telNum);
			$("#pnrNum").text(s.pnr);
			$("#orderNum").text(s.orderNum);
			$("#chufCity").text(findByCity(s.chufCity));
			$("#daodCity").text(findByCity(s.daodCity));
			$("#hangbanNum").text(s.hangbanNum);
			$("#chufDate").text(s.chufDate);
			$("#chufTime").text(faromTime(s.chufTime));
			$("#daodTime").text(faromTime(s.daodTime));
			$("#cabin").text(s.cabin);
			$("#linkName").text(s.linkName); 
			$("#linkPhoneNum").text(s.linkPhoneNum);
			$("#costMoney").text(s.costMoney);
			$("#stutisPay").text(faromStatuas(s.stutisPay));
			$("#qishiPlane").text(findByplaneName(s.chufCity));
			$("#daodPlane").text(findByplaneName(s.daodCity));
			$("#yanwuBX").text(farom(s.yanwuBX));
			$("#yiwaiBX").text(farom(s.yiwaiBX));
			$("#airCode").text(findByCode(s.hangbanNum.substring(0,2)));
			$("#psgType").text(faromPstMan(s.psgType));
			$("#userName").text(s.userName);
			$("#idcase").text(s.idcase);
			$("#linkSex").text(s.linkSex);
			$("#birthday").text(s.birthday);
			$("#age").text(s.age);
		});
		return;
		
		<%-- $("#retrunBtn").click(function(){
			var oNum = $("#orderNum").text();
			window.location.href="<%=basePath%>console/framework/jporder/up_user.jsp?orderNum="+oNum+"&pnrNo="+pnrNum;
		}); --%>
		
		<%-- $("#upcang").click(function(){
			var oNum = $("#orderNum").text();
			window.location.href="<%=basePath%>console/framework/jporder/up_cang.jsp?orderNum="+oNum+"&pnrNo="+pnrNum;
		}); --%>
	});
	
	function farom(fr){
		return fr==1?"购买":"不购买";
	}
	
	function faromStatuas(fr){
		return fr==1?"已支付":"未支付";
	}
	
	function faromPstMan(fr){
		if(fr=="ADT"){
			return "成人";
		}else if(fr=="CHD"){
			return "儿童";
		}else if(fr=="INF"){
			return "婴儿";
		}
	}
	
	function faromTime(fr){
		return fr.substring(0,2)+":"+fr.substring(2,4);
	}
</script>
</body>
</html>