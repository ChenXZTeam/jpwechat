<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<% 
	/* String chufCity=new String(request.getParameter("chufCity").getBytes("ISO-8859-1"),"utf-8");
	String daodCity=new String(request.getParameter("daodCity").getBytes("ISO-8859-1"),"utf-8");
	String cangW=new String(request.getParameter("cangW").getBytes("ISO-8859-1"),"utf-8");
	String chufCityCode=new String(request.getParameter("chufCityCode").getBytes("ISO-8859-1"),"utf-8");
	String daodCityCode=new String(request.getParameter("daodCityCode").getBytes("ISO-8859-1"),"utf-8");
	String chufPlan=new String(request.getParameter("chufPlan").getBytes("ISO-8859-1"),"utf-8");
	String daodPlan=new String(request.getParameter("daodPlan").getBytes("ISO-8859-1"),"utf-8");
	String dateTime=request.getParameter("dateTime"); */
	
	String cangW = request.getParameter("cangW");
	String chufCityCode = request.getParameter("chufCityCode");
	String daodCityCode = request.getParameter("daodCityCode");
	String dateTime = request.getParameter("dateTime");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title></title>
<link rel="stylesheet" href="<%=basePath%>console/css/weui.min.css" />
<link rel="stylesheet" href="<%=basePath%>console/css/jquery-weui.css" />
<link rel="stylesheet" href="<%=basePath %>console/css/mobiscroll.css"/>
<link rel="stylesheet" href="<%=basePath %>console/css/mobiscroll_date.css"/>
<link rel="stylesheet" type="text/css"  href="<%=basePath%>console/css/loading.css" />
<script src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script src="<%=basePath %>console/js/jquery-weui.js"></script>
<script src="<%=basePath %>console/js/airCodeVScity.js?yim=2015"></script>
<script src="<%=basePath %>console/js/mobiscroll_date.js"></script> 
<script src="<%=basePath %>console/js/mobiscroll.js"></script>
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
	.hangbanImform .neiImform{width:85%; border:#007AFF solid 1px; margin-left:auto; margin-right:auto; border-radius:10px; background-color:#ffffff; padding:15px;}
	.hangbanImform .neiImform .tuijianImgBox{width: 50px; height: 50px; margin-top: -15px; margin-left: -15px; position: absolute; background:url('<%=basePath%>console/images/smallCost.png')}
	.hangbanImform .neiImform .firstDiv{overflow:hidden; text-align:center;}
	.hangbanImform .neiImform .firstDiv .jjc{float:left; padding:5px; color:#666; font-size:16px;}
	.hangbanImform .neiImform .firstDiv .buyOver{float: right;  padding: 2px 15px; background-color: #D5D5D5; color:#fff; border-radius:5px;}
	.hangbanImform .neiImform .firstDiv .aYuding,.hangbanImform .neiImform .firstDiv .anotherCW,.hangbanImform .neiImform .firstDiv .zhzaYuding,.hangbanImform .neiImform .firstDiv .zhzanotheryu{float:right; padding:2px 15px; border:#FF8204 solid 1px; color:#FF8204;}
	.hangbanImform .neiImform .firstDiv .money{color:#FF8204;}
	.hangbanImform .neiImform .firstDiv .zhe{color:#0079FE;}
	.hangbanImform .neiImform .firstDiv .Eimg{float:left; border:1px solid #0079FE; color:#0079FE; width:16px; height:16px; line-height:17px; text-align:center;}
	.hangbanImform .neiImform .firstDiv .pointer{float:right; color:#FF8204;}
	.hangbanImform .neiImform .firstDiv .licheng{float:right; margin-right:5px; color:#666;}
	.hangbanImform .neiImform .firstDiv .shiyong{float:left; color:#B5B5B5; font-size:14px; font-family:Arial, Helvetica, sans-serif; line-height:20px;}
	.hangbanImform .neiImform .fourDiv{border-top:1px solid #E0E0E0; padding:10px 0px;}
	.hangbanImform .neiImform .firstDiv .jiantou{float:left;}
	.hangbanImform .neiImform .firstDiv .jiantou img{width:7px; margin-top:5px; margin-left:5px;}
	.hangbanImform .neiImform .firstDiv .piaojia,.hangbanImform .neiImform .firstDiv .wfpiaojia{float:right; color:#B5B5B5; font-size:14px; font-family:Arial, Helvetica, sans-serif; line-height:20px;}
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
	.zhzLiBox .monAndtick{ float:right; padding-right:3px;}
	.zhzLiBox .monAndtick .moneyCPY{line-height:33px; font-family:'微软雅黑'; margin-top:10px; text-align: right;}
	.zhzLiBox .monAndtick .moneyCPY .oneMoneyHouse{color:#FF8201; font-size:14px; font-family:Arial, Helvetica, sans-serif;}
	.zhzLiBox .monAndtick .tickNum{line-height:15px; text-align:center; color:#999999;}
	.zhzLiBox .infoMessgBox{ height:15px;}
	.zhzLiBox .infoMessgBox .infoChBox{ float:left; height:13px; color:#999999; font-size:10px; line-height:13px; padding:1px 10px;}
	.infoChBox img,.infoChBox span{display:block; float:left;}
	.infoChBox span{ margin-top:1px; margin-left:5px;}
	.jcDate{width:70px; text-align:right; color:#6CA5FE; border:none; font-size:12px; outline:none; -webkit-tap-highlight-color:rgba(255,255,255,0);}
	.weui-btn {position: relative; display: block;margin-left: auto; margin-right: auto; padding-left: 14px; padding-right: 14px; box-sizing: border-box; font-size: 18px; text-align: center; text-decoration: none; color: #FFFFFF; line-height: 2.55555556; border-radius: 5px;-webkit-tap-highlight-color: rgba(0, 0, 0, 0); overflow: hidden;}
	.weui-btn_mini{display: inline-block;padding: 0 1.32em; line-height: 2.3; font-size: 13px;}
	.weui-btn_primary {background-color: #1AAD19;}
	.weui-btn1 {position: relative; margin-left: auto; margin-right: auto; padding-left: 14px; padding-right: 14px; box-sizing: border-box;font-size: 1px; text-align: center; text-decoration: none; color: #FFFFFF;line-height: 2.55555556; border-radius: 5px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); overflow: hidden;}
	.weui-btn_disabled {color: rgba(255, 255, 255, 0.6);}
	.weui-btn_default {color: #000000; background-color: #F8F8F8;}
	.panel{text-align: left;webkit-box-shadow:3px 3px 3px #c3c3c3; -moz-box-shadow:3px 3px 3px #c3c3c3; box-shadow: 3px 3px 3px #c3c3c3;background-color:#f1f1f1;position:fixed;z-index:10000;width:100%;display:none;top:0px;left:0px;padding:15px 10px;}
	.panel>input{float:left;} 
	.resitInput{font-size:15px; padding:7px; border:1px solid #e1e1e1; border-radius:5px; width:60%;}
	.resitBtn{width:25%;background-color: #1AAD19; border: none; border-radius: 5px; padding:8px 20px; color: #fff; margin-left: 10px;font-size:14px;}
</style>

<script>
$(function(){ 
	var chufCityCode="<%=chufCityCode %>";
	var daodCityCode="<%=daodCityCode %>";
	var cangW="<%=cangW %>";
	var dateTime="<%=dateTime%>";
	conterCONTime(dateTime);//显示在中间的时间
	$("#dateTimeID").text(dateTime);
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
	
	$(".mmddWeek").click(function(){
		$(".panel").slideToggle("fast");
	});
	
	var tjTicket=0;//推荐的机票
	
	//推荐的机票点击时执行
	
});

//封装ajax方法
function ajax(chufCityCode, daodCityCode, cangW, dateTime){
	//开始通过传递过来的几个参数进行后台查询之后加载查询结果
	$.ajax({
		url:"<%=basePath%>wechatController/find/OtherQuery.action",
		type:"POST",
		data:{"chufCity":chufCityCode,"daodCity":daodCityCode,"dateTime":dateTime},
		dataType:"json",
		beforeSend:function(){
			$("#loading").css("display","block");
		},
		complete:function(){$("#loading").css("display","none");},
		success:function(data){
			if(data.msg==1){
				/* console.log(data.listDate);
				console.log(data.zzListDate); */
				var getDate = data.listDate;//直达
				var zhzDate = data.zzListDate;//中转
				for(var i=0;i<getDate.length;i++){
					var cangwei_type = "";
					var onewayPrice = 0;//排在最后一个舱位的价格
					var sum=0; 
					var cangDate = 0;
					for(var j=0;j<getDate[i].seatList.length;j++){
						if(getDate[i].seatList[j].basicCabin==cangW && tekNum(getDate[i].seatList[j].cangwei_data)!=0){
							cangwei_type = getDate[i].seatList[j].cangwei;
							onewayPrice = getDate[i].seatList[j].onewayPrice;
							cangDate = getDate[i].seatList[j].cangwei_data;
							sum += parseInt(tekNum(getDate[i].seatList[j].cangwei_data));
						}						
					}  
					var notTjList = '<li class="notTjTicket" style="position:relative;z-index:1;"><div class="notTjTicketDiv"><div class="StartTimeEnd"><div class="StartTime lineHeight">'+changeType(getDate[i].depTime)+'</div><div class="EndTime lineHeight">'+changeType(getDate[i].arrTime)+'<span style="color:#ff0000;">'+getDate[i].arriveTimeModify+'</span></div></div><div class="StartAndEnd"><div class="StartJC lineHeight"><img src="<%=basePath %>console/images/shi.png" style="float:left;"/><span style="float:left;">'+findByplaneName(chufCityCode)+'</span></div><div style="clear:both;"></div><div class="EndTJC lineHeight"><img src="<%=basePath %>console/images/zhong.png" style="float:left;"><span style="float:left;">'+findByplaneName(daodCityCode)+'</span></div></div><div class="moneyAndTicket"><div class="money lineHeight" style="color:#FF8201; text-align:right;">￥'+parseInt(onewayPrice)+'</div><div class="zuowei lineHeight" style="font-size:12px;">'+cnCang(cangW)+''+sum+'张</div></div><div style="clear:both;"></div></div><div class="banner"><div class="b-img"><div class="runDiv"><div class="hangbanImform"><div class="neiImform"><div class="tuijianImgBox"></div><div class="firstDiv"><span class="jjc">'+cnCang(cangW)+'</span><a class="aYuding" onclick="otherYdBtn(\''+getDate[i].uuid+'\',\''+cangwei_type+'\',\''+dateTime+'\')">预定</a></div><div class="firstDiv" style="padding:10px 0px;"><span class="money">￥'+parseInt(onewayPrice)+'</span><span> / </span><span class="zhe">85折</span></div><div class="firstDiv" style="padding-bottom:5px;"><span class="Eimg">'+cangwei_type+'</span><span class="pointer">100%</span><span class="licheng">里程累计比例</span></div><div class="firstDiv fourDiv"><span class="shiyong">退该政策</span><span class="jiantou"><img src="<%=basePath%>console/images/youpoit.png"></span><span class="jiantou" style="float:right;"><img src="<%=basePath%>console/images/youpoit.png"></span><span class="piaojia">更多舱位</span></div><div style="clear:both;"></div></div></div></div></div></div><div class="cangweiClass" style="height:auto;"></div></li>';              
					$("#TicketList").append(notTjList);	
					if(sum == 0||sum == "0"){
						$(".notTjTicket:eq("+i+") .aYuding").text("已售完");
						$(".notTjTicket:eq("+i+") .aYuding").addClass("buyOver");
						$(".notTjTicket:eq("+i+") .buyOver").removeClass("aYuding");
						$(".notTjTicket:eq("+i+") .buyOver").attr("onclick","javascript:$.alert('没票了')");
						$(".notTjTicket:eq("+i+") .Eimg").text(cangwei_type);
					}else{
						//动态加载针对该航班的其他舱位的信息
						for(var j=0;j<getDate[i].seatList.length;j++){
							if(getDate[i].seatList[j].basicCabin==cangW && tekNum(getDate[i].seatList[j].cangwei_data)!=0){
								var listDiv='<div class="banner1"><div class="b-img"><div class="runDiv"><div class="hangbanImform"><div class="neiImform"><div class="firstDiv"><span class="jjc">'+cnCang(getDate[i].seatList[j].basicCabin)+'</span><a class="anotherCW" onclick="otherYdBtn(\''+getDate[i].uuid+'\',\''+getDate[i].seatList[j].cangwei+'\',\''+dateTime+'\')">预定</a></div><div class="firstDiv" style="padding:10px 0px;"><span class="money">￥'+parseInt(getDate[i].seatList[j].onewayPrice)+'</span><span> / </span><span class="zhe">85折</span></div><div class="firstDiv" style="padding-bottom:5px;"><span class="Eimg">'+getDate[i].seatList[j].cangwei+'</span><span class="pointer">100%</span><span class="licheng">里程累计比例</span></div><div class="firstDiv fourDiv"><span class="shiyong">退该政策</span><span class="jiantou"><img src="<%=basePath%>console/images/youpoit.png"></span></div><div style="clear:both;"></div></div></div></div></div></div>';
								$(".notTjTicket:eq("+i+") .cangweiClass").append(listDiv);
							}						
						}
					}
					
				}
				
				//中转航班
				var countDivNum = 0; //计数器
				for(var i=0; i<zhzDate.length; i++){
					for(var j=zhzDate.length-1; j>i; j--){
						//第一段的到达城市和第二段的起始城市相同、第一段的到达时间要小于第二段的起飞时间1个小时、第一段的起飞时间小于第一段的到达时间(防止出现)
						if(zhzDate[i].dstCity==zhzDate[j].orgCity&&MathTime(zhzDate[i].arrTime,zhzDate[i].arriveTimeModify,zhzDate[j].depTime,zhzDate[j].deptimemodify)>9000){
							/* console.log(zhzDate[i]);
							console.log(zhzDate[j]);
							console.log("==========================="); */
							var rowseatInfo1 = zhzDate[i].seatList; //第一航段的座位
							var rowseatInfo2 = zhzDate[j].seatList; //第一航段的座位
							//自定义参数
							var cangType_bas = cangW; //舱位类型
							var cangType_csw; //第一航段舱位编码
							var cangType_csw2; //第一航段舱位编码
							var onePriceMoney = 0; //第一航段舱位价格
							var twoPriceMobey = 0; //第二航段舱位价格
							var sumTemk=0; //剩余的票
							for(var k=0; k<rowseatInfo1.length; k++){
								for(var h=0; h<rowseatInfo2.length; h++){
									//第一航段的舱位要有座位，第二航段要有座位，第一航段的舱位类型为经济舱，第二航段的舱位类型为经济舱
									if(tekNum(rowseatInfo1[k].cangwei_data)!=0 && tekNum(rowseatInfo2[h].cangwei_data)!=0 && rowseatInfo1[k].basicCabin==cangW && rowseatInfo2[h].basicCabin==cangW){
										cangType_bas = cnCang(rowseatInfo2[h].basicCabin);
										cangType_csw = rowseatInfo1[k].cangwei;
										cangType_csw2 = rowseatInfo2[h].cangwei;
										onePriceMoney = rowseatInfo1[k].onewayPrice;
										twoPriceMobey = rowseatInfo2[h].onewayPrice;
										sumTemk += parseInt(signTekt(tekNum(rowseatInfo1[k].cangwei_data),tekNum(rowseatInfo2[h].cangwei_data)));
									}
								}
							}
							var liBox = '<li class="zhzLiBox"><div class="zhzChildBox"><div class="feiTimeBox"><div class="staTimeBox">'+changeType(zhzDate[i].depTime)+'</div><div class="arrTimeBox">'+changeType(zhzDate[j].arrTime)+'<span style="color:#ff0000;">'+zhzDate[j].arriveTimeModify+'</span></div></div><div class="flidNameBox"><div class="qishiPlanNa"><img src="<%=basePath %>console/images/shi.png" style="width:20px;"><span class="qishiSpan">'+findByplaneName(zhzDate[i].orgCity)+'</span><span style="clear:both;"></span></div><div class="zhongPlanNa"><img src="<%=basePath %>console/images/zhong.png" style="width:20px;"><span class="zhzSpan">'+findByplaneName(zhzDate[j].dstCity)+'</span><span style="clear:both;"></span></div></div><div class="zhzPlanName"><span class="zhuanICO">转</span><span class="zhuanName">'+findByCity(zhzDate[i].dstCity)+'</span></div><div class="monAndtick"><div class="moneyCPY"><span style="color:#FF8201;font-size:14px;">￥</span><span class="oneMoneyHouse">'+(parseInt(onePriceMoney)+parseInt(twoPriceMobey))+'</span></div>	<div class="tickNum">'+cnCang(cangW)+''+sumTemk+'张</div></div><div style="clear:both;"></div></div><div class="wfbanner"><div class="b-img"><div class="runDiv"><div class="hangbanImform"><div class="neiImform"><div class="tuijianImgBox"></div><div class="firstDiv"><span class="jjc">'+cnCang(cangW)+'</span><a class="zhzaYuding" onclick="another(\''+zhzDate[i].uuid+'\',\''+zhzDate[j].uuid+'\',\''+cangType_csw+'\',\''+dateTime+'\',\''+cangType_csw2+'\')">预定</a></div><div class="firstDiv" style="padding:10px 0px;"><span class="money">￥'+(parseInt(onePriceMoney)+parseInt(twoPriceMobey))+'</span><span> / </span><span class="zhe">85折</span></div><div class="firstDiv" style="padding-bottom:5px;"><span class="Eimg">'+cangType_csw+'</span><span class="Eimg" style="margin-left:5px;">'+cangType_csw2+'</span><span class="pointer">100%</span><span class="licheng">里程累计比例</span></div><div class="firstDiv fourDiv"><span class="shiyong">退该政策</span><span class="jiantou"><img src="<%=basePath%>console/images/youpoit.png"></span><span class="jiantou" style="float:right;"><img src="<%=basePath%>console/images/youpoit.png"></span><span class="wfpiaojia">更多舱位</span></div><div style="clear:both;"></div></div></div></div></div></div><div class="cangweiClass" style="height:auto;"></div></li>';
							$("#TicketList").append(liBox);
							if(sumTemk == 0||sumTemk == "0"){ //如果全体票价为空的话就显示“已售完”并且后面的其他舱位也不用加载了
								$(".zhzLiBox:eq("+countDivNum+") .zhzaYuding").text("已售完");
								$(".zhzLiBox:eq("+countDivNum+") .zhzaYuding").addClass("buyOver");
								$(".zhzLiBox:eq("+countDivNum+") .buyOver").removeClass("zhzaYuding");
								$(".zhzLiBox:eq("+countDivNum+") .buyOver").attr("onclick","javascript:$.alert('没票了')");
								$(".zhzLiBox:eq("+countDivNum+") .buyOver").attr("href","javascript:void(0)");
								$(".zhzLiBox:eq("+countDivNum+") .Eimg").text(cangW);
							}else{
								//加载舱位
								for(var k=0; k<rowseatInfo1.length; k++){
									for(var h=0; h<rowseatInfo2.length; h++){
										if(rowseatInfo1[k].basicCabin==cangW && rowseatInfo2[h].basicCabin==cangW && tekNum(rowseatInfo1[k].cangwei_data)!=0 && tekNum(rowseatInfo2[h].cangwei_data)!=0){ 
											var cangType_csw = rowseatInfo1[k].cangwei; //舱位的类型如(L、U、E...等)，类型不同价钱也不一样
											var cangType_csw2 = rowseatInfo2[h].cangwei;
											var cangType_bas = cnCang(rowseatInfo2[h].basicCabin);
											onewayPrice = rowseatInfo1[k].onewayPrice; //价钱第一航班信息
											twowayPrice = rowseatInfo2[h].onewayPrice; //价钱第二航班信息
											var listDiv='<div class="banner1"><div class="b-img"><div class="runDiv"><div class="hangbanImform"><div class="neiImform"><div class="firstDiv"><span class="jjc">'+cangType_bas+'</span><a class="zhzanotheryu" onclick="another(\''+zhzDate[i].uuid+'\',\''+zhzDate[j].uuid+'\',\''+cangType_csw+'\',\''+dateTime+'\',\''+cangType_csw2+'\')">预定</a></div><div class="firstDiv" style="padding:10px 0px;"><span class="money">￥'+(parseInt(onewayPrice)+parseInt(twowayPrice))+'</span><span> / </span><span class="zhe">85折</span></div><div class="firstDiv" style="padding-bottom:5px;"><span class="Eimg">'+cangType_csw+'</span><span class="Eimg" style="margin-left:5px;">'+cangType_csw2+'</span><span class="pointer">100%</span><span class="licheng">里程累计比例</span></div><div class="firstDiv fourDiv"><span class="shiyong">退该政策</span><span class="jiantou"><img src="<%=basePath%>console/images/youpoit.png"></span></div><div style="clear:both;"></div></div></div></div></div></div>';
											$(".zhzLiBox:eq("+countDivNum+") .cangweiClass").append(listDiv);
										}
									}
								}
							}
							<%-- <div class="infoMessgBox"><div class="infoChBox" style="border-right:1px solid #ccc;">'+findByCode(zhzDate[i].airCode)+'</div><div class="infoChBox"><img src="<%=basePath%>console/images/TIMEiMG.png" style="width:13px;"/><span>'+cuntTime(zhzDate[i].depTime,zhzDate[j].arrTime)+'</span><span style="clear:both;"></span></div><div class="infoChBox"></div></div> --%>
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
		date="0";
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
function cuntTime(depTime,isDept,arrTime,isArrt){
	var sTime = changesTime(depTime,isDept); //出发时间的秒
	var oTime = changesTime(arrTime,isArrt); //到达时间的秒
	var chaTime = oTime-sTime; //两个时间相差的秒
	var liTime = parseInt(chaTime/3600)+"h"+parseInt((chaTime%3600)/60)+"m";
	return liTime;
}
		
//根据时间参数化成秒
function changesTime(time,isJia){
		var ohh,omm,ocount;
		if(isJia=="+1"){
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
function MathTime(starTime,isStar,overTime,isOver){
	//将时间转换成秒来比较
	var shh,smm;
	var scount,ocount; //定义总时间的两个变量
	var ohh,omm;
	if(isStar=="+1"){
		shh = starTime.substring(0,2);
		smm = starTime.substring(2,4);
		scount = shh*3600+smm*60+24*3600;
	}else{
		shh = starTime.substring(0,2);
		smm = starTime.substring(2,starTime.length);
		scount = shh*3600+smm*60;
	}
	
	if(isOver=="+1"){
		ohh = overTime.substring(0,2);
		omm = overTime.substring(2,4);
		ocount = ohh*3600+omm*60+24*3600;
	}else{
		ohh = overTime.substring(0,2);
		omm = overTime.substring(2,overTime.length);
		ocount = ohh*3600+omm*60;
	}
	return (parseInt(ocount)-parseInt(scount));
}

//对传过来的时间进行处理，为了实现前一天和后一天的切换
function conterCONTime(time){
	var yymmdd = time.split("-"); //拆分传进来的时间
	//根据时间获取星期
	var date = time;
	var day = new Date(Date.parse(date.replace(/-/g, '/')));  
	var today = new Array('周日','周一','周二','周三','周四','周五','周六');  
	var week = today[day.getDay()]; //获得星期
	var mmdd = yymmdd[1]+"月"+yymmdd[2]+"日 "+week+"<span class='jcD01' style='font-size:10px; color:#017AFD;' >&nbsp;▼</span>";
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
	jsElem.src='<%=basePath%>console/js/mudiPlace.js?time=2016sds01231sd23';
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

function chax(){
	//alert(document.getElementById("d11").value);
	dateTime=document.getElementById("d11").value;
	if(dateTime==""||dateTime==null){
		alert("请选择日期！");
		return false;
	}
	var data = dateTime;    //获取控件上选择的日期
    data = data.replace("-","/");
    var now = new Date();
    now.setDate(now.getDate()-1);
    var chknow = new Date(Date.parse(data));
    if (chknow < now) {
           $.alert("日期选择错误");
           return false;
    }
	var chufCityCode="<%=chufCityCode %>";
	var daodCityCode="<%=daodCityCode %>";
	var cangW="<%=cangW %>";
	ajax(chufCityCode, daodCityCode, cangW, dateTime); //执行数据加载ajax
	$("#dateTimeID").text(dateTime);
	conterCONTime(dateTime);//显示在中间的时间
	$(".panel").slideToggle("fast");
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
			<div class="panel">
				<input type="text" id="d11" class="resitInput" placeholder="请选择出发日期"/>
				<input type="button" class="resitBtn" value="确定" onclick="chax()"/>
				<span style="clear:both;"></span>
			</div>
		</div>
		<div id="dateTimeID"  style="display:none;"></div> 
		<%-- <div id="chufCityID" style="display:none;"><%=chufCity %></div>
		<div id="daodCityID" style="display:none;"><%=daodCity %></div> --%>
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
			<span class="textMove" id="one">广</span>
			<span class="textMove" id="two">州</span>
			<span class="textMove" id="three">仁</span>
			<span class="textMove" id="four">德</span>
			<span class="textMove" id="five">机</span>
			<span class="textMove" id="six">票</span>
			<span class="textMove" id="seven">系</span>
			<span class="textMove" id="eight">统</span>
		</div> 
	</div>
</body>
<script>
$(function () {
	var currYear = (new Date()).getFullYear();	
	var opt={};
	opt.date = {preset : 'date'};
	opt.datetime = {preset : 'datetime'};
	opt.time = {preset : 'time'};
	opt.defaults = {
		theme: 'android-ics light', //皮肤样式
		display: 'modal', //显示方式 
		mode: 'scroller', //日期选择模式
		dateFormat: 'yyyy-mm-dd',
		lang: 'zh',
		showNow: false,
		nowText: "今天",
		startYear: currYear - 50, //开始年份
		endYear: currYear + 10 //结束年份
	};
	
	$("#d11").mobiscroll($.extend(opt['date'], opt['defaults']));
});
</script>
</html>
