<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%	
	String username=(String) session.getAttribute("userName");
	//String jin = (String) session.getAttribute("invId");
	String uuid = request.getParameter("uuid");
	String canbin = request.getParameter("canbin");
	String dateTime = request.getParameter("dateTime");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>填写信息_订票</title>
<link rel="stylesheet" href="<%=basePath %>console/css/waritInforma.css?time=201161"/>
<link rel="stylesheet" href="<%=basePath %>console/css/normalize3.0.2.min.css" />
<link rel="stylesheet" href="<%=basePath%>console/css/weui.min.css" />
<link rel="stylesheet" href="<%=basePath%>console/css/jquery-weui.css" />
<link rel="stylesheet" href="<%=basePath %>console/css/style.css?time=2016" />
<link rel="stylesheet" href="<%=basePath%>scripts/common/weui/css/weui.css" />
<link rel="stylesheet" href="<%=basePath %>console/css/mobiscroll.css"/>
<link rel="stylesheet" href="<%=basePath %>console/css/mobiscroll_date.css"/>
<link rel="stylesheet" type="text/css"  href="<%=basePath%>console/css/loading.css"/>
<script type="text/javascript" src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/waritInforma.js?tt=5202sd121ssq3122111"></script>
<script src="<%=basePath %>console/js/mobiscroll_date.js"></script> 
<script src="<%=basePath %>console/js/mobiscroll.js"></script> 
<script src="<%=basePath %>console/js/jquery-weui.js"></script>
<script src="<%=basePath %>scripts/common/weui/js/zepto.min.js"></script>
<script src="<%=basePath %>console/js/airCodeVScity.js?time=11"></script>
<style>
	body{-webkit-text-size-adjust:none;}
	.ChoosClassBox{width:80.5%; height:0px; overflow:hidden; border:1px solid #e1e1e1; position:absolute; top:400px; left:20px; background-color:#FFFFFF; padding:5px 10px; display:none; z-index:1;}
	.ChoosClassBox .ChoosSmallBox{padding:5px; border-bottom:1px solid #e1e1e1;}
	.checkboxA{ border:#C9C9C9 1px solid; background-color:#fff; width:16px; height:16px; display:block; z-index:-1; float:left; border-radius:8px; margin-top:7px;}
	.checkboxB{ background-color:#0079FE; border-radius:4px; width:8px; height:8px; display:block; float:left; margin-left:-11.544px; margin-top:10.599999px; display:none;}
	#costXq li{overflow:hidden;}
	#costXq li div{float:right;}
	#ulText li{overflow: hidden;}
</style>
</head>

<body>
<script>
var fals=true;//防止重复提交
var uuid = "<%=uuid%>";
var canbin = "<%=canbin%>";
var dateTime = "<%=dateTime%>";
var orgcs = "";
var dstcs = "";
var costvar = 0;
var pn_tr = "";
$(function(){
	//获取选中的航班
	$.ajax({
		url: "<%=basePath %>wechatController/find/byuuid.action",
		type: "POST",
		data: {
				"uuid":uuid,
				"canbin":canbin
		},
		dataType: "json",
		success: function(result) {
			console.log(result);
			var vardate = result.dataObj;
			var bxcodate = result.bxCost;
			var kdcodate = result.kdCost;
			//为信息框赋值
			$(".chufTime").text(changeType(vardate[0].depTime));
			$(".arrDTime").text(changeType(vardate[0].arriTime));
			$(".shiPlace").text(findByplaneName(vardate[0].orgcity));
			orgcs = vardate[0].orgcity;
			dstcs = vardate[0].dstcity;
			costvar = parseInt(result.cost);
			$(".flidNum").text(vardate[0].airline);
			$(".zhongPlace").text(findByplaneName(vardate[0].dstcity));
			$(".countTime").text(cuntTime(vardate[0].depTime,vardate[0].deptimemodify,vardate[0].arriTime,vardate[0].arriveTimeModify));
			$("#moneyPay").text(parseInt(result.cost));
			$("#cost").text(parseInt(result.cost)+parseInt(50)); 
			$(".cangweiType").text(result.canbin);
			$(".chufCityID").text(findByCity(vardate[0].orgcity));
			$(".daodCityID").text(findByCity(vardate[0].dstcity));
			$(".chufDate").text(vardate[0].depDate);
			$(".arrDate").text(getArriDate(vardate[0].depDate,vardate[0].arriveTimeModify));
			for(var i=0; i<bxcodate.length; i++){
				if(bxcodate[i].bxType==1||bxcodate[i].bxType=="1"){
					$("#ywaicoid").text(bxcodate[i].cost);
				}else if(bxcodate[i].bxType==2||bxcodate[i].bxType=="2"){
					$("#ywcostid").text(bxcodate[i].cost);
				}
			}
			$("#kdcostid").text(kdcodate[0].kdcost);
			
			//确认信息框
			$("#ChufCity").text(findByCity(vardate[0].orgcity));
			$("#QishiPlan").text(findByplaneName(vardate[0].orgcity));
			$("#fildNumfly").text(vardate[0].airline);
			$("#ChufDate").text(dateTime);
			$("#ChufTime").text(changeType(vardate[0].depTime));
			
			$("#DaodCity").text(findByCity(vardate[0].dstcity));
			$("#DaodPlan").text(findByplaneName(vardate[0].dstcity));
			$("#ChufDateTwo").text(getArriDate(dateTime,vardate[0].arriveTimeModify));
			$("#DaodTime").text(changeType(vardate[0].arriTime));
			
			$("#CountTime").text(cuntTime(vardate[0].depTime,vardate[0].deptimemodify,vardate[0].arriTime,vardate[0].arriveTimeModify));
		},
		error: function() {

		}
	});
	
	//判断是否登录
	var username="<%=username%>";
	<%-- var jin = "<%=jin%>" --%>
	if(username==""||username=="null"||username==null){
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
						//console.log(result);
						if(result.msg==1){	
							/* ivid = (result.userInfo)[0].inCodeId;
							getcode(ivid); */
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
						//alert("登录失败");
					}
			});
	});
		
		//下一步的点击事件
		$(".aBtn").click(function(){
			var age = ""; //年龄
			var lvkeType = ""; //旅客类型
			var sexType = ""; //性别
			var birthdayNum = ""; //生日
			var deppDate = $(".chufDate").text(); //出发日期
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
					age = ageFunc(birthdayNum,$(".chufDate").text()); 
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
				age = ageFunc(birthdayNum,$(".chufDate").text()); 
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
			if($(".baoxiao").is(':checked')){
				var sanddren = $("#sendAdd").val().trim();
				if(sanddren==""||sanddren==null){
					$.alert("请填写配送地址！");
					return false;
				}
			}
			
			//意外险的值
			if($(".flindYw").is(':checked')){
				$("#YiwaiBX").text("已购买"); 
				$("#yiwaiNum").text("1");
			}else{
				$("#YiwaiBX").text("未购买");
				$("#yiwaiNum").text("0");
			}
			//延误险值
			if($(".delayBx").is(':checked')){
				$("#YanwuBX").text("已购买");
				$("#yanwuNum").text("1");
			}else{
				$("#YanwuBX").text("未购买");
				$("#yanwuNum").text("0");
			}
			//报销单
			if($(".baoxiao").is(':checked')){
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
			var jsondatastr = '{"depDate":"'+deppDate+'","uuid":"'+uuid+'","cangwei":"'+canbin+'","telkInfo":[{"LinkName":"'+LinkName+'","Sex":"'+sexType+'","iDcaseType":"'+iDcaseType+'","iDcase":"'+iDcase+'","PhoneNum":"'+PhoneNum+'","YiwaiBX":"'+YiwaiBX+'","YanwuBX":"'+YanwuBX+'","bxiaoOr":"'+bxiaoOr+'","sendAddren":"'+sendAddren+'","birthDay":"'+birthdayNum+'","age":"'+age+'","menType":"'+lvkeType+'"}]}';
			/* var jsondata = JSON.parse(jsondatastr);
			console.log(jsondata);
			return false; */
			$("#CostPay").text($(".payMoney").text());
			$("#LinkName").text(LinkName);
			$("#Sex").text(sexType=="F"?"先生":"女士");
			$("#iDcase").text(iDcase);
			$("#PhoneNum").text(PhoneNum);
			
			if(fals==true){
				fals=false;
				$.ajax({
					url:"<%=basePath%>userOrderController/add/order.action",
					type:"POST",
					data:{"jsStr":jsondatastr},
					dataType:"json",
					beforeSend:function(){$("#loading").css("display","block");},
					complete:function(){$("#loading").css("display","none");},
					success:function(result){
						//console.log(result);
						var resDate = result.resAlert;
						var tr = '<tr><td>'+findByCity(resDate.orgCity)+'</td><td><img src="<%=basePath%>console/images/resJt.png" style="width:25px;"/></td><td>'+findByCity(resDate.depCity)+'</td><td style="width:120px; text-align:right;">'+isOkResult(resDate.isOk)+'</td></tr>';
						$("#resBoxTables").append(tr);
						if(resDate.isOk==0||resDate.isOk=="0"){
							$("#commitRes").text(resDate.commit);
						}else{
							pn_tr = resDate.pntr;
							$("#commitRes").text("");
							$(document).attr("title","机票预定_确认信息");
							$("#trueOrderInfo").css("display","block");
							$("html").css("height","100%");
							$("html").css("overflow","hidden");
							$("body").css("height","100%");
							$("body").css("overflow","hidden");
						}
						$("#ydresuletBox").css("display","block");
					},
					error:function(result){
					}
				});			
			}else{
				$.alert("不能重复提交订单");
			}

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
		
		//判断输入的身份证是否正确
		$("#IDcase").change(function(){
			//用户选择输入身份证的时候才会校验  选择护照或者其他 不会校验
			if($("#caseIpntSource").text()=="NI"){
				if(codeSf()){ //当身份证输入正确的时候还得判断旅客的类型
					//获取年龄
					var idInfo = $("#IDcase").val();
					var birth = idInfo.substring(6,14);
					var birthdayNumXX = birth.substring(0,4)+"-"+birth.substring(4,6)+"-"+birth.substring(6,8);
					var ageXX = ageFunc(birthdayNumXX,$(".chufDate").text()); 
					
					var airline = $(".flidNum").text();
					var canbin = "Y";
					var cp = 0;
					//获乘机人类型
					if(ageXX<2){
						findbb(airline,canbin,orgcs,dstcs,dateTime,"IN");
					}else if(ageXX>=2&&ageXX<=12){
						findbb(airline,canbin,orgcs,dstcs,dateTime,"CH");
					}else{
						$("#crTelkBox").remove();
						$("#airBullte").remove();
						var liList = '<li id="crTelkBox"><div style="margin-left:15px;">x1</div><div style="width:80px;">￥<span id="moneyPay" class="kl">'+costvar+'</span>/人</div><div id="pstTypeName" style="width:100px; margin-right:50px;">成人票</div></li>';
						$("#sign").after(liList);
						var jjMonty = '<li id="airBullte"><div style="margin-left:15px;">x1</div><div style="width:80px;">￥<span id="airportPay" class="kl">50</span>/人</div><div style="width:100px; margin-right:50px;">机建费</div></li>';
						$("#crTelkBox").after(jjMonty);
						for(var i = 0;i<$(".kl").length;i++){
							cp+= parseInt($(".kl:eq("+i+")").text());
						}
						$("#cost").text(cp);
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
			if($(".flindYw").attr("checked")=="checked")yiwai = 1;
			if($(".delayBx").attr("checked")=="checked")yanwu = 1;
			var infojson = '{"sign":"0","yawai":"'+yiwai+'","yanwu":"'+yanwu+'","pn_tr":"'+pn_tr+'","uuid":"'+uuid+'"}';
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
	                			}else{
	                				$("#sexBox").css("display","block");
	                				$("#birthdayBox").css("display","block");
	                			}
	            			}  
	        	});  
    	});
		
		
		$("#quxiaoBtn").click(function(){
			$(".moveBox").css("display","none");
		});
		
		var heightscr = window.screen.height;
		if(heightscr<700){
			$(".moveBox").css("min-height",700);
		}else{
			$(".moveBox").css("min-height",heightscr);
		}
		
});

//获取邀请码
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

function isOkResult(isOk){
	return (isOk=="1"?"锁定成功":"锁定失败");
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

function findbb(airline,canbin,org,dst,dateTime,pstType){
	$("#loadMoney").css("display","block");
	$.post("<%=basePath%>wechatController/find/findBybb.action",{"airline":airline,"canbin":canbin,"org":org,"dst":dst,"dateTime":dateTime,"pstType":pstType},function(result){
		$("#loadMoney").css("display","none");
		var obj = JSON.parse(result);
	    //console.log(obj);
	    //<li id="crTelkBox"><div style="margin-left:15px;">x1</div><div style="width:80px;">￥<span id="moneyPay" class="kl">30</span>/人</div><div style="width:100px; margin-right:50px;">成人票</div></li>
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
			cp+= parseInt($(".kl:eq("+i+")").text());
		}
		$("#cost").text(cp);
	});
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
	
//计算历经多长时间到达
function cuntTime(depTime,isDept,arrTime,isArrt){
	var sTime = changesTime(depTime,isDept); //出发时间的秒
	var oTime = changesTime(arrTime,isArrt); //到达时间的秒
	var chaTime = oTime-sTime; //两个时间相差的秒
	var liTime = parseInt(chaTime/3600)+"h"+parseInt((chaTime%3600)/60)+"m";
	return liTime;
}
	
	function closeBox(){
		$("#ydresuletBox").css("display","none");
	}
	
	//改变出发时间和到达时间的类型
	function changeType(GoTime){	
		if(4<GoTime.length){
			var firstTime=GoTime.substring(0,2);
			var conterTime=GoTime.substring(2,4);
			var lastTime=GoTime.substring(4,GoTime.length);
			return firstTime+":"+conterTime+"<span style='color:#ff0000; font-size:10px;'>+"+lastTime+"</span>";
		}else{			
			var firstTime=GoTime.substring(0,2);
			var lastTime=GoTime.substring(2,GoTime.length);
			return firstTime+":"+lastTime;
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
	
	function addLink(){
		$(".moveBox").css("display","block");
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
</script>
<div class="massInfoBox">
	<ul>
		<li><span class="spanTit">出发时间：</span><span class="spanCont chufDate"></span><span class="chufTime" style="margin-left:5px;"></span></li>
		<li><span class="spanTit">到达时间：</span><span class="spanCont arrDate"></span><span class="arrDTime" style="margin-left:5px;"></span></li>
		<li><span class="spanTit">出发城市：</span><span class="spanCont chufCityID"></span></li>
		<li><span class="spanTit">到达城市：</span><span class="spanCont daodCityID"></span></li>
		<li><span class="spanTit">起始机场：</span><span class="spanCont shiPlace"></span><span class="flidNum" style="margin-left:5px;"></span></li>
		<li><span class="spanTit">到达机场：</span><span class="spanCont zhongPlace"></span></li>
		<li><span class="spanTit">飞行历时：</span><span class="spanCont countTime"></span><span class="cangweiType" style="display:none;"></span><!-- <span class="zhekou" style="display:none;"></span> --></li>
	</ul>
	<div class="trueCost"><span class="spanTit">实付价格：</span><span class="payMoney">￥<span id="cost"></span></span></div> 
	<ul id="costXq" style="list-style-type:none; text-align:right; font-size:12px; color:#888;">
		<li id="sign"></li>
		<li id="crTelkBox"><div style="margin-left:15px;">x1</div><div style="width:80px;">￥<span id="moneyPay" class="kl">30</span>/人</div><div id="pstTypeName" style="width:100px; margin-right:50px;">成人票</div></li>
		<li id="airBullte"><div style="margin-left:15px;">x1</div><div style="width:80px;">￥<span id="airportPay" class="kl">50</span>/人</div><div style="width:100px; margin-right:50px;">机建费</div></li>
	</ul>
</div>

<div class="writInfoBox">
	<div style="text-align:right; margin-top:10px;"><a style="font-size:13px; color:blue;" onclick="addLink()" >+选择常用联系人</a></div>
	<ul>
		<li><span class="spanTit">姓名：</span><input id="linkName" type="text"/></li>
		<li id="sexBox" style="display:none;"><span class="spanTit">性别：</span><input type="text" id="sexIpnt" readonly="readonly" value="先生"/><span id="sexIpntSource" style="display:none;">F</span><span style="float:right; margin-top:18px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span></li>
		<li id="birthdayBox" style="display:none;"><span class="spanTit">出生日期：</span><input type="text" id="birthIpnt" readonly="readonly"/><span style="float:right; margin-top:17px;"><img src="<%=basePath %>console/images/riliImg.png" style="width:15px;"/></span></li>
		<li><span class="spanTit">手机号：</span><input id="phoneNum" type="text"/></li>
		<%-- <li><span class="spanTit">旅客类型：</span><input type="hidden" id="m"/><input type="text" id="personIpnt" readonly="readonly"/><span id="personIpntSource" style="display:none;"></span><span style="float:right; margin-top:18px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span></li> --%>
		<li><span class="spanTit" id="caseIpnt">身份证</span><span id="caseIpntSource" style="display:none;">NI</span><span><img src="<%=basePath %>console/images/xialaPonting.png" style="padding-top:4px;"/></span><input id="IDcase" type="text" placeholder="请输入证件号码"/></li>
		<li id="sendAddBox" style="display:none;"><span class="spanTit">配送地址：</span><input id="sendAdd" type="text"/></li>
	</ul>
</div>

<div class="baoxianBox">
	<div class="oneClassBX"><a class="checkboxA"></a><a class="checkboxB"></a><input type="checkbox" class="checkBoxId flindYw" value="1"/><span class="spanTitBX">航意险</span></div>
	<div class="oneClassBX" style="margin-left:20px;"><a class="checkboxA"></a><a class="checkboxB"></a><input type="checkbox" class="checkBoxId delayBx" value="1"/><span class="spanTitBX">延误险</span></div>
	<!-- <div class="oneClassBX youhuiBox" style="margin-left:20px; display:none;"><a class="checkboxA"></a><a class="checkboxB"></a><input type="checkbox" class="checkBoxId youhuiBx" value="500"/><span class="spanTitBX youhuiText"></span></div> -->
	<div class="oneClassBX" style="margin-left:20px;"><a class="checkboxA"></a><a class="checkboxB"></a><input type="checkbox" class="checkBoxId baoxiao" value="1"/><span class="spanTitBX">报销单</span><span id="baoxiaoNum" style="display:none;"></span></div>
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
			<div class="placeCity" style="text-align:right;"><span id="ChufCity">广州</span></div>
			<div class="planeNameInfo" style="text-align:right;">
				<span id="fildNumfly" style="margin-left:5px; display:block; float:right;">CZ2051</span>
				<span id="QishiPlan" style="width:60px; height:25px; display:block; float:right; overflow:hidden;">广州新白云机场</span>
				<span style="clear:both"></span>
			</div>
			<div class="aboutTime" style="float:right; margin-right:0px; text-align:right;"><span style="text-align:right;" id="ChufDate">2017-05-27</span><span id="ChufTime" style="margin-left:5px;">08:25</span></div>
		</div>
		<div class="wanfDivBox">
			<img src="<%=basePath %>console/images/wanfan.png"/>
			<span id="CountTime" style="font-size:11px;">5h23m</span>
		</div>
		<div class="daodDivBox">
			<div class="placeCity" style="text-align:left;"><span id="DaodCity">北京</span></div>
			<div class="planeNameInfo" id="DaodPlan">北京首都机场</div>
			<div class="aboutTime"><span id="ChufDateTwo">2017-05-27</span><span id="DaodTime" style="margin-left:5px;">12:36</span></div>		
		</div>
		<div style="clear:both;"></div>
	</div>
	<div class="InfoMesBox">
		<div style="display:none;"><span id="ywcostid"></span><span id="ywaicoid"></span><span id="kdcostid"></span></div>
		<div class="InfoUserMess">
			<ul>
				<li class="InfoLiClass"><span>价格：</span><span id="CostPay" class="payCostMoney"></span></li>
				<li class="InfoLiClass"><span>姓名：</span><span id="LinkName" class="InfoValueClass"></span></li>
				<li class="InfoLiClass"><span>性别：</span><span id="Sex" class="InfoValueClass"></span></li>
				<li class="InfoLiClass"><span id="iDcaseType">证件</span><span>：</span><span id="iDcase" class="InfoValueClass"></span></li>
				<li class="InfoLiClass lastLiClass"><span>手机：</span><span id="PhoneNum" class="InfoValueClass"></span></li>
				<li class="InfoLiClass BXliClass"><span>航意险：</span><span id="YiwaiBX" class="InfoValueClass"></span><span id="yiwaiNum" style="display:none;"></span></li>
				<li class="InfoLiClass"><span>延误险：</span><span id="YanwuBX" class="InfoValueClass"></span><span id="yanwuNum" style="display:none;"></span></li>
				<li class="InfoLiClass"><span>报销单：</span><span id="baoxOr" class="InfoValueClass"></span><span id="baoxOrNum" style="display:none;"></span></li>
			</ul>
		</div>
	</div>
	<div class="truePayBtn" style="width:90%; margin-left:auto; margin-right:auto; margin-top:30px;"><span style="display:block; padding:10px; background-color:#007AFF; color:#FFFFFF; font-size:15px; text-align:center; line-height:20px; border-radius:5px;">确认付款</span></div>
</div>
<div id="ydresuletBox" style="position:absolute; width:100%; height:100%; background:rgba(51,51,51,0.7); top:0px; left:0px; z-index:99; display:none;">
	<div style="margin:60% auto; width:300px; border-radius:5px; background:#fff;">
		<div style="text-align:center; color:#666; font-size:18px; line-height:45px;">座位锁定结果</div>
		<table id="resBoxTables" border="0" style="margin-left:20px; width:85%; height:55px;"></table>
		<div id="commitRes" style="color:#ff0000; text-align:center;">系统出错，请稍后再试！</div>
		<div style="border-top:1px #e1e1e1 solid; margin-top:10px; overflow: hidden;"> 
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
<!-- 提交订单的时候加载等待的效果 -->
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
