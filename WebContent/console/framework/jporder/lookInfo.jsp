<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String strRow = new String(request.getParameter("strRow").getBytes("ISO-8859-1"),"utf-8");
//System.out.println(strRow);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>查看订单详情</title>
	<script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
	<style>
		.InfoTypeClass{ padding:10px; background-color:#E0ECFF; color:#0E2D5F; font-weight:bold;}
		.tableClass{ margin-top:15px; border-left:solid 1px #E0ECFF; font-size:14px;}
		.tableClass td{ border-right:solid 1px #E0ECFF; border-bottom:solid 1px #E0ECFF;}
		.titleClass{ font-weight:bold; width:100px; color:#000;}
		.btnClass{padding:5px 15px; background:none; border:1px solid #0099FF; margin-left:10px; cursor:pointer;}
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
<div style="margin-top:10px; text-align:center;"><button id="upcang" class="btnClass" style="background-color:#0099FF; color:#fff;">同舱改期</button><button id="upuser" class="btnClass">修改资料</button></div>
<script>
	$(function(){
		var strRow = '<%=strRow%>';
		var obj = JSON.parse(strRow);
		var pnrNum=obj.pnr;
	 	for(var key in obj) {
		    //遍历对象，k即为key，obj[k]为当前k对应的值
		    //console.log("key:"+key+"/ value:"+obj[key]);
		    var value = obj[key];
		    if(key=="cabin"){value=obj[key]+"舱";} //格式化舱位
		    if(key=="costMoney"){value="￥"+obj[key];} //格式化价格
		    if(key=="stutisPay"){
		    	if(value=="0"){value="未支付"; $("#upcang").css("display","none");}else if(value=="1"){value="已支付";}else{value="出错";}
		    }//格式化支付状态
		    if(key=="airCode"){
		    	if(value="CZ"){}
		    	value="南方航空";
		    } //格式化航空公司
		    if(key=="idcaseType"){value=value+"：";} //格式化证件类型
		    if(key=="age"){value=value+"岁";}
		    $("#"+key).text(value);
		}
		
		$("#upuser").click(function(){
			var oNum = $("#orderNum").text();
			window.location.href="<%=basePath%>console/framework/jporder/up_user.jsp?orderNum="+oNum+"&pnrNo="+pnrNum;
		});
		
		$("#upcang").click(function(){
			var oNum = $("#orderNum").text();
			window.location.href="<%=basePath%>console/framework/jporder/up_cang.jsp?orderNum="+oNum+"&pnrNo="+pnrNum;
		});
	});
</script>
</body>
</html>