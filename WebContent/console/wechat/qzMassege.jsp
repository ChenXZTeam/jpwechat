<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<link type="text/css" rel="stylesheet" href="<%=basePath %>console/css/qzBanner.css"/>
<script type="text/javascript"  src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/jquery.touchSwipe.min.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/qzBanner.js"></script>
<style type="text/css">
	body{padding:0px; margin:0px; background-color:#F9F9F9;}
	#bigContent{padding:0px;}
	#find{padding:10px 10px 5px 10px; text-align:center;}
	#xFind{border-radius:5px; background-color:#FFFFFF;}
	#xFind .inputName,.inputDiv{padding:5px 10px; overflow:hidden; float:left;}	
	#xFind img,span,input{float:left; outline:none; }
	.qzBackImg{margin-top:0px;}
	.cityTitle{padding:5px 10px 5px 0px; font-size:15px; color:#666666; background-color:#FFFFFF; font-family:Microsoft YaHei; border-bottom:solid 1px #DCDCDC;}
	.dazhou{ background-color:#FFFFFF; border-bottom:#DCDCDC solid 1px; padding-top:10px; padding-bottom:10px;}
	.dazhou .float{width:18%; float:left; text-align:center; padding:10px 0px; margin-left:5%; cursor:pointer; -webkit-tap-highlight-color:rgba(255,255,255,0);}
	.dazhou .float span{ margin-left:auto; margin-right:auto; color:#B6B6B6; width:100%; font-size:12px; margin-top:10px; display:block;}
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
			<div class="inputName" style="border-right:#F0EFF4 solid 1px;"><img src="<%=basePath %>console/images/dingwei.gif" style="width:10px; margin-top:1px;"/><span style="color:#0278FC; margin-left:5px; line-height:20px; font-size:13px;">广东</span></div>
			<div class="inputDiv" style="padding-left:3px;"><img src="<%=basePath %>console/images/findImgSma.png" style="width:20px;"/><input type="text" style="font-size:13px; padding-top:3px; color:#666666; border:none; margin-left:5px;"  placeholder="你想去哪儿？"/></div>
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
		<div style="background-color:#0079FE; width:5px; height:20px; float:left; overflow:hidden;"></div>
		<div style="line-height:20px; margin-left:5px; float:left; font-size:12px;"><span>热门国家/地区</span></div>
		<div style="line-height:20px; float:right;">＞</div>
		<div style="line-height:20px; float:right; font-size:12px;"><span>更多</span></div>
		<div style="clear:both;"></div>
	</div>
	
	<!--热门大洲-->
	<div class="dazhou">
		<div class="float" id="ya"><img src="<%=basePath %>console/images/qiuMap02.gif"/><span style="color:#007AFF; font-weight:bold;">亚洲</span></div>
		<div class="float" id="mei"><img src="<%=basePath %>console/images/meizhou01.gif" style="height:31px;"/><span>美洲</span></div>
		<div class="float" id="fei"><img src="<%=basePath %>console/images/feizhou01.gif"/><span>非洲</span></div>
		<div class="float" id="ou"><img src="<%=basePath %>console/images/ouzhou01.png"/><span>欧洲</span></div>
		<div style="clear:both"></div>
	</div>
	
	<!--热门国家（亚洲）-->
	<div id="yazhou">
		<ul>
			<li class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/thailand.jpg'); background-size:100% 60px; background-repeat:no-repeat;"><span>泰国</span></li>
			<li class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/japan.jpg'); background-size:100% 60px; background-repeat:no-repeat;"><span>日本</span></li>
			<li class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/singapore.jpg'); background-size:100% 60px; background-repeat:no-repeat;"><span>新加坡</span></li>
		</ul>
		<ul>
			<li class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/taiwan.jpg'); background-size:100% 60px; background-repeat:no-repeat;"><span>台湾</span></li>
			<li class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/malaysia.jpg'); background-size:100% 60px; background-repeat:no-repeat;"><span>马来西亚</span></li>
			<li class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/korea.jpg'); background-size:100% 60px; background-repeat:no-repeat;"><span>韩国</span></li>
		</ul>
		<div style="clear:both;"></div>
	</div>
	
	<!--美洲-->
	<div id="meizhou">
        <ul>
			<li class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/usa.jpg'); background-size:100% 60px; background-repeat:no-repeat;"><span>美国</span></li>
			<li class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/canada.jpg'); background-size:100% 60px; background-repeat:no-repeat;"><span>加拿大</span></li>
			<li class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/brazil.jpg'); background-size:100% 60px; background-repeat:no-repeat;"><span>巴西</span></li>
		</ul>
		<ul>
			<li class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/argentina.jpg'); background-size:100% 60px; background-repeat:no-repeat;"><span>阿根廷</span></li>
			<li class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/mexico.jpg'); background-size:100% 60px; background-repeat:no-repeat;"><span>墨西哥</span></li>
			<li class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/hawaii.jpg'); background-size:100% 60px; background-repeat:no-repeat;"><span>夏威夷</span></li>
		</ul>
		<div style="clear:both;"></div>
	</div>
	
	<!--非洲-->
	<div id="feizhou">
        <ul>
			<li class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/cairo.jpg'); background-size:100% 60px; background-repeat:no-repeat;"><span>开罗</span></li>
			<li class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/capetown.jpg'); background-size:100% 60px; background-repeat:no-repeat;"><span>开罗</span></li>
			<li class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/nebbiolo.jpg'); background-size:100% 60px; background-repeat:no-repeat;"><span>内毕罗</span></li>
		</ul>
		<ul>
			<li class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/algiers.jpg'); background-size:100% 60px; background-repeat:no-repeat;"><span>阿尔及尔</span></li>
			<li class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/lagos.jpg'); background-size:100% 60px; background-repeat:no-repeat;"><span>拉各斯</span></li>
			<li class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/kinshasa.jpg'); background-size:100% 60px; background-repeat:no-repeat;"><span>金沙萨</span></li>
		</ul>
		<div style="clear:both;"></div>
	</div>
	
	<!--欧洲-->
	<div id="ouzhou">
        <ul>
			<li class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/swit.jpg'); background-size:100% 60px; background-repeat:no-repeat;"><span>瑞士</span></li>
			<li class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/netherlands.jpg'); background-size:100% 60px; background-repeat:no-repeat;"><span>荷兰</span></li>
			<li class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/riga.jpg'); background-size:100% 60px; background-repeat:no-repeat;"><span>里加</span></li>
		</ul>
		<ul>
			<li class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/budapest.jpg'); background-size:100% 60px; background-repeat:no-repeat;"><span>布达佩斯</span></li>
			<li class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/copenhagen.jpg'); background-size:100% 60px; background-repeat:no-repeat;"><span>哥本哈根</span></li>
			<li class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/serbia.jpg'); background-size:100% 60px; background-repeat:no-repeat;"><span>塞尔维亚</span></li>
		</ul>
		<div style="clear:both;"></div>
	</div>
	
</div>
<script type="text/javascript">
	$(function(){
		$(".float").click(function(){
			resetImg();
			if($(this).children("span").text()=="亚洲"){
				$(this).children("img").attr("src","<%=basePath %>console/images/qiuMap02.gif");
			}else if($(this).children("span").text()=="美洲"){
				$(this).children("img").attr("src","<%=basePath %>console/images/meizhou02.png");
			}else if($(this).children("span").text()=="非洲"){
				$(this).children("img").attr("src","<%=basePath %>console/images/feizhou02.gif");
			}else if($(this).children("span").text()=="欧洲"){
				$(this).children("img").attr("src","<%=basePath %>console/images/ouzhou02.png");
			}
			$(this).children("span").css("color","#007AFF");
			$(this).children("span").css("font-weight","bold");
		});
		
		 $("#mei").click(function () {
			$("#meizhou").css("display","block");
			$("#yazhou").css("display","none");
			$("#feizhou").css("display","none");
			$("#ouzhou").css("display","none");
		});
		
		$("#fei").click(function() {
			$("#feizhou").css("display","block");
			$("#yazhou").css("display","none");
			$("#meizhou").css("display","none");
			$("#ouzhou").css("display","none");
		});
		
		$("#ou").click(function() {
			$("#ouzhou").css("display","block");
			$("#yazhou").css("display","none");
			$("#meizhou").css("display","none");
			$("#feizhou").css("display","none");
		});
		
		$("#ya").click(function() {
			$("#yazhou").css("display","block");
			$("#ouzhou").css("display","none");
			$("#meizhou").css("display","none");
			$("#feizhou").css("display","none");
		});
	})
	//图片恢复成灰色的样式
	function resetImg(){
		$(".float").eq(0).children("img").attr("src","<%=basePath %>console/images/qiuMap01.gif");
		$(".float").eq(0).children("span").css("color","#B6B6B6");	
		$(".float").eq(1).children("img").attr("src","<%=basePath %>console/images/meizhou01.gif");
		$(".float").eq(1).children("span").css("color","#B6B6B6");	
		$(".float").eq(2).children("img").attr("src","<%=basePath %>console/images/feizhou01.gif");
		$(".float").eq(2).children("span").css("color","#B6B6B6");	
		$(".float").eq(3).children("img").attr("src","<%=basePath %>console/images/ouzhou01.png");
		$(".float").eq(3).children("span").css("color","#B6B6B6");	
	}
</script>
</body>
</html>