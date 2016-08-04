<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%
	String chufCity=new String(request.getParameter("chufCity").getBytes("ISO-8859-1"),"utf-8");
	String daodCity=new String(request.getParameter("daodCity").getBytes("ISO-8859-1"),"utf-8");
	String cangW=new String(request.getParameter("cangW").getBytes("ISO-8859-1"),"utf-8");
	String chufCityCode=new String(request.getParameter("chufCityCode").getBytes("ISO-8859-1"),"utf-8");
	String daodCityCode=new String(request.getParameter("daodCityCode").getBytes("ISO-8859-1"),"utf-8");
	String chufPlan=new String(request.getParameter("chufPlan").getBytes("ISO-8859-1"),"utf-8");
	String daodPlan=new String(request.getParameter("daodPlan").getBytes("ISO-8859-1"),"utf-8");
	String dateTime=request.getParameter("dateTime");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title><%=chufCity %>--><%=daodCity %></title>
<link rel="stylesheet" type="text/css"  href="<%=basePath%>console/css/loading.css" />
<style type="text/css">
	*{padding:0px;margin:0px;}
	body{text-align:center; font-size:14px; font:normal Helvetica, Arial, sans-serif; background-color:#ffffff; font-family:Microsoft JhengHei;}
	ul{list-style-type:none;}
	ul li{overflow:hidden;}
	.time .timeDiv{line-height:40px; color:#007AFF; font-weight:bold;}
	.time .timeDiv a:hover{cursor:pointer;}
	.tjTicket{}
	.tjTicket .tuijianImg{}
	.tjTicket .notTjTicketDiv{border-bottom:#E0E0E0 solid 1px; padding-top:0px;}
	.tjTicket .hanban{text-align:left; margin-left:5%;}
	.tjTicket .hanban .hanbanName,.tjTicket .hanban .hanbanCompany{height:35px;}
	.tjTicket .hanban .hanbanName span{color:#666666;}
	.tjTicket .hanban .hanbanCompany span{color:#C7C7C7;}
	.tjTicket .tuijianLan{height:70px;float:left;}
	.tjTicket .money{text-align:right; float:right; margin-right:10px;}
	.tjTicket .money .moneyPay,.tjTicket .money .zhekouPay{height:35px;}
	.tjTicket .money .zhekouPay{color:#c7c7c7;}
	.notTjTicket{}
	.notTjTicketDiv{padding-top:13px; height:70px; border-bottom:#E0E0E0 solid 1px;}
	.notTjTicket .notTjTicketDiv .lineHeight{line-height:25px;}
	.notTjTicket .notTjTicketDiv .lineHeight img{width:25px; height:24px;}
	.notTjTicket .notTjTicketDiv .StartTimeEnd{width:60px; float:left; margin-left:10px;}
	.notTjTicket .notTjTicketDiv .StartTimeEnd .StartTime{color:#666666;}
	.notTjTicket .notTjTicketDiv .StartTimeEnd .EndTime{color:#c7c7c7;} 
	.notTjTicket .notTjTicketDiv .StartAndEnd{float:left; text-align:left; margin-left:3%;}
	.notTjTicket .notTjTicketDiv .StartAndEnd .StartJC span{display:block; color:#666666; width:100px; height:25px; overflow:hidden;}
	.notTjTicket .notTjTicketDiv .StartAndEnd .EndTJC span{display:block; color:#c7c7c7; width:100px; height:25px; overflow:hidden;}
	.notTjTicket .notTjTicketDiv .moneyAndTicket{text-align:right; float:right; margin-right:10px;}
	.notTjTicket .notTjTicketDiv .moneyAndTicket .zuowei{color:#c7c7c7;}
	.hangbanImform{padding:20px 10px; background-color:#F1F5FF; text-align:center;}
	.hangbanImform .neiImform{width:85%; border:#007AFF solid 1px; margin-left:auto; margin-right:auto; border-radius:5px; background-color:#ffffff; padding:5px 10px;}
	.hangbanImform .neiImform .firstDiv{overflow:hidden; text-align:center;}
	.hangbanImform .neiImform .firstDiv .jjc{float:left; padding:5px;}
	.hangbanImform .neiImform .firstDiv .aYuding,.hangbanImform .neiImform .firstDiv .anotherCW{float:right; padding:5px 10px; border:#FF8204 solid 1px; color:#FFFFFF; background-color:#FF8204; border-radius:5px;}
	.hangbanImform .neiImform .firstDiv .money{color:#FF8204;}
	.hangbanImform .neiImform .firstDiv .zhe{color:#0079FE;}
	.hangbanImform .neiImform .firstDiv .Eimg{float:left; border:1px solid #0079FE; border-radius:10px; padding:0px 5px; background-color:#0079FE; color:#FFFFFF;}
	.hangbanImform .neiImform .firstDiv .pointer{float:right; color:#FF8204;}
	.hangbanImform .neiImform .firstDiv .licheng{float:right; margin-right:5px;}
	.hangbanImform .neiImform .firstDiv .shiyong{float:left; color:#FF8204; font-size:15px; font-family:Arial, Helvetica, sans-serif; line-height:22px;}
	.hangbanImform .neiImform .fourDiv{border-top:1px solid #E0E0E0; padding:10px 0px;}
	.hangbanImform .neiImform .firstDiv  .jiantou{float:left; color:#ffffff; background-color:#FF8204; border:1px solid #FF8204; font-size:10px; border-radius:10px; margin-left:5px; padding-left:3px; padding-right:2px; padding-bottom:1px;}
	.hangbanImform .neiImform .firstDiv  .piaojia{float:right; color:#FF8204; font-size:15px; font-family:Arial, Helvetica, sans-serif; line-height:22px;}
	.banner{ display:none;}
	.cangweiClass{ display:none;}
</style>
<script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
<script>

$(function(){ 
	var chufCityCode="<%=chufCityCode %>";
	var daodCityCode="<%=daodCityCode %>";
	var cangW="<%=cangW %>";
	var dateTime=$("#dateTimeID").text();
	conterCONTime(dateTime);//显示在中间的时间
	ajax(chufCityCode, daodCityCode, cangW, dateTime); //执行数据加载ajax
	
	$(".prevDate").click(function(){		
		var newDate = prevTime($("#dateTimeID").text());
		conterCONTime(newDate);
		$(".notTjTicket").remove();
		ajax(chufCityCode, daodCityCode, cangW, newDate); //执行数据加载ajax		
		$("#dateTimeID").text(newDate);
	});
	
	$(".nextDate").click(function(){		
		var newDate = nextTime($("#dateTimeID").text());//获取加上一天的日期
		conterCONTime(newDate);//把这个日期格式转换一个放在中间的标签中
		$(".notTjTicket").remove();//移除原来加载的数据
		ajax(chufCityCode, daodCityCode, cangW, newDate); //执行数据加载ajax		
		$("#dateTimeID").text(newDate);//把这个值重新赋值一下，当做下一此点击时再一次调用
	});
	
	var tjTicket=0;//推荐的机票
	if(tjTicket==1){
		var tjList='<li class="tjTicket"><div class="notTjTicketDiv"><div class="tuijianImg tuijianLan"><img src="<%=basePath %>console/images/tuijianImg.jpg" /></div><div class="hanban tuijianLan"><div class="hanbanName"><span style="line-height:40px;">深圳-->北京</span></div><div class="hanbanCompany"><span style="line-height:20px;">HU7710 海南航空</span></div></div><div class="money tuijianLan"><div class="moneyPay"><span style="line-height:35px; color:#FF8201;">￥806起</span></div><div class="zhekouPay"><span style="line-height:20px; font-size:12px;">4.5折</span></div></div><div style="clear:both;"></div></div><div class="banner"><div class="b-img"><div class="runDiv"><div class="hangbanImform"><div class="neiImform"><div class="firstDiv"><span class="jjc">经济舱</span><a class="aYuding">预定</a></div><div class="firstDiv" style="padding:10px 0px;"><span class="money">￥1760</span><span> / </span><span class="zhe">85折</span></div><div class="firstDiv" style="padding-bottom:5px;"><span class="Eimg">E</span><span class="pointer">100%</span><span class="licheng">里程累计比例</span></div><div class="firstDiv fourDiv"><span class="shiyong">使用条件</span><span class="jiantou">＞</span><span class="jiantou" style="float:right;">＞</span><span class="piaojia">对应舱位其他票价</span></div><div style="clear:both;"></div></div></div></div></li>';
		$("#TicketList").append(tjList);
	}
	
	//推荐的机票点击时执行
	
});

//封装ajax方法
function ajax(chufCityCode, daodCityCode, cangW, dateTime){
	//开始通过传递过来的几个参数进行后台查询之后加载查询结果
	$.ajax({
			url:"<%=basePath%>/wechatController/find/planTek.action",
			type:"POST",
			data:{"chufCity":chufCityCode,"daodCity":daodCityCode,"cangW":cangW,"dateTime":dateTime},
			dataType:"json",
			beforeSend:function(){
				$("#loading").css("display","block");
			},
			complete:function(){$("#loading").css("display","none");},
			success:function(data){
				if(data.msg==1){
					console.log(data.listDate);
					var getDate=data.listDate;
					for(var i=0;i<getDate.length;i++){
						var depTime=changeType(getDate[i].depTime);//经过处理的出发时间
						var arrTime=changeType(getDate[i].arrTime);//经过处理的到达时间
						var basicCabin="";	//舱位的类型（如：经济舱、头等舱、公务舱）
						var onewayPrice=""; //单程需要的价格
						var sum=0;
						var cuntNumTime=cuntTime(getDate[i].depTime , getDate[i].arrTime);//求出历经的时间
						for(var j=0;j<getDate[i].seatList.length;j++){
							basicCabin = getDate[i].seatList[j].basicCabin;
							if(basicCabin=="C"){
								basicCabin="公务舱";
							}else if(basicCabin=="F"){
								basicCabin="头等舱";
							}else if(basicCabin=="Y"){
								basicCabin="经济舱";
							}
							if(basicCabin==cangW){																
								var cangwei_data = parseInt(tekNum(getDate[i].seatList[j].cangwei_data));
								var cangwei_type = getDate[i].seatList[j].cangwei; //舱位的类型如(L、U、E...等)，类型不同价钱也不一样
								//console.log(i+"/"+j+"/"+cangwei_type);
								sum+=cangwei_data;//剩余的票数
								onewayPrice = getDate[i].seatList[j].onewayPrice;//价钱
							}						
						}
						var notTjList = '<li class="notTjTicket"><div class="notTjTicketDiv"><div class="StartTimeEnd"><div class="StartTime lineHeight">'+depTime+'</div><div class="EndTime lineHeight">'+arrTime+'</div></div><div class="StartAndEnd"><div class="StartJC lineHeight"><img src="<%=basePath %>console/images/shi.png" style="float:left;"/><span style="float:left;"><%=chufPlan%></span><span style="width:60px;">'+' '+getDate[i].flightNo+'</span></div><div style="clear:both;"></div><div class="EndTJC lineHeight"><img src="<%=basePath %>console/images/zhong.png" style="float:left;"><span style="float:left;"><%=daodPlan%></span><span style="width:60px;">'+' '+cuntNumTime+'</span></div></div><div class="moneyAndTicket"><div class="money lineHeight" style="color:#FF8201;">￥'+onewayPrice+'</div><div class="zuowei lineHeight" style="font-size:12px;">'+cangW+''+sum+'张</div></div><div style="clear:both;"></div></div><div class="banner"><div class="b-img"><div class="runDiv"><div class="hangbanImform"><div class="neiImform"><div class="firstDiv"><span class="jjc">'+cangW+'</span><a class="aYuding">预定</a></div><div class="firstDiv" style="padding:10px 0px;"><span class="money">￥'+onewayPrice+'</span><span> / </span><span class="zhe">85折</span></div><div class="firstDiv" style="padding-bottom:5px;"><span class="Eimg">'+cangwei_type+'</span><span class="pointer">100%</span><span class="licheng">里程累计比例</span></div><div class="firstDiv fourDiv"><span class="shiyong">使用条件</span><span class="jiantou">＞</span><span class="jiantou" style="float:right;">＞</span><span class="piaojia">对应舱位其他票价</span></div><div style="clear:both;"></div></div></div></div></div></div><div class="cangweiClass" style="height:auto;"></div></li>';              
						$("#TicketList").append(notTjList);	
						//动态加载针对该航班的其他舱位的信息
						for(var j=0;j<(getDate[i].seatList.length)-1;j++){
							basicCabin = getDate[i].seatList[j].basicCabin;
							if(basicCabin=="C"){
								basicCabin="公务舱";
							}else if(basicCabin=="F"){
								basicCabin="头等舱";
							}else if(basicCabin=="Y"){
								basicCabin="经济舱";
							}
							if(basicCabin==cangW){
								var cangwei_type = getDate[i].seatList[j].cangwei; //舱位的类型如(L、U、E...等)，类型不同价钱也不一样
								onewayPrice = getDate[i].seatList[j].onewayPrice;//价钱
								var listDiv='<div class="banner1"><div class="b-img"><div class="runDiv"><div class="hangbanImform"><div class="neiImform"><div class="firstDiv"><span class="jjc">'+cangW+'</span><a class="anotherCW">预定</a></div><div class="firstDiv" style="padding:10px 0px;"><span class="money">￥'+onewayPrice+'</span><span> / </span><span class="zhe">85折</span></div><div class="firstDiv" style="padding-bottom:5px;"><span class="Eimg">'+cangwei_type+'</span><span class="pointer">100%</span><span class="licheng">里程累计比例</span></div><div class="firstDiv fourDiv"><span class="shiyong">使用条件</span><span class="jiantou">＞</span></div><div style="clear:both;"></div></div></div></div></div></div>';
								$(".notTjTicket:eq("+i+") .cangweiClass").append(listDiv);
							}						
						}
					}					
					loadjs();//加载js外部文件
				}else if(data.msg==0){
					alert("没有查找到该航班的信息");
				}else{
					alert("查找数据错误");
				}
			},error:function(){
			}
	});
}

//计算剩余票价张数的方法
function tekNum(date){
	if(date=="A"){
		date=9;
	}else if(date=="L"||date=="Q"||date=="S"||date=="C"||date=="X"||date=="Z"){
		date="";
	}else if(date!=""){
		date=date;
	}
	return date;
}

//改变出发时间和到达时间的类型
function changeType(GoTime){	
	if(4<GoTime.length){
		var firstTime=GoTime.substring(0,2);
		var conterTime=GoTime.substring(2,4);
		var lastTime=GoTime.substring(4,GoTime.length);
		return firstTime+":"+conterTime+"<span style='color:#ff0000; font-size:10px;'>"+lastTime+"</span>";
	}else{			
		var firstTime=GoTime.substring(0,2);
		var lastTime=GoTime.substring(2,GoTime.length);
		return firstTime+":"+lastTime;
	}
}

//计算历经多长时间到达
function cuntTime(depTime,arrTime){
	if(4<arrTime.length){	
		var firstTime=arrTime.substring(0,4);	
		var arrTime01 = parseInt(firstTime);
		var depTime01 = parseInt(depTime);
		var oneDayTime = 2400;
		var resultTime = (oneDayTime-depTime01)+arrTime01+'';
		if(resultTime.length==4){		
			var firstTime=resultTime.substring(0,2);
			var lastTime=resultTime.substring(2,resultTime.length);
			resultTime = firstTime+"时"+lastTime+"分";		
		}else if(resultTime.length==3){			
			var firstTime=resultTime.substring(0,1);
			var lastTime=resultTime.substring(1,resultTime.length);
			resultTime = firstTime+"时"+lastTime+"分";
		}
		return resultTime;
	}else{
		var arrTime01 = parseInt(arrTime);
		var depTime01 = parseInt(depTime);
		var numTime = (arrTime01-depTime01)+'';//将数字转化成字符型
		if(numTime.length==4){		
			var firstTime=numTime.substring(0,2);
			var lastTime=numTime.substring(2,numTime.length);
			numTime = firstTime+"时"+lastTime+"分";		
		}else if(numTime.length==3){			
			var firstTime=numTime.substring(0,1);
			var lastTime=numTime.substring(1,numTime.length);
			numTime = firstTime+"时"+lastTime+"分";
		}		
		return numTime;
	}
}

//对传过来的时间进行处理，为了实现前一天和后一天的切换
function conterCONTime(time){
	var yymmdd = time.split("-"); //拆分传进来的时间
	//根据时间获取星期
	var date = time;
	var day = new Date(Date.parse(date.replace(/-/g, '/')));  
	var today = new Array('周日','周一','周二','周三','周四','周五','周六');  
	var week = today[day.getDay()]; //获得星期
	var mmdd = yymmdd[1]+"月"+yymmdd[2]+"日 "+week;
	$(".mmddWeek").text(mmdd);
}

//前一天时间切换
function prevTime(time){
	var date = new Date(time);
 	date.setDate(date.getDate() - 1);
 	var yy = date.getFullYear();
 	var mm = date.getMonth()+1;
 	var dd = date.getDate();
 	if(mm < 10){
 		mm = "0"+mm;
 	}
 	if(dd<10){
 		dd = "0"+dd;
 	}
 	return yy+"-"+mm+"-"+dd;
}

//后一天时间切换
function nextTime(time){
	var date = new Date(time);
 	date.setDate(date.getDate() + 1);
 	var yy = date.getFullYear();
 	var mm = date.getMonth()+1;
 	var dd = date.getDate();
 	if(mm < 10){
 		mm = "0"+mm;
 	}
 	if(dd<10){
 		dd = "0"+dd;
 	}
 	return yy+"-"+mm+"-"+dd;
}

//重新加载指定js文件
function loadjs(){
	var jsElem = document.createElement('script');
	jsElem.src='<%=basePath%>console/js/mudiPlace.js';
	document.getElementsByTagName('head')[0].appendChild(jsElem);
}
</script>
</head>

<body>
<ul id="TicketList">
	<li class="time" style="border-bottom:#E0E0E0 solid 1px; background-color:#F8F8F8; height:40px;">
		<div class="timeDiv" style="float:left; width:25%; "><a class="prevDate">＜前一天</a></div>
		<div class="timeDiv mmddWeek" style="float:left; width:35%; text-align:right;"></div>
		<div id="dateTimeID" style="display:none;"><%=dateTime %></div>
		<!-- <div class="timeDiv" style="float:left; width:15%; text-align:left;">明天▼</div> -->
		<div class="timeDiv" style="float:right; width:25%; "><a class="nextDate">后一天＞</a><a id="basePath" style="display:none;"><%=basePath %></a></div>
		<div style="clear:both;"></div>
	</li>
	<!--推荐机票-->

	<!--机票列表--> 
	
</ul>

	<!-- 加载等待界面 -->	
	<div id="loading">
		<div id="loading-center">
			<div id="loading-center-absolute">
				<div class="object" id="object_four"></div>
				<div class="object" id="object_three"></div>
				<div class="object" id="object_two"></div>
				<div class="object" id="object_one"></div>
			</div>
			<div style="color:#ffffff; position:absolute; left:37%; top:58%;">数据加载中...</div>
		</div> 
	</div>
</body>
</html>
