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
	<link rel="stylesheet" type="text/css"  href="<%=basePath%>console/css/loading.css" />
	<script src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
	<script src="<%=basePath %>console/js/airCodeVScity.js"></script>
	<style>
		body{padding:0px; margin:0px;}
		ul{list-style-type:none; margin:0px; padding:0px;}
		.zhzLiBox{ margin:0px; font-size:15px; color:#666666; padding:7px 5px; font-family:Arial, Helvetica, sans-serif; border-bottom:#E0E0E0 solid 1px; padding:5px;}
		.zhzLiBox .feiTimeBox{margin-left:6px; float:left; width:50px;}
		.zhzLiBox .feiTimeBox .staTimeBox{ line-height:29px; text-align:left; height:40px;}
		.zhzLiBox .feiTimeBox .arrTimeBox{ line-height:29px; color:#999999; text-align:left; font-size:13px;}
		.zhzLiBox .flidNameBox{ float:left; margin-left:2%; padding-top:6px;}
		.zhzLiBox .flidNameBox .qishiPlanNa{ overflow:hidden; height:35px;}
		.zhzLiBox .flidNameBox .zhongPlanNa{ overflow:hidden; padding-top:4px;}
		.zhzLiBox .flidNameBox .qishiPlanNa img{ display:block; float:left;}
		.zhzLiBox .flidNameBox .qishiPlanNa .qishiSpan,.zhzLiBox .flidNameBox .qishiPlanNa .zhongone{margin-left:5px; display:block; float:left; line-height:22px;}
		.zhzLiBox .flidNameBox .fildNoClass{color:#888;display:block;margin-top:4px;font-size:13px;margin-left:10px;float:left;overflow:hidden;}
		.zhzLiBox .zhzPlanName{ text-align:center; float:left; margin-left:10px;}
		.zhzLiBox .zhzPlanName .zhuanICO{color:#648bff; font-size:10px; display:block; margin-top:15px;}
		.zhzLiBox .zhzPlanName .zhuanName{color:#648bff; font-size:10px; margin-top:0px;}
		.zhzLiBox .flidNameBox .zhongPlanNa .zhzSpan,.zhzLiBox .flidNameBox .zhongPlanNa .zhongtwo{margin-left:5px; display:block; float:left; line-height:22px; color:#999999;}
		.zhzLiBox .flidNameBox .zhongPlanNa img{display:block; float:left;}
		.zhzLiBox .monAndtick{ float:right; margin-right:7px;}
		.zhzLiBox .monAndtick .moneyCPY{font-family:'微软雅黑'; text-align:right; height:25px; line-height:25px;}
		.zhzLiBox .monAndtick .tickNumZh{color:#999; font-size:11px;}
		.zhzLiBox .monAndtick .moneyCPY .oneMoneyHouse{color:#FF8201; font-size:15px; font-family:Arial, Helvetica, sans-serif;}
		.zhzLiBox .monAndtick .tickNum{line-height:15px; text-align:right; color:#999999; margin-top:10px; font-size:12px;}
		.zhzLiBox .infoMessgBox{ height:15px; display:none;}
		.zhzLiBox .infoMessgBox .infoChBox{ float:left; height:13px; color:#999999; font-size:10px; line-height:13px; padding:1px 10px;}
		.infoChBox img,.infoChBox span{display:block; float:left;}
		.infoChBox span{ margin-top:1px; margin-left:5px;}
		
		/*子类框*/
		.hangbanImform{padding:20px 10px; background-color:#F1F5FF; text-align:center;}
		.hangbanImform .neiImform{width:85%; border:#007AFF solid 1px; margin-left:auto; margin-right:auto; border-radius:10px; background-color:#ffffff; padding:15px;}
		.hangbanImform .neiImform .firstDiv{overflow:hidden; text-align:center;}
		.hangbanImform .neiImform .firstDiv .jjc{float:left; padding:5px;}
		.hangbanImform .neiImform .firstDiv .aYuding,.hangbanImform .neiImform .firstDiv .anotherCW,.hangbanImform .neiImform .firstDiv .zhzaYuding,.hangbanImform .neiImform .firstDiv .zhzanotheryu{float:right; padding:4px 15px; border:#FF8204 solid 1px; color:#FF8204; font-size:13px; text-decoration:none;}
		.hangbanImform .neiImform .firstDiv .money{color:#FF8204;}
		.hangbanImform .neiImform .firstDiv .zhe{color:#0079FE;}
		.hangbanImform .neiImform .firstDiv .Eimg{float:left; border:1px solid #0079FE; border-radius:2px; color:#0079FE; width:16px; height:16px;}
		.hangbanImform .neiImform .firstDiv .pointer{float:right; color:#FF8204;}
		.hangbanImform .neiImform .firstDiv .licheng{float:right; margin-right:5px; font-size:13px;}
		.hangbanImform .neiImform .firstDiv .shiyong{float:left; color:#999; font-size:15px; font-family:Arial, Helvetica, sans-serif; line-height:22px;}
		.hangbanImform .neiImform .fourDiv{border-top:1px solid #E0E0E0; padding:10px 0px;}
		.hangbanImform .neiImform .firstDiv .jiantou{float:left;}
		.hangbanImform .neiImform .firstDiv .jiantou img{width:7px; margin-top:4px; margin-left:5px;}
		.hangbanImform .neiImform .firstDiv .piaojia,.hangbanImform .neiImform .firstDiv .wfpiaojia{float:right; color:#999; font-size:15px; font-family:Arial, Helvetica, sans-serif; line-height:20px;}
		.banner,.wfbanner{ display:none;}
		.cangweiClass{ display:none;}
	</style>
</head>
<body>
<ul id="ulBox"></ul>
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
<script>
$(function(){
	var cangW = "<%=cangW%>";
	var chufCityCode = "<%=chufCity%>";
	var daodCityCode = "<%=daodCity%>";
	var dateTime = "<%=dateTime%>";
	var returnTime = "<%=returnTime%>";
	date1 = new Date(dateTime); //出发时间
	date2 = new Date(returnTime); //返程时间
	if(Date.parse(date1)>Date.parse(date2)){
		alert("订当天往返的机票，推荐分开来订单程航班。");
		return false;
	}
	var airline = "";
	var page = "";
	$.ajax({
			url:"<%=basePath%>wechatController/find/planTekTo.action",
			type:"POST",
			data:{"org":chufCityCode,"dst":daodCityCode,"date":dateTime,"returnDate":returnTime,"airline":airline,"page":page},
			dataType:"json",
			beforeSend:function(){$("#loading").css("display","block");},
			complete:function(){$("#loading").css("display","none");},
			success:function(data){
				var depart = data.departAv; //去程的航班
				var returnf = data.returnAv; //回程的航班
				//console.log(depart);
				//console.log(returnf);
				var countDivNum = 0; //计数器
				for(var i=0; i<depart.length; i++){
						var airName = findByCode(depart[i].airCode);
						var departRows = JSON.stringify(depart[i]); //第一段航班(字符串)
						var depCity = findByCity(depart[i].orgCity); //第一航段的出发城市
						var arrCity = findByCity(depart[i].dstCity); //第一航段的到达城市
						var depTime = changeType(depart[i].depTime); //出发时间
						//console.log(depart[i].seatList);
						for(var j=0; j<returnf.length; j++){
								var returnRows = JSON.stringify(returnf[j]); //第二段航班(字符串)
								var airName2 = findByCode(returnf[j].airCode); 
								var depCityre = findByCity(returnf[j].orgCity); //第二航段的出发城市
								var arrCityre = findByCity(returnf[j].dstCity); //第二航段的到达城市
								var depTimere = changeType(returnf[j].depTime); //出发时间
								var departse = depart[i].seatList; //去程座位
								var returnse = returnf[j].seatList; //回程座位
								var onePriceMoney = 0; //第一航段的价格
								var twoPriceMobey = 0; //第二航段的价格
								var cangType_bas = cnCang(cangW);
								var cangType_csw = "";
								var sumTemk=0; //剩余的票
								//console.log(returnf[j].seatList);
								for(var k=0; k<departse.length; k++){
									for(var h=0; h<returnse.length; h++){
										if(departse[k].cangwei == returnse[h].cangwei && departse[k].basicCabin == cangW && returnse[h].basicCabin == cangW){
											cangType_bas = cnCang(returnse[h].basicCabin);
											cangType_csw = returnse[h].cangwei;
											
											onePriceMoney = departse[k].onewayPrice;//第一航段的价钱
											twoPriceMobey = returnse[h].onewayPrice;//第二航段的价格 
											sumTemk += parseInt(signTekt(tekNum(departse[k].cangwei_data),tekNum(returnse[h].cangwei_data)));
										}
									}
								}
								var liList='<li class="zhzLiBox"><div class="zhzChildBox" onclick="chooseLi(this)"><div class="feiTimeBox"><div class="staTimeBox">'+depTime+'</div><div class="arrTimeBox">'+depTimere+'</div></div><div class="flidNameBox"><div class="qishiPlanNa"><img src="<%=basePath %>console/images/depImg.png" style="width:18px;margin-top: 1px;"/><span class="qishiSpan">'+depCity+'</span><img src="<%=basePath %>console/images/zuopoinyer.png" style="margin-top:6px; margin-left:5px;"/><span class="zhongone" style="margin-left:5px;">'+arrCity+'</span><span class="fildNoClass">'+depart[i].flightNo+'</span><span style="clear:both;"></span></div><div class="zhongPlanNa"><img src="<%=basePath %>console/images/arrImg.png" style="width:18px;margin-top: 1px;"/><span class="zhzSpan">'+depCityre+'</span><img src="<%=basePath %>console/images/zuopoinyer.png" style="margin-top:7px; margin-left:5px;"/><span class="zhongtwo" style="margin-left:5px;">'+arrCityre+'</span><span class="fildNoClass">'+returnf[j].flightNo+'</span><span style="clear:both;"></span></div></div><div class="monAndtick"><div class="tickNum">往返总价</div><div class="moneyCPY"><span style="color:#FF8201;font-size:14px;">￥</span><span class="oneMoneyHouse">'+(parseFloat(onePriceMoney)+parseFloat(twoPriceMobey)).toFixed(2)+'</span></div><div class="tickNumZh">经济舱'+sumTemk+'张</div></div><div style="clear:both;"></div></div><div class="wfbanner"><div class="b-img"><div class="runDiv"><div class="hangbanImform"><div class="neiImform"><div class="firstDiv"><span class="jjc">'+cangType_bas+'</span><a class="zhzaYuding" href=\'<%=basePath%>console/wechat/wfconfirmInfo.jsp?dateTime='+dateTime+'&returnTime='+returnTime+'&cangwei='+cangType_csw+'&onezhzDate='+departRows+'&twozhzDate='+returnRows+'\'>预定</a></div><div class="firstDiv" style="padding:10px 0px;"><span class="money">￥'+(parseFloat(onePriceMoney)+parseFloat(twoPriceMobey)).toFixed(2)+'</span><span> / </span><span class="zhe">85折</span></div><div class="firstDiv" style="padding-bottom:5px;"><span class="Eimg">'+cangType_csw+'</span><span class="pointer">100%</span><span class="licheng">里程累计比例</span></div><div class="firstDiv fourDiv"><span class="shiyong">使用条件</span><span class="jiantou"><img src="<%=basePath%>console/images/youpoit.png"></span><span class="jiantou" style="float:right;"><img src="<%=basePath%>console/images/youpoit.png"></span><span class="wfpiaojia" onclick="othercang(this)">对应舱位其他票价</span></div><div style="clear:both;"></div></div></div></div></div></div><div class="cangweiClass" style="height:auto;"></div></li>';
								$("#ulBox").append(liList);
								
								for(var k=0; k<depart[i].seatList.length; k++){
									var GcangType = (depart[i].seatList)[k].basicCabin;
									var GcangPont = (depart[i].seatList)[k].cangwei;
									var depart_moneyCost = (depart[i].seatList)[k].onewayPrice;
									for(var h=0; h<returnf[j].seatList.length; h++){
										var RcangType = (returnf[j].seatList)[h].basicCabin;
										var RcangPont = (returnf[j].seatList)[h].cangwei;
										var return_moneyCost = (returnf[j].seatList)[h].onewayPrice;
										var dr_countPay = (parseFloat(depart_moneyCost)+parseFloat(return_moneyCost)).toFixed(2);
										if(GcangType == RcangType && GcangPont == RcangPont && RcangType == cangW && GcangType == cangW){
											var listDiv='<div class="banner1"><div class="b-img"><div class="runDiv"><div class="hangbanImform"><div class="neiImform"><div class="firstDiv"><span class="jjc">'+cnCang(cangW)+'</span><a class="zhzanotheryu" href=\'<%=basePath%>console/wechat/wfconfirmInfo.jsp?dateTime='+dateTime+'&returnTime='+returnTime+'&cangwei='+RcangPont+'&onezhzDate='+departRows+'&twozhzDate='+returnRows+'\'>预定</a></div><div class="firstDiv" style="padding:10px 0px;"><span class="money">￥'+dr_countPay+'</span><span> / </span><span class="zhe">85折</span></div><div class="firstDiv" style="padding-bottom:5px;"><span class="Eimg">'+RcangPont+'</span><span class="pointer">100%</span><span class="licheng">里程累计比例</span></div><div class="firstDiv fourDiv"><span class="shiyong">使用条件</span><span class="jiantou"><img src="<%=basePath%>console/images/youpoit.png"></span></div><div style="clear:both;"></div></div></div></div></div></div>';
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
});

function chooseLi(inc){
	$(inc).siblings(".wfbanner").slideToggle("fast");
	$(inc).siblings(".cangweiClass").slideUp("fast");
}

function othercang(inc){
	$(inc).parents(".wfbanner").siblings(".cangweiClass").slideToggle("fast");
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
	}else if(date=="L"||date=="Q"||date=="S"||date=="C"||date=="X"||date=="Z"){
		date="";
	}else if(date!=""){
		date=date;
	}
	return date;
}
</script>
</html>