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
<link rel="stylesheet" type="text/css" href="<%=basePath %>console/css/jcDate.css"/>
<link type="text/css" rel="stylesheet" href="<%=basePath %>console/css/banner.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath %>console/css/cityChoose.css"/>
<script type="text/javascript"  src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/jquery.touchSwipe.min.js"></script>
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
			<div class="runDiv"><img src="<%=basePath %>console/images/banner01.png" style="width:100%;"/></div>
			<div class="runDiv"><img src="<%=basePath %>console/images/banner02.png" style="width:100%;"/></div>
			<div class="runDiv"><img src="<%=basePath %>console/images/banner03.png" style="width:100%;"/></div>
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
				<span id="shi001" class="CityChoose" style="font-size:18px; color:#666666; font-family:Microsoft YaHei;">广州</span>
				<span id="shi0001">广州新白云国际机场</span>
				<span id="shi00001" style="display:none">CAN</span>
			</div>
			<div class="to dancheng" style="padding-top:5px; padding-bottom:7px;" onclick="dancheng()"><img src="<%=basePath %>console/images/wang.gif" width="35"/></div>
			<div class="zhong">
				<span id="zhong01">国内/国际到达城市</span>
				<span id="zhong001" class="CityChoose" style="font-size:18px; color:#666666; font-family:Microsoft YaHei;">北京</span>
				<span id="zhong0001">北京首都国际机场</span>
				<span id="zhong00001" style="display:none">PEK</span>			
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
	   		<div class="zuoweiFloat"><img src="<%=basePath %>console/images/zuowei.gif" width="45"/></div>
			<div class="cangwei">
				<div class="cang on" style="border-radius:7px 0 0 7px;">经济舱</div>
				<div class="cang">头等舱</div>
				<div class="cang" style="border-right:#CCCCCC solid 1px; border-radius:0 7px 7px 0;">公务舱</div>
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
				<span id="shif02" class="CityChoose" style="font-size:18px; color:#666666; font-family:Microsoft YaHei;">深圳</span>
				<span id="shif03">宝安机场T3</span>
				<span id="shif04" style="display:none;">SZX</span>
			</div>
			<div class="to fangcheng" style="padding-top:5px; padding-bottom:7px;" onclick="fangcheng()"><img src="<%=basePath %>console/images/wangfan.gif" width="35"/></div>
			<div class="zhong">
				<span>国内/国际到达城市</span>
				<span id="zhongf02" class="CityChoose" style="font-size:18px; color:#666666; font-family:Microsoft YaHei;">北京</span>
				<span id="zhongf03">首都机场T3</span>
				<span id="zhongf04" style="display:none;">PEK</span>			
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
	   		<div class="zuoweiFloat"><img src="<%=basePath%>console/images/zuowei.gif" width="45"/></div>
			<div class="cangwei">
				<div class="cang1 on" style="border-radius:7px 0 0 7px;">经济舱</div>
				<div class="cang1">头等舱</div>
				<div class="cang1" style="border-right:#CCCCCC solid 1px; border-radius:0 7px 7px 0;">公务舱</div>
			</div>
			<div style="clear:both;"></div>
	   </div>
	   <!--按钮-->
	   <div class="btnDiv" onclick="bb()">
	   		<a>机票查询</a>
	   </div>
    </div>
  </div>
</div>

<!--省份-->


