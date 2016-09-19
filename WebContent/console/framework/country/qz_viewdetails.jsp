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
<title>查看详情_国家</title>
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
		<td class="titleStyle">国家名：</td>
		<td class="contTextStyle countryName"></td>
		<td class="titleStyle">所属区域：</td>
		<td class="contTextStyle countryArea"></td>
	</tr>
	<tr>
		<td>有效期限：</td>
		<td class="contTextStyle youxiaoTime"></td>
		<td>办理时长：</td>
		<td class="contTextStyle banliLongTime"></td>
	</tr>
	<tr>
		<td>入境次数：</td>
		<td class="contTextStyle rujinTime"></td>
		<td>逗留天数：</td>
		<td class="contTextStyle douliuDay"></td>
	</tr>
	<tr>
		<td>是否推荐热门：</td>
		<td class="contTextStyle shifouRM"></td>
		<td>签证政策：</td>
		<td class="contTextStyle qzZhengce"></td>
	</tr>
	<tr>
		<td>最早可定日期：</td>
		<td class="contTextStyle canDingTime"></td>
		<td>签证类型：</td>
		<td class="contTextStyle qzType"></td>
	</tr>
	<tr>
		<td>签证价格：</td>
		<td colspan="3" class="contTextStyle moneyCost" style="font-size:16px; color:#f00; font-weight:bold;"></td>
	</tr>
	<tr>
		<td>受理范围：</td>
		<td colspan="3" class="contTextStyle shouliArea"></td>
	</tr>
	<tr>
		<td>办理流程：</td>
		<td colspan="3" class="contTextStyle banliLC"></td>
	</tr>
	<tr>
		<td>服务内容：</td>
		<td colspan="3" class="contTextStyle serviceCont"></td>
	</tr>
	<tr>
		<td>风景介绍：</td>
		<td colspan="3" class="contTextStyle fengjText"></td>
	</tr>
</table>

</body>
<script>
$(function(){
	 var jsonstr = '<%=str%>';
	 var obj = JSON.parse(jsonstr);
	 console.log(obj);
	 $(".countryName").text(obj.country);
	 $(".countryArea").text(obj.cotryBelongWhat);
	 $(".youxiaoTime").text(obj.periodOfValidity); //有效期限
	 $(".banliLongTime").text(obj.elapsedTime); //办理时长
	 $(".rujinTime").text(obj.immigrationOfTimes); //入境次数
	 $(".douliuDay").text(obj.sojournTime); //逗留天数
	 $(".shifouRM").text(obj.remenContry); //是否推荐热门
	 $(".qzZhengce").text(obj.qzMode); //签证政策
	 $(".canDingTime").text(obj.earlyDates); //最早可定日期
	 $(".qzType").text(obj.visaType); //签证类型
	 $(".moneyCost").text("￥"+obj.visaPrice); //签证价格
	 $(".shouliArea").text(obj.scopeOfAcceptance); //受理范围
	 $(".banliLC").text(obj.immigrationFlow+"会计师的恢复健康复活卡死机货到付款喀什地方哈萨克的风景好看杀得快放假哈开始的分开就爱好是打飞机阿克苏的复活卡啥地方看见爱上对方卡斯加对方会卡死地方看见爱上对方卡上的发挥"); //办理流程
	 $(".serviceCont").text(obj.serviceContent); //服务内容
	 $(".fengjText").text(obj.touryIntro); //风景介绍
});
</script>
</html>