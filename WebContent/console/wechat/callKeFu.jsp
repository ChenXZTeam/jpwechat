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
<title>在线客服</title>
<style>
	body{padding:0px; margin:0px; font-size:12px; font-family:Microsoft YaHei;}
	#bigContent{ padding:10px; margin-top:25px;}
	#bigContent .kefuImg{ float:left; padding:10px;}
	#bigContent .jiantou{position:absolute; top:60px; left:60px; z-index:100;}
	#bigContent .textMsg{ width:70%; float:left; border:#E1DFE0 solid 1px; border-radius:5px; background-color:#FDFFFE; padding:20px 10px 10px 10px;}
	#bigContent .textMsg .zixun{ color:#666666;}
	#bigContent .textMsg .zixun span{display:block; line-height:20px;}
	#bigContent .textMsg ul{ overflow:hidden; padding:0px; margin:0px; list-style-type:none;}
	#bigContent .textMsg ul li{padding-top:10px; padding-bottom:5px; border-bottom:1px solid #E1DFE0; overflow:hidden;}
	#bigContent .textMsg ul li:last-child{border:none;} /*去掉最后一个<li>的下划线*/
	#bigContent .textMsg ul li span{float:left; color:#007AFE;}
</style>
</head>

<body>
	<div id="bigContent">
		<div class="kefuImg"><img src="<%=basePath %>console/images/kefu_03.png" style="width:40px;"></div>
		<div class="jiantou"><img src="<%=basePath %>console/images/jiantou_03.png"/></div>
		<div class="textMsg">
			<div class="zixun"><span>您好，我是客服某某，请问有什么需要咨询的吗？某某竭诚为您服务！</span><span>您是想咨询一下问题吗？</span></div>
			<ul>
				<li>
					<span>怎么取票</span>
					<span style="color:#C5C6C8; font-weight:bold; float:right;">＞</span>
				</li>
				<li>
					<span>怎么查看订单</span>
					<span style="color:#C5C6C8; font-weight:bold; float:right;">＞</span>
				</li>
				<li>
					<span>名字选错了怎么办</span>
					<span style="color:#C5C6C8; font-weight:bold; float:right;">＞</span>
				</li>
				<li>
					<span>退机票</span>
					<span style="color:#C5C6C8; font-weight:bold; float:right;">＞</span>
				</li>
				<li>
					<span>申请机票改期</span>
					<span style="color:#C5C6C8; font-weight:bold; float:right;">＞</span>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>
