<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>发送邀请码</title>
<link rel="stylesheet" href="<%=basePath %>console/css/lc_switch.css" />
<script src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script src="<%=basePath %>console/js/lc_switch.min.js"></script>
<style>
	*{padding:0px;margin:0px;}
	body{text-align:center; font:normal 100% Helvetica, Arial, sans-serif; background-color:#F9F9F9;}
	#bigContent{padding:0px;}
	.yqPhone{width:90%; margin-left:auto; margin-right:auto; margin-top:30px;}
	.yqPhone input{width:100%; border:none; height:40px; font-size:14px; padding-left:10px; outline:none;}
	.yqMessgase{width:90%; margin-left:auto; margin-right:auto; margin-top:15px;}
	.yqMessgase textarea{width:100%; overflow:scroll-y; height:80px; border:none; outline:none; font-size:14px; padding-left:10px; padding-top:10px; resize:none;}
	.chexDiv{width:90%; margin-left:auto; margin-right:auto; margin-top:20px; overflow:hidden;}
	.btnDiv{width:90%; margin-left:auto; margin-right:auto; margin-top:30px;}
	.btnDiv a{background-color:#007AFF; padding:10px 10px; display:block; color:#FFFFFF; font-size:20px;  font-family:Microsoft JhengHei; border-radius:8px; border:1px solid #007AFF;}
</style>
</head>

<body>
	<div id="bigContent">
		<div class="yqPhone">
			<input type="text" name="" id="userPhone" placeholder="请输入被邀请者的手机号码"/>
		</div>
		<div class="yqMessgase">
			<textarea  placeholder="请输入被邀请者的短信留言"></textarea>
		</div>
		<div class="chexDiv">
			<div style="float:left;">
				<input type="checkbox" name="check-1" class="lcs_check" autocomplete="off" />
			</div>
			<div style="float:left; margin-left:15px;"><a onClick="chex()" style="line-height:29px; display:block;">我已经阅读邀请协议</a></div>
		</div>
		<div class="btnDiv">
			<a>提 交</a>
		</div>
	</div>
	
<script>
	$(function(){
		$('input').lc_switch();
	});
	
	//单选按钮事件
	function chex(){
		if($(".lcs_check").is(":checked")){
			return true;
		}else{
			alert("请选择邀请协议");
			return false;
		}
	}
	
	//提交按钮事件
	$(".btnDiv a").click(function(){
		var phone=/^(13[0-9]|14[0-9]|15[0-9]|18[0-9])\d{8}$/;
		if(!phone.test($("#userPhone").val())){
			alert("请输入正确的手机号码");
			$("#userPhone").focus();
			return false;
		}
		
		//判断邀请协议是否被选中
		if(!chex()){
			return false;
		}
			
		$(this).css("background-color","#dddddd");
		$(this).css("color","#666666");
		$(this).css("border","#cccccc solid 1px");
		$(this).html("");
		$(this).html("加载中...");
	});
</script>
</body>
</html>
