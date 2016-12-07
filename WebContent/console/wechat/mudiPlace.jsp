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
<link rel="stylesheet" href="<%=basePath%>console/css/weui.min.css" />
<link rel="stylesheet" href="<%=basePath%>console/css/jquery-weui.css" />
<link rel="stylesheet" type="text/css"  href="<%=basePath%>console/css/loading.css" />
<script src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script src="<%=basePath %>console/js/jquery-weui.js"></script>
<script src="<%=basePath %>console/js/airCodeVScity.js?yim=2015"></script>
<style type="text/css">
	*{padding:0px;margin:0px;}
	body{text-align:center; font-size:13px; font:normal Helvetica, Arial, sans-serif; background-color:#ffffff;}
	ul{list-style-type:none;}
	ul li{overflow:hidden;}
	.time .timeDiv{line-height:40px; color:#666666; font-size:15px;}
	.time #cendivBox{overflow: hidden; float: left; width: 50%; text-align: center;}
	.time .mmddWeek{background:url('<%=basePath %>console/images/riliImgblue.png') no-repeat 13px 6px; text-align:right; background-size:17px 16px; width:140px; height: 30px; border: 1px solid #f0f0f0; margin-left: auto; margin-right: auto; line-height: 30px; margin-top: 5px; padding: 0px 10px; background-color: #fff; border-radius: 5px;}
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
	.notTjTicketDiv{padding-top:13px; height:60px; border-bottom:#E0E0E0 solid 1px;}
	.notTjTicket .notTjTicketDiv .lineHeight{line-height:25px; text-align: left; overflow:hidden;}
	.notTjTicket .notTjTicketDiv .lineHeight img{width:20px; margin-top:2px;}
	.notTjTicket .notTjTicketDiv .StartTimeEnd{float:left; margin-left:10px; width:50px;}
	.notTjTicket .notTjTicketDiv .StartTimeEnd .StartTime{color:#666666;font-size: 15px;}
	.notTjTicket .notTjTicketDiv .StartTimeEnd .EndTime{color:#999999;} 
	.notTjTicket .notTjTicketDiv .StartAndEnd{float:left; text-align:left; margin-left:5%;}
	.notTjTicket .notTjTicketDiv .StartAndEnd .StartJC span{display:block; color:#666666; height:25px; overflow:hidden; font-size: 15px;}
	.notTjTicket .notTjTicketDiv .StartAndEnd .EndTJC span{display:block; color:#999999; height:25px; overflow:hidden; font-size: 13px;}
	.notTjTicket .notTjTicketDiv .moneyAndTicket{text-align:right; float:right; margin-right:10px;}
	.notTjTicket .notTjTicketDiv .moneyAndTicket .zuowei{color:#999999;}
	.hangbanImform{padding:20px 10px; background-color:#F1F5FF; text-align:center;}
	.hangbanImform .neiImform{width:85%; border:#007AFF solid 1px; margin-left:auto; margin-right:auto; border-radius:5px; background-color:#ffffff; padding:5px 10px;}
	.hangbanImform .neiImform .firstDiv{overflow:hidden; text-align:center;}
	.hangbanImform .neiImform .firstDiv .jjc{float:left; padding:5px;}
	.hangbanImform .neiImform .firstDiv .aYuding,.hangbanImform .neiImform .firstDiv .anotherCW,.hangbanImform .neiImform .firstDiv .zhzaYuding,.hangbanImform .neiImform .firstDiv .zhzanotheryu{float:right; padding:5px 10px; border:#FF8204 solid 1px; color:#FFFFFF; background-color:#FF8204; border-radius:5px;}
	.hangbanImform .neiImform .firstDiv .money{color:#FF8204;}
	.hangbanImform .neiImform .firstDiv .zhe{color:#0079FE;}
	.hangbanImform .neiImform .firstDiv .Eimg{float:left; border:1px solid #0079FE; border-radius:10px; padding:0px 5px; background-color:#0079FE; color:#FFFFFF;}
	.hangbanImform .neiImform .firstDiv .pointer{float:right; color:#FF8204;}
	.hangbanImform .neiImform .firstDiv .licheng{float:right; margin-right:5px;}
	.hangbanImform .neiImform .firstDiv .shiyong{float:left; color:#FF8204; font-size:15px; font-family:Arial, Helvetica, sans-serif; line-height:22px;}
	.hangbanImform .neiImform .fourDiv{border-top:1px solid #E0E0E0; padding:10px 0px;}
	.hangbanImform .neiImform .firstDiv .jiantou{float:left; color:#ffffff; background-color:#FF8204; border:1px solid #FF8204; font-size:10px; border-radius:10px; margin-left:5px; padding-left:3px; padding-right:2px; padding-bottom:1px;}
	.hangbanImform .neiImform .firstDiv .piaojia,.hangbanImform .neiImform .firstDiv .wfpiaojia{float:right; color:#FF8204; font-size:15px; font-family:Arial, Helvetica, sans-serif; line-height:22px;}
	.banner,.wfbanner{ display:none;}
	.cangweiClass,.choDate{ display:none;}
	
	/*中转*/
	.zhzLiBox{ margin:0px; font-size:13px; color:#666666; font-family:Arial, Helvetica, sans-serif; border-bottom:#E0E0E0 solid 1px; padding:5px;}
	.zhzLiBox .feiTimeBox{margin-left:6px; float:left; width:50px;}
	.zhzLiBox .feiTimeBox .staTimeBox{line-height:29px; text-align:left; font-size: 15px;}
	.zhzLiBox .feiTimeBox .arrTimeBox{line-height:29px; color:#999999; text-align:left;}
	.zhzLiBox .flidNameBox{ float:left; margin-left:5.1%; padding-top:6px;}
	.zhzLiBox .flidNameBox .qishiPlanNa{ overflow:hidden;}
	.zhzLiBox .flidNameBox .zhongPlanNa{ overflow:hidden; padding-top:4px;}
	.zhzLiBox .flidNameBox .qishiPlanNa img{ display:block; float:left;}
	.zhzLiBox .flidNameBox .qishiPlanNa .qishiSpan{ display:block; float:left; line-height:22px; height:20px; font-size:15px;}
	.zhzLiBox .zhzPlanName{ text-align:center; float:left; margin-left:10px;}
	.zhzLiBox .zhzPlanName .zhuanICO{color:#648bff; font-size:11px; display:block; margin-top:9px;}
	.zhzLiBox .zhzPlanName .zhuanName{color:#648bff; font-size:11px; margin-top:0px;}
	.zhzLiBox .flidNameBox .zhongPlanNa .zhzSpan{ display:block; float:left; line-height:22px; color:#999999; height: 20px;}
	.zhzLiBox .flidNameBox .zhongPlanNa img{display:block; float:left;}
	.zhzLiBox .monAndtick{ float:right; padding-right:8px;}
	.zhzLiBox .monAndtick .moneyCPY{line-height:33px; font-family:'微软雅黑'; margin-top:10px;}
	.zhzLiBox .monAndtick .moneyCPY .oneMoneyHouse{color:#FF8201; font-size:14px; font-family:Arial, Helvetica, sans-serif;}
	.zhzLiBox .monAndtick .tickNum{line-height:15px; text-align:center; color:#999999;}
	.zhzLiBox .infoMessgBox{ height:15px;}
	.zhzLiBox .infoMessgBox .infoChBox{ float:left; height:13px; color:#999999; font-size:10px; line-height:13px; padding:1px 10px;}
	.infoChBox img,.infoChBox span{display:block; float:left;}
	.infoChBox span{ margin-top:1px; margin-left:5px;}
</style>
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
		$(".zhzLiBox").remove(); //移除原来的中转航班
		ajax(chufCityCode, daodCityCode, cangW, newDate); //执行数据加载ajax		
		$("#dateTimeID").text(newDate);
	});
	
	$(".nextDate").click(function(){		
		var newDate = nextTime($("#dateTimeID").text());//获取加上一天的日期
		conterCONTime(newDate);//把这个日期格式转换一个放在中间的标签中
		$(".notTjTicket").remove();//移除原来加载的数据
		$(".zhzLiBox").remove(); //移除原来的中转航班
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
					console.log(data.zzListDate);
					var getDate = data.listDate;//直达
					var zhzDate = data.zzListDate;//中转
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
						// <span style="width:60px; text-align:right; font-size:13px; line-height:28px;">'+' '+getDate[i].flightNo+'</span>
						// <span style="width:50px; text-align:center; float:right;">'+' '+cuntNumTime+'</span>
						var notTjList = '<li class="notTjTicket"><div class="notTjTicketDiv"><div class="StartTimeEnd"><div class="StartTime lineHeight">'+depTime+'</div><div class="EndTime lineHeight">'+arrTime+'</div></div><div class="StartAndEnd"><div class="StartJC lineHeight"><img src="<%=basePath %>console/images/shi.png" style="float:left;"/><span style="float:left;"><%=chufPlan%></span></div><div style="clear:both;"></div><div class="EndTJC lineHeight"><img src="<%=basePath %>console/images/zhong.png" style="float:left;"><span style="float:left;"><%=daodPlan%></span></div></div><div class="moneyAndTicket"><div class="money lineHeight" style="color:#FF8201; text-align:right;">￥'+onewayPrice+'</div><div class="zuowei lineHeight" style="font-size:12px;">'+cangW+''+sum+'张</div></div><div style="clear:both;"></div></div><div class="banner"><div class="b-img"><div class="runDiv"><div class="hangbanImform"><div class="neiImform"><div class="firstDiv"><span class="jjc">'+cangW+'</span><a class="aYuding">预定</a><span class="choDate">'+JSON.stringify(getDate[i])+'</span></div><div class="firstDiv" style="padding:10px 0px;"><span class="money">￥'+onewayPrice+'</span><span> / </span><span class="zhe">85折</span></div><div class="firstDiv" style="padding-bottom:5px;"><span class="Eimg">'+cangwei_type+'</span><span class="pointer">100%</span><span class="licheng">里程累计比例</span></div><div class="firstDiv fourDiv"><span class="shiyong">使用条件</span><span class="jiantou">＞</span><span class="jiantou" style="float:right;">＞</span><span class="piaojia">对应舱位其他票价</span></div><div style="clear:both;"></div></div></div></div></div></div><div class="cangweiClass" style="height:auto;"></div></li>';              
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
								var listDiv='<div class="banner1"><div class="b-img"><div class="runDiv"><div class="hangbanImform"><div class="neiImform"><div class="firstDiv"><span class="jjc">'+cangW+'</span><a class="anotherCW">预定</a><span class="choDate">'+JSON.stringify(getDate[i])+'</span></div><div class="firstDiv" style="padding:10px 0px;"><span class="money">￥'+onewayPrice+'</span><span> / </span><span class="zhe">85折</span></div><div class="firstDiv" style="padding-bottom:5px;"><span class="Eimg">'+cangwei_type+'</span><span class="pointer">100%</span><span class="licheng">里程累计比例</span></div><div class="firstDiv fourDiv"><span class="shiyong">使用条件</span><span class="jiantou">＞</span></div><div style="clear:both;"></div></div></div></div></div></div>';
								$(".notTjTicket:eq("+i+") .cangweiClass").append(listDiv);
							}						
						}
					}
					
					//中转航班
					var countDivNum = 0; //计数器
					for(var i=0; i<zhzDate.length; i++){
						var liList;
						for(var j=zhzDate.length-1; j>i; j--){
							if(zhzDate[i].dstCity==zhzDate[j].orgCity&&zhzDate[i].airCode==zhzDate[j].airCode&&MathTime(zhzDate[i].arrTime,zhzDate[j].depTime)>3600){
								var onezhzDate = JSON.stringify(zhzDate[i]); //第一航段
								var twozhzDate = JSON.stringify(zhzDate[j]); //第二航段
								var rowseatInfo1 = zhzDate[i].seatList; //第一航段的座位
								var rowseatInfo2 = zhzDate[j].seatList; //第一航段的座位
								//初识化参数
								var cangType_bas; //经济舱参数
								var cangType_csw; //Y舱、C舱 什么的参数
								var onePriceMoney; //第一航段的价格
								var twoPriceMobey; //第二航段的价格
								var sumTemk=0; //剩余的票
								for(var k=0; k<rowseatInfo1.length; k++){
									for(var h=0; h<rowseatInfo2.length; h++){
										if(rowseatInfo1[k].cangwei == rowseatInfo2[h].cangwei){
											cangType_bas = cnCang(rowseatInfo2[h].basicCabin);
											cangType_csw = rowseatInfo2[h].cangwei;
											
											onePriceMoney = rowseatInfo1[k].onewayPrice;//第一航段的价钱
											twoPriceMobey = rowseatInfo2[h].onewayPrice;//第二航段的价格 
											
											sumTemk += parseInt(signTekt(tekNum(rowseatInfo1[k].cangwei_data),tekNum(rowseatInfo2[h].cangwei_data)));
										}
									}
								}
								var liBox = '<li class="zhzLiBox"><div class="zhzChildBox"><div class="feiTimeBox"><div class="staTimeBox">'+changeType(zhzDate[i].depTime)+'</div><div class="arrTimeBox">'+changeType(zhzDate[j].arrTime)+'</div></div><div class="flidNameBox"><div class="qishiPlanNa"><img src="<%=basePath %>console/images/shi.png" style="width:20px;"><span class="qishiSpan">'+findByplaneName(zhzDate[i].orgCity)+'</span><span style="clear:both;"></span></div><div class="zhongPlanNa"><img src="<%=basePath %>console/images/zhong.png" style="width:20px;"><span class="zhzSpan">'+findByplaneName(zhzDate[j].dstCity)+'</span><span style="clear:both;"></span></div></div><div class="zhzPlanName"><span class="zhuanICO">转</span><span class="zhuanName">'+findByCity(zhzDate[i].dstCity)+'</span></div><div class="monAndtick"><div class="moneyCPY"><span style="color:#FF8201;font-size:14px;">￥</span><span class="oneMoneyHouse">'+(parseFloat(onePriceMoney)+parseFloat(twoPriceMobey)).toFixed(2)+'</span></div>	<div class="tickNum">经济舱'+sumTemk+'张</div></div><div style="clear:both;"></div></div><div class="wfbanner"><div class="b-img"><div class="runDiv"><div class="hangbanImform"><div class="neiImform"><div class="firstDiv"><span class="jjc">'+cangType_bas+'</span><a class="zhzaYuding" href=\'<%=basePath%>console/wechat/zhzconfirmInfo.jsp?dateTime='+dateTime+'&cangwei='+cangType_csw+'&onezhzDate='+onezhzDate+'&twozhzDate='+twozhzDate+'\'>预定</a></div><div class="firstDiv" style="padding:10px 0px;"><span class="money">￥'+(parseFloat(onePriceMoney)+parseFloat(twoPriceMobey)).toFixed(2)+'</span><span> / </span><span class="zhe">85折</span></div><div class="firstDiv" style="padding-bottom:5px;"><span class="Eimg">'+cangType_csw+'</span><span class="pointer">100%</span><span class="licheng">里程累计比例</span></div><div class="firstDiv fourDiv"><span class="shiyong">使用条件</span><span class="jiantou">＞</span><span class="jiantou" style="float:right;">＞</span><span class="wfpiaojia">对应舱位其他票价</span></div><div style="clear:both;"></div></div></div></div></div></div><div class="cangweiClass" style="height:auto;"></div></li>';
								$("#TicketList").append(liBox);
								<%-- <div class="infoMessgBox"><div class="infoChBox" style="border-right:1px solid #ccc;">'+findByCode(zhzDate[i].airCode)+'</div><div class="infoChBox"><img src="<%=basePath%>console/images/TIMEiMG.png" style="width:13px;"/><span>'+cuntTime(zhzDate[i].depTime,zhzDate[j].arrTime)+'</span><span style="clear:both;"></span></div><div class="infoChBox"></div></div> --%>
								//加载舱位
								for(var k=0; k<rowseatInfo1.length; k++){
									for(var h=0; h<rowseatInfo2.length; h++){
										if(rowseatInfo1[k].cangwei == rowseatInfo2[h].cangwei){ 
											var cangType_csw = rowseatInfo1[k].cangwei; //舱位的类型如(L、U、E...等)，类型不同价钱也不一样
											var cangType_bas = cnCang(rowseatInfo2[h].basicCabin);
											onewayPrice = rowseatInfo1[k].onewayPrice; //价钱第一航班信息
											twowayPrice = rowseatInfo2[h].onewayPrice; //价钱第二航班信息
											//alert(onewayPrice+", "+twowayPrice);
											var listDiv='<div class="banner1"><div class="b-img"><div class="runDiv"><div class="hangbanImform"><div class="neiImform"><div class="firstDiv"><span class="jjc">'+cangType_bas+'</span><a class="zhzanotheryu" href=\'<%=basePath%>console/wechat/zhzconfirmInfo.jsp?dateTime='+dateTime+'&cangwei='+cangType_csw+'&onezhzDate='+onezhzDate+'&twozhzDate='+twozhzDate+'\'>预定</a></div><div class="firstDiv" style="padding:10px 0px;"><span class="money">￥'+(parseInt(onewayPrice)+parseInt(twowayPrice))+'</span><span> / </span><span class="zhe">85折</span></div><div class="firstDiv" style="padding-bottom:5px;"><span class="Eimg">'+cangType_csw+'</span><span class="pointer">100%</span><span class="licheng">里程累计比例</span></div><div class="firstDiv fourDiv"><span class="shiyong">使用条件</span><span class="jiantou">＞</span></div><div style="clear:both;"></div></div></div></div></div></div>';
											$(".zhzLiBox:eq("+countDivNum+") .cangweiClass").append(listDiv);
										}
									}
								}
								countDivNum++;
							}
							
						}
					}
					loadjs();//加载js外部文件
				}else{
					$.alert("没有查找到该航班的信息");
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

//当两段航班的票数不一样的时候，按最低的票为准
function signTekt(onefd,twofd){
	if(parseInt(onefd)>parseInt(twofd)){
		return twofd;
	}else if(parseInt(onefd)<parseInt(twofd)){
		return onefd;
	}else{
		return onefd;
	}
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
	var sTime = changesTime(depTime); //出发时间的秒
	var oTime = changesTime(arrTime); //到达时间的秒
	var chaTime = oTime-sTime; //两个时间相差的秒
	var liTime = parseInt(chaTime/3600)+"h"+parseInt((chaTime%3600)/60)+"m";
	return liTime;
}
		
//根据时间参数化成秒
function changesTime(time){
		var ohh,omm,ocount;
		if(time.indexOf("+")>0){
			ohh = time.substring(0,2);
			omm = time.substring(2,4);
			ocount = ohh*3600+omm*60+24*3600;
		}else{
			ohh = time.substring(0,2);
			omm = time.substring(2,time.length);
			ocount = ohh*3600+omm*60;
		}
		return ocount;
}

//根据时间参数进行大小比较
function MathTime(starTime,overTime){
	//将时间转换成秒来比较
	var shh,smm,sdd;
	var scount,ocount; //定义总时间的两个变量
	var ohh,omm,odd;
	if(starTime.indexOf("+")>0){
			shh = starTime.substring(0,2);
			smm = starTime.substring(2,4);
			sdd = starTime.substring(4,starTime.length);
			scount = shh*3600+smm*60+24*3600;
	}else{
			shh = starTime.substring(0,2);
			smm = starTime.substring(2,starTime.length);
			sdd = "0";
			scount = shh*3600+smm*60;
	}
	
	if(overTime.indexOf("+")>0){
			ohh = overTime.substring(0,2);
			omm = overTime.substring(2,4);
			odd = overTime.substring(4,overTime.length);
			ocount = ohh*3600+omm*60+24*3600;
	}else{
			ohh = overTime.substring(0,2);
			omm = overTime.substring(2,overTime.length);
			odd = "0";
			ocount = ohh*3600+omm*60;
	}
	return ocount-scount;
}

//对传过来的时间进行处理，为了实现前一天和后一天的切换
function conterCONTime(time){
	var yymmdd = time.split("-"); //拆分传进来的时间
	//根据时间获取星期
	var date = time;
	var day = new Date(Date.parse(date.replace(/-/g, '/')));  
	var today = new Array('周日','周一','周二','周三','周四','周五','周六');  
	var week = today[day.getDay()]; //获得星期
	var mmdd = yymmdd[1]+"月"+yymmdd[2]+"日 "+week+"<span style='font-size:10px; color:#017AFD;'>&nbsp;▼</span>";
	$(".mmddWeek").html(mmdd);
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
	jsElem.src='<%=basePath%>console/js/mudiPlace.js?time=20160503';
	document.getElementsByTagName('head')[0].appendChild(jsElem);
}

//格式化舱位
function cnCang(basicCabin){
		if(basicCabin=="C"){
			basicCabin="公务舱";
		}else if(basicCabin=="F"){
			basicCabin="头等舱";
		}else if(basicCabin=="Y"){
			basicCabin="经济舱";
		}
		return basicCabin;
}

//
/* function notTickDiv(inc){
	$("body .banner").css("display","none");
	$("body .wfbanner").css("display","none");
	$("body .cangweiClass").css("display","none");
	$(inc).siblings(".banner").css("display","block");
} */
</script>
</head>

<body>
<ul id="TicketList">
	<li class="time" style="border-bottom:#E0E0E0 solid 1px; background-color:#F8F8F8; height:40px;">
		<div class="timeDiv" style="float:left; width:25%; "><a class="prevDate" style="background:url('<%=basePath%>console/images/zuopoit.png') no-repeat 0px 1px; background-size:15px 16px; padding-left:15px;">前一天</a></div>
		<div id="cendivBox">
			<div class="timeDiv mmddWeek"></div>
		</div>
		<div id="dateTimeID" style="display:none;"><%=dateTime %></div>
		<div id="chufCityID" style="display:none;"><%=chufCity %></div>
		<div id="daodCityID" style="display:none;"><%=daodCity %></div>
		<!-- <div class="timeDiv" style="float:left; width:15%; text-align:left;">明天▼</div> -->
		<div class="timeDiv" style="float:right; width:25%; "><a class="nextDate" style="background:url('<%=basePath%>console/images/youpoit.png') no-repeat 45px 2px; background-size:13px 16px; padding-right:15px;">后一天</a><a id="basePath" style="display:none;"><%=basePath %></a></div>
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
			<div style="color:#ffffff; position:absolute; left:39%; top:58%;">数据加载中...</div>
		</div> 
	</div>
</body>
</html>
