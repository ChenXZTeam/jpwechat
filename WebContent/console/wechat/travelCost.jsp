<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type";content="text/html";charset="utf-8"/>
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.maximum-scale=1,user-scalable=no"/>
<title>行李须知</title>
<link rel="stylesheet" type="text/css" href="<%=basePath %>console/css/TravelBanner.css"/>
<script type="text/javascript" src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/jquery.touchSwipe.min.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/TravelBanner.js"></script>
<style>
	body{padding:0px; margin:0px;}
	.bigcontent{}
	.bigcontent .contentText{width:95%; margin-left:auto; margin-right:auto; text-align:left; font-size:37px; font-family:Microsoft YaHei,"微软雅黑",MicrosoftJhengHei,"华文细黑",STHeiti,MingLiu;}
	.bigcontent .contentImg{position:fixed; /*or前面的是absolute就可以用*/ bottom:0px;}
</style>

</head>

<body>
<div class="bigcontent">
	<div class="contentText">
		<div class="banner"> 
		  <div class="b-img">
			<div class="runDiv" style="padding-top:10%; text-align:center;">
				<p style="color:#CB160F;margin-top:-68px;font-size:42px;" >国内航班</p>
				<p style="color:#F2CE09;margin-top:40px;font-size:31px;" >1、行李规定</p>
				<p style="color:#09608A;margin-top:40px;font-size:31px;" >2、转起留存</p>
			</div>
			
			<div class="runDiv">
				<span style="color:#C70901;  font-size:25px; line-height:80px;">托运行李限额:(须知)</span><br/>
				<span style="font-size:15px; text-align:left; color:#666666; line-height:35px;">①每件托运行李不得低于2公斤</span><br/>
				<span style="font-size:15px; text-align:left; color:#666666; line-height:35px;">②每件托运的行李的最大重量不得超过45公斤</span><br/>
				<span style="font-size:15px; text-align:left; color:#666666; line-height:35px;">③每件托运行李的长、宽、高之和不得超过203厘米，不得小于60厘米。</span><br/>
			    
			</div>
			
			<div class="runDiv">
				
				<span style="color:#C70901; font-size:25px; line-height:80px;">免费托运行李限额:(须知)</span><br/>
			    <span style="font-size:15px; text-align:left; color:#666666; line-height:10px;">重量：20公斤</span><br/>
				<span style="font-size:15px; text-align:left; color:#666666; line-height:40px;">大小：100×40×40（单位：厘米）</span><br/>
				<span style="color:#C70901; font-size:25px; line-height:80px;">随行行李限重:(须知)</span><br/>
				<span style="font-size:15px; text-align:left; color:#666666; line-height:10px;">5公斤（一件）</span><br/>
				<span style="font-size:15px; text-align:left; color:#666666; line-height:40px;">大小：55×40×20（单位：厘米）</span><br/>
			</div>
		  </div>
		
		  <div class="b-list" style="margin-top:210px;"></div>
		  <!-- <a class="bar-left" href="#"><em></em></a>
		  <a class="bar-right" href="#"><em></em></a> -->
		<!--end 全屏滚动-->
		</div>
		
	</div>
	<div style="clear:both;"></div>
	<div class="contentImg"><img src="<%=basePath %>console/images/xingliImg.gif" style="width:100%; height:auto;"/></div>
	<div style="clear:both;"></div>

</div>
</body>
</html>
