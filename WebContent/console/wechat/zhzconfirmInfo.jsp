<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
String username=(String) session.getAttribute("userName");
//String jin = (String) session.getAttribute("invId");
String uuid1 = request.getParameter("uuid1");
String uuid2 = request.getParameter("uuid2");
String canbin = request.getParameter("canbin");
String canbin2 = request.getParameter("canbin2");
String dateTime = request.getParameter("dateTime");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>填写资料</title>
<link rel="stylesheet" href="<%=basePath %>console/css/normalize3.0.2.min.css" />
<link rel="stylesheet" href="<%=basePath %>console/css/style.css?time=2106" />
<link rel="stylesheet" href="<%=basePath%>console/css/weui.min.css" />
<link rel="stylesheet" href="<%=basePath%>console/css/jquery-weui.css" />
<link rel="stylesheet" href="<%=basePath%>scripts/common/weui/css/weui.css" />
<link rel="stylesheet" href="<%=basePath %>console/css/mobiscroll.css"/>
<link rel="stylesheet" href="<%=basePath %>console/css/mobiscroll_date.css"/>
<link rel="stylesheet" type="text/css"  href="<%=basePath%>console/css/loading.css" />
<script type="text/javascript" src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/waritInforma.js?tsji=5221212559689"></script>
<script src="<%=basePath %>console/js/mobiscroll_date.js"></script> 
<script src="<%=basePath %>console/js/mobiscroll.js"></script>
<script src="<%=basePath %>console/js/jquery-weui.js"></script>
<script src="<%=basePath %>scripts/common/weui/js/zepto.min.js"></script>
<script src="<%=basePath %>console/js/airCodeVScity.js?name=11"></script>
<style>
	body{ background-color:#e5e5e5;}
	.fildBox{padding:12px; margin-left:auto; margin-right:auto; border-radius:5px; font-size:15px; font-family:Arial, Helvetica, sans-serif; background-color:#FFFFFF;}
	.timeBox{color:#333; overflow:hidden; font-size:14px;}
	.timeBox>span{ float:left;}
	.timeBox>.weekday{ margin-left:3px;}
	.timeBox>.plandep{ margin-left:5px; margin-right:3px;}
	.timeBox>.planarr{ margin-left:3px;}
	.timeBox>.time{ float:right; margin-left:3px;}
	.timeBox>img{ float:right; margin-top:3px;}
	.planName{ margin-top:15px;}
	.planName .planNamech{float:left; margin-left:10px;}
	.planName .planNamech>div{}
	.planName .planNamech .depTimefirst{ font-size:18px; font-weight:bold; text-align:right; margin-top:0px;}
	.planName .planNamech .depTimesecond{ margin-top:20px; text-align:right;}
	.planName .planNamech .depAirPlanfirst{ font-size:17px; margin-top:0px;}
	.planName .planNamech .lishiTime{ color:#999; font-size:14px;}
	.planName .planNamech .depAirPlansecond{ font-size:15px; color:#666;}
	.planName .planNamech .depTimenumt{text-align:right; margin-top:0px;}
	.planName .planNamech .arrTimenumt{ font-size:17px; font-weight:bold; text-align:right; margin-top:0px; margin-top:25px;}
	.planName .planNamech .depPlane_numt{ margin-top:0px; color:#666; font-size:15px;}
	.planName .planNamech .lishiTime_two{ color:#999; font-size:14px;}
	.planName .planNamech .arrPlane_numt{font-size: 17px;}
	.planName .airNameType{ float:right; color:#666666;}
	.planName .airNameType .airNameTypech{ margin-top:0px;}
	.planName .planNamech img{width:14px;}
	.zhzBox{ margin-top:15px; color:#666666; font-size:12px;}
	.zhzBox .zhzCity{ margin-left:30px;}
	.zhzBox .zhzPlanName{float:left;line-height: 25px;}
	.zhzBox .zhuangBox{ margin-left:8px;}
	.zhzBox .zhzPlanName .tingliuText{ margin-left:8px;}
	.countNumMoney{ text-align:right; margin-top:15px; font-size:18px; color:#FF9A14;}
	
	#costXq li{overflow:hidden;}
	#costXq li div{float:right;}
	
	/*填写资料*/
	.writInfoBox{ border-top:1px solid #e8e8e8; border-bottom:1px solid #e8e8e8; color:#8D8D8D; margin-top:10px; padding:0px; background-color:#FFFFFF; padding:0px 20px;}
	.writInfoBox ul{ list-style-type:none; padding:0px; margin:0px; border:none;}
	.writInfoBox ul li{ line-height:50px; border-bottom:1px solid #e8e8e8; height:50px;}
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

	.aBtn{margin-top:15px; display:block; background-color:#007AFF; border-radius:5px; color:#FBFDFF; text-align:center; width:88.55%; margin-left:auto; margin-right:auto; margin-bottom: 30px; height: 50px; line-height: 50px;}

	/*登录*/
	#touMbackground{ position:absolute; top:0px; left:0px; width:100%; height:100%; background:rgba(0,0,0,0.5); z-index:1; display:block; display:none;}
	#touMbackground .loginBox{ background-color:#FFFFFF; border-radius:10px; width:90%; height:150px; left:5%; top:25%; position:absolute; padding-top:10px;}
	#touMbackground .loginBox .inputBoxLogin{ border:#e1e1e1 solid 1px; height:30px; width:78%; margin-left:auto; margin-right:auto; margin-top:10px; border-radius:3px;}
	#touMbackground .loginBox .inputBoxLogin .loginImgBox{float:left;}
	#touMbackground .loginBox .inputBoxLogin .loginImgBox img{border-right:#e1e1e1 solid 1px; padding-right:5px; width:25px; margin-top:5px; margin-left:3px;}
	#touMbackground .loginBox .inputBoxLogin .logininpBox{}
	#touMbackground .loginBox .inputBoxLogin .logininpBox input{margin-top:5px; border:none; margin-left:10px;}
	#touMbackground .loginBox .loginBtn{ text-align:center; line-height:28px; color:#FFFFFF; background-color:#004F92;}

	/*确认订单*/
	#trueOrderInfo{position:absolute; top:0px; left:0px; width:100%; height:100%; background-color:#f1f1f1; z-index:1; display:none;}
	#trueOrderInfo .flidNoNumBox{width:90%; margin:15px auto 15px auto; padding-bottom:20px; background-color:#FFFFFF; border:#e1e1e1 solid 1px; overflow:hidden;}
	#trueOrderInfo .flidNoNumBox .chufDivBox{width:40%; float:left; height:100%;}
	#trueOrderInfo .flidNoNumBox .wanfDivBox{width:22%; float:left; height:100%; padding-top:8px;}
	#trueOrderInfo .flidNoNumBox .wanfDivBox img,.wanfDivBox span{}
	#trueOrderInfo .flidNoNumBox .wanfDivBox img{display:block; margin:auto; text-align:center; width:25px;}
	#trueOrderInfo .flidNoNumBox .wanfDivBox span{display:block; margin:auto; text-align:center; color:#8E8E8E; margin-top:11px;}
	#trueOrderInfo .flidNoNumBox .daodDivBox{width:32%; float:left; height:100%;}
	#trueOrderInfo .flidNoNumBox .placeCity{font-size:20px; font-weight:500; color:#007BFD; line-height:40px;}
	#trueOrderInfo .flidNoNumBox .planeNameInfo{color:#666666; font-size:12px; line-height:20px; overflow:hidden; height:18px;}
	#trueOrderInfo .flidNoNumBox .aboutTime{width:125px; color:#8E8E8E; line-height:20px; font-size:10px; -webkit-transform-origin-x:0;}
	
	#trueOrderInfo .InfoMesBox{width:90%; margin-left:auto; margin-right:auto; background:#FFFFFF; border:#E2E2E2 solid 1px; padding:10px 20px;}
	#trueOrderInfo .InfoMesBox .InfoUserMess ul{list-style-type:none; padding:0px; margin:0px;}
	#trueOrderInfo .InfoMesBox .InfoUserMess ul li{line-height:25px; color:#9A9A9A;}
	#trueOrderInfo .InfoMesBox .InfoUserMess ul li.lastLiClass{ padding-bottom:5px; border-bottom:#e1e1e1 solid 1px;}
	#trueOrderInfo .InfoMesBox .InfoUserMess ul li.BXliClass{ padding-top:5px;}
	.payCostMoney{ font-size:15px; color:#C70900; font-weight:bold;}
	#trueOrderInfo .InfoMesBox .InfoUserMess ul li .InfoValueClass{color:#666666;}
	
	#ulText li{overflow: hidden;}
</style>
</head>

<body>
<script>
$(function(){
	window.history.forward(1);//禁止后退
	<%-- var ivid = "<%=jin%>"; --%>
	var uuid1 = '<%=uuid1%>';
	var uuid2 = '<%=uuid2%>';
	var cangwei = '<%=canbin%>';
	var canbin2 = '<%=canbin2%>';
	var dateTime = "<%=dateTime%>";
	var orgtt = "";
	var zhztt = "";
	var dsttt = "";
	var pntrer = "";
	var pntrtw = "";
	var fals = true;
	var costvar = "";
	
	//获取选中的航班
	$.ajax({
		url: "<%=basePath %>wechatController/find/byuuidTwo.action",
		type: "POST",
		data: {
				"uuid1":uuid1,
				"uuid2":uuid2,
				"canbin":cangwei,
				"canbin2":canbin2
		},
		dataType: "json",
		success: function(result) {
			console.log(result);
			var filgNum1 = result.dataObj1[0];
			var filgNum2 = result.dataObj2[0];
			var bxcodate = result.bxCost;
			var kdcodate = result.kdCost;
			$(".depday").text(dateTime);
			$(".weekday").text(conterCONTime(dateTime));
			$(".plandep").text(findByCity(filgNum1.orgcity));
			orgtt = filgNum1.orgcity; 
			zhztt = filgNum2.orgcity;
			dsttt = filgNum2.dstcity;
			$(".planarr").text(findByCity(filgNum2.dstcity));
			$(".time").text(cuntTime(filgNum1.depTime,filgNum1.deptimemodify,filgNum2.arriTime,filgNum2.arriveTimeModify));
			$(".firstair").text(filgNum1.airline.substring(0,2));
			$(".scondair").text(filgNum2.airline.substring(0,2));
			$(".depTimefirst").text(changeType(filgNum1.depTime,""));
			$(".DaodTimetwo").html(changeType(filgNum1.depTime,""));	
			$(".depTimesecond").html(changeType(filgNum1.arriTime,filgNum1.arriveTimeModify));
			$(".depAirPlanfirst").text(findByplaneName(filgNum1.orgcity));
			$(".depAirPlansecond").text(findByplaneName(filgNum1.dstcity));
			$(".lishiTime").text(cuntTime(filgNum1.depTime,filgNum1.deptimemodify,filgNum1.arriTime,filgNum1.arriveTimeModify));
			$(".airNameTypech").text(findByCode(filgNum1.airline.substring(0,2)));
			$(".flindNum").text(filgNum1.airline);
			for(var i=0; i<bxcodate.length; i++){
				if(bxcodate[i].bxType==1||bxcodate[i].bxType=="1"){
					$("#ywaicoid").text(bxcodate[i].cost);
				}else if(bxcodate[i].bxType==2||bxcodate[i].bxType=="2"){
					$("#ywcostid").text(bxcodate[i].cost);
				}
			}
			$("#kdcostid").text(kdcodate[0].kdcost);
			
			$(".zhzCity").text(findByCity(filgNum1.dstcity));
			$(".tingliuTime").text(cuntTime(filgNum1.arriTime,filgNum1.arriveTimeModify,filgNum2.depTime,filgNum2.deptimemodify));
			
			$(".depTimenumt").html(changeType(filgNum2.depTime,filgNum2.deptimemodify));
			$(".arrTimenumt").html(changeType(filgNum2.arriTime,filgNum2.arriveTimeModify));
			$(".depPlane_numt").text(findByplaneName(filgNum2.orgcity));
			$(".lishiTime_two").text(cuntTime(filgNum2.depTime,filgNum2.deptimemodify,filgNum2.arriTime,filgNum2.arriveTimeModify));
			$(".arrPlane_numt").text(findByplaneName(filgNum2.dstcity));
			$(".airNameTypechch").text(findByCode(filgNum2.airline.substring(0,2)));
			$(".flindNumch").text(filgNum2.airline);
			

			$("#moneyPay").text((parseInt(result.cost1)+parseInt(result.cost2)));
			$("#countPay").text((parseInt(result.cost1)+parseInt(result.cost2))+100);
			costvar = parseInt(result.cost1)+parseInt(result.cost2);

			//航班信息
			$("#ChufCityone").text(findByCity(filgNum1.orgcity));
			$("#DaodCityone").text(findByCity(filgNum1.dstcity));
			$("#QishiPlanone").text(findByplaneName(filgNum1.orgcity));
			$("#DaodPlanone").text(findByplaneName(filgNum1.dstcity));
			$("#fildNumflyone").text(filgNum1.airline);
			$("#CountTimeone").text($(".lishiTime").text());
			$("#ChufDateone").text(dateTime);
			$("#ChufDateone_one").text(getArriDate(dateTime,filgNum1.arriveTimeModify));
			$("#ChufTimeone").html(changeType(filgNum1.depTime,""));
			$("#DaodTimeone").html(changeType(filgNum1.arriTime,""));
			
			$("#ChufCitytwo").text(findByCity(filgNum2.orgcity));
			$("#DaodCitytwo").text(findByCity(filgNum2.dstcity));
			$("#QishiPlantwo").text(findByplaneName(filgNum2.orgcity));
			$("#DaodPlantwo").text(findByplaneName(filgNum2.dstcity));
			$("#fildNumflytwo").text(filgNum2.airline);
			$("#CountTimetwo").text($(".lishiTime_two").text());
			$("#ChufDatetwo").text(seconDay(dateTime,filgNum2.deptimemodify));
			$("#ChufDatetwo_two").text(seconDay(dateTime,filgNum2.arriveTimeModify));
			$("#ChufTimetwo").html(changeType(filgNum2.depTime,""));
			$("#DaodTimetwo").html(changeType(filgNum2.arriTime,""));
		},
		error: function() {

		}
	});	
	
	//判断是否登录
	var username="<%=username%>";
	<%-- var jin = "<%=jin%>" --%>
	//alert(username+"/"+jin);
	if(username==""||username=="null"||username==null){
		$("#touMbackground").css("min-height","700px");
		$("#touMbackground").css("display","block");
	}else{
		<%-- getcode("<%=jin%>"); --%>
		$.post("<%=basePath%>wechatController/wechat/getlinkPsg.action",{userName:username},function(res){
			var jsonDate = JSON.parse(res);
			//console.log(jsonDate);
			//加载常用旅客
			$("#ulText").html("");
			for(var i=0; i<jsonDate.length; i++){
				var liStr = '<li><input class="radioClass" type="radio" name="radioName" style="float:left; margin-top:6px;"><span style="display:block; float:left; margin-left:7px;">'+jsonDate[i].linkman+'</span><span class="psgInfo" style="display:none;">'+JSON.stringify(jsonDate[i])+'</span></li>';
				$("#ulText").append(liStr);	
			}
			$(".radioClass").eq(0).attr("checked",'checked');
		});
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
							//ivid = (result.userInfo)[0].inCodeId;
							//getcode(ivid);			
							//加载常用旅客
							$("#ulText").html("");
							for(var i=0; i<(result.linkPeop).length; i++){
								var liStr = '<li><input class="radioClass" type="radio" name="radioName" style="float:left; margin-top:6px;"><span style="display:block; float:left; margin-left:7px;">'+(result.linkPeop)[i].linkman+'</span><span class="psgInfo" style="display:none;">'+JSON.stringify((result.linkPeop)[i])+'</span></li>';
								$("#ulText").append(liStr);	
							}
							$(".radioClass").eq(0).attr("checked",'checked');
							//上面的条件正确时候改变按钮格式
							$(".loginBtn").css("background-color","#dddddd");
							$(".loginBtn").css("color","#666666");
							$(".loginBtn").css("border","#cccccc solid 1px");
							$(".loginBtn").html("");
							$(".loginBtn").html("加载中...");
							$("#touMbackground").css("display","none");
						}else{
							$.alert("登录失败");
							$("#touMbackground").css("display","block");
						}							
					},
					error: function() {
						//$.alert("登录失败");
					}
			});
	});
	//return false;
	
	//下一步的按钮点击事件
	$(".aBtn").click(function(){
		var age = ""; //年龄
		var lvkeType = ""; //旅客类型
		var sexType = ""; //性别
		var birthdayNum = ""; //生日
		var deppDate = $(".depday").text(); //第一段出发日期
		if($("#linkName").val()==""||$("#linkName").val()==" "||$("#linkName").val()=="null"||$("#linkName").val()==null){
				$.alert("请填写姓名");
				return;
		}
		if($("#caseIpntSource").text()!="NI"){
			if($("#birthIpnt").val()==""||$("#birthIpnt").val()==" "||$("#birthIpnt").val()==null||$("#birthIpnt").val()=="null"){
				$.alert("请选择出生日期");
				return;
			}else{
				//获取年龄和出生日期
				birthdayNum = $("#birthIpnt").val();
				age = ageFunc(birthdayNum,$(".depday").text()); 
				//旅客类型
				if(age<2){
					lvkeType = "INF"; //婴儿  
				}else if(age>=2&&age<=12){
					lvkeType = "CHD"; //儿童
				}else{
					lvkeType = "ADT"; //成人票
				}
				//旅客性别
				sexType = $("#sexIpntSource").text();
			}
		}else{
			//获取年龄
			var idInfo = $("#IDcase").val();
			var birth = idInfo.substring(6,14);
			birthdayNum = birth.substring(0,4)+"-"+birth.substring(4,6)+"-"+birth.substring(6,8);
			age = ageFunc(birthdayNum,$(".depday").text()); 
			//获乘机人类型
			if(age<2){
				lvkeType = "INF"; //婴儿  
			}else if(age>=2&&age<=12){
				lvkeType = "CHD"; //儿童
			}else{
				lvkeType = "ADT"; //成人票
			}
			//获取性别
			var sexNum = idInfo.substring(idInfo.length-2,idInfo.length-1);
			sexType = (sexNum%2 ==0)?"M":"F";
		}
		if($("#phoneNum").val()==""||$("#phoneNum").val()==" "||$("#phoneNum").val()==null||$("#phoneNum").val()=="null"){
				$.alert("请填写手机号码");
				return;
		}
		if($("#IDcase").val()==""||$("#IDcase").val()==" "||$("#IDcase").val()==null||$("#IDcase").val()=="null"){
				$.alert("请填写证件号码");
				return;
		}
		
		if($("#caseIpntSource").text()=="NI"){
			if(codeSf()){}else{
				$.alert("身份证号码输入错误，请认真核实！");
				return false;
			}
		}
		if($(".baoxiaoDc").is(':checked')){
			var sanddren = $("#sendAdd").val().trim();
			if(sanddren==""||sanddren==null){
				$.alert("请填写配送地址！");
				return false;
			}
		}
		
		//意外险的值
		if($(".flindYwzhz").is(':checked')){
			$("#YiwaiBX").text("已购买");
			$("#yiwaiNum").text("1");
		}else{
			$("#YiwaiBX").text("未购买");
			$("#yiwaiNum").text("0");
		}
		//延误险值
		if($(".delayBxzhz").is(':checked')){
			$("#YanwuBX").text("已购买");
			$("#yanwuNum").text("1");
		}else{
			$("#YanwuBX").text("未购买");
			$("#yanwuNum").text("0");
		}
		//报销单
		if($(".baoxiaoDc").is(':checked')){
			$("#baoxOr").text("打印");
			$("#baoxOrNum").text("1");
		}else{
			$("#baoxOr").text("不打印");
			$("#baoxOrNum").text("0");
		}
		
		//乘机人资料
		var LinkName=$("#linkName").val();//乘机人
		var iDcaseType=$("#caseIpntSource").text();//证件类型
		var iDcase=$("#IDcase").val();//证件号码
		var PhoneNum=$("#phoneNum").val();//手机号码
		var YiwaiBX = $("#yiwaiNum").text();//意外保险
		var YanwuBX = $("#yanwuNum").text();//延误险
		var bxiaoOr = $("#baoxOrNum").text();//是否打印报销单
		var sendAddren = $("#sendAdd").val(); //配送地址
		//将航班数据打包到json数据里面
		var jsondatastr = '{"sign":"0","depDate":"'+deppDate+'","uuid1":"'+uuid1+'","uuid2":"'+uuid2+'","cangwei":"'+cangwei+'","canbin2":"'+canbin2+'","telkInfo":[{"LinkName":"'+LinkName+'","Sex":"'+sexType+'","iDcaseType":"'+iDcaseType+'","iDcase":"'+iDcase+'","PhoneNum":"'+PhoneNum+'","YiwaiBX":"'+YiwaiBX+'","bxiaoOr":"'+bxiaoOr+'","sendAddren":"'+sendAddren+'","YanwuBX":"'+YanwuBX+'","birthDay":"'+birthdayNum+'","age":"'+age+'","menType":"'+lvkeType+'"}]}';
		//var jsondata = JSON.parse(jsondatastr);
		//console.log(jsondata);
					
		$("#CostPay").text("￥"+$("#countPay").text());
		$("#LinkName").text(LinkName);
		$("#Sex").text(sexType=="F"?"先生":"女士");
		$("#iDcase").text(iDcase);
		$("#PhoneNum").text(PhoneNum);
		if(fals==true){
			fals=false;
			$.ajax({
				url:"<%=basePath%>userOrderController/add/zrorder.action",
				type:"POST",
				data:{"jsStr":jsondatastr},
				dataType:"json",
				beforeSend:function(){$("#loading").css("display","block");},
				complete:function(){$("#loading").css("display","none");},
				success:function(result){
					//console.log(result);
					var resDate = result.resAlert;
					$("#commitRes").html("");
					var tr = '<tr><td>'+findByCity(orgtt)+'</td><td><img src="<%=basePath%>console/images/resJt.png" style="width:25px;"/></td><td>'+findByCity(zhztt)+'</td><td style="width:120px; text-align:right;">'+isOkResult(resDate[0].isOk)+'</td></tr>';
					$("#resBoxTables").append(tr);
					var tr = '<tr><td>'+findByCity(zhztt)+'</td><td><img src="<%=basePath%>console/images/resJt.png" style="width:25px;"/></td><td>'+findByCity(dsttt)+'</td><td style="width:120px; text-align:right;">'+isOkResult(resDate[1].isOk)+'</td></tr>';
					$("#resBoxTables").append(tr);
					if(resDate[0].isOk=="1"&&resDate[1].isOk=="1"){
						pntrer = resDate[0].pntr;
						pntrtw = resDate[1].pntr;
						$("#trueOrderInfo").css("display","block");
						$("html").css("height","100%");
						$("html").css("overflow","hidden");
						$("body").css("height","100%");
						$("body").css("overflow","hidden");
					}else{
						if(resDate[0].isOk=="0"&&resDate[1].isOk=="1"){
							var li = '<li>'+resDate[0].commit+'</li>';
							$("#commitRes").append(li);
						}else if(resDate[0].isOk=="1"&&resDate[1].isOk=="0"){
							var li = '<li>'+resDate[1].commit+'</li>';
							$("#commitRes").append(li);
						}else{
							for(var i=0; i<resDate.length;i++){
								var li = '<li>'+resDate[i].commit+'</li>';
								$("#commitRes").append(li);
							}
						}
					}
					var heiScr = window.screen.height;
					if(heiScr<850){
						$("#ydresuletBox").css("min-height",850);
					}else{
						$("#ydresuletBox").css("height",heiScr);
					}
					$("#ydresuletBox").css("display","block");
				},
				error:function(result){
				}
			});	
		}else{
			$.alert("请勿重复提交订单");
		}
			
	});
	
	//判断输入的身份证是否正确
	$("#IDcase").change(function(){
		//用户选择输入身份证的时候才会校验  选择护照或者其他 不会校验
		if($("#caseIpntSource").text()=="NI"){
			if(codeSf()){ //当身份证输入正确的时候还得判断旅客的类型
				//获取年龄
				var airline1 = $(".flindNum").text();
				var airline2 = $(".flindNumch").text();
				var gdate = $("#ChufDateone").text();
				var rdate = $("#ChufDatetwo").text();
				var idInfo = $("#IDcase").val();
				var birth = idInfo.substring(6,14);
				var birthdayNumXX = birth.substring(0,4)+"-"+birth.substring(4,6)+"-"+birth.substring(6,8);
				var ageXX = ageFunc(birthdayNumXX,gdate); 
				
				var canbin = "Y";
				var cp = 0;
				//获乘机人类型
				if(ageXX<2){
					findbb(airline1,canbin,orgtt,zhztt,gdate,airline2,canbin,zhztt,dsttt,rdate,"IN");
				}else if(ageXX>=2&&ageXX<=12){
					findbb(airline1,canbin,orgtt,zhztt,gdate,airline2,canbin,zhztt,dsttt,rdate,"CH");
				}else{
					$("#crTelkBox").remove();
					$("#airBullte").remove();
					var liList = '<li id="crTelkBox"><div style="margin-left:15px;">共</div><div style="width:80px;">￥<span id="moneyPay" class="kl">'+costvar+'</span></div><div id="pstTypeName" style="width:100px; margin-right:50px;">成人票</div></li>';
					$("#sign").after(liList);
					var jjMonty = '<li id="airBullte"><div style="margin-left:15px;">x2</div><div style="width:80px;">￥<span id="airportPay" class="kl">50</span>/人</div><div style="width:100px; margin-right:50px;">机建费</div></li>';
					$("#crTelkBox").after(jjMonty);
					for(var i = 0;i<$(".kl").length;i++){
						cp+= parseInt($(".kl:eq("+i+")").text())*2;
					}
					$("#countPay").text(parseInt(cp)-parseInt(costvar));
				}
			}else{
				$.alert("身份证号码输入错误，请认真核实！");
			}
		}
	});
	
	//确认付款
	$(".truePayBtn").click(function(){
			$.alert("暂未开放支付功能！");	
			return false;
			var yiwai = 0,yanwu = 0;
			if($(".flindYwzhz").attr("checked")=="checked")yiwai = 1;
			if($(".delayBxzhz").attr("checked")=="checked")yanwu = 1;
			var subDateJson = '{"sign":"1","yiwai":"'+yiwai+'","yanwu":"'+yanwu+'","pntrer":"'+pntrer+'","pntrtw":"'+pntrtw+'","uuid1":"'+uuid1+'","uuid2":"'+uuid2+'"}';
			$.ajax({
					url:"<%=basePath%>wechatController/payCost/orderPay.action",
					type:"POST",
					data:{"subDateJson":subDateJson},
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
										$.alert("支付失败，请重新下单！");
								}
							});
						} else if(obj.state == 0) {
									
						}
					},
					error:function(result){
					}
				});
		});
	
	//检查手机格式是否正确
	$("#phoneNum").change(function(){
		var phone=/^(13[0-9]|14[0-9]|15[0-9]|18[0-9])\d{8}$/;
		if(!phone.test($("#phoneNum").val())){
			$.alert("请输入正确的手机号码");
			$("#phoneNum").focus();
			return false;
		}
	});
	
	$("#sexIpnt").on('click',function (){  
	        weui.picker([{
							label:'先生', 
							value:'F'
	        		   },{  
	        		   		label:'女士',
	        		   		value:'M'
	        		   }],{  
	            			onChange: function (result) {  
	                			//改变函数
	            			},  
	            			onConfirm: function (result) {  
	            				$("#sexIpntSource").text(result); 
								$("#sexIpnt").val(sourceSex(1,result));
	            			}  
	        	});  
    	});
    	
    	$("#personIpnt").on('click',function (){  
	        weui.picker([{
							label:'成人',  
							value:'ADT'
	        		   },{  
	        		   		label:'儿童',
	        		   		value:'CHD'
	        		   },{  
	        		   		label:'婴儿',
	        		   		value:'INF'
	        		   }],{  
	            			onChange: function (result) {  
	                			//改变函数
	            			},  
	            			onConfirm: function (result) {  
	            				$("#personIpntSource").text(result); 
								$("#personIpnt").val(sourceSex(2,result)); 
	            			}  
	        	});  
    	});
		
		$("#caseIpnt").on('click',function (){  
	        weui.picker([{
							label:'身份证', 
							value:'NI'
	        		   },{  
	        		   		label:'护照',
	        		   		value:'PP'
	        		   },{  
	        		   		label:'其他',
	        		   		value:'ID' 
	        		   }],{  
	            			onChange: function (result) {  
	                			//改变函数
	            			},  
	            			onConfirm: function (result) {  
	            				$("#caseIpnt").text(sourceSex(3,result)); 
								$("#caseIpntSource").text(result);

	                			if(result=="NI"){
	                				$("#sexBox").css("display","none");
	                				$("#birthdayBox").css("display","none");
	                				/* $("#personBox").css("display","none"); */
	                			}else{
	                				$("#sexBox").css("display","block");
	                				$("#birthdayBox").css("display","block");
	                				/* $("#personBox").css("display","block"); */
	                			}
	            			}  
	        	});  
    	});
		
		$("#quxiaoBtn").click(function(){
			$(".moveBox").css("display","none");
		});
		
		var heightscr = window.screen.height;
		if(heightscr<850){
			$(".moveBox").css("min-height",850);
		}else{
			$(".moveBox").css("min-height",heightscr);
		}
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
function changeType(GoTime,isJia){
	if(isJia=="+1"){
		var firstTime=GoTime.substring(0,2);
		var conterTime=GoTime.substring(2,4);
		return firstTime+":"+conterTime+"<span style='color:#666; font-size:10px;'>+1</span>";
	}else{			
		var firstTime=GoTime.substring(0,2);
		var lastTime=GoTime.substring(2,GoTime.length);
		return firstTime+":"+lastTime;
	}
}

function findbb(airline1,canbin1,org1,dst1,dateTime1,airline2,canbin2,org2,dst2,dateTime2,pstType){
	$("#loadMoney").css("display","block");
	$.post("<%=basePath%>wechatController/find/findBytwo.action",{airline1:airline1,canbin1:canbin1,org1:org1,dst1:dst1,dateTime1:dateTime1,airline2:airline2,canbin2:canbin2,org2:org2,dst2:dst2,dateTime2:dateTime2,pstType:pstType},function(result){
		$("#loadMoney").css("display","none");
		var obj = JSON.parse(result);
	    //console.log(obj);
		var cp = 0;
	    if("IN"==pstType){
			$("#pstTypeName").text("婴儿票");
			$("#moneyPay").text(parseInt(obj[0].total));
			$("#airBullte").remove();
		}else if("CH"==pstType){
			$("#pstTypeName").text("儿童票");
			$("#moneyPay").text(parseInt(obj[0].total));
			$("#airBullte").remove();
		}
	    for(var i = 0;i<$(".kl").length;i++){
			cp+= parseInt($(".kl:eq("+i+")").text())*2;
		}
		$("#countPay").text(parseInt(cp)-parseInt(obj[0].total));
	});
}

function addLink(){
	$(".moveBox").css("display","block");
}

//根据出发时间和是否+1的天数推算出到达时间
function getArriDate(depDate,isJiaOne){
	var dedat = new Date(depDate);
	if(isJiaOne=="+1"){
		dedat.setDate(dedat.getDate() + 1);
	 	var yy = dedat.getFullYear();
	 	var mm = dedat.getMonth()+1;
	 	var dd = dedat.getDate();
	 	if(mm < 10){
	 		mm = "0"+mm;
	 	}
	 	if(dd<10){
	 		dd = "0"+dd;
	 	}
	 	return yy+"-"+mm+"-"+dd;
	}else{
		return depDate;
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

function LookOrderFunc(){
	window.location.href="<%=basePath%>wechatController/page/myPlaneTickek.action";
}

function isOkResult(isOk){
	return (isOk=="1"?"锁定成功":"锁定失败");
}

//计算历经多长时间到达
function cuntTime(depTime,isDept,arrTime,isArrt){
	var sTime = changesTime(depTime,isDept); //出发时间的秒
	var oTime = changesTime(arrTime,isArrt); //到达时间的秒
	var chaTime = oTime-sTime; //两个时间相差的秒
	var liTime = parseInt(chaTime/3600)+"h"+parseInt((chaTime%3600)/60)+"m";
	return liTime;
}

function seconDay(depDate,isjiaOne){
	if(isjiaOne=="+1"){
		var date = new Date(depDate);
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
	}else{
		return depDate;
	}
}

function codeSf(){
	var strVal = $("#IDcase").val();
    var arrExp = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2];//加权因子  
    var arrValid = [1, 0, "X", 9, 8, 7, 6, 5, 4, 3, 2];//校验码  
    if(/^\d{17}\d|x$/i.test(strVal)){   
        var sum = 0, idx;  
        for(var i = 0; i < strVal.length - 1; i++){  
            //对前17位数字与权值乘积求和  
            sum += parseInt(strVal.substr(i, 1), 10) * arrExp[i];  
        }  
        //计算模（固定算法）  
        idx = sum % 11;  
        //检验第18为是否与校验码相等  
        return arrValid[idx] == strVal.substr(17, 1).toUpperCase();  
    }else{ 
        return false;  
    }
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

function sdsds(depTime,arrTime){
	var hh1 = depTime.split(":");
	var hh2 = arrTime.split(":");
	var hhNum = parseInt(hh1[0])+parseInt(hh2[0]);
	var num = parseInt(hh1[1])+parseInt(hh2[1]);
	var zShu = parseInt(num/60);
	var yShu = num-(60*zShu);
	if(yShu<10){
		yShu = "0"+yShu;
	}
	return (hhNum+zShu)+"h"+yShu+"m";
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

function ageFunc(strBirthday,goDate){
	    var returnAge;  
	    var strBirthdayArr=strBirthday.split("-");  
	    var birthYear = strBirthdayArr[0];  
	    var birthMonth = strBirthdayArr[1];  
	    var birthDay = strBirthdayArr[2];  
	      
	    d = new Date(goDate);  
	    var nowYear = d.getFullYear();  
	    var nowMonth = d.getMonth() + 1;  
	    var nowDay = d.getDate();  
	      
	    if(nowYear == birthYear){  
	        returnAge = 0;//同年 则为0岁  
	    }  
	    else{  
	        var ageDiff = nowYear - birthYear ; //年之差  
	        if(ageDiff > 0){  
	            if(nowMonth == birthMonth){  
	                var dayDiff = nowDay - birthDay;//日之差  
	                if(dayDiff < 0){  
	                    returnAge = ageDiff - 1;  
	                }  
	                else{  
	                    returnAge = ageDiff ;  
	                }  
	            }  
	            else{  
	                var monthDiff = nowMonth - birthMonth;//月之差  
	                if(monthDiff < 0){  
	                    returnAge = ageDiff - 1;  
	                }  
	                else{  
	                    returnAge = ageDiff ;  
	                }  
	            }  
	        }  
	        else{  
	            returnAge = -1;//返回-1 表示出生日期输入错误 晚于今天  
	        }  
	    }  
	    return returnAge;//返回周岁年龄  
}

function sourceSex(num,val){
	var value = "";
	if(num==1){
		if(val=="F"){
			value = "先生";
		}else if(val=="M"){
			value = "女士";
		}
	}else if(num==2){
		if(val=="ADT"){
			value = "成人";
		}else if(val=="CHD"){
			value = "儿童";
		}else if(val=="INF"){
			value = "婴儿";
		}
	}else if(num==3){
		if(val=="NI"){
			value = "身份证";
		}else if(val=="PP"){
			value = "护照";
		}else if(val=="ID"){
			value = "其他证件";
		}
	}
	return value;
}

function closeBox(){
	$("#ydresuletBox").css("display","none");
}

function chooseInfo(){
	var choInfo = $(".radioClass:checked").siblings(".psgInfo").text();
	var jsonDate = JSON.parse(choInfo);
	//console.log(jsonDate);
	if(jsonDate.caseType!="NI"){
		$("#linkName").val(jsonDate.linkman);
		$("#phoneNum").val(jsonDate.linkNumber);
		$("#caseIpnt").text(sourceSex(3,jsonDate.caseType));
		$("#caseIpntSource").text(jsonDate.caseType);
		$("#sexIpnt").val(sourceSex(1,jsonDate.sex));
		$("#sexIpntSource").text(jsonDate.sex);
		$("#birthIpnt").val(jsonDate.birthday);
		$("#IDcase").val(jsonDate.caseNum);
		$("#sexBox").css("display","block");
		$("#birthdayBox").css("display","block");
	}else{
		$("#linkName").val(jsonDate.linkman);
		$("#phoneNum").val(jsonDate.linkNumber);
		$("#caseIpnt").text(sourceSex(3,jsonDate.caseType));
		$("#caseIpntSource").text(jsonDate.caseType);
		$("#IDcase").val(jsonDate.caseNum);
		$("#sexBox").css("display","none");
		$("#birthdayBox").css("display","none");
	}
	$(".moveBox").css("display","none");
}

function getcode(inc){
	$.ajax({
			url:"<%=basePath%>framework/invite/findByid.action",
			type:"POST",
			data:{"id":inc},
			dataType:"json",
			success:function(result){
				var date = result.rows;
				//console.log(date);
				if(date.length>0){
					$("#zhekouType").text(date[0].type);
					$.alert("您有优惠券可以使用哟！");
					if(date[0].type=="discount"){
						$(".youhuiText").text(date[0].remarks);
						$(".youhuiBxzhz").val(date[0].discount);
						$(".youhuiBox").css("display","block");
					}else if(date[0].type=="preferential"){
						$(".youhuiText").text(date[0].remarks);
						$(".youhuiBxzhz").val(date[0].sum);
						$(".youhuiBox").css("display","block");
					}else{
						$.alert("未知类型的优惠券，不能使用");
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
	<div class="timeBox"><span class="depday">01-05</span><span class="weekday">周四</span><span class="plandep">香港</span><span>—</span><span class="planarr">杭州</span><span class="time">4h50m</span><img src="<%=basePath %>console/images/TIMEiMG.png" style="width:15px;"/><span style="clear:both;"></span></div>
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
			<div class="flindNum" style="text-align:right;">CZ5201</div>
		</div>
		<div style="clear:both;"></div>
	</div>
	<div class="zhzBox">
		<div class="zhzPlanName zhzCity">厦门</div>
		<div class="zhzPlanName zhuangBox"><img src="<%=basePath %>console/images/zhuangImg.png" style="width:20px; height:20px; border-radius:15px; border:2px solid #ff9a14;"/></div>
		<div class="zhzPlanName"><span class="tingliuText">停留</span><span class="tingliuTime">1h35m</span></div>
		<div style="clear:both;"></div>
	</div>
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
			<div class="flindNumch" style="text-align:right;">CZ5201</div>
		</div>
		<div style="clear:both;"></div>
	</div>
	<div class="countNumMoney">
		<span style="float:left;font-size:15px;color:#888;font-weight:bold;">实付金额</span><span style="font-family:'微软雅黑'; color:#FF9A14; font-size:10px;">￥</span><span id="countPay">1205.00</span><span id="zhekouType" style="display:none;"></span>
	</div>
	<ul id="costXq" style="list-style-type:none; text-align:right; font-size:12px; color:#888;">
		<li id="sign"></li>
		<li id="crTelkBox"><div style="margin-left:15px;">共</div><div style="width:80px;">￥<span id="moneyPay" class="kl">30</span></div><div id="pstTypeName" style="width:100px; margin-right:50px;">成人票</div></li>
		<li id="airBullte"><div style="margin-left:15px;">x2</div><div style="width:80px;">￥<span id="airportPay" class="kl">50</span>/人</div><div style="width:100px; margin-right:50px;">机建费</div></li>
	</ul>
</div>

<!-- 填写资料 -->
<div class="writInfoBox">
	<div style="text-align:right; margin-top:10px;"><a style="font-size:13px; color:blue;" onclick="addLink()" >+选择常用联系人</a></div>
	<ul>
		<li><span class="spanTit">姓名：</span><input id="linkName" type="text"/><input type="hidden" id="firNumorder"/></li>
		<li id="sexBox" style="display:none;"><span class="spanTit">性别：</span><input type="text" id="sexIpnt" readonly="readonly" value="先生"/><span id="sexIpntSource" style="display:none;">F</span><span style="float:right; margin-top:18px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span><input type="hidden" id="secdNumorder"/></li>
		<li id="birthdayBox" style="display:none;"><span class="spanTit">出生日期：</span><input type="text" id="birthIpnt" readonly="readonly"/><span style="float:right; margin-top:17px;"><img src="<%=basePath %>console/images/riliImg.png" style="width:15px;"/></span></li>
		<li><span class="spanTit">手机号：</span><input id="phoneNum" type="text"/></li>
		<%-- <li id="personBox" style="display:none;"><span class="spanTit">旅客类型：</span><input type="text" id="personIpnt" readonly="readonly" value="成人"/><span id="personIpntSource" style="display:none;">ADT</span><span style="float:right; margin-top:18px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span></li> --%>
		<li><span class="spanTit" id="caseIpnt">身份证</span><span id="caseIpntSource" style="display:none;">NI</span><span><img src="<%=basePath %>console/images/xialaPonting.png" style="padding-top:4px;"/></span><input id="IDcase" type="text" placeholder="请输入证件号码"/></li>
		<li id="sendAddBox" style="display:none;"><span class="spanTit">配送地址：</span><input id="sendAdd" type="text"/></li>
	</ul>
</div>

<div class="baoxianBox">
	<div class="oneClassBX"><a class="checkboxA"></a><a class="checkboxB"></a><input type="checkbox" class="checkBoxId flindYwzhz" value="1"/><span class="spanTitBX">航意险</span></div>
	<div class="oneClassBX" style="margin-left:20px;"><a class="checkboxA"></a><a class="checkboxB"></a><input type="checkbox" class="checkBoxId delayBxzhz" value="1"/><span class="spanTitBX">延误险</span></div>
	<!-- <div class="oneClassBX youhuiBox" style="margin-left:20px; display:none;"><a class="checkboxA"></a><a class="checkboxB"></a><input type="checkbox" class="checkBoxId youhuiBxzhz" value="500"/><span class="spanTitBX youhuiText"></span></div> -->
	<div class="oneClassBX" style="margin-left:20px;"><a class="checkboxA"></a><a class="checkboxB"></a><input type="checkbox" class="checkBoxId baoxiaoDc" value="1"/><span class="spanTitBX">报销</span><span id="baoxiaoNum" style="display:none;"></span></div>
	<div style="clear:both;"></div>
</div>

<a class="aBtn">下 一 步</a>

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
		<div style="display:none;"><span class="firstair"></span><span class="scondair"></span></div>
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
		<div class="daodDivBox">
			<div class="placeCity" style="text-align:left;"><span id="DaodCitytwo">海口</span></div>
			<div class="planeNameInfo" id="DaodPlantwo">海口美兰国际机场</div>
			<div class="aboutTime"><span id="ChufDatetwo_two">2016-11-18</span><span id="DaodTimetwo" style="margin-left:5px;">08:05</span></div>		
		</div>
		<div style="clear:both;"></div>
	</div>
	<div class="InfoMesBox">
		<div style="display:none;"><span id="ywcostid"></span><span id="ywaicoid"></span><span id="kdcostid"></span></div>
		<div class="InfoUserMess">
			<ul>
				<li class="InfoLiClass"><span>价格：</span><span id="CostPay" class="payCostMoney">￥11111</span></li>
				<li class="InfoLiClass"><span>姓名：</span><span id="LinkName" class="InfoValueClass">111111</span></li>
				<li class="InfoLiClass"><span>性别：</span><span id="Sex" class="InfoValueClass">1111</span></li>
				<li class="InfoLiClass"><span id="iDcaseType">身份证</span><span>：</span><span id="iDcase" class="InfoValueClass">1111111111111</span></li>
				<li class="InfoLiClass lastLiClass"><span>手机：</span><span id="PhoneNum" class="InfoValueClass">111111111111</span></li>
				<li class="InfoLiClass BXliClass"><span>航意险：</span><span id="YiwaiBX" class="InfoValueClass">1</span><span id="yiwaiNum" style="display:none;"></span></li>
				<li class="InfoLiClass"><span>延误险：</span><span id="YanwuBX" class="InfoValueClass">1</span><span id="yanwuNum" style="display:none;"></span></li>
				<li class="InfoLiClass"><span>报销单：</span><span id="baoxOr" class="InfoValueClass"></span><span id="baoxOrNum" style="display:none;"></span></li>
			</ul>
		</div>
	</div>
	<div class="truePayBtn" style="width:90%; margin-left:auto; margin-right:auto; margin-top:10px;"><span style="display:block; padding:10px; background-color:#007AFF; color:#FFFFFF; font-size:15px; text-align:center; line-height:20px; border-radius:5px;">确认付款</span></div>
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
<div id="ydresuletBox" style="position:absolute; width:100%; height:100%; background:rgba(51,51,51,0.7); top:0px; left:0px; z-index:99; display:none;">
	<div style="margin:60% auto; width:300px; border-radius:5px; background:#fff;">
		<div style="text-align:center; color:#666; font-size:18px; line-height:45px;">座位锁定结果</div>
		<table id="resBoxTables" border="0" style="margin-left:20px; width:85%; height:55px;"></table>
		<ul id="commitRes" style="color:#ff0000; text-align:center; list-style-type:none;"></ul>
		<div style="border-top:1px #e1e1e1 solid; margin-top:10px; overflow:hidden;"> 
			<a style="display:block; float:left; width:49%; line-height:49px; text-align:center; border-right:1px solid #e1e1e1;" onclick="LookOrderFunc()">查看订单</a>
			<a style="display:block; float:right; width:50%; line-height:49px; text-align:center;" onclick="closeBox()">关闭</a>
			<a style="clear:both;"></a>
		</div>
	</div>
</div>
<div id="loadMoney" style="position:absolute; width:100%; height:100%; top:0px; left:0px; z-index:99; display:none;">
	<div style="margin:65% auto; width:200px; border-radius:5px; text-align: center; font-size:12px; line-height: 50px; color:#fff; background:rgba(51,51,51,0.6);">
		正在加载特殊旅客的票价...
	</div>
</div>
<div class="moveBox" style="display:none; width:100%; z-index:2; border:#000; position: absolute; background:#fff; top: 0px; box-shadow: 0px -2px 5px #e1e1e1; overflow: auto; padding-bottom: 20px;">
	<div style="background:#007AFF; text-align:center; padding:10px;"><a style="color:#fff; font-size:18px;">常用联系人</a></div>
	<ul id="ulText" style="list-style-type:none; margin:20px;"></ul>
	<div style="clear:both;"></div> 
	<div>
		<div id="quxiaoBtn" style="float:left; margin-left:5%; width:40%; line-height:35px; border-radius:5px; background:#cccccc; color:#fff; text-align:center;">取消</div>
		<div style="float:right; margin-right:5%; width:40%; line-height:35px; border-radius:5px; background:#007AFF; color:#fff; text-align:center;" onclick="chooseInfo()">确定</div>
		<div style="clear:both;"></div>
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
	</div> 
</div>
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
	
	$("#birthIpnt").mobiscroll($.extend(opt['date'], opt['defaults']));
});
</script>
<script src="<%=basePath %>scripts/common/weui/js/weui.min.js"></script>
</body>
</html>