<div id="CityCH">
	<!--输入框搜索部分-->
	<div id="basePathDiv" style="display:none;"><%=basePath %></div>
	<div id="cityFind"><input type="text" class="citySearch" id="citySearch" placeholder="城市查找" oninput="myFunction()"/><a href="#CityResult" id="finBtn">搜索</a></div>
	<div id="pipeiValue"></div>
	<!---热门推荐部分--->
	<div id="remenCity">
		<div id="remenTitle">
			<span>热门城市</span>
		</div>
		<ul>
			<li><div class="remenLi">海口</div></li>
			<li><div class="remenLi">三亚</div></li>
			<li><div class="remenLi">儋州</div></li>
			<li><div class="remenLi">东方</div></li>
			<li><div class="remenLi">万宁</div></li>
			<li><div class="remenLi">临高</div></li>
			<li><div class="remenLi">陵水</div></li>
			<li><div class="remenLi">琼海</div></li>
			<li><div class="remenLi">文昌</div></li>
			<li><div class="remenLi">八所</div></li>
		</ul>
		<div style="clear:both;"></div>
	</div>
	
	<div class="CityTab">
	  <div class="titleTab cf1">
	    <ul class="titleTab-list fr1 cf1 ">
	      <li class="onCountry">国内</li>
	      <li>国际</li>
	      <p><b></b></p>
	    </ul>
	  </div>
	  
	  <div class="product-wrap1">
	    <!--案例1：国内-->
	    <div class="product1 show">
	    	<!---城市详细列表部分---->
			<div id="CityList">
				<div id="A-a" class="zimuResult">
					<div class="zimuTitle"><span>A</span></div>
					<ul class="cityUL">
						<li><span class="cityName">安纳巴</span><span class="planeName">安纳巴机场</span><span class="airportCode">AAE</span></li>
						<li><span class="cityName">阿帕拉契科拉</span><span class="planeName">阿帕拉契科拉地区机场</span><span class="airportCode">AAF</span></li>
						<li><span class="cityName">奥尔堡</span><span class="planeName">奥尔堡机场</span><span class="airportCode">AAL</span></li>
						<li><span class="cityName">艾因</span><span class="planeName">艾因国际机场</span><span class="airportCode">AAN</span></li>
						<li><span class="cityName">北京</span><span class="planeName">北京首都国际机场</span><span class="airportCode">PEK</span></li>
						<li><span class="cityName">广州</span><span class="planeName">广州新白云国际机场</span><span class="airportCode">	CAN</span></li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="B-b" class="zimuResult">
					<div class="zimuTitle"><span>B</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>			
				</div>
				<div id="C-c" class="zimuResult">
					<div class="zimuTitle"><span>C</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="D-d" class="zimuResult">
					<div class="zimuTitle"><span>D</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="E-e" class="zimuResult">
					<div class="zimuTitle"><span>E</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="F-f" class="zimuResult">
					<div class="zimuTitle"><span>F</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="G-g" class="zimuResult">
					<div class="zimuTitle"><span>G</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="H-h" class="zimuResult">
					<div class="zimuTitle"><span>H</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="I-i" class="zimuResult">
					<div class="zimuTitle"><span>I</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="J-j" class="zimuResult">
					<div class="zimuTitle"><span>J</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="K-k" class="zimuResult">
					<div class="zimuTitle"><span>K</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="L-l" class="zimuResult">
					<div class="zimuTitle"><span>L</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="M-m" class="zimuResult">
					<div class="zimuTitle"><span>M</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="N-n" class="zimuResult">
					<div class="zimuTitle"><span>N</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="O-o" class="zimuResult">
					<div class="zimuTitle"><span>O</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="P-p" class="zimuResult">
					<div class="zimuTitle"><span>P</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="Q-q" class="zimuResult">
					<div class="zimuTitle"><span>Q</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="R-r" class="zimuResult">
					<div class="zimuTitle"><span>R</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="S-s" class="zimuResult">
					<div class="zimuTitle"><span>S</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="T-t" class="zimuResult">
					<div class="zimuTitle"><span>T</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="U-u" class="zimuResult">
					<div class="zimuTitle"><span>U</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="V-v" class="zimuResult">
					<div class="zimuTitle"><span>V</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="W-w" class="zimuResult">
					<div class="zimuTitle"><span>W</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="X-x" class="zimuResult">
					<div class="zimuTitle"><span>X</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="Y-y" class="zimuResult">
					<div class="zimuTitle"><span>Y</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="Z-z" class="zimuResult">
					<div class="zimuTitle"><span>Z</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
			</div>
			<!---右边字母查找部分--->
			<div id="zimuList">
				<div class="zimuOne"><a href="#A-a">A</a></div>
				<div class="zimuOne"><a href="#B-b">B</a></div>
				<div class="zimuOne"><a href="#C-c">C</a></div>
				<div class="zimuOne"><a href="#D-d">D</a></div>
				<div class="zimuOne"><a href="#E-e">E</a></div>
				<div class="zimuOne"><a href="#F-f">F</a></div>
				<div class="zimuOne"><a href="#G-g">G</a></div>
				<div class="zimuOne"><a href="#H-h">H</a></div>
				<div class="zimuOne"><a href="#I-i">I</a></div>
				<div class="zimuOne"><a href="#J-j">J</a></div>
				<div class="zimuOne"><a href="#K-k">K</a></div>
				<div class="zimuOne"><a href="#L-l">L</a></div>
				<div class="zimuOne"><a href="#M-m">M</a></div>
				<div class="zimuOne"><a href="#N-n">N</a></div>
				<div class="zimuOne"><a href="#O-o">O</a></div>
				<div class="zimuOne"><a href="#P-p">P</a></div>
				<div class="zimuOne"><a href="#Q-q">Q</a></div>
				<div class="zimuOne"><a href="#R-r">R</a></div>
				<div class="zimuOne"><a href="#S-s">S</a></div>
				<div class="zimuOne"><a href="#T-t">T</a></div>
				<div class="zimuOne"><a href="#U-u">U</a></div>
				<div class="zimuOne"><a href="#V-v">V</a></div>
				<div class="zimuOne"><a href="#W-w">W</a></div>
				<div class="zimuOne"><a href="#X-x">X</a></div>
				<div class="zimuOne"><a href="#Y-y">Y</a></div>
				<div class="zimuOne"><a href="#Z-z">Z</a></div>
			</div>
	    </div>
	    <!--案例2：国际-->
	    <div class="product1">
	    	<div id="CityList">
				<div id="a-A" class="zimuResult">
					<div class="zimuTitle"><span>A</span></div>
					<ul class="cityUL">
						<li><span class="cityName">安纳巴</span><span class="planeName">安纳巴机场</span><span class="airportCode">AAE</span></li>
						<li><span class="cityName">阿帕拉契科拉</span><span class="planeName">阿帕拉契科拉地区机场</span><span class="airportCode">AAF</span></li>
						<li><span class="cityName">奥尔堡</span><span class="planeName">奥尔堡机场</span><span class="airportCode">AAL</span></li>
						<li><span class="cityName">艾因</span><span class="planeName">艾因国际机场</span><span class="airportCode">AAN</span></li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="b-B" class="zimuResult">
					<div class="zimuTitle"><span>B</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>			
				</div>
				<div id="c-C" class="zimuResult">
					<div class="zimuTitle"><span>C</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="d-D" class="zimuResult">
					<div class="zimuTitle"><span>D</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="e-E" class="zimuResult">
					<div class="zimuTitle"><span>E</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="f-F" class="zimuResult">
					<div class="zimuTitle"><span>F</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="g-G" class="zimuResult">
					<div class="zimuTitle"><span>G</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="h-H" class="zimuResult">
					<div class="zimuTitle"><span>H</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="i-I" class="zimuResult">
					<div class="zimuTitle"><span>I</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="j-J" class="zimuResult">
					<div class="zimuTitle"><span>J</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="k-K" class="zimuResult">
					<div class="zimuTitle"><span>K</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="l-L" class="zimuResult">
					<div class="zimuTitle"><span>L</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="m-M" class="zimuResult">
					<div class="zimuTitle"><span>M</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="n-N" class="zimuResult">
					<div class="zimuTitle"><span>N</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="o-O" class="zimuResult">
					<div class="zimuTitle"><span>O</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="p-P" class="zimuResult">
					<div class="zimuTitle"><span>P</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="q-Q" class="zimuResult">
					<div class="zimuTitle"><span>Q</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="r-R" class="zimuResult">
					<div class="zimuTitle"><span>R</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="s-S" class="zimuResult">
					<div class="zimuTitle"><span>S</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="t-T" class="zimuResult">
					<div class="zimuTitle"><span>T</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="u-U" class="zimuResult">
					<div class="zimuTitle"><span>U</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="v-V" class="zimuResult">
					<div class="zimuTitle"><span>V</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="w-W" class="zimuResult">
					<div class="zimuTitle"><span>W</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="x-X" class="zimuResult">
					<div class="zimuTitle"><span>X</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="y-Y" class="zimuResult">
					<div class="zimuTitle"><span>Y</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
				<div id="z-Z" class="zimuResult">
					<div class="zimuTitle"><span>Z</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
						<li>阿舍</li>
						<li>阿的防守打法</li>
						<li>阿的份儿</li>
						<li>阿水电费</li>
						<li>阿非的个人头</li>
						<li>阿要人头</li>
						<li style="padding-bottom:10px;">阿的风格让他</li>
					</ul>
				</div>
			</div>
			<!---右边字母查找部分--->
			<div id="zimuList">
				<div class="zimuOne"><a href="#a-A">A</a></div>
				<div class="zimuOne"><a href="#b-B">B</a></div>
				<div class="zimuOne"><a href="#c-C">C</a></div>
				<div class="zimuOne"><a href="#d-D">D</a></div>
				<div class="zimuOne"><a href="#e-E">E</a></div>
				<div class="zimuOne"><a href="#f-F">F</a></div>
				<div class="zimuOne"><a href="#g-G">G</a></div>
				<div class="zimuOne"><a href="#h-H">H</a></div>
				<div class="zimuOne"><a href="#i-I">I</a></div>
				<div class="zimuOne"><a href="#j-J">J</a></div>
				<div class="zimuOne"><a href="#k-K">K</a></div>
				<div class="zimuOne"><a href="#l-L">L</a></div>
				<div class="zimuOne"><a href="#m-M">M</a></div>
				<div class="zimuOne"><a href="#n-N">N</a></div>
				<div class="zimuOne"><a href="#o-O">O</a></div>
				<div class="zimuOne"><a href="#p-P">P</a></div>
				<div class="zimuOne"><a href="#q-Q">Q</a></div>
				<div class="zimuOne"><a href="#r-R">R</a></div>
				<div class="zimuOne"><a href="#s-S">S</a></div>
				<div class="zimuOne"><a href="#t-T">T</a></div>
				<div class="zimuOne"><a href="#u-U">U</a></div>
				<div class="zimuOne"><a href="#v-V">V</a></div>
				<div class="zimuOne"><a href="#w-W">W</a></div>
				<div class="zimuOne"><a href="#x-X">X</a></div>
				<div class="zimuOne"><a href="#y-Y">Y</a></div>
				<div class="zimuOne"><a href="#z-Z">Z</a></div>
			</div>
	    </div>
	   </div>
	</div>	
