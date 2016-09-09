<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.maximum-scale=1,user-scalable=no"/>
<title>申请签证</title>
<link rel="stylesheet" href="<%=basePath %>console/css/qz_waritInfo.css"/>
<script type="text/javascript" src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<style>
	.chooseBox{position:absolute; top:0px; left:0px; padding:0px; margin:0px;width:88.55%; display:none;}
	.chooseBox ul{list-style-type:none; padding:0px 10px; background-color:#FFF; margin:0px; border:1px solid #e1e1e1;}
	.chooseBox ul li{border-bottom:1px solid #e1e1e1; line-height:35px;}
	.chooseBox ul li:last-child{ border:none;}
	#qztrueBtn{display:block; width:88.55%; margin:10px auto 0 auto; background-color:#007AFF; font-size:13px; padding:10px 0; text-align:center; color:#FFFFFF; border-radius:5px;}
</style>
</head>
<body>
<div class="writInfoBox">
	<ul>
		<li><span class="spanTit">姓名：</span><input id="linkName" type="text"/></li>
		<li><span class="spanTit">客户类型：</span><input type="text" id="personWorkIpnt" readonly="readonly"/><span style="float:right; margin-top:12px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span></li>
		<li><span class="spanTit">性别：</span><input type="text" id="sexIpnt" readonly="readonly"/><span style="float:right; margin-top:12px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span></li>
		<li><span class="spanTit">手机号：</span><input id="phoneNum" type="text"/></li>
		<li><span class="spanTit">电子邮件：</span><input id="EmailAdd" type="text"/></li>
		<li><span class="spanTit">旅客类型：</span><input type="text" id="trayTypeIpnt" readonly="readonly"/><span style="float:right; margin-top:12px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span></li>
		<li><span class="spanTit">身份证：</span><input id="IDcase" type="text" placeholder="请输入证件号码"/></li>
		<li><span class="spanTit" id="songTypeIpnt">配送方式</span><span><img src="<%=basePath %>console/images/xialaPonting.png" style="padding-top:6px;"/></span><input id="sondAdd" type="text" placeholder="请输入配送地址"/></li>	
	</ul>
</div>
<div class="chooseBox sexBox">
	<ul>
		<li class="choValSex">男</li>
		<li class="choValSex">女</li>
	</ul>
</div>

<div class="chooseBox trayTypeBox">
	<ul>
		<li class="choValTray">成人</li>
		<li class="choValTray">儿童</li>
	</ul>
</div>

<div class="chooseBox userTypeBox">
	<ul>
		<li class="choValUser">在职</li>
		<li class="choValUser">自由职业</li>
		<li class="choValUser">退休</li>
		<li class="choValUser">在校学生</li>
		<li class="choValUser">学龄儿童</li>
	</ul>
</div>

<div class="chooseBox sonTypeBox">
	<ul>
		<li class="choValSon">送货上门</li>
	</ul>
</div>

<a id="qztrueBtn">提交申请</a>

<script>
	$(function(){
		//性别选择
		$("#sexIpnt").click(function(){
			var top = $(this).offset().top;
			var left = $(this).offset().left;
			$(".sexBox").css("top",top+25);
			$(".sexBox").css("left",left-50);
			$(".sexBox").css("display","block");
		});
		$(".choValSex").click(function(){
			$("#sexIpnt").val($(this).text());
			$(".sexBox").css("display","none");
		});
		
		//旅客类型选择
		$("#trayTypeIpnt").click(function(){
			var top = $(this).offset().top;
			var left = $(this).offset().left;
			$(".trayTypeBox").css("top",top+25);
			$(".trayTypeBox").css("left",left-70);
			$(".trayTypeBox").css("display","block");
		});
		$(".choValTray").click(function(){
			$("#trayTypeIpnt").val($(this).text());
			$(".trayTypeBox").css("display","none");
		});
		
		//客户类型选择
		$("#personWorkIpnt").click(function(){
			var top = $(this).offset().top;
			var left = $(this).offset().left;
			$(".userTypeBox").css("top",top+25);
			$(".userTypeBox").css("left",left-70);
			$(".userTypeBox").css("display","block");
		});
		$(".choValUser").click(function(){
			$("#personWorkIpnt").val($(this).text());
			$(".userTypeBox").css("display","none");
		});
		
		//配送方式
		$("#songTypeIpnt").click(function(){
			var top = $(this).offset().top;
			var left = $(this).offset().left;
			$(".sonTypeBox").css("top",top+25);
			$(".sonTypeBox").css("left",left);
			$(".sonTypeBox").css("display","block");
		});
		$(".choValSon").click(function(){
			$("#songTypeIpnt").text($(this).text());
			$(".sonTypeBox").css("display","none");
		});
		
		$("#qztrueBtn").click(function(){
			var linkName = $("#linkName").val();//申请人
			var personWorkIpnt = $("#personWorkIpnt").val();//客户类型
			var sexIpnt = $("#sexIpnt").val();//性别
			var phoneNum = $("#phoneNum").val();//手机号码
			var EmailAdd = $("#EmailAdd").val();//电子邮件
			var trayTypeIpnt = $("#trayTypeIpnt").val();//旅客类型
			var IDcase = $("#IDcase").val()//身份证号
			var songTypeIpnt = $("#songTypeIpnt").text();//配送方式
			var sondAdd = $("#sondAdd").val();//配送地址
			var dataList = {
				"linkName":linkName,
				"personWorkIpnt":personWorkIpnt,
				"sexIpnt":sexIpnt,
				"phoneNum":phoneNum,
				"EmailAdd":EmailAdd,
				"trayTypeIpnt":trayTypeIpnt,
				"IDcase":IDcase,
				"songTypeIpnt":songTypeIpnt,
				"sondAdd":sondAdd
			}
			$.ajax({
				url:"<%=basePath%>framework/visa/addVisaOrder.action",
				type:"post",
				data:dataList,
				dataType:"json",
				success:function(res){
					alert("成功"+res.msg);
				},
				error:function(res){
				}
			});
		});
	});
</script>
</body>
</html>