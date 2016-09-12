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
<link type="text/css" rel="stylesheet" href="<%=basePath %>console/css/QZcityChoose.css"/>
<script type="text/javascript"  src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/jquery.touchSwipe.min.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/qzBanner.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/QZcityChoose.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=vKCQUCy8RGAuMMHU3iPH226z32Ojt6fI" charset="utf-8"></script>
<style type="text/css">
	body{padding:0px; margin:0px; background-color:#F9F9F9;}
	#bigContent{padding:0px;}
	#find{padding:10px 10px 5px 10px; text-align:center;}
	#xFind{border-radius:5px; background-color:#FFFFFF;}
	#xFind .inputName,.inputDiv{padding:5px 10px; overflow:hidden; float:left;}	
	#xFind img,span,input{float:left; outline:none; }
	.qzBackImg{margin-top:0px;}
	.cityTitle{padding:15px 10px 5px 0px; font-size:15px; color:#666666; background-color:#FFFFFF; font-family:Microsoft YaHei; border-bottom:solid 1px #DCDCDC;}
	.dazhou{ background-color:#FFFFFF; padding-top:10px; padding-bottom:10px;}
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
			<div class="inputName" style="border-right:#F0EFF4 solid 1px;"><img src="<%=basePath %>console/images/dingwei.gif" style="width:12px; margin-top:-1px;"/><span style="color:#0278FC; margin-left:5px; line-height:20px; font-size:13px;" id="cityName">北京市</span></div>
			<div class="inputDiv" style="padding-left:3px;"><img src="<%=basePath %>console/images/findImgSma.png" style="width:20px;"/><input type="text" id="cityFindInpt" style="font-size:13px; padding-top:3px; color:#666666; border:none; margin-left:5px;"  placeholder="你想去哪儿？"/></div>
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
		<div style="clear:both;"><span id="basePathID" style="display:none;"><%=basePath %></span></div>
	</div>
	
	<!--热门大洲-->
	<div class="dazhou">
		<div class="float" id="ya"><img src="<%=basePath %>console/images/qiuMap02.gif"/><span style="color:#56ABE4;">亚洲</span></div>
		<div class="float" id="mei"><img src="<%=basePath %>console/images/meizhou01.gif" style="height:31px;"/><span>美洲</span></div>
		<div class="float" id="fei"><img src="<%=basePath %>console/images/feizhou01.gif"/><span>非洲</span></div>
		<div class="float" id="ou"><img src="<%=basePath %>console/images/ouzhou01.png"/><span>欧洲</span></div>
		<div style="clear:both"></div>
	</div>
	
	<!--热门国家（亚洲）-->
	<div id="yazhou" class="contryClassZ">
		<ul>
			<li><span class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/thailand.jpg'); background-size:100% 60px; background-repeat:no-repeat;">泰国</span><span class="countryNum">100001</span><span class="contryMonty">￥1302</span></li>
			<li><span class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/japan.jpg'); background-size:100% 60px; background-repeat:no-repeat;">日本</span><span class="countryNum">100002</span><span class="contryMonty">￥1302</span></li>
			<li><span class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/singapore.jpg'); background-size:100% 60px; background-repeat:no-repeat;">新加坡</span><span class="countryNum">100003</span><span class="contryMonty">￥1302</span></li>
		</ul>
		<ul>
			<li><span class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/taiwan.jpg'); background-size:100% 60px; background-repeat:no-repeat;">台湾</span><span class="countryNum">100004</span><span class="contryMonty">￥1302</span></li>
			<li><span class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/malaysia.jpg'); background-size:100% 60px; background-repeat:no-repeat;">马来西亚</span><span class="countryNum">100005</span><span class="contryMonty">￥1302</span></li>
			<li><span class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/korea.jpg'); background-size:100% 60px; background-repeat:no-repeat;">韩国</span><span class="countryNum">100006</span><span class="contryMonty">￥1302</span></li>
		</ul>
		<div style="clear:both;"></div>
	</div>
	
	<!--美洲-->
	<div id="meizhou" class="contryClassZ">
        <ul>
			<li><span class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/usa.jpg'); background-size:100% 60px; background-repeat:no-repeat;">美国</span><span class="countryNum">100007</span><span class="contryMonty">￥1302</span></li>
			<li><span class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/canada.jpg'); background-size:100% 60px; background-repeat:no-repeat;">加拿大</span><span class="countryNum">100008</span><span class="contryMonty">￥1302</span></li>
			<li><span class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/brazil.jpg'); background-size:100% 60px; background-repeat:no-repeat;">巴西</span><span class="countryNum">100009</span><span class="contryMonty">￥1302</span></li>
		</ul>
		<ul>
			<li><span class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/argentina.jpg'); background-size:100% 60px; background-repeat:no-repeat;">阿根廷</span><span class="countryNum">100010</span><span class="contryMonty">￥1302</span></li>
			<li><span class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/mexico.jpg'); background-size:100% 60px; background-repeat:no-repeat;">墨西哥</span><span class="countryNum">100011</span><span class="contryMonty">￥1302</span></li>
			<li><span class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/hawaii.jpg'); background-size:100% 60px; background-repeat:no-repeat;">夏威夷</span><span class="countryNum">100012</span><span class="contryMonty">￥1302</span></li>
		</ul>
		<div style="clear:both;"></div>
	</div>
	
	<!--非洲-->
	<div id="feizhou" class="contryClassZ">
        <ul>
			<li><span class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/cairo.jpg'); background-size:100% 60px; background-repeat:no-repeat;">开罗</span><span class="countryNum">100013</span><span class="contryMonty">￥1302</span></li>
			<li><span class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/capetown.jpg'); background-size:100% 60px; background-repeat:no-repeat;">开罗</span><span class="countryNum">100014</span><span class="contryMonty">￥1302</span></li>
			<li><span class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/nebbiolo.jpg'); background-size:100% 60px; background-repeat:no-repeat;">内毕罗</span><span class="countryNum">100015</span><span class="contryMonty">￥1302</span></li>
		</ul>
		<ul>
			<li><span class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/algiers.jpg'); background-size:100% 60px; background-repeat:no-repeat;">阿尔及尔</span><span class="countryNum">100016</span><span class="contryMonty">￥1302</span></li>
			<li><span class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/lagos.jpg'); background-size:100% 60px; background-repeat:no-repeat;">拉各斯</span><span class="countryNum">100017</span><span class="contryMonty">￥1302</span></li>
			<li><span class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/kinshasa.jpg'); background-size:100% 60px; background-repeat:no-repeat;">金沙萨</span><span class="countryNum">100018</span><span class="contryMonty">￥1302</span></li>
		</ul>
		<div style="clear:both;"></div>
	</div>
	
	<!--欧洲-->
	<div id="ouzhou" class="contryClassZ">
        <ul>
			<li><span class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/swit.jpg'); background-size:100% 60px; background-repeat:no-repeat;">瑞士</span><span class="countryNum">100019</span><span class="contryMonty">￥1302</span></li>
			<li><span class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/netherlands.jpg'); background-size:100% 60px; background-repeat:no-repeat;">荷兰</span><span class="countryNum">100020</span><span class="contryMonty">￥1302</span></li>
			<li><span class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/riga.jpg'); background-size:100% 60px; background-repeat:no-repeat;">里加</span><span class="countryNum">100021</span><span class="contryMonty">￥1302</span></li>
		</ul>
		<ul>
			<li><span class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/budapest.jpg'); background-size:100% 60px; background-repeat:no-repeat;">布达佩斯</span><span class="countryNum">100022</span><span class="contryMonty">￥1302</span></li>
			<li><span class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/copenhagen.jpg'); background-size:100% 60px; background-repeat:no-repeat;">哥本哈根</span><span class="countryNum">100023</span><span class="contryMonty">￥1302</span></li>
			<li><span class="remenCantroyClass" style="background:url('<%=basePath %>tempoImg/serbia.jpg'); background-size:100% 60px; background-repeat:no-repeat;">塞尔维亚</span><span class="countryNum">100024</span><span class="contryMonty">￥1302</span></li>
		</ul>
		<div style="clear:both;"></div>
	</div>
	
	<!-- 免签、落地签国家连接 -->
	<div style="text-align:right; margin-top:15px; margin-right:10px;"><a href="<%=basePath %>console/wechat/qzOtherCountry.jsp" style="color:#999999;font-size:11px; text-decoration:none;">去查看免签、落地签国家有哪些？</a></div>
</div>

<!-- 城市选择 -->
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
			<li><div class="remenLi">泰国</div></li>
			<li><div class="remenLi">日本</div></li>
			<li><div class="remenLi">韩国</div></li>
			<li><div class="remenLi">新加坡</div></li>
			<li><div class="remenLi">美国</div></li>
			<li><div class="remenLi">法国</div></li>
			<li><div class="remenLi">夏威夷</div></li>
			<li><div class="remenLi">阿根廷</div></li>
			<li><div class="remenLi">埃及</div></li>
			<li><div class="remenLi">内毕罗</div></li>
		</ul>
		<div style="clear:both;"></div>
	</div>
	
    <!---城市详细列表部分---->
	<div id="CityList">
				<div id="A-a" class="zimuResult">
					<div class="zimuTitle"><span>A</span></div>
					<ul class="cityUL">
						<li>奥地利</li>
					</ul>
				</div>
				<div id="B-b" class="zimuResult">
					<div class="zimuTitle"><span>B</span></div>
					<ul class="cityUL">
						<li>巴西</li>
					</ul>			
				</div>
				<div id="C-c" class="zimuResult">
					<div class="zimuTitle"><span>C</span></div>
					<ul class="cityUL">
						<li>朝鲜</li>
					</ul>
				</div>
				<div id="D-d" class="zimuResult">
					<div class="zimuTitle"><span>D</span></div>
					<ul class="cityUL">
						<li>德国</li>
					</ul>
				</div>
				<div id="E-e" class="zimuResult">
					<div class="zimuTitle"><span>E</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
					</ul>
				</div>
				<div id="F-f" class="zimuResult">
					<div class="zimuTitle"><span>F</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
					</ul>
				</div>
				<div id="G-g" class="zimuResult">
					<div class="zimuTitle"><span>G</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
					</ul>
				</div>
				<div id="H-h" class="zimuResult">
					<div class="zimuTitle"><span>H</span></div>
					<ul class="cityUL">
						<li>海地</li>
					</ul>
				</div>
				<div id="I-i" class="zimuResult">
					<div class="zimuTitle"><span>I</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
					</ul>
				</div>
				<div id="J-j" class="zimuResult">
					<div class="zimuTitle"><span>J</span></div>
					<ul class="cityUL">
						<li>吉隆坡</li>
					</ul>
				</div>
				<div id="K-k" class="zimuResult">
					<div class="zimuTitle"><span>K</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
					</ul>
				</div>
				<div id="L-l" class="zimuResult">
					<div class="zimuTitle"><span>L</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
					</ul>
				</div>
				<div id="M-m" class="zimuResult">
					<div class="zimuTitle"><span>M</span></div>
					<ul class="cityUL">
						<li>马耳他</li>
					</ul>
				</div>
				<div id="N-n" class="zimuResult">
					<div class="zimuTitle"><span>N</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
					</ul>
				</div>
				<div id="O-o" class="zimuResult">
					<div class="zimuTitle"><span>O</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
					</ul>
				</div>
				<div id="P-p" class="zimuResult">
					<div class="zimuTitle"><span>P</span></div>
					<ul class="cityUL">
						<li>葡萄牙</li>
					</ul>
				</div>
				<div id="Q-q" class="zimuResult">
					<div class="zimuTitle"><span>Q</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
					</ul>
				</div>
				<div id="R-r" class="zimuResult">
					<div class="zimuTitle"><span>R</span></div>
					<ul class="cityUL">
						<li>日本</li>
					</ul>
				</div>
				<div id="S-s" class="zimuResult">
					<div class="zimuTitle"><span>S</span></div>
					<ul class="cityUL">
						<li>苏丹</li>
					</ul>
				</div>
				<div id="T-t" class="zimuResult">
					<div class="zimuTitle"><span>T</span></div>
					<ul class="cityUL">
						<li>泰国</li>
					</ul>
				</div>
				<div id="U-u" class="zimuResult">
					<div class="zimuTitle"><span>U</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
					</ul>
				</div>
				<div id="V-v" class="zimuResult">
					<div class="zimuTitle"><span>V</span></div>
					<ul class="cityUL">
						<li>啊是大富科技</li>
					</ul>
				</div>
				<div id="W-w" class="zimuResult">
					<div class="zimuTitle"><span>W</span></div>
					<ul class="cityUL">
						<li>乌兰巴托</li>
					</ul>
				</div>
				<div id="X-x" class="zimuResult">
					<div class="zimuTitle"><span>X</span></div>
					<ul class="cityUL">
						<li>新西兰</li>
					</ul>
				</div>
				<div id="Y-y" class="zimuResult">
					<div class="zimuTitle"><span>Y</span></div>
					<ul class="cityUL">
						<li>英格兰</li>
					</ul>
				</div>
				<div id="Z-z" class="zimuResult">
					<div class="zimuTitle"><span>Z</span></div>
					<ul class="cityUL">
						<li>智利</li>
					</ul>
				</div>
	</div>
			
	<!---右边字母查找部分--->
	<div class="zimuListImgDiv"><img src="<%=basePath %>console/images/cityPoint.png" /></div>
	<div class="zimuList">
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
<div class="zimuTishi">A</div>
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
			$(this).children("span").css("color","#56ABE4");
		});
		
		$("#cityFindInpt").click(function(){
			$("#CityCH").fadeIn();
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
		
		$(".remenCantroyClass").click(function(){
			var country = $(this).text();
			window.location.href="<%=basePath %>console/wechat/qzOneCoInfo.jsp?countryName="+country+"&countryId=213543";
		});
	});
	
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
	
	
	
	//百度定位的方法
	var geolocation = new BMap.Geolocation();    
	var gc = new BMap.Geocoder();     
	geolocation.getCurrentPosition( function(r) {  //定位结果对象会传递给r变量 
	        if(this.getStatus() == BMAP_STATUS_SUCCESS){  //通过Geolocation类的getStatus()可以判断是否成功定位。  
	            var pt = r.point; 
	            var mk = new BMap.Marker(r.point);  
        		//alert('您的位置：'+r.point.lng+','+r.point.lat);  //获取定位后的坐标  
	            gc.getLocation(pt, function(rs){    
	                var addComp = rs.addressComponents; 
	                $("#cityName").text(addComp.city);
	                //alert('您的位置：'+addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber);
	                console.log(addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber);    
	            }); 
	        }
	});
</script>
</body>
</html>