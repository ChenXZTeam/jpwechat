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
<title>机票预订</title>
<link type="text/css" rel="stylesheet" href="<%=basePath %>console/css/planTek.css"/>
<link href="<%=basePath %>console/css/jcDate.css" rel="stylesheet" type="text/css"/>
<link type="text/css" rel="stylesheet" href="<%=basePath %>console/css/banner.css"/>
<link href="<%=basePath %>console/css/cityChoose.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript"  src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/planTek.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=basePath %>console/js/jcDate.js"></script>
<script type="text/javascript"  src="<%=basePath %>console/js/cityChoose.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/banner.js"></script>
<style>
	body{margin:0px; padding:0px;}
	.product .ziDiv{width:100%; margin-left:auto; margin-right:auto; border-bottom:#cccccc solid 1px;}
	.mudiplace{padding:5px;}
	.product .mudiplace .shi{width:40%; float:left; text-align:center;}
	.product .mudiplace .shi span{ line-height:23px; display:block; color:#B5B5B5;}
	.product .mudiplace .to{width:45px; float:left;}
	.product .mudiplace .zhong{width:40%; float:left; text-align:center;}
	.product .mudiplace .zhong span{ line-height:23px; display:block; color:#B5B5B5;}
	.product .gotime{ padding:15px 0 6px 0; }
	.product .gotime .goDay{margin-left:20px; float:left; color:#B5B5B5;}
	.product .gotime .goTimeDiv{margin-right:20px; float:right; color:#6CA5FE;}
	.product .gotime .goTimeDiv .jcDate{width:70px; text-align:right; color:#6CA5FE; border:none; font-size:12px; outline:none; -webkit-tap-highlight-color:rgba(255,255,255,0);}
	.product .seatChoose{padding:20px 0 10px 0; border-bottom:none;}
	.product .ziDiv .zuoweiFloat{margin-left:15px; float:left; width:45px;}
	.product .ziDiv .cangwei{margin-top:8px; margin-left:10px; float:left; width:65%; padding-left:3px; background-color:#ffffff; border-radius:7px; margin-bottom:0px; height:30px;}
	.product .ziDiv .cang{float:left; border:#CCCCCC solid 1px; border-right:none;  line-height:30px; width:32%; font-size:12px; color:#666666;}
	.product .ziDiv .cang1{float:left; border:#CCCCCC solid 1px; border-right:none;  line-height:30px; width:32%; font-size:12px; color:#666666;}
	.product .ziDiv .on{background-color:#007AFF; color:#FFFFFF; border:#007AFF solid 1px;}
	.product .btnDiv{width:95%; margin-top:10px; margin-left:auto; margin-right:auto; background-color:#007AFF; border:1px solid #007AFF; border-radius:7px;}
	.product .btnDiv a{ display:block; font-size:14px; padding:10px 0; color:#FFFFFF;}
</style>
</head>

<body>
	<!--图片轮播图 宽高比为2.77:1-->
<div>
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
<div class="lanrenzhijia">
  <div class="title cf">
    <ul class="title-list fr cf ">
      <li class="on">单程</li>
      <li>返程</li>
      <p><b></b></p>
    </ul>
  </div>
  
  <div class="product-wrap">
    <!--案例1-->
    <div class="product show">
		<!--航班-->
       <div class="ziDiv mudiplace">
	   		<div class="shi">
				<span id="shi01">国内/国际出发城市</span>
				<span id="shi001" style="font-size:18px; color:#666666; font-family:Microsoft YaHei;">深圳</span>
				<span id="shi0001">宝安机场T3</span>
			</div>
			<div class="to dancheng" style="padding-top:5px; padding-bottom:7px;"><img src="<%=basePath %>console/images/wang.gif" width="35"></div>
			<div class="zhong">
				<span id="zhong01">国内/国际到达城市</span>
				<span id="zhong001" style="font-size:18px; color:#666666; font-family:Microsoft YaHei;">北京</span>
				<span id="zhong0001">首都机场T3</span>			
			</div>
			<div style="clear:both;"></div>
	   </div>
	   <!--时间-->
	   <div class="ziDiv gotime">
	   		<div class="goDay">出发日期</div>
			<div class="goTimeDiv"><input type="text" class="jcDate jcD01" readonly="readonly" placeholder="选择日期"/><span id="houtian" style="color:#6CA5FE; margin-left:10px;"></span></div>
			<div style="clear:both;"></div>
	   </div>
	   <!--舱位-->
	   <div class="ziDiv seatChoose">
	   		<div class="zuoweiFloat"><img src="<%=basePath %>console/images/zuowei.gif" width="45"></div>
			<div class="cangwei">
				<div class="cang on" style="border-radius:7px 0 0 7px;">经济舱</div>
				<div class="cang">头等舱</div>
				<div class="cang" style="border-right:#CCCCCC solid 1px; border-radius:0 7px 7px 0;">商务舱</div>
			</div>
			<div style="clear:both;"></div>
	   </div>
	   <!--按钮-->
	   <div class="btnDiv" onclick="aa()">
	   		<a>机票查询</a>
	   </div>
    </div>
    <!--案例2-->
    <div class="product">
		<!--航班-->
       <div class="ziDiv mudiplace">
	   		<div class="shi">
				<span>国内/国际出发城市</span>
				<span id="shif02" style="font-size:18px; color:#666666; font-family:Microsoft YaHei;">深圳</span>
				<span id="shif03">宝安机场T3</span>
			</div>
			<div class="to fangcheng" style="padding-top:5px; padding-bottom:7px;"><img src="<%=basePath %>console/images/wangfan.gif" width="35"></div>
			<div class="zhong">
				<span>国内/国际到达城市</span>
				<span id="zhongf02" style="font-size:18px; color:#666666; font-family:Microsoft YaHei;">北京</span>
				<span id="zhongf03">首都机场T3</span>			
			</div>
			<div style="clear:both;"></div>
	   </div>
	   <!--时间-->
	   <div class="ziDiv gotime">
	   		<div class="goDay">出发日期</div>
			<div class="goTimeDiv"><input type="text" class="jcDate jcD02" readonly="readonly" placeholder="选择日期"/><span id="houtian" style="color:#6CA5FE; margin-left:10px;"></span></div>
			<div style="clear:both;"></div>
	   </div>
	   <!--舱位-->
	   <div class="ziDiv seatChoose">
	   		<div class="zuoweiFloat"><img src="<%=basePath%>console/images/zuowei.gif" width="45"></div>
			<div class="cangwei">
				<div class="cang1 on" style="border-radius:7px 0 0 7px;">经济舱</div>
				<div class="cang1">头等舱</div>
				<div class="cang1" style="border-right:#CCCCCC solid 1px; border-radius:0 7px 7px 0;">商务舱</div>
			</div>
			<div style="clear:both;"></div>
	   </div>
	   <!--按钮-->
	   <div class="btnDiv" onclick="bb()">
	   		<a href="<%=basePath %>console/wechat/mudiPlace.jsp">机票查询</a>
	   </div>
    </div>
  </div>
</div>

<!--省份-->
<div class="cityContent">
		<div class="priv">
			<div class="smallPriv">省份</div>
			<div class="smallKong"></div>
			<div style="clear:both;"></div>
		</div>
		<div class="A_G">
			<div class="zm">A-G</div>
			<ul>
				<li class="on">安徽省</li>
				<li>北京市</li>
				<li>重庆市</li>
				<li>福建省</li>
				<li>甘肃省</li>
				<li>广东省</li>
				<li>广西壮族自治区</li>
				<li>贵州省</li>
			</ul>
			<div style="clear:both;"></div>
		</div>
		
		<div class="A_G">
			<div class="zm">H-K</div>
			<ul>
				<li>海南省</li>
				<li>河北省</li>
				<li>黑龙江省</li>
				<li>河南省</li>
				<li>湖北省</li>
				<li>湖南省</li>
				<li>江苏省</li>
				<li>江西省</li>
				<li>吉林省</li>
			</ul>
			<div style="clear:both;"></div>
		</div>
		<div class="A_G">
			<div class="zm">H-K</div>
			<ul>
				<li>辽宁省</li>
				<li>内蒙古</li>
				<li>宁夏回族自治区</li>
				<li>青海省</li>
				<li>山东省</li>
				<li>上海市</li>
				<li>山西省</li>
				<li>陕西省</li>
				<li>四川省</li>
			</ul>
			<div style="clear:both;"></div>
		</div>
		<div class="A_G" style="border:none;">
			<div class="zm">H-K</div>
			<ul>
				<li>天津市</li>
				<li>新疆</li>
				<li>西藏自治区</li>
				<li>云南省</li>
				<li>浙江省</li>
			</ul>
			<div style="clear:both;"></div>
		</div>
</div>
</body>
<script>
	$(function(){
		//目的地和出发地切换功能(单程)
		$(".dancheng").click(function(){
			var shi001=$("#shi001").text();
			var shi0001=$("#shi0001").text();
			$("#shi001").text("");
			$("#shi0001").text("");
			$("#shi001").text($("#zhong001").text());
			$("#shi0001").text($("#zhong0001").text());
			$("#zhong001").text(shi001);
			$("#zhong0001").text(shi0001);
		});
		//目的地和出发地切换功能(返程)
		$(".fangcheng").click(function(){
			var shif02=$("#shif02").text();
			var shif03=$("#shif03").text();
			$("#shif02").text("");
			$("#shif03").text("");
			$("#shif02").text($("#zhongf02").text());
			$("#shif03").text($("#zhongf03").text());
			$("#zhongf02").text(shif02);
			$("#zhongf03").text(shif03);
		});
		//单程的舱位切换
		$(".cangwei .cang").click(function(){
			$(this).addClass('on').siblings().removeClass('on');
		});
		//返程的舱位切换
		$(".cangwei .cang1").click(function(){
			$(this).addClass('on').siblings().removeClass('on');
		});		
		//加载日期控件
		$(".jcDate").jcDate({
			Event : "click",
			Speed : 100,
			Left : 0,
			Top : 28,
			format : "-",
			Timeout : 100
		});
	});
	
	function aa(){
		alert($(".jcD01 ").val());
	}
	
	function bb(){
		alert($(".jcD02").val());
	}
</script>
</html>
