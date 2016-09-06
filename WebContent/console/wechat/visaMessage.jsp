<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
    
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>签证信息</title>
<link type="text/css" rel="stylesheet" href="<%=basePath %>console/css/banner.css"/>
<script type="text/javascript"  src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/banner.js"></script>
<style type="text/css">
	body{padding:0px; margin:0px; background-color:#F9F9F9;}
	#bigContent{padding:0px;}
	#find{padding:10px 10px 5px 10px; text-align:center;}
	#xFind{border-radius:5px; background-color:#FFFFFF;}
	#xFind .inputName,.inputDiv{padding:10px; overflow:hidden; float:left;}	
	#xFind img,span,input{float:left; outline:none;}
	.qzBackImg{margin-top:0px;}
	.cityTitle{margin-top:10px; padding:5px 10px 5px 0px; font-size:15px; color:#666666; background-color:#FFFFFF; font-family:Microsoft YaHei; border-bottom:solid 1px #DCDCDC;}
	.dazhou{ background-color:#FFFFFF; border-bottom:#DCDCDC solid 1px; padding-top:10px; padding-bottom:10px;}
	.dazhou .float{width:18%; float:left; text-align:center; padding:10px 0px; margin-left:5%; cursor:pointer; -webkit-tap-highlight-color:rgba(255,255,255,0);}
	.dazhou .float span{ margin-left:auto; margin-right:auto; color:#B6B6B6; width:100%; font-size:14px; margin-top:10px; display:block;}
	.dazhou .float img{ margin-left:auto; margin-right:auto; display:block; width:30px;}
	#controy{padding:0px; background-color:#ffffff;}
	#controy ul{padding:10px 0px; margin:0px; list-style-type:none; overflow:hidden;}
	#controy ul li{border:1px solid #F5F5F5;float:left; margin:1% 2.1%; border-radius:6px; background-color:#F5F5F5; color:#B6B6B6; text-align:center; font-size:14px; padding:6px 3px; width:18%; cursor:pointer; -webkit-tap-highlight-color:rgba(255,255,255,0);}
	.qianZ{padding:5px; background-color:#FFFFFF;}
	.qianZ .sessce{padding:20px; border-right:#DCDCDC solid 1px; float:left; text-align:center;}
	.qianZ .jindu{padding:20px; float:left;}
</style>
</head>

<body>
<div id="bigContent">
	<!--查找地址-->
	<div id="find">
		<div id="xFind">
			<div class="inputName" style="border-right:#F0EFF4 solid 1px;"><img src="<%=basePath %>console/images/dingwei.gif"><span style="color:#0278FC; margin-left:5px; line-height:20px; font-weight:bold;">广东</span></div>
			<div class="inputDiv"><input type="text" style="font-size:14px; color:#666666; border:none;"  placeholder="你想去哪儿？"/></div>
			<div style="clear:both;"></div>
		</div>
	</div>
	
	<!--轮播图-->
	<div class="qzBackImg">
		<div class="banner"> 
		  <div class="b-img">
			<div class="runDiv"><img src="<%=basePath %>console/images/banner0.jpg" style="width:100%;"/></div>
			<div class="runDiv"><img src="<%=basePath %>console/images/banner1.jpg" style="width:100%;"/></div>
			<div class="runDiv"><img src="<%=basePath %>console/images/banner2.jpg" style="width:100%;"/></div>
		  </div>
		
		  <div class="b-list"></div>
			<!--
		  <a class="bar-left" href="#"><em></em></a>
		  <a class="bar-right" href="#"><em></em></a> 
		  --->
		<!--end 全屏滚动-->
		</div> 
	</div>
	
	<!--热门国家地区标题-->
	<div class="cityTitle">
		<div style="background-color:#0079FE; width:5px; height:20px; float:left;"></div>
		<div style="line-height:20px; margin-left:5px; float:left;"><span>热门国家/地区</span></div>
		<div style="line-height:20px; float:right;">＞</div>
		<div style="line-height:20px; float:right;"><span>更多热门</span></div>
		<div style="clear:both;"></div>
	</div>
	
	<!--热门大洲-->
	<div class="dazhou">
		<div class="float"><img src="<%=basePath %>console/images/qiuMap02.gif"/><span style="color:#007AFF;">亚洲</span></div>
		<div class="float" style="padding:6px 0px;"><img src="<%=basePath %>console/images/meizhou01.gif"/><span>美洲</span></div>
		<div class="float"><img src="<%=basePath %>console/images/feizhou01.gif"/><span>非洲</span></div>
		<div class="float"><img src="<%=basePath %>console/images/ouzhou01.png"/><span>欧洲</span></div>
		<div style="clear:both"></div>
	</div>
	
	<!--热门国家-->
	<div id="controy">
		<ul>
			<li>泰国</li>
			<li>美国</li>
			<li>日本</li>
			<li>新加坡</li>
			<li>台湾</li>
			<li>马来西亚</li>
			<li>菲律宾</li>
			<li>韩国</li>
		</ul>
		<div style="clear:both;"></div>
	</div>
	
	<!--签证亮点-->
	<div class="qianZ">
		<div class="sessce"><span style="color:#B6B6B6; font-size:15px; font-family:Microsoft YaHei; display:block; width:100%;">签证成功率</span><span style="width:100%; color:#017CFE; display:block; font-family:Microsoft YaHei; ">99.8%</span></div>
		<div class="jindu"><img src="<%=basePath %>console/images/qianzImg.png" style="float:left; width:20px; margin-top:3px;"/><span style=" width:60px; color:#B6B6B6; font-size:13px; margin-left:10px; font-family:Microsoft YaHei; float:left;">签证进度查询</span></div>
		<div style="clear:both;"></div>
	</div>
</div>

<script type="text/javascript">
	$(".float").click(function(){
		resetImg();
		if($(this).children("span").text()=="亚洲"){
			$(this).children("img").attr("src","<%=basePath%>console/images/qiuMap02.gif");
			$(this).children("span").css("color","#007AFF");			
		}else if($(this).children("span").text()=="美洲"){
			$(this).children("img").attr("src","<%=basePath%>console/images/meizhou02.png");
			$(this).children("span").css("color","#007AFF");
		}else if($(this).children("span").text()=="非洲"){
			$(this).children("img").attr("src","<%=basePath%>console/images/feizhou02.gif");
			$(this).children("span").css("color","#007AFF");
		}else if($(this).children("span").text()=="欧洲"){
			$(this).children("img").attr("src","<%=basePath%>console/images/ouzhou02.png");
			$(this).children("span").css("color","#007AFF");
		}
	});
	
	//图片恢复成灰色的样式
	function resetImg(){
		$(".float").eq(0).children("img").attr("src","<%=basePath%>console/images/qiuMap01.gif");
		$(".float").eq(0).children("span").css("color","#B6B6B6");	
		$(".float").eq(1).children("img").attr("src","<%=basePath%>console/images/meizhou01.gif");
		$(".float").eq(1).children("span").css("color","#B6B6B6");	
		$(".float").eq(2).children("img").attr("src","<%=basePath%>console/images/feizhou01.gif");
		$(".float").eq(2).children("span").css("color","#B6B6B6");	
		$(".float").eq(3).children("img").attr("src","<%=basePath%>console/images/ouzhou01.png");
		$(".float").eq(3).children("span").css("color","#B6B6B6");	
	}
</script>
</body>
</html>
