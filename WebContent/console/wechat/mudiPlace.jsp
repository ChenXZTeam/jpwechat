<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%
	String chufCity=new String(request.getParameter("chufCity").getBytes("ISO-8859-1"),"utf-8");
	String daodCity=new String(request.getParameter("daodCity").getBytes("ISO-8859-1"),"utf-8");
	String cangW=new String(request.getParameter("cangW").getBytes("ISO-8859-1"),"utf-8");
	String dateTime=request.getParameter("dateTime");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>深圳-->北京</title>
<link rel="stylesheet" type="text/css"  href="<%=basePath%>console/css/bannerPlanTek.css" />
<style type="text/css">
	*{padding:0px;margin:0px;}
	body{text-align:center; font-size:14px; font:normal Helvetica, Arial, sans-serif; background-color:#ffffff; font-family:Microsoft JhengHei;}
	ul{list-style-type:none;}
	ul li{overflow:hidden;}
	.time .timeDiv{line-height:40px; color:#007AFF; font-weight:bold;}
	.time .timeDiv a:hover{cursor:pointer;}
	.tjTicket{border-bottom:#E0E0E0 solid 1px;}
	.tjTicket .tuijianImg{width:}
	.tjTicket .hanban{text-align:left; margin-left:5%;}
	.tjTicket .hanban .hanbanName,.tjTicket .hanban .hanbanCompany{height:35px;}
	.tjTicket .hanban .hanbanName span{color:#666666;}
	.tjTicket .hanban .hanbanCompany span{color:#C7C7C7;}
	.tjTicket .tuijianLan{height:70px;float:left;}
	.tjTicket .money{text-align:right; float:right; margin-right:10px;}
	.tjTicket .money .moneyPay,.tjTicket .money .zhekouPay{height:35px;}
	.tjTicket .money .zhekouPay{color:#c7c7c7;}
	.notTjTicket{padding-top:13px; height:70px; border-bottom:#E0E0E0 solid 1px;}
	.notTjTicket .lineHeight{line-height:25px;}
	.notTjTicket .StartTimeEnd{width:60px; float:left; margin-left:20px;}
	.notTjTicket .StartTimeEnd .StartTime{color:#666666;}
	.notTjTicket .StartTimeEnd .EndTime{color:#c7c7c7;}
	.notTjTicket .StartAndEnd{float:left; text-align:left; margin-left:5%;}
	.notTjTicket .StartAndEnd .StartJC span{color:#666666;}
	.notTjTicket .StartAndEnd .EndTJC span{color:#c7c7c7;}
	.notTjTicket .moneyAndTicket{text-align:right; float:right; margin-right:10px;}
	.notTjTicket .moneyAndTicket .zuowei{color:#c7c7c7;}
	.hangbanImform{padding:20px 10px; background-color:#F1F5FF; text-align:center;}
	.hangbanImform .neiImform{width:85%; border:#007AFF solid 1px; margin-left:auto; margin-right:auto; border-radius:5px; background-color:#ffffff; padding:5px 10px;}
	.hangbanImform .neiImform .firstDiv{overflow:hidden; text-align:center;}
	.hangbanImform .neiImform .firstDiv .jjc{float:left; padding:5px;}
	.hangbanImform .neiImform .firstDiv .aYuding{float:right; padding:5px 10px; border:#FF8204 solid 1px; color:#FFFFFF; background-color:#FF8204; border-radius:5px;}
	.hangbanImform .neiImform .firstDiv .money{color:#FF8204;}
	.hangbanImform .neiImform .firstDiv .zhe{color:#0079FE;}
	.hangbanImform .neiImform .firstDiv .Eimg{float:left; border:1px solid #0079FE; border-radius:10px; padding:0px 5px; background-color:#0079FE; color:#FFFFFF;}
	.hangbanImform .neiImform .firstDiv .pointer{float:right; color:#FF8204;}
	.hangbanImform .neiImform .firstDiv .licheng{float:right; margin-right:5px;}
	.hangbanImform .neiImform .firstDiv .shiyong{float:left; color:#FF8204; font-size:15px; font-family:Arial, Helvetica, sans-serif; line-height:22px;}
	.hangbanImform .neiImform .fourDiv{border-top:1px solid #E0E0E0; padding:10px 0px;}
	.hangbanImform .neiImform .firstDiv  .jiantou{float:left; color:#ffffff; background-color:#FF8204; border:1px solid #FF8204; font-size:10px; border-radius:10px; margin-left:5px; padding-left:3px; padding-right:2px; padding-bottom:1px;}
	.hangbanImform .neiImform .firstDiv  .piaojia{float:right; color:#FF8204; font-size:15px; font-family:Arial, Helvetica, sans-serif; line-height:22px;}
</style>
<script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
<script>
$(function(){ 
	var chufCity="<%=chufCity %>";
	var daodCity="<%=daodCity %>";
	var cangW="<%=cangW %>";
	var dateTime="<%=dateTime %>";
	alert(chufCity);
	alert(daodCity);
	alert(cangW);
	alert(dateTime);
	
	//开始通过传递过来的几个参数进行后台查询之后加载查询结果
	$.ajax({
			url:"<%=basePath%>/wechatController/find/planTek.action",
			type:"POST",
			data:{"chufCity":chufCity,"daodCity":daodCity,"cangW":cangW,"dateTime":dateTime},
			dataType:"json",
			success:function(data){
				if(data.msg==1){
					console.log(data.listDate);
					var getDate=data.listDate;
					for(var i=0;i<getDate.length;i++){
						var notTjList = '<li class="notTjTicket"><div class="StartTimeEnd"><div class="StartTime lineHeight">'+getDate[i].depTime+'</div><div class="EndTime lineHeight">'+getDate[i].arrTime+'</div></div><div class="StartAndEnd"><div class="StartJC lineHeight"><img src="<%=basePath %>console/images/shi.jpg" style="float:left;"/><span style="float:left;">宝安机场 '+getDate[i].flightNo+'</span></div><div style="clear:both;"></div><div class="EndTJC lineHeight"><img src="<%=basePath %>console/images/zhong.jpg" style="float:left;"><span style="float:left;">首都机场 3时05分</span></div></div><div class="moneyAndTicket"><div class="money lineHeight" style="color:#FF8201;">￥953</div><div class="zuowei lineHeight" style="font-size:12px;">二等座436张</div></div><div style="clear:both;"></div></li>';
						$("#TicketList").append(notTjList);
					}
				}else if(data.msg==0){
					alert("没有查找到该航班的信息");
				}else{
					alert("查找数据错误");
				}
				/* alert(getDate.length);
				alert(getDate[0].airCode);
				alert(getDate[0].seatList[0].basicCabin);
				alert("能行"); */
			},error:function(){
				alert("不行");
			}
	});
	
	var tjTicket=1;//推荐的机票
	if(tjTicket==1){
		var tjList='<li class="tjTicket"><div class="tuijianImg tuijianLan"><img src="<%=basePath %>console/images/tuijianImg.jpg" /></div><div class="hanban tuijianLan"><div class="hanbanName"><span style="line-height:40px;">深圳-->北京</span></div><div class="hanbanCompany"><span style="line-height:20px;">HU7710 海南航空</span></div></div><div class="money tuijianLan"><div class="moneyPay"><span style="line-height:35px; color:#FF8201;">￥806起</span></div><div class="zhekouPay"><span style="line-height:20px; font-size:12px;">4.5折</span></div></div><div style="clear:both;"></div></li>';
		$("#TicketList").append(tjList);
	}
	
	//推荐的机票点击时执行
	$(".tjTicket").click(function(){ 
		var tekInform='<div class="banner"><div class="b-img"><div class="runDiv"><div class="hangbanImform"><div class="neiImform"><div class="firstDiv"><span class="jjc">经济舱</span><a class="aYuding">预定</a></div><div class="firstDiv" style="padding:10px 0px;"><span class="money">￥1760</span><span> / </span><span class="zhe">85折</span></div><div class="firstDiv" style="padding-bottom:5px;"><span class="Eimg">E</span><span class="pointer">100%</span><span class="licheng">里程累计比例</span></div><div class="firstDiv fourDiv"><span class="shiyong">使用条件</span><span class="jiantou">＞</span><span class="jiantou" style="float:right;">＞</span><span class="piaojia">对应舱位其他票价</span></div><div style="clear:both;"></div></div></div></div><div class="runDiv"><div class="hangbanImform"><div class="neiImform"><div class="firstDiv"><span class="jjc">头等舱</span><a class="aYuding">预定</a></div><div class="firstDiv" style="padding:10px 0px;"><span class="money">￥5800</span><span> / </span><span class="zhe">279折</span></div><div class="firstDiv" style="padding-bottom:5px;"><span class="Eimg">E</span><span class="pointer">300%</span><span class="licheng">里程累计比例</span></div><div class="firstDiv fourDiv"><span class="shiyong">使用条件</span><span class="jiantou">＞</span><span class="jiantou" style="float:right;">＞</span><span class="piaojia">对应舱位其他票价</span></div><div style="clear:both;"></div></div></div></div><div class="runDiv"><div class="hangbanImform"><div class="neiImform"><div class="firstDiv"><span class="jjc">商务舱</span><a class="aYuding">预定</a></div><div class="firstDiv" style="padding:10px 0px;"><span class="money">￥6800</span><span> / </span><span class="zhe">569折</span></div><div class="firstDiv" style="padding-bottom:5px;"><span class="Eimg">E</span><span class="pointer">无</span><span class="licheng">里程累计比例</span></div><div class="firstDiv fourDiv"><span class="shiyong">使用条件</span><span class="jiantou">＞</span><span class="jiantou" style="float:right;">＞</span><span class="piaojia">对应舱位其他票价</span></div><div style="clear:both;"></div></div></div></div></div><div class="b-list"></div><a class="bar-left" href="#"><em></em></a><a class="bar-right" href="#"><em></em></a><div style="clear:both;"></div></div>';
		$(this).siblings().remove('.banner');
		$(this).after(tekInform);
		loadjs();
	});
	
	
	//选中航班时执行
	$(".notTjTicket").click(function(){
		var tekInform='<div class="banner"><div class="b-img"><div class="runDiv"><div class="hangbanImform"><div class="neiImform"><div class="firstDiv"><span class="jjc">经济舱</span><a class="aYuding">预定</a></div><div class="firstDiv" style="padding:10px 0px;"><span class="money">￥1760</span><span> / </span><span class="zhe">85折</span></div><div class="firstDiv" style="padding-bottom:5px;"><span class="Eimg">E</span><span class="pointer">100%</span><span class="licheng">里程累计比例</span></div><div class="firstDiv fourDiv"><span class="shiyong">使用条件</span><span class="jiantou">＞</span><span class="jiantou" style="float:right;">＞</span><span class="piaojia">对应舱位其他票价</span></div><div style="clear:both;"></div></div></div></div><div class="runDiv"><div class="hangbanImform"><div class="neiImform"><div class="firstDiv"><span class="jjc">头等舱</span><a class="aYuding">预定</a></div><div class="firstDiv" style="padding:10px 0px;"><span class="money">￥5800</span><span> / </span><span class="zhe">279折</span></div><div class="firstDiv" style="padding-bottom:5px;"><span class="Eimg">E</span><span class="pointer">300%</span><span class="licheng">里程累计比例</span></div><div class="firstDiv fourDiv"><span class="shiyong">使用条件</span><span class="jiantou">＞</span><span class="jiantou" style="float:right;">＞</span><span class="piaojia">对应舱位其他票价</span></div><div style="clear:both;"></div></div></div></div><div class="runDiv"><div class="hangbanImform"><div class="neiImform"><div class="firstDiv"><span class="jjc">商务舱</span><a class="aYuding">预定</a></div><div class="firstDiv" style="padding:10px 0px;"><span class="money">￥6800</span><span> / </span><span class="zhe">569折</span></div><div class="firstDiv" style="padding-bottom:5px;"><span class="Eimg">E</span><span class="pointer">无</span><span class="licheng">里程累计比例</span></div><div class="firstDiv fourDiv"><span class="shiyong">使用条件</span><span class="jiantou">＞</span><span class="jiantou" style="float:right;">＞</span><span class="piaojia">对应舱位其他票价</span></div><div style="clear:both;"></div></div></div></div></div><div class="b-list"></div><a class="bar-left" href="#"><em></em></a><a class="bar-right" href="#"><em></em></a><div style="clear:both;"></div></div>';
		$(this).siblings().remove('.banner');
		$(this).after(tekInform);
		loadjs();
	});
	
});

//重新加载指定js文件
function loadjs(){
	var jsElem = document.createElement('script');
	jsElem.src='<%=basePath%>console/js/bannerPlanTek.js';
	document.getElementsByTagName('head')[0].appendChild(jsElem);
}
</script>
</head>

<body>
<ul id="TicketList">
	<li class="time" style="border-bottom:#E0E0E0 solid 1px; background-color:#F8F8F8; height:40px;">
		<div class="timeDiv" style="float:left; width:25%; "><a>＜前一天</a></div>
		<div class="timeDiv" style="float:left; width:35%; text-align:right;">12月19日 周三</div>
		<div class="timeDiv" style="float:left; width:15%; text-align:left;">明天▼</div>
		<div class="timeDiv" style="float:left; width:25%; "><a>后一天＞</a></div>
		<div style="clear:both;"></div>
	</li>
	<!--推荐机票-->

	<!--机票列表--> 
	
</ul>
</body>
</html>
