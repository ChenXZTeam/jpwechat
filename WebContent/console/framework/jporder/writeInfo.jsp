<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%	
	String chufTime=new String(request.getParameter("chufTime").getBytes("ISO-8859-1"),"utf-8");
	String arrDTime=new String(request.getParameter("arrDTime").getBytes("ISO-8859-1"),"utf-8");
	String shiPlace=new String(request.getParameter("shiPlace").getBytes("ISO-8859-1"),"utf-8");
	String zhongPlace=new String(request.getParameter("zhongPlace").getBytes("ISO-8859-1"),"utf-8");
	String cost=new String(request.getParameter("cost").getBytes("ISO-8859-1"),"utf-8");
	String zhekou=new String(request.getParameter("zhekou").getBytes("ISO-8859-1"),"utf-8");
	String cangweiType=new String(request.getParameter("cangweiType").getBytes("ISO-8859-1"),"utf-8");
	String chufCityID=new String(request.getParameter("chufCityID").getBytes("ISO-8859-1"),"utf-8");
	String daodCityID=new String(request.getParameter("daodCityID").getBytes("ISO-8859-1"),"utf-8");
	String chufDate = request.getParameter("chufDate");
	String chufCode=new String(request.getParameter("chufCode").getBytes("ISO-8859-1"),"utf-8");
	String daodCode=new String(request.getParameter("daodCode").getBytes("ISO-8859-1"),"utf-8");
	System.out.println(chufTime+"/"+arrDTime+"/"+shiPlace+"/"+zhongPlace+"/"+cost+"/"+zhekou+"/"+cangweiType+"/"+chufCityID+"/"+daodCityID+"/"+chufDate);
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>填写信息</title>
	<script src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>console/js/waritInforma.js"></script>
	<style>
		body{ font-size:14px; color:#333;}
		.massInfoBox{text-align:left;}
		.massInfoBox ul{list-style-type:none; padding:0px; margin:0px; color:#333;}
		.massInfoBox ul li{padding:5px;}
		.massInfoBox .trueCost{text-align:right; margin-right:50px; font-size:14px;}
		.massInfoBox .trueCost .payMoney{color:#ff0000; font-weight:bold; font-size:20px; font-family:'微软雅黑';}
		
		.writInfoBox{}
		.writInfoBox ul{list-style-type:none; margin:0px; padding:0px;} 
		.writInfoBox ul li{padding:5px 0px; overflow:hidden;}
		.writInfoBox ul li .spanTit{}
		.writInfoBox ul li input{float:left; border:1px solid #e1e1e1; height:25px; width:346px; padding-left:10px;}
		.writInfoBox ul li span{display:block; float:left; width:85px; line-height:30px;} 
		.writInfoBox ul li img{width:15px;}
		.ChoosClassBox{width:80.5%; height:0px; overflow:hidden; border:1px solid #e1e1e1; position:absolute; top:400px; left:20px; background-color:#FFFFFF; padding:5px 10px; display:none; z-index:1;}
		.ChoosClassBox .ChoosSmallBox{padding:5px; border-bottom:1px solid #e1e1e1;}
		.baoxianBox{margin-top:15px;}
		.baoxianBox .oneClassBX{float:left;}
		.aBtn{margin-top:15px; cursor:pointer; display:block; padding:10px 0px; background-color:#007AFF; border-radius:5px; color:#FBFDFF; font-size:12px; text-align:center; width:100px; margin-left:0px;}
		
		#trueOrderInfo{position:absolute; display:none; font-family:"微软雅黑"; top:10%; left:35%; width:30%; border:1px solid #e1e1e1; padding:15px 15px 30px 15px; border-radius:5px; background-color:#fff;}
		.InfoMesBox .InfoUserMess ul{list-style-type:none;}
		.InfoMesBox .InfoUserMess ul li{height:25px; line-height:25px;}
		#trueOrderInfo .flidNoNumBox .chufDivBox{width:40%; float:left; height:100%;}
		#trueOrderInfo .flidNoNumBox .wanfDivBox{width:25%; float:left; height:100%; padding-top:8px;}
		#trueOrderInfo .flidNoNumBox .wanfDivBox img,.wanfDivBox span{}
		#trueOrderInfo .flidNoNumBox .wanfDivBox img{display:block; margin:auto; text-align:center; width:25px;}
		#trueOrderInfo .flidNoNumBox .wanfDivBox span{display:block; margin:auto; text-align:center; color:#8E8E8E; margin-top:11px;}
		#trueOrderInfo .flidNoNumBox .daodDivBox{width:32%; float:left; height:100%;}
		#trueOrderInfo .flidNoNumBox .placeCity{font-size:25px; color:#007BFD; line-height:40px;}
		#trueOrderInfo .flidNoNumBox .planeNameInfo{color:#666666; font-size:12px; line-height:20px; overflow:hidden; height:18px;}
		#trueOrderInfo .flidNoNumBox .aboutTime{width:125px; color:#8E8E8E; line-height:20px; font-size:10px; -webkit-transform-origin-x:0;}

	</style>
</head>
<body>
<!-- 信息反馈 -->
<div class="massInfoBox">
	<ul>
		<li><span class="spanTit">出发时间：</span><span class="spanCont chufDate"></span><span class="chufTime" style="margin-left:5px;"></span></li>
		<li><span class="spanTit">到达时间：</span><span class="spanCont chufDate"></span><span class="arrDTime" style="margin-left:5px;"></span></li>
		<li><span class="spanTit">出发城市：</span><span class="spanCont chufCityID"></span></li>
		<li><span class="spanTit">到达城市：</span><span class="spanCont daodCityID"></span></li>
		<li><span class="spanTit">起始机场：</span><span class="spanCont shiPlace"></span><span class="flidNum" style="margin-left:5px;"></span></li>
		<li><span class="spanTit">到达机场：</span><span class="spanCont zhongPlace"></span></li>
		<li><span class="spanTit">飞行历时：</span><span class="spanCont countTime"></span><span class="cangweiType" style="display:none;"></span><span class="zhekou" style="display:none;"></span></li>
	</ul>
	<div class="trueCost"><span class="spanTit">实付价格：</span><span class="payMoney cost"></span></div>
</div>
<!-- 填写乘机人信息 -->
<div class="writInfoBox">
	<ul>
		<li><span class="spanTit">姓名：</span><input id="linkName" type="text"/><span style="clear:both;"></span></li>
		<li><span class="spanTit">性别：</span><input type="text" id="sexIpnt" readonly="readonly" style="cursor:pointer;"/><span style="margin-top:7px; margin-left:-20px; cursor:pointer;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span><span style="clear:both;"></span></li>
		<li><span class="spanTit">出生日期：</span><input type="text" id="birthIpnt" style="cursor:pointer;"/><span style="float:left; margin-top:7px; margin-left:-20px;"><img src="<%=basePath %>console/images/riliImg.png" style="width:15px;"/></span><span style="clear:both;"></span></li>
		<li><span class="spanTit">手机号：</span><input id="phoneNum" type="text"/><span style="clear:both;"></span></li>
		<li><span class="spanTit">旅客类型：</span><input type="text" id="personIpnt" readonly="readonly" style="cursor:pointer;"/><span style="margin-top:7px; margin-left:-20px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span><span style="clear:both;"></span></li>
		<li><span class="spanTit" id="caseIpnt" style="width:68px; cursor:pointer;">证件类型</span><span style="width:15px; padding-top:4px;"><img src="<%=basePath %>console/images/xialaPonting.png" style="padding-top:4px;"/></span><input id="IDcase" type="text" placeholder="请输入证件号码"/><span style="clear:both;"></span></li>
	</ul>
</div>
<div class="baoxianBox">
	<div class="oneClassBX"><a class="checkboxA"></a><a class="checkboxB"></a><input type="checkbox" class="checkBoxId flindYw" value="购买"/><span class="spanTitBX">航空意外险</span></div>
	<div class="oneClassBX" style="margin-left:20px;"><a class="checkboxA"></a><a class="checkboxB"></a><input type="checkbox" class="checkBoxId delayBx" value="购买"/><span class="spanTitBX">延误取消险</span></div>
	<div style="clear:both;"></div>
</div>

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
<a class="aBtn">提交订单</a>

<!--确认订单-->
<div id="trueOrderInfo">
	<div class="flidNoNumBox">
		<div class="chufDivBox">
			<div class="placeCity" style="text-align:right;"><span id="ChufCity">北京</span></div>
			<div class="planeNameInfo" style="text-align:right;">
				<span id="fildNumfly" style="margin-left:5px; display:block; float:right;">CZ3166</span>
				<span id="QishiPlan" style="height:25px; display:block; float:right; overflow:hidden;">广州新白云国际机场</span>
				<span style="clear:both"></span>
			</div>
			<div class="aboutTime" style="float:right; margin-right:0px; text-align:right;"><span style="text-align:right;" id="ChufDate">2016-10-30</span><span id="ChufTime" style="margin-left:5px;">06:30</span></div>
		</div>
		<div class="wanfDivBox">
			<img src="<%=basePath %>console/images/wanfan.png"/>
			<span id="CountTime">3时20分</span>
		</div>
		<div class="daodDivBox">
			<div class="placeCity" style="text-align:left;"><span id="DaodCity">广州</span></div>
			<div class="planeNameInfo" id="DaodPlan">北京首都国际机场</div>
			<div class="aboutTime"><span id="ChufDateTwo">2016-10-30</span><span id="DaodTime" style="margin-left:5px;">09:50</span></div>		
		</div>
		<div style="clear:both;"></div>
	</div>
	<div class="InfoMesBox">
		<div class="InfoUserMess">
			<ul>
				<li class="InfoLiClass"><span>价格：</span><span id="CostPay" class="payCostMoney">1910.00</span></li>
				<li class="InfoLiClass"><span>姓名：</span><span id="LinkName" class="InfoValueClass">李霞</span></li>
				<li class="InfoLiClass"><span>性别：</span><span id="Sex" class="InfoValueClass">女</span></li>
				<li class="InfoLiClass"><span id="iDcaseType">身份证</span><span>：</span><span id="iDcase" class="InfoValueClass">460003199305034638</span></li>
				<li class="InfoLiClass lastLiClass"><span>手机：</span><span id="PhoneNum" class="InfoValueClass">15799024022</span></li>
				<li class="InfoLiClass BXliClass"><span>购买意外险：</span><span id="YiwaiBX" class="InfoValueClass">无</span></li>
				<li class="InfoLiClass"><span>购买延误险：</span><span id="YanwuBX" class="InfoValueClass">无</span></li>
			</ul>
		</div>
	</div>
	<div class="truePayBtn" style="width:90%; margin-left:auto; margin-right:auto;"><span style="display:block; padding:10px; background-color:#007AFF; color:#FFFFFF; font-size:15px; text-align:center; line-height:20px; border-radius:5px;">确认付款</span></div>
</div>
<script>
	window.history.forward(1); //禁止后退
	var fals=true;//防止重复提交
	//获取上个界面传过来的值
	var chufTime = "<%=chufTime%>"; //出发时间
	var arrDTime = "<%=arrDTime%>"; //到达时间
	var shiPlace = "<%=shiPlace%>";	//起始机场和航班（集合）
	var chufPlane = shiPlace.split(" "); //拆分shiPlace
	shiPlace = chufPlane[0]; //起始机场
	var flidNum = chufPlane[1];//航班
	var zhongPlace = "<%=zhongPlace%>"; //终止机场和历时（集合）
	var mudiPlane = zhongPlace.split(" ");//拆分zhongPlace
	zhongPlace = mudiPlane[0];//终止机场
	var countTime = mudiPlane[1];//历时多长时间
	var cost = "<%=cost%>"; //价格
	var zhekou = "<%=zhekou%>"; //折扣
	var cangweiType = "<%=cangweiType%>"; //舱位类型
	var chufCityID = "<%=chufCityID%>"; //出发城市
	var daodCityID = "<%=daodCityID%>"; //目的城市
	var chufDate = "<%=chufDate%>"; //出发日期
	//为信息框赋值
	console.log(chufTime+","+arrDTime+","+shiPlace+","+flidNum+","+zhongPlace+","+countTime+","+cost+","+zhekou+","+cangweiType+","+chufCityID+","+daodCityID+","+chufDate); 
	$(".chufTime").text(chufTime);
	$(".arrDTime").text(arrDTime);
	$(".shiPlace").text(shiPlace);
	$(".flidNum").text(flidNum);
	$(".zhongPlace").text(zhongPlace);
	$(".countTime").text(countTime);
	$(".cost").text("￥"+cost);
	$(".zhekou").text(zhekou);
	$(".cangweiType").text(cangweiType);
	$(".chufCityID").text(chufCityID);
	$(".daodCityID").text(daodCityID);
	$(".chufDate").text(chufDate);
	
	//提交订单的点击事件
	$(function(){
		$(".aBtn").click(function(){
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
			
			if($("#linkName").val()==""||$("#sexIpnt").val()==""||$("#caseIpnt").text()==""||$("#personIpnt").val()==""||$("#IDcase").val()==""||$("#phoneNum").val()==""){
				alert("信息填写未完成");
				return false;
			}
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
			nextPat(); //创建订单表		
			/* $(document).attr("title","机票预定_确认信息");
			$("#trueOrderInfo").css("display","block"); */
		});
		
		//检查手机格式是否正确
		$("#phoneNum").change(function(){
			var phone=/^(13[0-9]|14[0-9]|15[0-9]|18[0-9])\d{8}$/;
			if(!phone.test($("#phoneNum").val())){
				alert("请输入正确的手机号码");
				$("#phoneNum").focus();
				return false;
			}
		});
		
		//判断是否选择了证件类型
		$("#IDcase").focus(function(){
			if($("#caseIpnt").text()=="证件类型"){
				alert("请选择证件类型");
				$("#IDcase").blur();
				return false;
			}
		});
		
		//付款的方法
		$(".truePayBtn").click(function(){
			alert("开发中...");
		});
	});
		
//创建订单的方法
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
				"age":age,
				"daodCode":"<%=daodCode%>",
				"chufCode":"<%=chufCode%>"
			};
			if(fals==true){
				$.ajax({
					url:"<%=basePath%>userOrderController/add/order.action",
					type:"POST",
					data:date,
					dataType:"json",
					beforeSend:function(){$(".loadingBox").css("display","block");},
					complete:function(){$(".loadingBox").css("display","none");},
					success:function(result){
						alert(result.planMsg);
						fals=false;
						window.location.href="<%=basePath%>console/framework/jporder/index.jsp";
					},
					error:function(result){
					}
				});			
			}
}

//根据出生日期自动求出年龄
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
</script>
</body>
</html>