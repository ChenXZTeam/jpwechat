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
<title>注册</title>
<script src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<style>
	*{padding:0px; margin:0px;}
	body{text-align:center; font:normal 100% Helvetica, Arial, sans-serif; background-color:#F9F9F9; font-family:Microsoft JhengHei;}
	#bigContent{padding:0px;}
	.divInput{width:90%; margin-left:auto; margin-right:auto; background-color:#FFFFFF;}
	.divInput input{width:95%; height:50px; border:none; border-bottom:#E8E8E8 solid 1px; outline:none; font-size:14px;}
	.buttonRegist{width:90%; margin-left:auto; margin-right:auto; margin-top:30px;}
	.buttonRegist a{background-color:#007AFF; padding:10px 10px; display:block; color:#FFFFFF; font-size:20px; border-radius:8px; border:1px solid #007AFF;}
	.RegistXY{width:85%; margin-left:auto; margin-right:auto; margin-top:20px; overflow:hidden;}
	.RegistXY span{color:#C8C8C8; float:left;}
	.RegistXY a{color:#1584FE; float:left;}
</style>
</head>

<body>
	<div id="bigContent">
		<div class="divInput" style="margin-top:40px;">
			<input type="text" id="userName" placeholder="请输入用户名"/>
		</div>
		<div class="divInput">
			<input type="text" id="userPhone" placeholder="请输入手机号"/>
		</div>
		<div class="divInput">
			<input type="password" id="passWord" placeholder="请输入1~16位密码"/>
		</div>
		<div class="divInput">
			<input type="password" id="passWordAg" placeholder="请再次输入密码"/>
		</div>
		<div class="divInput" style="border:none;">
			<input type="text" id="Aoqing" placeholder="邀请码"/>
		</div>
		<div class="buttonRegist">
			<a>注 册</a>		
		</div>
		<div class="RegistXY">
			<span>注册即表示同意</span><a>《永弘网络服务协议》</a>		
		</div>
		<div style="clear:both;"></div>
	</div>
	
	<script>
		$(function(){
			var fale=true;	//防止重复提交注册信息
			//注册按钮事件
			$(".buttonRegist a").click(function(){
				var userName=$("#userName").val();
				var userPhone=$("#userPhone").val();
				var password=$("#passWord").val();
				var passwordAgr=$("#passWordAg").val();
				var aoqing=$("#Aoqing").val();
			
				//验证手机号码是否正确
				var phone=/^(13[0-9]|14[0-9]|15[0-9]|18[0-9])\d{8}$/;
				if(!phone.test($("#userPhone").val())){
					alert("请输入正确的手机号码");
					$("#userPhone").focus();
					fale=false;
					return false;
				}
			
				//判断信息是否填写完成
				if(password==""||passwordAgr==""||aoqing==""){
					alert("信息填写未完成");
					fale=false;
					return false;
				}
			
				//判断密码是否输入一样
				if(password!=passwordAgr){
					alert("密码不一致");
					fale=false;
					return false;
				}				
			
				if(fale==true){
					//上面的条件正确时候改变按钮格式
					$(this).css("background-color","#dddddd");
					$(this).css("color","#666666");
					$(this).css("border","#cccccc solid 1px");
					$(this).html("");
					$(this).html("加载中...");
					
					$.ajax({
						url: "<%=basePath %>/wechatController/register/add.action",
						type: "POST",
						data: {
							"userName":userName, "password":password, "userPhone":userPhone,"aoqing":aoqing
						},
						dataType: "json",
						success: function(result) {
							alert("注册成功");
						},
						error: function() {
							alert("注册失败");
						}
					});
				}
			});
		});
		
	</script>
</body>
</html>
