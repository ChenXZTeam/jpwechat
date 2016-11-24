<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
String username=(String) session.getAttribute("userName");
String jin = (String) session.getAttribute("invId");
String onezhzDate=new String(request.getParameter("onezhzDate").getBytes("ISO-8859-1"),"utf-8");
String twozhzDate=new String(request.getParameter("twozhzDate").getBytes("ISO-8859-1"),"utf-8");
String dateTime=new String(request.getParameter("dateTime").getBytes("ISO-8859-1"),"utf-8");
String returnTime=new String(request.getParameter("returnTime").getBytes("ISO-8859-1"),"utf-8");
String cangwei=new String(request.getParameter("cangwei").getBytes("ISO-8859-1"),"utf-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>填写资料</title>
<link rel="stylesheet" href="<%=basePath %>console/css/normalize3.0.2.min.css" />
<link rel="stylesheet" href="<%=basePath %>console/css/style.css" />
<link rel="stylesheet" href="<%=basePath %>console/css/mobiscroll.css"/>
<link rel="stylesheet" href="<%=basePath %>console/css/mobiscroll_date.css"/>
<link rel="stylesheet" type="text/css"  href="<%=basePath%>console/css/loading.css" />
<script type="text/javascript" src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/waritInforma.js"></script>
<script src="<%=basePath %>console/js/mobiscroll_date.js"></script> 
<script src="<%=basePath %>console/js/mobiscroll.js"></script>
<script src="<%=basePath %>console/js/airCodeVScity.js"></script>
<style>
	body{ background-color:#e5e5e5;}
	.fildBox{padding:12px; margin-left:auto; margin-right:auto; border-radius:5px; font-size:13px; font-family:Arial, Helvetica, sans-serif; background-color:#FFFFFF;}
	.timeBox{color:#333; overflow:hidden; font-size:11px;}
	.timeBox>span{ float:left;}
	.timeBox>.weekdayone,.timeBox>.weekdaytwo{ margin-left:3px;}
	.timeBox>.plandepone,.timeBox>.plandeptwo{ margin-left:5px; margin-right:3px;}
	.timeBox>.planarrone,.timeBox>.planarrtwo{ margin-left:3px;}
	.timeBox>.time{ float:right; margin-left:3px;}
	.timeBox>img{ float:right; margin-top:2px;}
	.planName{ margin-top:10px;}
	.planName .planNamech{float:left; margin-left:10px;}
	.planName .planNamech>div{ margin-top:5px;}
	.planName .planNamech .depTimefirst{ font-size:17px; font-weight:bold; text-align:right; margin-top:0px;}
	.planName .planNamech .depTimesecond{ margin-top:27px; text-align:right;}
	.planName .planNamech .depAirPlanfirst{ font-size:13px; margin-top:0px;}
	.planName .planNamech .lishiTime{ color:#999; font-size:12px; margin-top:10px;}
	.planName .planNamech .depAirPlansecond{ font-size:11px; color:#666; margin-top:10px;}
	.planName .planNamech .depTimenumt{text-align:right; margin-top:0px;}
	.planName .planNamech .arrTimenumt{ font-size:17px; font-weight:bold; text-align:right; margin-top:0px; margin-top:30px;}
	.planName .planNamech .depPlane_numt{ margin-top:0px; color:#666; font-size:11px;}
	.planName .planNamech .lishiTime_two{ color:#999; font-size:12px; margin-top:10px;}
	.planName .planNamech .arrPlane_numt{font-size: 13px; margin-top:10px;}
	.planName .airNameType{float:right; font-size:10px; color:#666666; text-align: right;}
	.planName .airNameType .airNameTypech{ margin-top:0px;}
	.planName .planNamech img{width:14px;}
	.zhzBox{ margin-top:15px; color:#666666; font-size:12px;}
	.zhzBox .zhzCity{ margin-left:30px;}
	.zhzBox .zhzPlanName{float:left;}
	.zhzBox .zhuangBox{ margin-left:8px; margin-top:-2px;}
	.zhzBox .zhzPlanName .tingliuText{ margin-left:8px;}
	.countNumMoney{ text-align:right; margin-top:15px; font-size:18px; color:#FF9A14;}
	
	/*填写资料*/
	.writInfoBox{ border-top:1px solid #e8e8e8; border-bottom:1px solid #e8e8e8; font-size:12px; color:#8D8D8D; margin-top:10px; padding:0px; background-color:#FFFFFF; padding:0px 20px;}
	.writInfoBox ul{ list-style-type:none; padding:0px; margin:0px; border:none;}
	.writInfoBox ul li{ line-height:35px; border-bottom:1px solid #e8e8e8;}
	.writInfoBox ul li input{border:none; outline:none; -webkit-tap-highlight-color:rgba(255,255,255,0); margin-left:10px; width:65%;}
	.writInfoBox ul li span img{width:12px;}
	.writInfoBox ul li:last-child{border:none;}
	
	.baoxianBox{height:30px; padding-left:15px;}
	.baoxianBox .oneClassBX{float:left; padding:8px 0px;}
	.baoxianBox .oneClassBX input{margin-top:5px; margin-left:-13px; display:block; float:left; filter:alpha(opacity=0); -moz-opacity:0; opacity:0;}
	.baoxianBox .oneClassBX .spanTitBX{color:#8D8D8D; font-size:12px; margin-top:5px; margin-left:5px; display:block; float:left;}	

	.ChoosClassBox{width:80.5%; height:0px; overflow:hidden; border:1px solid #e1e1e1; position:absolute; top:400px; left:20px; background-color:#FFFFFF; padding:5px 10px; display:none; z-index:1;}
	.ChoosClassBox .ChoosSmallBox{padding:5px; border-bottom:1px solid #e1e1e1;}
	.checkboxA{ border:#C9C9C9 1px solid; background-color:#fff; width:16px; height:16px; display:block; z-index:-1; float:left; border-radius:8px; margin-top:3px;}
	.checkboxB{ background-color:#0079FE; border-radius:4px; width:8px; height:8px; display:block; float:left; margin-left:-11.544px; margin-top:6.599999px; display:none;}

	.aBtn{margin-top:15px; display:block; padding:7px 0px; background-color:#007AFF; border-radius:5px; color:#FBFDFF; font-size:12px; text-align:center; width:88.55%; margin-left:auto; margin-right:auto;}

	/*登录*/
	#touMbackground{ position:absolute; top:0px; left:0px; width:100%; height:100%; background:rgba(0,0,0,0.5); z-index:1; display:block; display:none;}
	#touMbackground .loginBox{ background-color:#FFFFFF; border-radius:10px; width:78%; height:150px; left:10%; top:25%; position:absolute; padding-top:10px;}
	#touMbackground .loginBox .inputBoxLogin{ border:#e1e1e1 solid 1px; height:30px; width:78%; margin-left:auto; margin-right:auto; margin-top:10px; border-radius:3px;}
	#touMbackground .loginBox .inputBoxLogin .loginImgBox{float:left;}
	#touMbackground .loginBox .inputBoxLogin .loginImgBox img{border-right:#e1e1e1 solid 1px; padding-right:5px; width:25px; margin-top:5px; margin-left:3px;}
	#touMbackground .loginBox .inputBoxLogin .logininpBox{float:left;}
	#touMbackground .loginBox .inputBoxLogin .logininpBox input{margin-top:5px; margin-left:10px; border:none;}
	#touMbackground .loginBox .loginBtn{ text-align:center; line-height:28px; color:#FFFFFF; background-color:#004F92;}


	/*确认订单*/
	#trueOrderInfo{position:absolute; top:0px; left:0px; width:100%; height:100%; background-color:#f1f1f1; z-index:1; display:none;}
	#trueOrderInfo .flidNoNumBox{width:90%; margin:15px auto 15px auto; padding-bottom:20px; background-color:#FFFFFF; border:#e1e1e1 solid 1px; overflow:hidden;}
	#trueOrderInfo .flidNoNumBox .chufDivBox{width:40%; float:left; height:100%;}
	#trueOrderInfo .flidNoNumBox .wanfDivBox{width:25%; float:left; height:100%; padding-top:8px;}
	#trueOrderInfo .flidNoNumBox .wanfDivBox img,.wanfDivBox span{}
	#trueOrderInfo .flidNoNumBox .wanfDivBox img{display:block; margin:auto; text-align:center; width:25px;}
	#trueOrderInfo .flidNoNumBox .wanfDivBox span{display:block; margin:auto; text-align:center; color:#8E8E8E; margin-top:11px;}
	#trueOrderInfo .flidNoNumBox .daodDivBox{width:32%; float:left; height:100%;}
	#trueOrderInfo .flidNoNumBox .placeCity{font-size:16px; font-weight:500; color:#007BFD; line-height:40px;}
	#trueOrderInfo .flidNoNumBox .planeNameInfo{color:#666666; font-size:12px; line-height:20px; overflow:hidden; height:18px;}
	#trueOrderInfo .flidNoNumBox .aboutTime{width:125px; color:#8E8E8E; line-height:20px; font-size:10px; -webkit-transform-origin-x:0;}
	
	#trueOrderInfo .InfoMesBox{width:90%; margin-left:auto; margin-right:auto; background:#FFFFFF; border:#E2E2E2 solid 1px; padding:10px 20px;}
	#trueOrderInfo .InfoMesBox .InfoUserMess ul{list-style-type:none; padding:0px; margin:0px;}
	#trueOrderInfo .InfoMesBox .InfoUserMess ul li{line-height:25px; color:#9A9A9A;}
	#trueOrderInfo .InfoMesBox .InfoUserMess ul li.lastLiClass{ padding-bottom:5px; border-bottom:#e1e1e1 solid 1px;}
	#trueOrderInfo .InfoMesBox .InfoUserMess ul li.BXliClass{ padding-top:5px;}
	.payCostMoney{ font-size:15px; color:#C70900; font-weight:bold;}
	#trueOrderInfo .InfoMesBox .InfoUserMess ul li .InfoValueClass{color:#666666;}
</style>
</head>

<body>
<script>
$(function(){
	window.history.forward(1);//禁止后退
	var ivid = "<%=jin%>";
	var onezhzDate = '<%=onezhzDate%>';
	var twozhzDate = '<%=twozhzDate%>';
	var dateTime = '<%= dateTime%>';
	var returnTime = '<%= returnTime%>';
	var cangwei = '<%=cangwei%>';
	var onezhzDateJson = JSON.parse(onezhzDate);
	var twozhzDateJson = JSON.parse(twozhzDate);
	onezhzDateJson.sign = "1";  //为第一航班添加一个标志
	twozhzDateJson.sign = "2";  //为第二航班也添加一个标志
	console.log(onezhzDateJson);
	console.log(twozhzDateJson);
	
	$(".depdayone").text(dateTime);
	$(".weekdayone").text(conterCONTime(dateTime));
	$(".plandepone").text(findByCity(onezhzDateJson.orgCity));
	$(".planarrone").text(findByCity(onezhzDateJson.dstCity));
	$(".firstair").text(onezhzDateJson.airCode);
	$(".scondair").text(twozhzDateJson.airCode);
	
	$(".depdaytwo").text(returnTime);
	$(".weekdaytwo").text(conterCONTime(returnTime));
	$(".plandeptwo").text(findByCity(twozhzDateJson.orgCity));
	$(".planarrtwo").text(findByCity(twozhzDateJson.dstCity));
	
	$(".depTimefirst").html(changeType(onezhzDateJson.depTime));
	$(".depTimesecond").html(changeType(onezhzDateJson.arrTime));
	$(".depAirPlanfirst").text(findByplaneName(onezhzDateJson.orgCity));
	$(".depAirPlansecond").text(findByplaneName(onezhzDateJson.dstCity));
	$(".lishiTime").text(cuntTime(onezhzDateJson.depTime,onezhzDateJson.arrTime));
	$(".airNameTypech").text(findByCode(onezhzDateJson.airCode));
	$(".flindNum").text(onezhzDateJson.flightNo);
	
	$(".zhzCity").text(findByCity(onezhzDateJson.dstCity));
	$(".tingliuTime").text(cuntTime(onezhzDateJson.arrTime,twozhzDateJson.depTime));
	
	$(".depTimenumt").html(changeType(twozhzDateJson.depTime));
	$(".arrTimenumt").html(changeType(twozhzDateJson.arrTime));
	$(".depPlane_numt").text(findByplaneName(twozhzDateJson.orgCity));
	$(".lishiTime_two").text(cuntTime(twozhzDateJson.depTime,twozhzDateJson.arrTime));
	$(".arrPlane_numt").text(findByplaneName(twozhzDateJson.dstCity));
	$(".airNameTypechch").text(findByCode(twozhzDateJson.airCode));
	$(".flindNumch").text(twozhzDateJson.flightNo);
	
	var one_monTimey,two_monTimey;
	var seatList_one = onezhzDateJson.seatList;
	var seatList_two = twozhzDateJson.seatList;
	for(var i=0; i<seatList_one.length; i++){
		if(seatList_one[i].cangwei == cangwei){
			one_monTimey = seatList_one[i].onewayPrice;
		}
	}
	for(var i=0; i<seatList_two.length; i++){
		if(seatList_two[i].cangwei == cangwei){
			two_monTimey = seatList_two[i].onewayPrice;
		}
	}
	$("#moneyPay").text((parseFloat(one_monTimey)+parseFloat(two_monTimey)).toFixed(2));
	
	//判断是否登录
	var username="<%=username%>";
	var jin = "<%=jin%>"
	if(username==""||username=="null"||jin==""||jin=="null"){
		alert("登录才能订票");
		$("#touMbackground").css("display","block");
	}else{
		getcode("<%=jin%>");
	}
	
	//登录
	$(".loginBtn").click(function(){
			var userN=$("#userN").val();
			var passW=$("#passW").val();
			$.ajax({
					url: "<%=basePath %>wechatController/wechat/login.action",
					type: "POST",
					data: {
							"userName":userN, "PassWord":passW
					},
					dataType: "json",
					success: function(result) {
						if(result.msg==1){	
							ivid = (result.userInfo)[0].inCodeId;
							getcode(ivid);					
							//上面的条件正确时候改变按钮格式
							$(".loginBtn").css("background-color","#dddddd");
							$(".loginBtn").css("color","#666666");
							$(".loginBtn").css("border","#cccccc solid 1px");
							$(".loginBtn").html("");
							$(".loginBtn").html("加载中...");
							alert("登录成功，可以订票咯^_^");
							$("#touMbackground").css("display","none");
						}else{
							alert("登录失败");
							$("#touMbackground").css("display","block");
						}							
					},
					error: function() {
						//alert("登录失败");
					}
			});
	});
	
	//下一步的按钮点击事件
	$(".aBtn").click(function(){
			if($("#linkName").val()==""||$("#linkName").val()==" "||$("#linkName").val()=="null"||$("#linkName").val()==null){
				alert("请填写姓名");
				return;
			}
			if($("#sexIpnt").val()==""||$("#sexIpnt").val()==" "||$("#sexIpnt").val()=="null"||$("#sexIpnt").val()==null){
				alert("请填写性别");
				return;
			}
			if($("#phoneNum").val()==""||$("#phoneNum").val()==" "||$("#phoneNum").val()==null||$("#phoneNum").val()=="null"){
				alert("请填写手机号码");
				return;
			}
			if($("#personIpnt").val()==""||$("#personIpnt").val()==" "||$("#personIpnt").val()==null||$("#personIpnt").val()=="null"){
				alert("请选择旅客类型");
				return;
			}
			if($("#caseIpnt").text()==""||$("#caseIpnt").text()==" "||$("#caseIpnt").text()==null||$("#caseIpnt").text()=="null"){
				alert("请选择证件类型");
				return;
			}
			if($("#IDcase").val()==""||$("#IDcase").val()==" "||$("#IDcase").val()==null||$("#IDcase").val()=="null"){
				alert("请填写证件号码");
				return;
			}
		//航班信息
		$("#ChufCityone").text(findByCity(onezhzDateJson.orgCity));
		$("#DaodCityone").text(findByCity(onezhzDateJson.dstCity));
		$("#QishiPlanone").text(findByplaneName(onezhzDateJson.orgCity));
		$("#DaodPlanone").text(findByplaneName(onezhzDateJson.dstCity));
		$("#fildNumflyone").text(onezhzDateJson.flightNo);
		$("#CountTimeone").text(cuntTime(onezhzDateJson.depTime,onezhzDateJson.arrTime));
		$("#ChufDateone").text(dateTime);
		$("#ChufDateone_one").text(gsDate(onezhzDateJson.depTime, dateTime));
		$("#ChufTimeone").html(changeType(onezhzDateJson.depTime));
		$("#DaodTimeone").html(changeType(onezhzDateJson.arrTime));
		
		$("#ChufCitytwo").text(findByCity(twozhzDateJson.orgCity));
		$("#DaodCitytwo").text(findByCity(twozhzDateJson.dstCity));
		$("#QishiPlantwo").text(findByplaneName(twozhzDateJson.orgCity));
		$("#DaodPlantwo").text(findByplaneName(twozhzDateJson.dstCity));
		$("#fildNumflytwo").text(twozhzDateJson.flightNo);
		$("#CountTimetwo").text(cuntTime(twozhzDateJson.depTime,twozhzDateJson.arrTime));
		$("#ChufDatetwo").text(gsDate(twozhzDateJson.depTime, returnTime));
		$("#ChufDatetwo_two").text(gsDate(twozhzDateJson.arrTime, returnTime));
		$("#ChufTimetwo").text(changeTypetwo(twozhzDateJson.depTime));
		$("#DaodTimetwo").text(changeTypetwo(twozhzDateJson.arrTime));
		
		//资料信息
		$("#LinkName").text($("#linkName").val());
		$("#Sex").text($("#sexIpnt").val());
		$("#iDcaseType").text($("#caseIpnt").text());
		$("#iDcase").text($("#IDcase").val());
		$("#PhoneNum").text($("#phoneNum").val());
		//意外险的值
		if($(".flindYwzhz").is(':checked')){
			$("#YiwaiBX").text($(".flindYwzhz").val());
		}else{
			$("#YiwaiBX").text("无");
		}
		//延误险值
		if($(".delayBxzhz").is(':checked')){
			$("#YanwuBX").text($(".delayBxzhz").val());
		}else{
			$("#YanwuBX").text("无");
		}	
		
		//第一航段信息
		var ChufDate1 = $(".depdayone").text();//出发日期
		var ChufTime1 = $(".depTimefirst").text();//出发时间
		var DaodTime1 = $(".depTimesecond").text();//到达时间
		var ChufCity1 = findByCity(onezhzDateJson.orgCity);//出发城市
		var DaodCity1 = findByCity(onezhzDateJson.dstCity);//到达城市
		var QishiPlan1 = $(".depAirPlanfirst").text();//起始机场
		var hangbanNum1 = $(".flindNum").text(); //航班号
		var airCode1 = $(".firstair").text(); //航空公司
		var DaodPlan1 = $(".depAirPlansecond").text();//到达机场
		var lishiTime1 = $(".lishiTime").text(); //历时多长时间
		var CostPay1 = $("#oneMoney").val();//该付金额
			
		//第二航段信息
		var ChufDate2 = $("#ChufDatetwo").text();//出发日期
		var ChufTime2 = $("#ChufTimetwo").text();//出发时间
		var DaodTime2 = $("#DaodTimetwo").text();//到达时间
		var ChufCity2 = findByCity(twozhzDateJson.orgCity);//出发城市
		var DaodCity2 = findByCity(twozhzDateJson.dstCity);//到达城市
		var QishiPlan2 = $(".depPlane_numt").text();//起始机场
		var hangbanNum2 = $(".flindNumch").text(); //航班号
		var airCode2 = $(".scondair").text(); //航空公司
		var DaodPlan2 = $(".arrPlane_numt").text();//到达机场
		var lishiTime2 = $(".lishiTime_two").text(); //历时多长时间
		var CostPay2 = $("#twoMoney").val();//该付金额
		
		//乘机人资料
		var LinkName = $("#linkName").val();//乘机人
		var Sex = $("#sexIpnt").val();//性别
		var iDcaseType = $("#caseIpnt").text();//证件类型
		var iDcase = $("#IDcase").val();//证件号码
		var PhoneNum = $("#phoneNum").val();//手机号码
		var YiwaiBX = $("#YiwaiBX").text();//意外保险
		var YanwuBX = $("#YanwuBX").text();//延误险
		var cangweiType = cangwei;
		var birthDay = $("#birthIpnt").val();//生日
		var age = ageFunc(birthDay);//年龄
		if(age==""||age==" "||age==null||age=="null"){
				return false;
		}
		var menType = $("#personIpnt").val();//乘机人类型
			
		//将提交的订单打包成json数据
		var jsondatastr = '{"sign":"WFF","firstFild":[{"ChufDate":"'+ChufDate1+'","ChufTime":"'+ChufTime1+'","DaodTime":"'+DaodTime1+'","ChufCity":"'+ChufCity1+'","DaodCity":"'+DaodCity1+'","QishiPlan":"'+QishiPlan1+'","hangbanNum":"'+hangbanNum1+'","airCode":"'+airCode1+'","DaodPlan":"'+DaodPlan1+'","lishiTime":"'+lishiTime1+'","CostPay":"'+CostPay1+'","LinkName":"'+LinkName+'","Sex":"'+Sex+'","iDcaseType":"'+iDcaseType+'","iDcase":"'+iDcase+'","PhoneNum":"'+PhoneNum+'","YiwaiBX":"'+YiwaiBX+'","YanwuBX":"'+YanwuBX+'","cangweiType":"'+cangweiType+'","birthDay":"'+birthDay+'","age":"'+age+'","menType":"'+menType+'","depcityCode1":"'+onezhzDateJson.orgCity+'","arrcityCode1":"'+onezhzDateJson.dstCity+'"}],"sconedFild":[{"ChufDate":"'+ChufDate2+'","ChufTime":"'+ChufTime2+'","DaodTime":"'+DaodTime2+'","ChufCity":"'+ChufCity2+'","DaodCity":"'+DaodCity2+'","QishiPlan":"'+QishiPlan2+'","hangbanNum":"'+hangbanNum2+'","airCode":"'+airCode2+'","DaodPlan":"'+DaodPlan2+'","lishiTime":"'+lishiTime2+'","CostPay":"'+CostPay2+'","LinkName":"'+LinkName+'","Sex":"'+Sex+'","iDcaseType":"'+iDcaseType+'","iDcase":"'+iDcase+'","PhoneNum":"'+PhoneNum+'","YiwaiBX":"'+YiwaiBX+'","YanwuBX":"'+YanwuBX+'","cangweiType":"'+cangweiType+'","birthDay":"'+birthDay+'","age":"'+age+'","menType":"'+menType+'","depcityCode2":"'+twozhzDateJson.orgCity+'","arrcityCode2":"'+twozhzDateJson.dstCity+'"}]}';
		//创建订单
		$.ajax({
					url:"<%=basePath%>userOrderController/add/zrorder.action",
					type:"POST",
					data:{"jsStr":jsondatastr},
					dataType:"json",
					beforeSend:function(){$("#loading").css("display","block");},
					complete:function(){$("#loading").css("display","none");},
					success:function(result){
						alert(result.of+", "+result.sc);
						if(result.msg=="1"||result.msg==1){
							alert("机票预定成功");
							$("#trueOrderInfo").css("display","block");
							<%-- window.location.href="<%=basePath%>wechatController/page/myPlaneTickek.action"; --%>
						}else if(result.msg=="0"||result.msg==0){
							alert("机票预定失败1，请稍后再试");
						}else{
							alert("机票预定失败2，请稍后再试");
						}
					},
					error:function(result){
					}
		});
	});
	
	//确认付款
		$(".truePayBtn").click(function(){
			var a = $("#turmonp").text();
			var yiwai = 0,yanwu = 0,youhui = 0;
			if($(".flindYwzhz").attr("checked")=="checked")yiwai = 1;
			if($(".delayBxzhz").attr("checked")=="checked")yanwu = 1;
			if($(".youhuiBxzhz").attr("checked")=="checked")youhui = 1;
			var activType = ivid;
			//var yiwai = $(".flindYw")
			$.ajax({
					url:"<%=basePath%>wechatController/payCost/orderPay.action",
					type:"POST",
					data:{
						"a":a,
						"yiwai":yiwai,
						"yanwu":yanwu,
						"youhui":youhui,
						"activType":activType,
						"depCity":obj.orgCity,
						"arrCity":obj.dstCity,
						"depDate":chufDate,
						"airCode":obj.airCode,
						"hangbanNum":obj.flightNo,
						"canbin":cangweiType
					},
					dataType:"json",
					success:function(result){
						//var obj = JSON.parse(result);
						if(obj.state==1){
							WeixinJSBridge.invoke('getBrandWCPayRequest',{
								"appId" : obj.appId, //公众号名称，由商户传入
								"timeStamp" : obj.timeStamp, //时间戳
								"nonceStr" : obj.nonceStr, //随机串
								"package" : obj.wxPackage,//统一支付接口返回的prepay_id 参数值，提交格式如：prepay_id=***
								"signType" : obj.signType, //微信签名方式:sha1
								"paySign" : obj.paySign //微信签名
							},function(res){
								if (res.err_msg == "get_brand_wcpay_request:ok") {
										<%-- window.location.href = "<%=basePath%>/wechatController/business/paySncyNotify.action?time=" + obj.time; --%>
										<%-- window.location.href = "<%=basePath %>console/wechat/StepFour.jsp?companyTypeJS="+companyTypeJS+"&typeCode="+typeCode; --%>
								} else if (res.err_msg == "get_brand_wcpay_request:cancel") {
												
								} else if (res.err_msg == "get_brand_wcpay_request:fail") {
										alert("支付失败，请重新下单！");
								}
							});
						} else if(obj.state == 0) {
									
						}
					},
					error:function(result){
					}
				});
		});
	
	$("#timess_m").val((parseFloat(one_monTimey)+parseFloat(two_monTimey)).toFixed(2));
	$("#truess_m").val((parseFloat(one_monTimey)+parseFloat(two_monTimey)).toFixed(2));
	$("#CostPay").text((parseFloat(one_monTimey)+parseFloat(two_monTimey)).toFixed(2));
	$("#oneMoney").val(one_monTimey);
	$("#twoMoney").val(two_monTimey);
});

//根据时间获取星期
function conterCONTime(time){
	var date = time;
	var day = new Date(Date.parse(date.replace(/-/g, '/')));  
	var today = new Array('周日','周一','周二','周三','周四','周五','周六');  
	var week = today[day.getDay()]; //获得星期
	var mmdd = week;
	return mmdd;
}

//改变出发时间和到达时间的类型
function changeType(GoTime){
	GoTime = GoTime.replace(" ","+");
	if(4<GoTime.length){
		var firstTime=GoTime.substring(0,2);
		var conterTime=GoTime.substring(2,4);
		var lastTime=GoTime.substring(4,GoTime.length);
		return firstTime+":"+conterTime+"<span style='color:#666; font-size:10px;'>"+lastTime+"</span>";
	}else{			
		var firstTime=GoTime.substring(0,2);
		var lastTime=GoTime.substring(2,GoTime.length);
		return firstTime+":"+lastTime;
	}
}

//改变出发时间和到达时间的类型
function changeTypetwo(GoTime){
	GoTime = GoTime.replace(" ","+");
	if(4<GoTime.length){
		var firstTime=GoTime.substring(0,2);
		var conterTime=GoTime.substring(2,4);
		var lastTime=GoTime.substring(4,GoTime.length);
		return firstTime+":"+conterTime;
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
	if(time.indexOf("+")>0||time.indexOf(" ")>0){
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

//格式化含有+1的出发日期
function gsDate(detTime, chufDate){
	if(detTime.indexOf("+")>0||detTime.indexOf(" ")>0){
		var date = new Date(chufDate);
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
		chufDate = yy+"-"+mm+"-"+dd;
	}
	return chufDate;
}

function ageFunc(birthday){
	var age = 0;
	var birth = birthday.split("-");	//对生日进行拆分
	var today=new Date();				//创建今天的日期
	var todayYear=today.getFullYear();	//今天的年
	var ageNum = todayYear*1 - birth[0]*1;
	if(ageNum > 0){
	    age = ageNum;
	}else{
	    alert("年龄选择错误，请重新选择！");
	    return false;
	}
	return age;
}

//获取邀请码
function getcode(inc){
	$.ajax({
			url:"<%=basePath%>framework/invite/findByid.action",
			type:"POST",
			data:{"id":inc},
			dataType:"json",
			success:function(result){
				var date = result.rows;
				console.log(date);
				if(date.length>0){
					$("#zhekouType").text(date[0].type);
					alert("您有优惠券可以使用哟！");
					if(date[0].type=="discount"){
						$(".youhuiText").text(date[0].remarks);
						$(".youhuiBxzhz").val(date[0].discount);
						$(".youhuiBox").css("display","block");
					}else if(date[0].type=="preferential"){
						$(".youhuiText").text(date[0].remarks);
						$(".youhuiBxzhz").val(date[0].sum);
						$(".youhuiBox").css("display","block");
					}else{
						alert("未知类型的优惠券，不能使用");
						$(".youhuiBox").remove();
					}
				}else{
					$(".youhuiBox").remove();
				}
			},
			error:function(result){
	
			}
	});
}
</script>
<div class="fildBox">
	<div class="timeBox"><span class="depdayone">01-05</span><span class="weekdayone">周四</span><span class="plandepone">香港</span><span>—</span><span class="planarrone">杭州</span><span style="clear:both;"></span></div>
	<div class="planName">
		<div class="planNamech">
			<div class="depTimefirst">09:35</div>
			<div class="depTimesecond">11:05</div>
		</div>
		<div class="planNamech">
			<img src="<%=basePath %>console/images/firestFlid.jpg"/>
		</div>
		<div class="planNamech">
			<div class="depAirPlanfirst">香港机场T1</div>
			<div class="lishiTime">1h30m</div>
			<div class="depAirPlansecond">高崎机场T3</div>
		</div>
		<div class="planNamech airNameType">
			<div class="airNameTypech">南方航空</div>
			<input type="hidden" id="truess_m"/>
			<div class="flindNum">CZ5201</div>
		</div>
		<div style="clear:both;"></div>
	</div>
	<div class="timeBox" style="margin-top:15px;"><span class="depdaytwo">01-05</span><span class="weekdaytwo">周四</span><span class="plandeptwo">香港</span><span>—</span><span class="planarrtwo">杭州</span><span style="clear:both;"></span></div>
	<div class="planName">
		<div class="planNamech">
			<div class="depTimenumt">12:35</div>
			<div class="arrTimenumt">14:25</div>
		</div>
		<div class="planNamech">
			<img src="<%=basePath %>console/images/secondFlid.jpg" style="width:12px;"/>
		</div>
		<div class="planNamech">
			<div class="depPlane_numt">高崎机场T3</div>
			<div class="lishiTime_two">1h35m</div>
			<div class="arrPlane_numt">萧山机场</div>
		</div>
		<div class="planNamech airNameType">
			<div class="airNameTypechch">南方航空</div>
			<input type="hidden" id="timess_m"/>
			<div class="flindNumch">CZ5201</div>
		</div>
		<div style="clear:both;"></div>
	</div>
	<div class="countNumMoney">
		<span style="font-family:'微软雅黑'; color:#FF9A14; font-size:10px;">￥</span><span id="moneyPay">1205.00</span>
	</div>
</div>

<!-- 填写资料 -->
<div class="writInfoBox">
	<ul>
		<li><span class="spanTit">姓名：</span><input id="linkName" type="text"/></li>
		<li><span class="spanTit">性别：</span><input type="text" id="sexIpnt" readonly="readonly"/><span style="float:right; margin-top:12px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span></li>
		<li><span class="spanTit">出生日期：</span><input type="text" id="birthIpnt" readonly="readonly"/><span style="float:right; margin-top:10px;"><img src="<%=basePath %>console/images/riliImg.png" style="width:15px;"/></span></li>
		<li><span class="spanTit">手机号：</span><input id="phoneNum" type="text"/></li>
		<li><span class="spanTit">旅客类型：</span><input type="text" id="personIpnt" readonly="readonly"/><span style="float:right; margin-top:12px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span></li>
		<li><span class="spanTit" id="caseIpnt">证件类型</span><span><img src="<%=basePath %>console/images/xialaPonting.png" style="padding-top:4px;"/></span><input id="IDcase" type="text" placeholder="请输入证件号码"/></li>
	</ul>
</div>

<div class="baoxianBox">
	<div class="oneClassBX"><a class="checkboxA"></a><a class="checkboxB"></a><input type="checkbox" class="checkBoxId flindYwzhz" value="购买"/><span class="spanTitBX">航空意外险</span></div>
	<div class="oneClassBX" style="margin-left:20px;"><a class="checkboxA"></a><a class="checkboxB"></a><input type="checkbox" class="checkBoxId delayBxzhz" value="购买"/><span class="spanTitBX">延误取消险</span></div>
	<div class="oneClassBX youhuiBox" style="margin-left:20px; display:none;"><a class="checkboxA"></a><a class="checkboxB"></a><input type="checkbox" class="checkBoxId youhuiBxzhz" value="500"/><span class="spanTitBX youhuiText"></span></div>
	<div style="clear:both;"><input id="oneMoney" type="hidden"/><span id="zhekouType" style="display:none;"></span><input id="twoMoney" type="hidden"/></div>
</div>

<a class="aBtn">下 一 步</a>
<!--性别选择-->
<div class="ChoosClassBox" id="sexType">
	<div class="ChoosSmallBox sexBoxCH">男</div>
	<div class="ChoosSmallBox sexBoxCH" style="border:none;">女</div>
	<div style="clear:both;"></div>
</div>
<!--旅客类型-->
<div class="ChoosClassBox" id="personType">
	<div class="ChoosSmallBox persBoxCH">成人</div>
	<div class="ChoosSmallBox persBoxCH">儿童</div>
	<div class="ChoosSmallBox persBoxCH" style="border:none;">婴儿</div>
	<div style="clear:both;"></div>
</div>
<!--证件类型-->
<div class="ChoosClassBox" id="CaseType" style="width:30%;">
	<div class="ChoosSmallBox caseBoxCH">身份证</div>
	<div class="ChoosSmallBox caseBoxCH">护照</div>
	<div class="ChoosSmallBox caseBoxCH" style="border:none;">其他</div>
	<div style="clear:both;"></div>
</div>

<!--确认订单-->
<div id="trueOrderInfo">
	<div class="flidNoNumBox" style="margin-bottom: 0px;">
		<div class="chufDivBox">
			<div class="placeCity" style="text-align:right;"><span id="ChufCityone">广州</span></div>
			<div class="planeNameInfo" style="text-align:right;">
				<span id="fildNumflyone" style="margin-left:5px; display:block; float:right;">CZ6772</span>
				<span id="QishiPlanone" style="width:60px; height:25px; display:block; float:right; overflow:hidden;">广州白云机场</span>
				<span style="clear:both"></span>
			</div>
			<div class="aboutTime" style="float:right; margin-right:0px; text-align:right;"><span style="text-align:right;" id="ChufDateone">2016-11-18</span><span id="ChufTimeone" style="margin-left:5px;">06:45</span></div>
		</div>
		<div class="wanfDivBox">
			<img src="<%=basePath %>console/images/zhzImg.png"/>
			<span id="CountTimeone">2h25m</span>
		</div>
		<div class="daodDivBox">
			<div class="placeCity" style="text-align:left;"><span id="DaodCityone">海口</span></div>
			<div class="planeNameInfo" id="DaodPlanone">海口美兰国际机场</div>
			<div class="aboutTime"><span id="ChufDateone_one">2016-11-18</span><span id="DaodTimeone" style="margin-left:5px;">08:05</span></div>		
		</div>
		<div style="clear:both;"></div>
	</div>
	<div class="flidNoNumBox" style="border-top:none; margin-top:0px;">
		<div class="chufDivBox">
			<div class="placeCity" style="text-align:right;"><span id="ChufCitytwo">广州</span></div>
			<div class="planeNameInfo" style="text-align:right;">
				<span id="fildNumflytwo" style="margin-left:5px; display:block; float:right;">CZ6772</span>
				<span id="QishiPlantwo" style="width:60px; height:25px; display:block; float:right; overflow:hidden;">广州白云机场</span>
				<span style="clear:both"></span>
			</div>
			<div class="aboutTime" style="float:right; margin-right:0px; text-align:right;"><span style="text-align:right;" id="ChufDatetwo">2016-11-18</span><span id="ChufTimetwo" style="margin-left:5px;">06:45</span></div>
		</div>
		<div class="wanfDivBox">
			<img src="<%=basePath %>console/images/zhzImg.png"/>
			<span id="CountTimetwo">1h35m</span>
		</div>
		<div style="display:none;"><span class="firstair"></span><span class="scondair"></span></div>
		<div class="daodDivBox">
			<div class="placeCity" style="text-align:left;"><span id="DaodCitytwo">海口</span></div>
			<div class="planeNameInfo" id="DaodPlantwo">海口美兰国际机场</div>
			<div class="aboutTime"><span id="ChufDatetwo_two">2016-11-18</span><span id="DaodTimetwo" style="margin-left:5px;">08:05</span></div>		
		</div>
		<div style="clear:both;"></div>
	</div>
	<div class="InfoMesBox">
		<div class="InfoUserMess">
			<ul>
				<li class="InfoLiClass"><span>价格：</span><span id="CostPay" class="payCostMoney">￥650.00</span></li>
				<li class="InfoLiClass"><span>姓名：</span><span id="LinkName" class="InfoValueClass">李向前</span></li>
				<li class="InfoLiClass"><span>性别：</span><span id="Sex" class="InfoValueClass">男</span></li>
				<li class="InfoLiClass"><span id="iDcaseType">身份证</span><span>：</span><span id="iDcase" class="InfoValueClass">460003199305034638</span></li>
				<li class="InfoLiClass lastLiClass"><span>手机：</span><span id="PhoneNum" class="InfoValueClass">15799024022</span></li>
				<li class="InfoLiClass BXliClass"><span>购买意外险：</span><span id="YiwaiBX" class="InfoValueClass">购买</span></li>
				<li class="InfoLiClass"><span>购买延误险：</span><span id="YanwuBX" class="InfoValueClass">购买</span></li>
			</ul>
		</div>
	</div>
	<div class="truePayBtn" style="width:90%; margin-left:auto; margin-right:auto; margin-top:30px;"><span style="display:block; padding:10px; background-color:#007AFF; color:#FFFFFF; font-size:15px; text-align:center; line-height:20px; border-radius:5px;">确认付款</span></div>
</div>

<!--用户登录-->
<div id="touMbackground">
	<div class="loginBox">
		<div class="inputBoxLogin">
			<div class="loginImgBox"><img src="<%=basePath %>console/images/admin.png"/></div>
			<div class="logininpBox"><input type="text" id="userN" placeholder="请输入登录账号"/></div>
		</div>
		<div class="inputBoxLogin">
			<div class="loginImgBox"><img src="<%=basePath %>console/images/suo.png"/></div>
			<div class="logininpBox"><input type="password" id="passW" placeholder="请输入登录密码"/></div>
		</div>
		<div class="inputBoxLogin loginBtn">登 录</div>
	</div>
</div>

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
<script>
$(function () {
	var currYear = (new Date()).getFullYear();	
	var opt={};
	opt.date = {preset : 'date'};
	opt.datetime = {preset : 'datetime'};
	opt.time = {preset : 'time'};
	opt.default = {
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
	
	$("#birthIpnt").mobiscroll($.extend(opt['date'], opt['default']));
});
</script>
</body>
</html>