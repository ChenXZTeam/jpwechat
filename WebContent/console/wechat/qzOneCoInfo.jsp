<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	String path= request.getContextPath();
	String basePath= request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+ path +"/";
%>
<%
	String countryId = new String(request.getParameter("countryId").getBytes("ISO-8859-1"),"utf-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>签证的国家</title>
<script type="text/javascript" src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<style>
	body{padding:0px; margin:0px; font-family:"微软雅黑";}
	.imgBoxClass{ margin:0px;}
	.imgBoxClass img{width:100%;}
	.countryNameBox{ width:88.55%; height:30px; margin:10px auto 0 auto; border-bottom:1px solid #007AFF;}
	.countryNameBox .countryName{line-height:35px; font-size:16px; color:#007AFF;}
	.messageBox{ padding:0px; margin:0px; list-style-type:none; width:88.55%; margin:10px auto 0 auto;}
	.messageBox li{ margin-top:5px;}
	.messageBox li .titleClass{font-size:13px; color:#666666;}
	.messageBox li .contornClass{font-size:13px; color:#666666;}
	.messageBox li .payMoney{font-size:15px; color:#fe0000; font-weight:bold;}
	.jianjieBox{ width:88.55%; margin:15px auto 0 auto;}
	.jianjieBox .textContClass{font-size:10px; color:#999999; text-indent:2em; display:block; height:30px; overflow:hidden;}
	.jianjieBox .seeMore{font-size:11px; color:#666; cursor:pointer; font-family:Arial, Helvetica, sans-serif; float:right; margin-right:3%; margin-top:5px;}
	#qzBtn{display:block; width:88.55%; margin:30px auto 0 auto; background-color:#007AFF; font-size:13px; padding:10px 0; text-align:center; color:#FFFFFF; border-radius:5px;}
</style>
</head>

<body>
<!--图片-->
<div class="imgBoxClass"><img id="contryImg" src="<%=basePath %>console/images/jepImg.png"/></div>
<div class="countryNameBox"><span class="countryName">日本</span></div>
<ul class="messageBox">
	<li><span class="titleClass">入境次数：</span><span class="contornClass immigrationOfTimes">50次</span></li>
	<li><span class="titleClass">停留天数：</span><span class="contornClass sojournTime">一年</span></li>
	<li><span class="titleClass">签字类型：</span><span class="contornClass">本人</span></li>
	<li><span class="titleClass">办理时长：</span><span class="contornClass elapsedTime">7天</span></li>
	<li><span class="titleClass">有效期限：</span><span class="contornClass periodOfValidity">5年</span></li>
	<li><span class="titleClass">费　　用：</span><span class="contornClass payMoney">￥1205</span></li>
	<li><span class="titleClass">最早可定日期：</span><span class="contornClass earlyDates">2016-08-30</span></li>
</ul>
<div class="jianjieBox">
	<span class="textContClass touryIntro">日本位于亚洲大陆东边的太平洋上。整个国土由四个主要岛屿组成，在这四个岛屿的周围还有约4,000多个小岛。日本是一个地势多变、水力资源丰富的国家，由此构成了优美壮丽的景色，那里有山中积雪的湖泊、怪石嶙峋的峡谷、湍急的河流、峻峭的山峰、雄伟的瀑布以及大大小小的温泉，这些引人入胜的旅游景点常年吸引着大量游客来到日本观光。</span>
	<span class="seeMore">展开︾</span>
</div>
<a id="qzBtn">申请签证</a>
<script>
	$(function(){
		//根据国家编号查找数据并加载在对应的位置
		var countryId = "<%=countryId%>";
		$.ajax({
			url:"<%=basePath%>framework/visa/findByCountryId.action",
			type:"POST",
			data:{"countryId":countryId},
			dataType:"json",
			success:function(res){
				console.log(res.dataList);
				if(res.msg==1){
					var data = res.dataList;
					$(".countryName").text(data[0].country);
					$(".immigrationOfTimes").text(data[0].immigrationOfTimes);
					$(".sojournTime").text(data[0].sojournTime);
					$(".elapsedTime").text(data[0].elapsedTime);
					$(".periodOfValidity").text(data[0].periodOfValidity);
					$(".payMoney").text("￥"+data[0].visaPrice);
					$(".earlyDates").text(data[0].earlyDates);
					$(".touryIntro").text(data[0].touryIntro);
					$("#contryImg").attr("src","<%=basePath%>"+data[0].urlImg);
				}
			},error:function(){}
		});
		
		var fasl=true;
		$(".seeMore").click(function(){
			if(fasl==true){				
				$(".textContClass").animate({height:"80px"},250,function(){$(".seeMore").text("收起︽");});
				fasl=false;
			}else{
				$(".textContClass").animate({height:"30px"},250,function(){$(".seeMore").text("展开︾");});
				fasl=true;
			}
			
			//$(".textContClass").slideToggle("slow",function(){$(".seeMore").text("展开︾");});
		});
		
		$("#qzBtn").click(function(){
			var payMoney = $(".payMoney").text().substring(1,$(".payMoney").text().length);
			var countryName = $(".countryName").text();
			var countryIdNum = "<%=countryId%>";
			window.location.href="<%=basePath%>console/wechat/qz_waritInfo.jsp?payTry="+payMoney+"&countryName="+countryName+"&countryId="+countryIdNum;
		});
	});
</script>
</body>
</html>