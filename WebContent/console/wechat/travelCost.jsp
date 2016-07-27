<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta  http-equiv="Content-Type"; content="text/html"; charset="utf-8"/>
<meta  name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.maximum-scale=1,user-scalable=no">
	<title>行李须知</title>
	<link rel="stylesheet" type="text/css" href="">
	<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="js/TravelBanner.js"></script>
	
</head>
<body  style="background-image:url(<%=basePath %>console/images/xingliImg.gif)";>
	<div class="bigcontent">
	
		<div>
			<div>
				<div >
				<!-- <img  src="xingliImg.gif"> -->
					<div >
						<div  style="padding-top:10%;text-align:center";>
							<span style="color:#CB160F;">国内航班</span>
							<span style="color:#F2CE09;">行李规定</span><br/>
							<span style="color:#09608A;">转起留存</span>
						</div>
						<div>
							<span style="color:#C70901">托运行李限额</span><br/>
							<span  style="text-align:left">①每件托运行李不得低于2公斤</span><br/>
							<span style="text-align:left">②每件托运的行李的最大重量不得超过45公斤</span><br/>
							<span style="text-align:left">③每件托运行李的长、宽、高之和不得超过203厘米，不得小于60厘米。</span>
						<br/>
						</div>
						<div>
							<span  style="color:#C70901;">免费托运行李限额:</span><br/>
							<span style="color:##A7E7FF">重量：20公斤</span><br/>
							<span style="color:#A7E7FF">大小：100×40×40（单位：厘米）</span><br/>
							<span style="color:#A7E7FF">随行行李限重</span><br/>
							<span style="color:#A7E7FF">5公斤（一件）</span>
							<span style="color:#A7E7FF">大小：55×40×20（单位：厘米）</span><br/>
						</div>
						
					</div>
					
					
				</div>
			</div>
		</div>
		<!-- <div  class="imagesb" style="clear:both"><img  src="xingliImg.gif"></div> -->
	</div>

</body>
</html>