</div>
</body>
<script>
	$(function(){
		var gofind=true;		
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
	
	//目的地和出发地切换功能(单程)
	function dancheng(){
		var shi001=$("#shi001").text();
		var shi0001=$("#shi0001").text();
		var shi00001=$("#shi00001").text();
		$("#shi001").text("");
		$("#shi0001").text("");
		$("#shi00001").text("");
		$("#shi001").text($("#zhong001").text());
		$("#shi0001").text($("#zhong0001").text());
		$("#shi00001").text($("#zhong00001").text());
		$("#zhong001").text(shi001);
		$("#zhong0001").text(shi0001);
		$("#zhong00001").text(shi00001);
	}
	
	//目的地和出发地切换功能(返程)
	function fangcheng(){
		var shif02=$("#shif02").text();
		var shif03=$("#shif03").text();
		var shif04=$("#shif04").text();
		$("#shif02").text("");
		$("#shif03").text("");
		$("#shif04").text("");
		$("#shif02").text($("#zhongf02").text());
		$("#shif03").text($("#zhongf03").text());
		$("#shif04").text($("#zhongf04").text());
		$("#zhongf02").text(shif02);
		$("#zhongf03").text(shif03);
		$("#zhongf04").text(shif04);
	}
	
	function aa(){
		var chufCity= $("#shi001").text();
		var daodCity = $("#zhong001").text();
		var chufPlan = $("#shi0001").text();
		var daodPlan = $("#zhong0001").text();
		var chufCityCode = $("#shi00001").text();
		var daodCityCode = $("#zhong00001").text();
		var cangW = $(".cang.on").text();
		var dateTime = $(".jcD01").val();
		if(dateTime==""){
			alert("请选择出发日期");
			gofind=false;
			return false;
		}else{
			gofind=true;
		}
		if(gofind==true){
			window.location.href="<%=basePath%>wechatController/page/mudiPlace.action?chufCity="+chufCity+"&daodCity="+daodCity+"&cangW="+cangW+"&dateTime="+dateTime+"&chufCityCode="+chufCityCode+"&daodCityCode="+daodCityCode+"&chufPlan="+chufPlan+"&daodPlan="+daodPlan;
		}
	}
	
	function bb(){
		var chufCity= $("#shif02").text();
		var daodCity = $("#zhongf02").text();
		var chufPlan = $("#shif03").text();
		var daodPlan = $("#zhongf03").text();
		var chufCityCode = $("#shif04").text();
		var daodCityCode = $("#zhongf04").text();
		var cangW = $(".cang1.on").text();
		var dateTime = $(".jcD02").val();
		if(dateTime==""){
			alert("请选择出发日期");
			gofind=false;
			return false;
		}else{
			gofind=true;
		}
		if(gofind==true){
			window.location.href="<%=basePath%>wechatController/page/mudiPlace.action?chufCity="+chufCity+"&daodCity="+daodCity+"&cangW="+cangW+"&dateTime="+dateTime+"&chufCityCode="+chufCityCode+"&daodCityCode="+daodCityCode+"&chufPlan="+chufPlan+"&daodPlan="+daodPlan;
		}
	}
</script>
</html>
