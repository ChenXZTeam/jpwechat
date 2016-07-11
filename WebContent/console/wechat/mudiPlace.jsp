<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>深圳-->北京</title>
<style>
	*{padding:0px;margin:0px;}
	body{text-align:center; font-size:14px; font:normal Helvetica, Arial, sans-serif; background-color:#ffffff; font-family:Microsoft JhengHei;}
	ul{list-style-type:none;}
	ul li{overflow:hidden;}
	.time .timeDiv{line-height:40px; color:#007AFF; font-weight:bold;}
	.time .timeDiv a:hover{cursor:pointer;}
	.tjTicket{border-bottom:#E0E0E0 solid 1px;}
	.tjTicket .tuijianImg{width:}
	.tjTicket .hanban{text-align:left; margin-left:5%;}
	.tjTicket .hanban .hanbanName,.tjTicket .hanban .hanbanCompany{height:35px;}
	.tjTicket .hanban .hanbanName span{color:#666666;}
	.tjTicket .hanban .hanbanCompany span{color:#C7C7C7;}
	.tjTicket .tuijianLan{height:70px;float:left;}
	.tjTicket .money{text-align:right; float:right; margin-right:10px;}
	.tjTicket .money .moneyPay,.tjTicket .money .zhekouPay{height:35px;}
	.tjTicket .money .zhekouPay{color:#c7c7c7;}
	.notTjTicket{padding-top:13px; height:70px; border-bottom:#E0E0E0 solid 1px;}
	.notTjTicket .lineHeight{line-height:25px;}
	.notTjTicket .StartTimeEnd{width:60px; float:left; margin-left:20px;}
	.notTjTicket .StartTimeEnd .StartTime{color:#666666;}
	.notTjTicket .StartTimeEnd .EndTime{color:#c7c7c7;}
	.notTjTicket .StartAndEnd{float:left; text-align:left; margin-left:5%;}
	.notTjTicket .StartAndEnd .StartJC span{color:#666666;}
	.notTjTicket .StartAndEnd .EndTJC span{color:#c7c7c7;}
	.notTjTicket .moneyAndTicket{text-align:right; float:right; margin-right:10px;}
	.notTjTicket .moneyAndTicket .zuowei{color:#c7c7c7;}
</style>
<script src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script>
$(function(){
	
	var tjTicket=1;//推荐的机票
	if(tjTicket==1){
		var tjList='<li class="tjTicket"><div class="tuijianImg tuijianLan"><img src="<%=basePath %>console/images/tuijianImg.jpg" /></div><div class="hanban tuijianLan"><div class="hanbanName"><span style="line-height:40px;">深圳-->北京</span></div><div class="hanbanCompany"><span style="line-height:20px;">HU7710 海南航空</span></div></div><div class="money tuijianLan"><div class="moneyPay"><span style="line-height:35px; color:#FF8201;">￥806起</span></div><div class="zhekouPay"><span style="line-height:20px; font-size:12px;">4.5折</span></div></div><div style="clear:both;"></div></li>';
		$("#TicketList").append(tjList);
	}
	
	//航班列表
	for(var i=0;i<5;i++){
		var notTjList='<li class="notTjTicket"><div class="StartTimeEnd"><div class="StartTime lineHeight">07:25</div><div class="EndTime lineHeight">10:30</div></div><div class="StartAndEnd"><div class="StartJC lineHeight"><img src="<%=basePath %>console/images/shi.jpg" style="float:left;"/><span style="float:left;">宝安机场 A323</span></div><div style="clear:both;"></div><div class="EndTJC lineHeight"><img src="<%=basePath %>console/images/zhong.jpg" style="float:left;"><span style="float:left;">首都机场 3时05分</span></div></div><div class="moneyAndTicket"><div class="money lineHeight" style="color:#FF8201;">￥953</div><div class="zuowei lineHeight" style="font-size:12px;">二等座436张</div></div><div style="clear:both;"></div></li>';
		$("#TicketList").append(notTjList);
	}
	
});
</script>
</head>

<body>
<ul id="TicketList">
	<li class="time" style="border-bottom:#E0E0E0 solid 1px; background-color:#F8F8F8; height:40px;">
		<div class="timeDiv" style="float:left; width:25%; "><a>< 前一天</a></div>
		<div class="timeDiv" style="float:left; width:35%; text-align:right;">12月19日 周三</div>
		<div class="timeDiv" style="float:left; width:15%; text-align:left;">明天▼</div>
		<div class="timeDiv" style="float:left; width:25%; "><a>后一天 ></a></div>
		<div style="clear:both;"></div>
	</li>
	
	<!--推荐机票-->

	
	<!--航班列表-->
	
	
</ul>
</body>
</html>
