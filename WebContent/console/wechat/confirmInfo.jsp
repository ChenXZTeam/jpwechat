<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%	
	String username=(String) session.getAttribute("userName");
	String jin = (String) session.getAttribute("invId");
	String cangweiType=new String(request.getParameter("cangweiType").getBytes("ISO-8859-1"),"utf-8");
	String chufDate = request.getParameter("chufDate");
	String jsd = new String(request.getParameter("jsd").getBytes("ISO-8859-1"),"utf-8");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>填写信息_订票</title>
<link rel="stylesheet" href="<%=basePath %>console/css/waritInforma.css?time=2016"/>
<link rel="stylesheet" href="<%=basePath %>console/css/normalize3.0.2.min.css" />
<link rel="stylesheet" href="<%=basePath%>console/css/weui.min.css" />
<link rel="stylesheet" href="<%=basePath%>console/css/jquery-weui.css" />
<link rel="stylesheet" href="<%=basePath %>console/css/style.css?time=2016" />
<link rel="stylesheet" href="<%=basePath%>scripts/common/weui/css/weui.css" />
<link rel="stylesheet" href="<%=basePath %>console/css/mobiscroll.css"/>
<link rel="stylesheet" href="<%=basePath %>console/css/mobiscroll_date.css"/>
<link rel="stylesheet" type="text/css"  href="<%=basePath%>console/css/loading.css"/>
<script type="text/javascript" src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/waritInforma.js"></script>
<script src="<%=basePath %>console/js/mobiscroll_date.js"></script> 
<script src="<%=basePath %>console/js/mobiscroll.js"></script> 
<script src="<%=basePath %>console/js/jquery-weui.js"></script>
<script src="<%=basePath %>scripts/common/weui/js/zepto.min.js"></script>
<script src="<%=basePath %>console/js/airCodeVScity.js"></script>
<style>
	body{-webkit-text-size-adjust:none;}
	.ChoosClassBox{width:80.5%; height:0px; overflow:hidden; border:1px solid #e1e1e1; position:absolute; top:400px; left:20px; background-color:#FFFFFF; padding:5px 10px; display:none; z-index:1;}
	.ChoosClassBox .ChoosSmallBox{padding:5px; border-bottom:1px solid #e1e1e1;}
	.checkboxA{ border:#C9C9C9 1px solid; background-color:#fff; width:16px; height:16px; display:block; z-index:-1; float:left; border-radius:8px; margin-top:7px;}
	.checkboxB{ background-color:#0079FE; border-radius:4px; width:8px; height:8px; display:block; float:left; margin-left:-11.544px; margin-top:10.599999px; display:none;}
</style>
</head>

<body>
<script>
var fals=true;//防止重复提交
var ivid = "<%=jin%>";
$(function(){
	var strRow = '<%= jsd%>';
	var obj = JSON.parse(strRow);
	console.log(obj);
	//获取上个界面传过来的值
	var chufTime = changeType(obj.depTime); //出发时间
	var arrDTime = changeType(obj.arrTime); //到达时间
	var shiPlace = findByplaneName(obj.orgCity)+" "+obj.flightNo;	//起始机场和航班（集合）
	var chufPlane = shiPlace.split(" "); //拆分shiPlace
	shiPlace = chufPlane[0]; //起始机场
	var flidNum = chufPlane[1];//航班
	var zhongPlace = findByplaneName(obj.dstCity)+" "+cuntTime(obj.depTime,obj.arrTime); //终止机场和历时（集合）
	var mudiPlane = zhongPlace.split(" ");//拆分zhongPlace
	zhongPlace = mudiPlane[0];//终止机场
	var countTime = mudiPlane[1];//历时多长时间
	var cost = ""; //价格
	<%-- var zhekou = "<%=zhekou%>"; //折扣 --%>
	var cangweiType = "<%=cangweiType%>"; //舱位类型
	var chufCityID = findByCity(obj.orgCity); //出发城市
	var daodCityID = findByCity(obj.dstCity); //目的城市
	var chufDate = "<%=chufDate%>"; //出发日期
	var seInfo = obj.seatList;
	for(var i=0; i<seInfo.length; i++){
		if(seInfo[i].cangwei == cangweiType){
			cost = seInfo[i].onewayPrice;
			$("#m").val(cost);
		}
	}
	//为信息框赋值
	console.log(chufTime+","+arrDTime+","+shiPlace+","+flidNum+","+zhongPlace+","+countTime+","+cost+","+cangweiType+","+chufCityID+","+daodCityID+","+chufDate); 
	$(".chufTime").text(chufTime);
	$(".arrDTime").text(arrDTime);
	$(".shiPlace").text(shiPlace);
	$(".flidNum").text(flidNum);
	$(".zhongPlace").text(zhongPlace);
	$(".countTime").text(countTime);
	$(".cost").text("￥"+cost);
	//$(".zhekou").text(zhekou);
	$(".cangweiType").text(cangweiType);
	$(".chufCityID").text(chufCityID);
	$(".daodCityID").text(daodCityID);
	$(".chufDate").text(chufDate);
	
	//判断是否登录
	var username="<%=username%>";
	var jin = "<%=jin%>"
	if(username==""||username=="null"||username==null){
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
							$.alert("登录成功，您可以订票咯");
							$("#touMbackground").css("display","none");
						}else{
							$.alert("登录失败");
							$("#touMbackground").css("display","block");
						}							
					},
					error: function() {
						//alert("登录失败");
					}
			});
		});
		
		//下一步的点击事件
		$(".aBtn").click(function(){
			if($("#linkName").val()==""||$("#linkName").val()==" "||$("#linkName").val()=="null"||$("#linkName").val()==null){
				$.alert("请填写姓名");
				return;
			}
			if($("#sexIpnt").val()==""||$("#sexIpnt").val()==" "||$("#sexIpnt").val()=="null"||$("#sexIpnt").val()==null){
				$.alert("请填写性别");
				return;
			}
			if($("#phoneNum").val()==""||$("#phoneNum").val()==" "||$("#phoneNum").val()==null||$("#phoneNum").val()=="null"){
				$.alert("请填写手机号码");
				return;
			}
			if($("#personIpnt").val()==""||$("#personIpnt").val()==" "||$("#personIpnt").val()==null||$("#personIpnt").val()=="null"){
				$.alert("请选择旅客类型");
				return;
			}
			if($("#caseIpnt").text()==""||$("#caseIpnt").text()==" "||$("#caseIpnt").text()==null||$("#caseIpnt").text()=="null"){
				$.alert("请选择证件类型");
				return;
			}
			if($("#IDcase").val()==""||$("#IDcase").val()==" "||$("#IDcase").val()==null||$("#IDcase").val()=="null"){
				$.alert("请填写证件号码");
				return;
			}
			$("#ChufDate").text(chufDate);
			$("#ChufDateTwo").text(chufDate);
			$("#ChufTime").text(chufTime);
			$("#DaodTime").text(arrDTime);
			$("#ChufCity").text(chufCityID);
			$("#DaodCity").text(daodCityID);
			$("#QishiPlan").text(shiPlace);
			$("#fildNumfly").text(flidNum);
			$("#CountTime").text(countTime);
			$("#DaodPlan").text(zhongPlace);
			$("#CostPay").text($(".cost").text());
			
			$("#LinkName").text($("#linkName").val());
			$("#Sex").text($("#sexIpnt").val());
			$("#iDcaseType").text($("#caseIpnt").text());
			$("#MenType").text($("#personIpnt").val());
			$("#iDcase").text($("#IDcase").val());
			$("#PhoneNum").text($("#phoneNum").val());
			
			//意外险的值
			if($(".flindYw").is(':checked')){
				$("#YiwaiBX").text($(".flindYw").val());
			}else{
				$("#YiwaiBX").text("无");
			}
			//延误险值
			if($(".delayBx").is(':checked')){
				$("#YanwuBX").text($(".delayBx").val());
			}else{
				$("#YanwuBX").text("无");
			}	
			if(nextPat()==false){return;}
			$(document).attr("title","机票预定_确认信息");
			$("#trueOrderInfo").css("display","block");
			$("html").css("height","100%");
			$("html").css("overflow","hidden");
			$("body").css("height","100%");
			$("body").css("overflow","hidden");
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
		
		//判断是否选择了证件类型
		$("#IDcase").focus(function(){
			if($("#caseIpnt").text()=="证件类型"){
				$.alert("请选择证件类型");
				$("#IDcase").blur();
				return false;
			}
		});
		
		//确认付款
		$(".truePayBtn").click(function(){
			var a = $("#turmonp").text();
			var yiwai = 0,yanwu = 0,youhui = 0;
			if($(".flindYw").attr("checked")=="checked")yiwai = 1;
			if($(".delayBx").attr("checked")=="checked")yanwu = 1;
			if($(".youhuiBx").attr("checked")=="checked")youhui = 1;
			var activType = ivid;
			var infojson = '{"sign":"0","a":"'+a+'","yiwai":"'+yiwai+'","yanwu":"'+yanwu+'","youhui":"'+youhui+'","activType":"'+activType+'","depCity":"'+obj.orgCity+'","arrCity":"'+obj.dstCity+'","depDate":"'+chufDate+'","airCode":"'+obj.airCode+'","canbin":"'+cangweiType+'"}';
			//var yiwai = $(".flindYw")
			$.ajax({
					url:"<%=basePath%>wechatController/payCost/orderPay.action",
					type:"POST",
					data:{"subDateJson":infojson},
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
		
		$("#sexIpnt").on('click',function (){  
	        weui.picker([{
							label:'先生', 
	            			value:'先生'
	        		   },{  
	        		   		label:'女士',
	            			value:'女士'
	        		   }],{  
	            			onChange: function (result) {  
	                			//改变函数
	            			},  
	            			onConfirm: function (result) {  
								$("#sexIpnt").val(result); 
	            			}  
	        	});  
    	});
    	
    	$("#personIpnt").on('click',function (){  
	        weui.picker([{
							label:'成人', 
	            			value:'成人'
	        		   },{  
	        		   		label:'儿童',
	            			value:'儿童'
	        		   },{  
	        		   		label:'婴儿',
	            			value:'婴儿'
	        		   }],{  
	            			onChange: function (result) {  
	                			//改变函数
	            			},  
	            			onConfirm: function (result) {  
								$("#personIpnt").val(result); 
	            			}  
	        	});  
    	});
		
		$("#caseIpnt").on('click',function (){  
	        weui.picker([{
							label:'身份证', 
	            			value:'身份证'
	        		   },{  
	        		   		label:'护照',
	            			value:'护照'
	        		   },{  
	        		   		label:'其他',
	            			value:'其他' 
	        		   }],{  
	            			onChange: function (result) {  
	                			//改变函数
	            			},  
	            			onConfirm: function (result) {  
								$("#caseIpnt").text(result); 
	            			}  
	        	});  
    	});
});

function nextPat(){
			var ChufDate=$("#ChufDate").text();//出发日期
			var ChufTime=$("#ChufTime").text();//出发时间
			var DaodTime=$("#DaodTime").text();//到达时间
			var ChufCity=$("#ChufCity").text();//出发城市
			var DaodCity=$("#DaodCity").text();//到达城市
			var QishiPlan=$("#QishiPlan").text();//起始机场
			var hangbanNum=$("#fildNumfly").text();
			var airCode = hangbanNum.substring(0,2);
			var DaodPlan=$("#DaodPlan").text();//到达机场
			var lishiTime=$(".countTime").text();
			var CostPay=$("#CostPay").text().substr(1,$("#CostPay").text().length);//该付金额
			var LinkName=$("#LinkName").text();//乘机人
			var Sex=$("#Sex").text();//性别
			var iDcaseType=$("#iDcaseType").text();//证件类型
			var iDcase=$("#iDcase").text();//证件号码
			var PhoneNum=$("#PhoneNum").text();//手机号码
			var YiwaiBX=$("#YiwaiBX").text();//意外保险
			var YanwuBX=$("#YanwuBX").text();//延误险
			var cangweiType=$(".cangweiType").text();
			var birthDay = $("#birthIpnt").val();//生日
			var age = ageFunc(birthDay);//年龄
			if(age==""||age==" "||age==null||age=="null"){
				return false;
			}
			var menType = $("#personIpnt").val();//乘机人类型
			var date={
				"ChufDate":ChufDate,
				"ChufTime":ChufTime,
				"DaodTime":DaodTime,
				"ChufCity":ChufCity,
				"DaodCity":DaodCity,
				"QishiPlan":QishiPlan,
				"hangbanNum":hangbanNum,
				"DaodPlan":DaodPlan,
				"lishiTime":lishiTime,
				"CostPay":CostPay,
				"LinkName":LinkName,
				"Sex":Sex,
				"iDcaseType":iDcaseType,
				"iDcase":iDcase,
				"PhoneNum":PhoneNum,
				"YiwaiBX":YiwaiBX,
				"YanwuBX":YanwuBX,
				"cabin":cangweiType,
				"birthday":birthDay,
				"menType":menType,
				"airCode":airCode,
				"age":age
			};
			if(fals==true){
				$.ajax({
					url:"<%=basePath%>userOrderController/add/order.action",
					type:"POST",
					data:date,
					dataType:"json",
					beforeSend:function(){$(".loading").css("display","block");},
					complete:function(){$(".loading").css("display","none");},
					success:function(result){
						$.alert(result.planMsg);
						$("#turmonp").text(result.order);
						//fals=false;
						<%-- window.location.href="<%=basePath%>wechatController/page/myPlaneTickek.action"; --%>
					},
					error:function(result){
					}
				});			
			}
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
					$.alert("您有优惠券可以使用哟！");
					if(date[0].type=="discount"){
						$(".youhuiText").text(date[0].remarks);
						$(".youhuiBx").val(date[0].discount);
						$(".youhuiBox").css("display","block");
					}else if(date[0].type=="preferential"){
						$(".youhuiText").text(date[0].remarks);
						$(".youhuiBx").val(date[0].sum);
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

function ageFunc(birthday){
		var age = 0;
		var birth = birthday.split("-");	//对生日进行拆分
		var today=new Date();				//创建今天的日期
	    var todayYear=today.getFullYear();	//今天的年
	    var ageNum = todayYear*1 - birth[0]*1;
	    if(ageNum > 0){
	    	age = ageNum;
	    }else{
	    	$.alert("年龄选择错误，请重新选择！");
	    	return "";
	    }
		return age;
	}
	
	//计算历经多长时间到达
	function cuntTime(depTime,arrTime){
		var sTime = changesTime(depTime); //出发时间的秒
		var oTime = changesTime(arrTime); //到达时间的秒
		var chaTime = oTime-sTime; //两个时间相差的秒
		var liTime = parseInt(chaTime/3600)+"h"+parseInt((chaTime%3600)/60)+"m";
		//alert(depTime+"->"+changesTime(depTime)+"/"+arrTime+"->"+changesTime(arrTime)+"/"+liTime);
		return liTime;
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
</script>
<div class="massInfoBox">
	<ul>
		<li><span class="spanTit">出发时间：</span><span class="spanCont chufDate"></span><span class="chufTime" style="margin-left:5px;"></span></li>
		<li><span class="spanTit">到达时间：</span><span class="spanCont chufDate"></span><span class="arrDTime" style="margin-left:5px;"></span></li>
		<li><span class="spanTit">出发城市：</span><span class="spanCont chufCityID"></span></li>
		<li><span class="spanTit">到达城市：</span><span class="spanCont daodCityID"></span></li>
		<li><span class="spanTit">起始机场：</span><span class="spanCont shiPlace"></span><span class="flidNum" style="margin-left:5px;"></span></li>
		<li><span class="spanTit">到达机场：</span><span class="spanCont zhongPlace"></span></li>
		<li><span class="spanTit">飞行历时：</span><span class="spanCont countTime"></span><span class="cangweiType" style="display:none;"></span><!-- <span class="zhekou" style="display:none;"></span> --></li>
	</ul>
	<div class="trueCost"><span class="spanTit">实付价格：</span><span class="payMoney cost"></span></div>
</div>

<div class="writInfoBox">
	<ul>
		<li><span class="spanTit">姓名：</span><input id="linkName" type="text"/></li>
		<li><span class="spanTit">性别：</span><input type="text" id="sexIpnt" readonly="readonly"/><span style="float:right; margin-top:18px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span></li>
		<li><span class="spanTit">出生日期：</span><input type="text" id="birthIpnt" readonly="readonly"/><span style="float:right; margin-top:17px;"><img src="<%=basePath %>console/images/riliImg.png" style="width:15px;"/></span></li>
		<li><span class="spanTit">手机号：</span><input id="phoneNum" type="text"/></li>
		<li><span class="spanTit">旅客类型：</span><input type="hidden" id="m"/><input type="text" id="personIpnt" readonly="readonly"/><span style="float:right; margin-top:18px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span></li>
		<li><span class="spanTit" id="caseIpnt">证件类型</span><span><img src="<%=basePath %>console/images/xialaPonting.png" style="padding-top:4px;"/></span><input id="IDcase" type="text" placeholder="请输入证件号码"/></li>
	</ul>
</div>

<div class="baoxianBox">
	<div class="oneClassBX"><a class="checkboxA"></a><a class="checkboxB"></a><input type="checkbox" class="checkBoxId flindYw" value="购买"/><span class="spanTitBX">航空意外险</span></div>
	<div class="oneClassBX" style="margin-left:20px;"><a class="checkboxA"></a><a class="checkboxB"></a><input type="checkbox" class="checkBoxId delayBx" value="购买"/><span class="spanTitBX">延误取消险</span></div>
	<div class="oneClassBX youhuiBox" style="margin-left:20px; display:none;"><a class="checkboxA"></a><a class="checkboxB"></a><input type="checkbox" class="checkBoxId youhuiBx" value="500"/><span class="spanTitBX youhuiText"></span></div>
	<div style="clear:both;"><span id="zhekouType" style="display:none;"></span></div>
</div>
<a class="aBtn">下 一 步</a>

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

<!--确认订单-->
<div id="trueOrderInfo">
	<div class="flidNoNumBox">
		<div class="chufDivBox">
			<div class="placeCity" style="text-align:right;"><span id="ChufCity"></span></div>
			<div class="planeNameInfo" style="text-align:right;">
				<span id="fildNumfly" style="margin-left:5px; display:block; float:right;"></span>
				<span id="QishiPlan" style="width:60px; height:25px; display:block; float:right; overflow:hidden;"></span>
				<span style="clear:both"></span>
				<span id="turmonp" style="display:none;"></span>
			</div>
			<div class="aboutTime" style="float:right; margin-right:0px; text-align:right;"><span style="text-align:right;" id="ChufDate"></span><span id="ChufTime" style="margin-left:5px;"></span></div>
		</div>
		<div class="wanfDivBox">
			<img src="<%=basePath %>console/images/wanfan.png"/>
			<span id="CountTime"></span>
		</div>
		<div class="daodDivBox">
			<div class="placeCity" style="text-align:left;"><span id="DaodCity"></span></div>
			<div class="planeNameInfo" id="DaodPlan"></div>
			<div class="aboutTime"><span id="ChufDateTwo"></span><span id="DaodTime" style="margin-left:5px;"></span></div>		
		</div>
		<div style="clear:both;"></div>
	</div>
	<div class="InfoMesBox">
		<div class="InfoUserMess">
			<ul>
				<li class="InfoLiClass"><span>价格：</span><span id="CostPay" class="payCostMoney"></span></li>
				<li class="InfoLiClass"><span>姓名：</span><span id="LinkName" class="InfoValueClass"></span></li>
				<li class="InfoLiClass"><span>性别：</span><span id="Sex" class="InfoValueClass"></span></li>
				<li class="InfoLiClass"><span id="iDcaseType">证件</span><span>：</span><span id="iDcase" class="InfoValueClass"></span></li>
				<li class="InfoLiClass lastLiClass"><span>手机：</span><span id="PhoneNum" class="InfoValueClass"></span></li>
				<li class="InfoLiClass BXliClass"><span>购买意外险：</span><span id="YiwaiBX" class="InfoValueClass"></span></li>
				<li class="InfoLiClass"><span>购买延误险：</span><span id="YanwuBX" class="InfoValueClass"></span></li>
			</ul>
		</div>
	</div>
	<div class="truePayBtn" style="width:90%; margin-left:auto; margin-right:auto; margin-top:30px;"><span style="display:block; padding:10px; background-color:#007AFF; color:#FFFFFF; font-size:15px; text-align:center; line-height:20px; border-radius:5px;">确认付款</span></div>
</div>
<!-- 提交订单的时候加载等待的效果 -->
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
<script src="<%=basePath %>scripts/common/weui/js/weui.min.js"></script>
</body>
</html>
