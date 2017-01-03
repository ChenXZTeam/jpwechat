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
<link type="text/css" rel="stylesheet" href="<%=basePath %>console/css/swiper.min.css?time=222"/>
<script type="text/javascript" src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/jquery.touchSwipe.min.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/TravelBanner.js?time=22"></script>
<script type="text/javascript" src="<%=basePath%>console/js/swiper.min.js"></script>
<style>
	html,body{padding:0px; margin:0px; height:100%}
	.bigcontent{width:100%; height:100%;}
	.bigcontent .contentText{height:100%;margin-left:auto; margin-right:auto; text-align:left; font-size:37px; font-family:Microsoft YaHei,"微软雅黑",MicrosoftJhengHei,"华文细黑",STHeiti,MingLiu;}
	.bigcontent .contentText>.banner{height:100%;}
	.bigcontent .contentImg{position:fixed; /*or前面的是absolute就可以用*/ bottom:0px;}
	.swiper-container {width: 360px; height:100%; margin: 0px;}
    .swiper-slide {text-align: center; font-size: 18px; mbackground: #fff; display: -webkit-box; display: -ms-flexbox; display: -webkit-flex; display: flex; -webkit-box-pack: center; -ms-flex-pack: center; -webkit-justify-content: center; justify-content: center; -webkit-box-align: center; -ms-flex-align: center; -webkit-align-items: center; align-items: center;}
</style>
<script>
$(function(){
	var swiper = new Swiper('.swiper-container', {
	    pagination: '.swiper-pagination',
	    paginationClickable: true,
	    spaceBetween: 30,
	    //autoplay: 3000,//可选选项，自动滑动
	});
})
</script>
</head>

<body>
<%-- <div class="bigcontent">
	<div class="contentText">
		<div class="banner"> 
		  <div class="b-img">
			<div class="runDiv"><img src="<%=basePath%>console/images/travelImg_1.jpg" style="width:100%;"/></div>
			<div class="runDiv"><img src="<%=basePath%>console/images/travelImg_2.jpg" style="width:100%;"/></div>
			<div class="runDiv"><img src="<%=basePath%>console/images/travelImg_3.jpg" style="width:100%;"/></div>
		  </div>
		  <div class="b-list" style="margin-top:210px;"></div>
		</div>
	</div>
</div> --%>
<div class="swiper-container">
        <div class="swiper-wrapper">
            <div class="swiper-slide"><img src="<%=basePath%>console/images/travelImg_1.jpg" style="width:100%;"/></div>
            <div class="swiper-slide"><img src="<%=basePath%>console/images/travelImg_2.jpg" style="width:100%;"/></div>
        	<div class="swiper-slide"><img src="<%=basePath%>console/images/travelImg_3.jpg" style="width:100%;"/></div>
        </div>
        <div class="swiper-pagination"></div>
</div>
</body>
</html>
