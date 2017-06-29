<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	String chufCity=new String(request.getParameter("chufCityCode").getBytes("ISO-8859-1"),"utf-8");
	String daodCity=new String(request.getParameter("daodCityCode").getBytes("ISO-8859-1"),"utf-8");
	String dateTime=new String(request.getParameter("dateTime").getBytes("ISO-8859-1"),"utf-8");
	String returnTime=new String(request.getParameter("returnTime").getBytes("ISO-8859-1"),"utf-8");
	String cangW=new String(request.getParameter("cangW").getBytes("ISO-8859-1"),"utf-8");
	System.out.println(chufCity+"/"+daodCity+"/"+dateTime+"/"+returnTime+"/"+cangW);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
	<title>往返航班</title>
	<link rel="stylesheet" href="<%=basePath%>console/css/weui.min.css" />
	<link rel="stylesheet" href="<%=basePath%>console/css/jquery-weui.css" />
	<link rel="stylesheet" href="<%=basePath %>console/css/mobiscroll.css"/>
	<link rel="stylesheet" href="<%=basePath %>console/css/mobiscroll_date.css"/>
	<link rel="stylesheet" type="text/css"  href="<%=basePath%>console/css/loading.css" />
	<script src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
	<script src="<%=basePath %>console/js/jquery-weui.js"></script>
	<script src="<%=basePath %>console/js/airCodeVScity.js?name=11"></script>
	<script src="<%=basePath %>console/js/mobiscroll_date.js"></script> 
	<script src="<%=basePath %>console/js/mobiscroll.js"></script>
	<style>
		body{padding:0px; margin:0px;}
		ul{list-style-type:none; margin:0px; padding:0px;}
		.zhzLiBox{ margin:0px; font-size:15px; color:#666666; padding:8px 5px; font-family:Arial, Helvetica, sans-serif; border-bottom:#E0E0E0 solid 1px;}
		.zhzLiBox .feiTimeBox{margin-left:6px; float:left; width:50px;}
		.zhzLiBox .feiTimeBox .staTimeBox{text-align:left; padding-top:5px;}
		.zhzLiBox .feiTimeBox .arrTimeBox{ margin-top:15px; color:#999999; text-align:left; font-size:13px;}
		.zhzLiBox .flidNameBox{ float:left; margin-left:2%; padding-top:6px;}
		.zhzLiBox .flidNameBox .qishiPlanNa{ overflow:hidden; padding-top:2px;}
		.zhzLiBox .flidNameBox .zhongPlanNa{ overflow:hidden; padding-top:10px;}
		.zhzLiBox .flidNameBox .qishiPlanNa img{ display:block; float:left;}
		.zhzLiBox .flidNameBox .qishiPlanNa .qishiSpan,.zhzLiBox .flidNameBox .qishiPlanNa .zhongone{margin-left:5px; display:block; float:left; line-height:22px;}
		.zhzLiBox .flidNameBox .fildNoClass{color:#888;display:block;font-size:13px;margin-left:10px;float:left;overflow:hidden;}
		.zhzLiBox .zhzPlanName{ text-align:center; float:left; margin-left:10px;}
		.zhzLiBox .zhzPlanName .zhuanICO{color:#648bff; font-size:10px; display:block; margin-top:15px;}
		.zhzLiBox .zhzPlanName .zhuanName{color:#648bff; font-size:10px; margin-top:0px;}
		.zhzLiBox .flidNameBox .zhongPlanNa .zhzSpan,.zhzLiBox .flidNameBox .zhongPlanNa .zhongtwo{margin-left:5px; display:block; float:left; line-height:22px; color:#999999;}
		.zhzLiBox .flidNameBox .zhongPlanNa img{display:block; float:left;}
		.zhzLiBox .monAndtick{ float:right; margin-right:7px; text-align:right;}
		.zhzLiBox .monAndtick .moneyCPY{font-family:'微软雅黑'; text-align:right; height:25px; line-height:25px;}
		.zhzLiBox .monAndtick .tickNumZh{color:#999; font-size:11px;}
		.zhzLiBox .monAndtick .moneyCPY .oneMoneyHouse{color:#FF8201; font-size:15px; font-family:Arial, Helvetica, sans-serif;}
		.zhzLiBox .monAndtick .tickNum{line-height:15px; text-align:right; color:#999999; margin-top:5px; font-size:12px;}
		.zhzLiBox .infoMessgBox{ height:15px; display:none;}
		.zhzLiBox .infoMessgBox .infoChBox{ float:left; height:13px; color:#999999; font-size:10px; line-height:13px; padding:1px 10px;}
		.infoChBox img,.infoChBox span{display:block; float:left;}
		.infoChBox span{ margin-top:1px; margin-left:5px;}
		
		/*子类框*/
		.hangbanImform{padding:20px 10px; background-color:#F1F5FF; text-align:center;}
		.hangbanImform .neiImform{width:85%; border:#007AFF solid 1px; margin-left:auto; margin-right:auto; border-radius:10px; background-color:#ffffff; padding:15px;}
		.hangbanImform .neiImform .tuijianImgBox{width: 50px; height: 50px; margin-top: -15px; margin-left: -15px; position: absolute; background:url('<%=basePath%>console/images/smallCost.png')}
		.hangbanImform .neiImform .firstDiv{overflow:hidden; text-align:center;}
		.hangbanImform .neiImform .firstDiv .jjc{float:left; padding:5px;}
		.hangbanImform .neiImform .firstDiv .buyOver{float: right;  padding: 5px 15px; background-color: #D5D5D5; color:#fff; border-radius:5px; text-decoration:none;}
		.hangbanImform .neiImform .firstDiv .aYuding,.hangbanImform .neiImform .firstDiv .anotherCW,.hangbanImform .neiImform .firstDiv .zhzaYuding,.hangbanImform .neiImform .firstDiv .zhzanotheryu{float:right; padding:4px 15px; border:#FF8204 solid 1px; color:#FF8204; font-size:13px; text-decoration:none;}
		.hangbanImform .neiImform .firstDiv .money{color:#FF8204;}
		.hangbanImform .neiImform .firstDiv .zhe{color:#0079FE;}
		.hangbanImform .neiImform .firstDiv .Eimg{float:left; border:1px solid #0079FE; border-radius:2px; color:#0079FE; width:16px; height:16px; line-height:18px;}
		.hangbanImform .neiImform .firstDiv .pointer{float:right; color:#FF8204;}
		.hangbanImform .neiImform .firstDiv .licheng{float:right; margin-right:5px; font-size:13px;}
		.hangbanImform .neiImform .firstDiv .shiyong{float:left; color:#999; font-size:15px; font-family:Arial, Helvetica, sans-serif; line-height:22px;}
		.hangbanImform .neiImform .fourDiv{border-top:1px solid #E0E0E0; padding:10px 0px;}
		.hangbanImform .neiImform .firstDiv .jiantou{float:left;}
		.hangbanImform .neiImform .firstDiv .jiantou img{width:7px; margin-top:4px; margin-left:5px;}
		.hangbanImform .neiImform .firstDiv .piaojia,.hangbanImform .neiImform .firstDiv .wfpiaojia{float:right; color:#999; font-size:15px; font-family:Arial, Helvetica, sans-serif; line-height:20px;}
		.banner,.wfbanner{ display:none;}
		.cangweiClass{ display:none;}
		.time .timeDiv{ color:#666666; font-size:14px;}
		.time .mmddWeek{background:url('<%=basePath %>console/images/riliImgblue.png') no-repeat 13px 6px; text-align:right; background-size:17px 16px; width:250px; border: 1px solid #f0f0f0; margin-left: auto; margin-right: auto; line-height: 30px; padding: 0px 10px; background-color: #fff; border-radius: 5px;}
		.time .timeDiv{ color:#666666; font-size:15px;}
		.weui-btn { position: relative; display: block; margin-left: auto; margin-right: auto; margin-top: auto; padding-left: 14px; padding-right: 14px; box-sizing: border-box; font-size: 18px; text-align: center; text-decoration: none; color: #FFFFFF; line-height: 2.55555556; border-radius: 5px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); overflow: hidden;}
		.weui-btn_mini {display: inline-block; padding: 0 1.32em;line-height: 2.3; font-size: 13px;}
		.weui-btn_primary {background-color: #1AAD19;}
		.weui-btn1 {position: relative;margin-left: auto; margin-right: auto; margin-top: auto; padding-left: 14px; padding-right: 14px; box-sizing: border-box; font-size: 1px; text-align: center; text-decoration: none; color: #FFFFFF; line-height: 2.55555556; border-radius: 5px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); overflow: hidden;}
		.weui-btn_disabled {color: rgba(255, 255, 255, 0.6);}
		.weui-btn_default{color: #000000; background-color: #F8F8F8;}
		.panel{text-align: left;webkit-box-shadow:3px 3px 3px #c3c3c3; -moz-box-shadow:3px 3px 3px #c3c3c3; box-shadow: 3px 3px 3px #c3c3c3;background-color:#f1f1f1;position:fixed;z-index:10000;width:100%;display:none;top:0px;left:0px;padding:15px 10px;}
		.panel .paanelChild{float:left;}
		.panel .paanelChild .inpStyle{font-size:15px; padding:7px; border:1px solid #e1e1e1; border-radius:5px; width:90%;}
		.panel .paanelChild #ahtherBtn{cursor:pointer;background-color: #1AAD19; border: none; border-radius: 5px; padding:20px; color: #fff; font-size:14px;height:75px;width:100%;}
		.panel .paanelChild>input{display:block;}
	</style>
</head>
<body>
<div class="panel" style="display:none;">
	<div class="paanelChild" style="width:70%;">
		<input type="text" id="d11" class="inpStyle" placeholder="出发日期"/>
		<input type="text" id="d12" class="inpStyle" placeholder="返程日期" style="margin-top:10px;"/>
	</div>
	<div class="paanelChild" style="width:25%;">
		<input type="button" id="ahtherBtn" value="确定"/>
	</div>
	<div style="clear:both;"></div>
</div> 
<div class="time" style="border-bottom:#E0E0E0 solid 1px; background-color:#F8F8F8; padding:3px;">
	<div id="cendivBox">
		<div class="timeDiv mmddWeek"></div>
	</div>
	<%-- <div id="dateTimeID"  style="display:none;"><%=dateTime %></div> 
	<div id="chufCityID" style="display:none;"><%=chufCity %></div>
	<div id="daodCityID" style="display:none;"><%=daodCity %></div> --%>
</div>
<ul id="ulBox">
	<li id="TicketList">
	</li>
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
	</div> 
</div>
</body>
<script>
var deTimeDate = '<%=dateTime%>';
var reTimeDate = '<%=returnTime%>';
$(function(){
	chax(deTimeDate,reTimeDate);
	$("#ahtherBtn").click(function(){
		var returnTime =document.getElementById("d12").value; 
		var dateTime=document.getElementById("d11").value;
		if(dateTime==""||dateTime==null){
			$.alert("出发时间不能为空");
			return false;
		}
		if(returnTime==""||returnTime==null){
			$.alert("返程时间不能为空");
			return false;
		}
	    if(dateTime == returnTime){
	    	$.alert("同一天请分开预定");
	    	return false;
	    }
		var data = dateTime;
		var reData = returnTime;
	    data = data.replace("-","/");
	    reData = reData.replace("-","/");
	    var chknow = new Date(Date.parse(data));
	    var rechknow = new Date(Date.parse(reData));
	    if(rechknow < chknow){
	    	$.alert("返程时间不能在去程时间之前");
	    	return false;
	    }
	    var now = new Date();
	    now.setDate(now.getDate()-1);
	    if (chknow < now) {
	           $.alert("去程时间不能在今天之前");
	           return false;
	    }
	    if (rechknow < now) {
	           $.alert("返程时间不能在今天之前");
	           return false;
	    }
		chax(dateTime,returnTime);
	});
});

function chooseLi(inc){
	$(inc).siblings(".wfbanner").slideToggle("fast");
	$(inc).siblings(".cangweiClass").slideUp("fast");
	$(".panel").slideUp("fast");
}

function othercang(inc){
	$(inc).parents(".wfbanner").siblings(".cangweiClass").slideToggle("fast");
	$(".panel").slideUp("fast");
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

//计算剩余票价张数的方法
function tekNum(date){
	if(date=="A"){
		date=9;
	}else if(date=="L"||date=="Q"||date=="S"||date=="C"||date=="X"||date=="Z"||date=="null"||date==""||date==null){
		date="";
	}else if(date!=""){
		date=date;
	}
	return date;
}

function conterCONTime(goTime,resTime){
	var yymmdd = goTime.split("-"); //拆分传进来的时间
	//根据时间获取星期
	var date = goTime;
	var day = new Date(Date.parse(date.replace(/-/g, '/')));  
	var today = new Array('周日','周一','周二','周三','周四','周五','周六');  
	var week = today[day.getDay()]; //获得星期
	var mmdd = yymmdd[1]+"月"+yymmdd[2]+"日 "+week;

	var YYMMDD = resTime.split("-");
	var date2 = resTime;
	var day2 = new Date(Date.parse(date2.replace(/-/g, '/')));  
	var today2 = new Array('周日','周一','周二','周三','周四','周五','周六');  
	var week2 = today2[day2.getDay()]; //获得星期
	var mmdd2 = YYMMDD[1]+"月"+YYMMDD[2]+"日 "+week2+"<span class='jcD01' style='font-size:10px; color:#017AFD;' >&nbsp;▼</span>";
	
	$(".mmddWeek").html(mmdd+"<span style='color:#017AFD;margin:0px 3px;font-size:16px;'>/</span>"+mmdd2);
}   

$(".mmddWeek").click(function(){
	$(".panel").slideToggle("fast");
});

function trueBtnYd(uuid1,uuid2,canbin1,canbin2,gdate,rdate){
	window.location.href="<%=basePath%>console/wechat/wfconfirmInfo.jsp?uuid1="+uuid1+"&uuid2="+uuid2+"&canbin1="+canbin1+"&canbin2="+canbin2+"&gdate="+gdate+"&rdate="+rdate;
}

function chax(dateTime,returnTime){
	//alert(document.getElementById("d11").value);
	//alert(document.getElementById("d12").value);
	var cangW = "<%=cangW%>";
	var chufCityCode = "<%=chufCity%>";
	var daodCityCode = "<%=daodCity%>";
	//var dateTime=document.getElementById("d11").value;
	conterCONTime(dateTime,returnTime);//显示在中间的时间
	//var returnTime =document.getElementById("d12").value; 
	date1 = new Date(dateTime); //出发时间
	date2 = new Date(returnTime); //返程时间
	
	var airline = "";
	var page = "";
	$.ajax({
			url:"<%=basePath%>wechatController/find/planTekTo.action",
			type:"POST",
			data:{"org":chufCityCode,"dst":daodCityCode,"date":dateTime,"retDate":returnTime},
			dataType:"json",
			beforeSend:function(){$("#loading").css("display","block");},
			complete:function(){$("#loading").css("display","none");},
			success:function(data){
				var depart = data.departAv; //去程的航班
				var returnf = data.returnAv; //回程的航班
				console.log(depart);
				console.log(returnf);
				var countDivNum = 0; //计数器
				for(var i=0; i<depart.length; i++){
						var depCity = findByCity(depart[i].orgCity); //第一航段的出发城市
						var arrCity = findByCity(depart[i].dstCity); //第一航段的到达城市
						var depTime = changeType(depart[i].depTime); //出发时间
						for(var j=0; j<returnf.length; j++){
								var depCityre = findByCity(returnf[j].orgCity); //第二航段的出发城市
								var arrCityre = findByCity(returnf[j].dstCity); //第二航段的到达城市
								var depTimere = changeType(returnf[j].depTime); //出发时间
								var returnse = returnf[j].seatList; //回程座位
								var departse = depart[i].seatList; //去程座位
								var onePriceMoney = 0; //第一航段的价格
								var twoPriceMobey = 0; //第二航段的价格
								var cangType_bas = cnCang(cangW);
								var cangType_csw = "";
								var sumTemk=0; //剩余的票
								for(var k=0; k<departse.length; k++){
									for(var h=0; h<returnse.length; h++){
										if(departse[k].basicCabin == cangW && tekNum(departse[k].cangwei_data)!=0 && returnse[h].basicCabin == cangW && tekNum(returnse[h].cangwei_data)!=0){
											cangType_bas = cnCang(returnse[h].basicCabin);
											cangType_csw2 = departse[k].cangwei;
											cangType_csw = returnse[h].cangwei;
											
											onePriceMoney = departse[k].onewayPrice;//第一航段的价钱
											twoPriceMobey = returnse[h].onewayPrice;//第二航段的价格 
											sumTemk += parseInt(signTekt(tekNum(departse[k].cangwei_data),tekNum(returnse[h].cangwei_data)));
										}
									}
								}
								var liList='<li class="zhzLiBox"><div class="zhzChildBox" onclick="chooseLi(this)"><div class="feiTimeBox"><div class="staTimeBox">'+depTime+'</div><div class="arrTimeBox">'+depTimere+'</div></div><div class="flidNameBox"><div class="qishiPlanNa"><img src="<%=basePath %>console/images/depImg.png" style="width:18px;margin-top: 1px;"/><span class="qishiSpan">'+depCity+'</span><img src="<%=basePath %>console/images/zuopoinyer.png" style="margin-top:6px; margin-left:5px;"/><span class="zhongone" style="margin-left:5px;">'+arrCity+'</span><span class="fildNoClass">'+depart[i].flightNo+'</span><span style="clear:both;"></span></div><div class="zhongPlanNa"><img src="<%=basePath %>console/images/arrImg.png" style="width:18px;margin-top: 1px;"/><span class="zhzSpan">'+depCityre+'</span><img src="<%=basePath %>console/images/zuopoinyer.png" style="margin-top:7px; margin-left:5px;"/><span class="zhongtwo" style="margin-left:5px;">'+arrCityre+'</span><span class="fildNoClass">'+returnf[j].flightNo+'</span><span style="clear:both;"></span></div></div><div class="monAndtick"><div class="tickNum">往返总价</div><div class="moneyCPY"><span style="color:#FF8201;font-size:14px;">￥</span><span class="oneMoneyHouse">'+(parseInt(onePriceMoney)+parseInt(twoPriceMobey))+'</span></div><div class="tickNumZh">'+cnCang(cangW)+''+sumTemk+'张</div></div><div style="clear:both;"></div></div><div class="wfbanner"><div class="b-img"><div class="runDiv"><div class="hangbanImform"><div class="neiImform"><div class="tuijianImgBox"></div><div class="firstDiv"><span class="jjc">'+cangType_bas+'</span><a class="zhzaYuding" onclick="trueBtnYd(\''+depart[i].uuid+'\',\''+returnf[j].uuid+'\',\''+cangType_csw2+'\',\''+cangType_csw+'\',\''+deTimeDate+'\',\''+reTimeDate+'\')">预定</a></div><div class="firstDiv" style="padding:10px 0px;"><span class="money">￥'+(parseInt(onePriceMoney)+parseInt(twoPriceMobey))+'</span><span> / </span><span class="zhe">85折</span></div><div class="firstDiv" style="padding-bottom:5px;"><span class="Eimg">'+cangType_csw2+'</span><span class="Eimg" style="margin-left:5px;">'+cangType_csw+'</span><span class="pointer">100%</span><span class="licheng">里程累计比例</span></div><div class="firstDiv fourDiv"><span class="shiyong">使用条件</span><span class="jiantou"><img src="<%=basePath%>console/images/youpoit.png"></span><span class="jiantou" style="float:right;"><img src="<%=basePath%>console/images/youpoit.png"></span><span class="wfpiaojia" onclick="othercang(this)">对应舱位其他票价</span></div><div style="clear:both;"></div></div></div></div></div></div><div class="cangweiClass" style="height:auto;"></div></li>';
								$("#ulBox").append(liList);
								if(sumTemk == 0||sumTemk == "0"){
									$(".zhzLiBox:eq("+countDivNum+") .zhzaYuding").text("已售完");
									$(".zhzLiBox:eq("+countDivNum+") .zhzaYuding").addClass("buyOver");
									$(".zhzLiBox:eq("+countDivNum+") .buyOver").removeClass("zhzaYuding");
									$(".zhzLiBox:eq("+countDivNum+") .buyOver").attr("href","javascript:void(0)");
									$(".zhzLiBox:eq("+countDivNum+") .Eimg").text(cangW);
								}
								//加载舱位
								var depDate = []; //盛装符合第一航段舱位和座位不为空的数据
								var depLastDate = []; //第一航段最终需要打印的数据
								for(var k=0; k<departse.length; k++){
									if(departse[k].basicCabin==cangW && tekNum(departse[k].cangwei_data)!=0){
										depDate.push(departse[k]);
									}
								}
								if(depDate.length>1){ //如果这些数据大于1
									depLastDate.push(depDate[parseInt(depDate.length)-2]);
									depLastDate.push(depDate[parseInt(depDate.length)-1]);
								}else{
									depLastDate = depDate;
								}
								
								var retDate = []; //盛装符合第二航段舱位和座位不为空的数据
								var retLastDate = []; //第二航段最终需要打印的数据
								for(var h=0; h<returnse.length; h++){
									if(returnse[h].basicCabin==cangW && tekNum(returnse[h].cangwei_data)!=0){
										retDate.push(returnse[h]);
									}
								}
								if(retDate.length>1){
									retLastDate.push(retDate[parseInt(retDate.length)-2]);
									retLastDate.push(retDate[parseInt(retDate.length)-1]);
								}else{
									retLastDate = retDate;
								}
								
								for(var k=0; k<depLastDate.length; k++){
									var GcangType = depLastDate[k].basicCabin;
									var GcangPont = depLastDate[k].cangwei;
									var depart_moneyCost = depLastDate[k].onewayPrice;
									for(var h=0; h<retLastDate.length; h++){
										var RcangType = retLastDate[h].basicCabin;
										var RcangPont = retLastDate[h].cangwei;
										var return_moneyCost = retLastDate[h].onewayPrice;
										var dr_countPay = parseInt(depart_moneyCost)+parseInt(return_moneyCost);
										if(tekNum(depLastDate[k].cangwei_data) != 0 && tekNum(retLastDate[h].cangwei_data) != 0 && retLastDate[h].basicCabin == cangW && depLastDate[k].basicCabin == cangW){
											var listDiv='<div class="banner1"><div class="b-img"><div class="runDiv"><div class="hangbanImform"><div class="neiImform"><div class="firstDiv"><span class="jjc">'+cnCang(cangW)+'</span><a class="zhzanotheryu" onclick="trueBtnYd(\''+depart[i].uuid+'\',\''+returnf[j].uuid+'\',\''+GcangPont+'\',\''+RcangPont+'\',\''+deTimeDate+'\',\''+reTimeDate+'\')">预定</a></div><div class="firstDiv" style="padding:10px 0px;"><span class="money">￥'+dr_countPay+'</span><span> / </span><span class="zhe">85折</span></div><div class="firstDiv" style="padding-bottom:5px;"><span class="Eimg">'+GcangPont+'</span><span class="Eimg" style="margin-left:5px;">'+RcangPont+'</span><span class="pointer">100%</span><span class="licheng">里程累计比例</span></div><div class="firstDiv fourDiv"><span class="shiyong">使用条件</span><span class="jiantou"><img src="<%=basePath%>console/images/youpoit.png"></span></div><div style="clear:both;"></div></div></div></div></div></div>';
											$(".zhzLiBox:eq("+countDivNum+") .cangweiClass").append(listDiv);
										}
									}
								}
								countDivNum++;
						}
					}
			},error:function(){
						
			}
	});
	$(".panel").slideUp("fast");
}
</script>
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
	$("#d12").mobiscroll($.extend(opt['date'], opt['defaults']));
});
</script>
</html>