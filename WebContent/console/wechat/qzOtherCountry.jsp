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
<title>特优国家</title>
<link rel="stylesheet" href="<%=basePath %>console/css/QZplanTek.css" />
<script type="text/javascript"  src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/QZplanTek.js"></script>
<style>
	body{background-color:#F9F9F9;}
	#cityFind{margin-bottom:15px; background-color:#FFFFFF; padding:8px 0px;}
	.fangbigImgbox{ border-right:1px solid #D8D8D8;}
	.fangbigImgbox,.inputDivBox{float:left;}
	.fangbigImgbox img{width:25px; padding:0px 10px;}
	.inputDivBox input{height:20px; border:none; margin-left:10px; outline:none; margin-top:3px;}
	#findResult{width:99%; position:absolute; top:40px; left:0; border:#d8d8d8 solid 1px; border-bottom:#d8d8d8 solid 1px; background-color:#FFFFFF; overflow:hidden; z-index:99;}
	#findResult .pipeiChildren{padding:10px 5px; border-bottom:#d8d8d8 solid 1px;}
	.conteryBox{width:95%; margin-left:auto; margin-right:auto;}
	.conteryBox .zhouNameBoxClass{border-bottom:1px solid #D8D8D8; overflow:hidden;}
	.conteryBox .zhouNameBoxClass .zhouNameClass{font-family:'微软雅黑'; color:#666666;/*#AEADB3*/; display:block; float:left; padding-bottom:3px;}
	.conteryBox .conterListBox{overflow:hidden;}
	.conteryList{border-bottom:1px solid #D8D8D8; overflow:hidden; display:none;}
	.conteryList ul{list-style-type:none; padding:5px 10px 10px 10px; margin:0px; overflow:hidden; margin-top:5px;}
	.conteryList ul li{text-align:left; padding:5px 0px; margin-top:5px; color:#666666;}
	.shouImgBox{margin-top:1px; padding-bottom:10px;}
</style>
</head>

<body>
<div id="cityFind">
	<div class="fangbigImgbox"><img src="<%=basePath %>console/images/FangBig.png"/></div>
	<div class="inputDivBox"><input type="text" id="citySearch" oninput="myFunction()" placeholder="请输入搜索的国家"/></div>
	<div style="clear:both;"></div>
</div>
<div id="findResult" >
	
</div>

<div class="lanrenzhijia">
  <div class="title cf">
    <ul class="title-list fr cf ">
      <li class="on">免签国家</li>
      <li>落地签国家</li>
      <p><b></b></p>
    </ul>
  </div>
  
  <div class="product-wrap">
    <!--案例1-->
    <div class="product show">
		<div class="conteryBox">
			<!--亚洲-->
			<div class="zhouNameBoxClass">
				<span class="zhouNameClass">亚洲</span>
				<span style="clear:both;"></span>
			</div>
			<div class="conterListBox">
				<div class="conteryList" style="display:block;">
					<ul>
						<li>韩国</li>
						<li>日本</li>
						<li>中国</li>
						<li>韩国</li>
						<li>日本</li>
						<li>中国</li>
						<li>韩国</li>
						<li>日本</li>
						<li>中国</li>
					</ul>
				</div>
				<div class="shouImgBox"><img src="<%=basePath %>console/images/threeLine.png"/></div>
			</div>
			
			<!--欧洲-->
			<div class="zhouNameBoxClass">
				<span class="zhouNameClass">欧洲</span>
				<span style="clear:both;"></span>
			</div>
			<div class="conterListBox">
				<div class="conteryList">
					<ul>
						<li>法国</li>
						<li>德国</li>
						<li>英国</li>
						<li>意大利</li>
						<li>法国</li>
						<li>德国</li>
						<li>英国</li>
						<li>意大利</li>
						<li>法国</li>
						<li>德国</li>
						<li>英国</li>
						<li>意大利</li>
					</ul>
				</div>
				<div class="shouImgBox"><img src="<%=basePath %>console/images/threeLine.png"/></div>
			</div>
			
			<!--美洲-->
			<div class="zhouNameBoxClass">
				<span class="zhouNameClass">美洲</span>
				<span style="clear:both;"></span>
			</div>
			<div class="conterListBox">
				<div class="conteryList">
					<ul>
						<li>韩国</li>
						<li>日本</li>
						<li>中国</li>
						<li>韩国</li>
						<li>日本</li>
						<li>中国</li>
						<li>韩国</li>
						<li>日本</li>
						<li>中国</li>
					</ul>
				</div>
				<div class="shouImgBox"><img src="<%=basePath %>console/images/threeLine.png"/></div>
			</div>
			
			<!--非洲-->
			<div class="zhouNameBoxClass">
				<span class="zhouNameClass">非洲</span>
				<span style="clear:both;"></span>
			</div>
			<div class="conterListBox">
				<div class="conteryList">
					<ul>
						<li>韩国</li>
						<li>日本</li>
						<li>中国</li>
						<li>韩国</li>
						<li>日本</li>
						<li>中国</li>
						<li>韩国</li>
						<li>日本</li>
						<li>中国</li>
					</ul>
				</div>
				<div class="shouImgBox"><img src="<%=basePath %>console/images/threeLine.png"/></div>
			</div>
			
			<!--大洋洲-->
			<div class="zhouNameBoxClass">
				<span class="zhouNameClass">大洋洲</span>
				<span style="clear:both;"></span>
			</div>
			<div class="conterListBox">
				<div class="conteryList">
					<ul>
						<li>韩国</li>
						<li>日本</li>
						<li>中国</li>
						<li>韩国</li>
						<li>日本</li>
						<li>中国</li>
						<li>韩国</li>
						<li>日本</li>
						<li>中国</li>
						<li>马来西亚</li>
					</ul>
				</div>
				<div class="shouImgBox"><img src="<%=basePath %>console/images/threeLine.png"/></div>
			</div>
			
		</div>
    </div>
    <!--案例2-->
    <div class="product">
		2
    </div>
  </div>
  
</div>
<script type="text/javascript">
	$(function(){
		$(".shouImgBox").click(function(){			
			if(!$(this).prev().hasClass("nowShow"))$(".nowShow").slideUp("slow");
			$(".conteryList").removeClass("nowShow");
			$(this).prev().addClass("nowShow");
			$(".nowShow").slideToggle("slow");
		});
		//选中的国家
		$(".conteryList").click(function(){
			var country = $(this).text();
			window.location.href="<%=basePath%>console/wechat/qzOneCoInfo.jsp?countryName="+country+"&countryId=213543";
		});
	});
	
//输入关键字的时候自动索引
function myFunction() {
	var keyVal = document.getElementById("citySearch").value;
	$(".conteryList>ul>li").removeClass("chCity").filter(":contains(" + keyVal + ")").addClass("chCity");
	$("#findResult").text("");
	$("#findResult").css("display","block");
	for(var i=0; i<$(".chCity").length&&i!=10; i++){
		var contrayName = $(".chCity:eq("+i+")").text();
		var dateList = '<div class="pipeiChildren" onclick="javascript:chaRes(this)"><span class="cityName01">'+contrayName+'</span></div>';
		$("#findResult").append(dateList);
	}
}

//索引出来的结果的点击事件
function chaRes(inc){
	var countryName = $(inc).children(".cityName01").text();
	alert(countryName);
	window.location.href="<%=basePath%>console/wechat/qzOneCoInfo.jsp?countryName="+countryName+"&countryId=213543";
	$("#findResult").css("display","none");
}
</script>
</body>
</html>
