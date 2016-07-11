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
<title>验证手机号码</title>
<script src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<style>
	*{padding:0px; margin:0px;}
	body{text-align:center; font:normal 100% Helvetica, Arial, sans-serif; background-color:#F9F9F9; font-family:Microsoft JhengHei;}
	#bigContent{padding:0px;}
	.inputDiv{width:90%; margin-left:auto; margin-right:auto; background-color:#ffffff; border-bottom:#E7E7E7 solid 1px; overflow:hidden;}
	.inputDiv input{width:60%; height:40px; padding-left:15px; float:left; outline:none; font-size:14px; border:none;}
	.inputDiv a{background-color:#007AFF; margin-top:5px; padding:5px 5px; margin-left:3%; border-radius:5px; font-size:14px; float:left; color:#FFFFFF;}
	.buttonRegist{width:90%; margin-left:auto; margin-right:auto; margin-top:30px;}
	.buttonRegist a{background-color:#007AFF; padding:10px 10px; display:block; color:#FFFFFF; font-size:20px; border-radius:8px; border:1px solid #007AFF;}
	.RegistXY{width:85%; margin-left:auto; margin-right:auto; margin-top:20px; overflow:hidden;}
	.RegistXY span{font-size:14px; color:#C8C8C8; float:left;}
	.RegistXY a{font-size:14px; color:#1584FE; float:left;}
</style>
</head>

<body>
	<div id="bigContent">
		<div class="inputDiv" style="margin-top:40px;">
			<input type="text" id="userPhone" placeholder="请输入手机号"/>
			<a>获取验证码</a>
		</div>
		<div class="inputDiv">
			<input type="text" id="code" placeholder="请输入验证码"/>
		</div>
		<div class="buttonRegist">
			<a>提 交</a>		
		</div>
		<div class="RegistXY">
			<span>点击提交即表示同意</span><a>《永弘网络服务协议》</a>		
		</div>
		<div style="clear:both;"></div>
	</div>
	
	<script>
		//验证码倒计时
		var wait = 100;
		function time(o){		
			if(wait == 0){
				o.css("background-color","#007AFF");
				o.css("color","#ffffff");
				o.css("border","none");
				o.text("");
				o.text("获取验证码");
				wait = 100;
			}else{
				o.text("");
				o.text("正在倒数" + wait + "s");
				wait--;
				setTimeout(function(){time(o)}, 10)
			}
		}
		
		//获取验证码按钮事件
		$(".inputDiv a").click(function(){
			//发短信时检查手机号码格式
			if(checkPhone()){
				time($(this));
				$(this).css("background-color","#dddddd");
				$(this).css("color","#666666");
				$(this).css("border","#cccccc solid 1px");
			}
		});		
	
		//提交按钮事件
		$(".buttonRegist a").click(function(){
			var usPhone=$("#userPhone").val();
			var code=$("#code").val();
			if(usPhone==""||code==""){
				alert("信息未填写完成");
				return false;
			}
			//提交时检查手机号码格式
			if(!checkPhone()){
				return false;
			}
			//checkPhone();
			$(this).css("background-color","#dddddd");
			$(this).css("color","#666666");
			$(this).css("border","#cccccc solid 1px");
			$(this).html("");
			$(this).html("加载中...");
		});
		
		//检查手机格式是否正确
		function checkPhone(){
			var phone=/^(13[0-9]|14[0-9]|15[0-9]|18[0-9])\d{8}$/;
			if(!phone.test($("#userPhone").val())){
				alert("请输入正确的手机号码");
				$("#userPhone").focus();
				return false;
			}else{
				return true;
			}
		}
	</script>
</body>
</html>
