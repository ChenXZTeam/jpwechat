<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>登录</title>
<link rel="stylesheet" href="<%=basePath %>console/css/lc_switch.css">
<script src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script src="<%=basePath %>console/js/lc_switch.min.js"></script>
<style type="text/css">
	*{padding:0px;margin:0px;}
	body{text-align:center; font:normal 100% Helvetica, Arial, sans-serif; background-color:#F9F9F9; font-family:Microsoft JhengHei;}
	#bigContent{}
	.backImg{width:100%;}
	.backImg img{width:100%;}
	.padAndMar{height:30px;}
	.userPass{width:90%; margin-left:auto; margin-right:auto;}
	.userPass .inputStyle{width:100%; height:45px; margin:0px; border:none; padding:3px 10px 3px 20px; outline:none; background-color;#ffffff; border-bottom:#E8E8E8 solid 1px; font-size:14px;}
	.readChexc{width:90%; margin-left:auto; margin-right:auto; margin-top:20px; overflow:hidden;}
	.logoBtn{width:90%; margin-left:auto; margin-right:auto; margin-top:20px;}
	.logoBtn a{background-color:#007AFF; padding:10px 10px; display:block; color:#FFFFFF; font-size:20px; border-radius:8px; border:1px solid #007AFF;  font-family:Microsoft JhengHei;}
	.forgetPass{width:87%; margin-left:auto; margin-right:auto; margin-top:20px; overflow:hidden;}
	.forgetPass a{color:#676767; display:block;}
</style>
</head>

<body>

	<div id="bigContent">
		<div class="backImg"><img src="<%=basePath %>console/images/feiji.gif"></div>
		<div class="padAndMar"></div>
		<div class="userPass">
			<div>
				<input type="text" class="inputStyle" id="iPhone" name="username" placeholder="使用用户名/手机号进行登录"/>
			</div>
			<div>
				<input type="password" class="inputStyle" id="password" style="border:none;" name="padss" placeholder="请输入1~16位密码"/>
			</div>
		</div>
		<div class="readChexc">
			<div style="float:left;">
				<input type="checkbox" name="check-1" class="lcs_check" autocomplete="off" />
			</div>
			<div style="float:left; margin-left:15px;"><a onClick="chex()" style="line-height:29px; display:block;">我已经阅读用户协议</a></div>
		</div>
		<div style="clear:both;"></div>
		<div class="logoBtn">
			<a>登 陆</a>
		</div>
		<div class="forgetPass"><a href="<%=basePath %>console/wechat/regies.jsp" style="float:left;">注册用户名</a> <a style="float:right;">忘记密码?</a></div>
		<div style="clear:both;"></div>
	</div>
		
<script>
//这个是单选按钮的样式加载
$(function(){
	$('input').lc_switch();
});

//单选按钮事件
function chex(){
	if($(".lcs_check").is(":checked")){
		return true;
	}else{		
		alert("请选择用户协议");
		return false;
	}
}

//检查手机号码格式
/* function chexPhone(){
	var phone=/^(13[0-9]|14[0-9]|15[0-9]|18[0-9])\d{8}$/;
	if(!phone.test($("#iPhone").val())){
		alert("请输入正确的手机号码");
		$("#iPhone").focus();
		return false;
	}else{
		return true;
	}
} */

//登录按钮事件
$(".logoBtn a").click(function(){
	var fale=true; //防止用户重复登录
	var iPhone=$("#iPhone").val();
	var pass=$("#password").val();
	if(iPhone==""||pass==""){
		alert("账号或密码不能为空");
		fale=false;
		return false;
	}else{
		fale=true;
	}
	
	//判断手机格式
/* 	if(!chexPhone()){
		return false;
		fale=false;
	}else{
		fale=true;
	} */
	
	//检测用户协议按钮是否打开
	if(!chex()){
		return false;
		fale=false;
	}else{
		fale=true;
	}
	
	if(fale==true){
		$.ajax({
				url: "<%=basePath %>wechatController/wechat/login.action",
				type: "POST",
				data: {
						"userName":iPhone, "PassWord":pass
				},
				dataType: "json",
				success: function(result) {
					if(result.msg==1){						
						//上面的条件正确时候改变按钮格式
						$(".logoBtn a").css("background-color","#dddddd");
						$(".logoBtn a").css("color","#666666");
						$(".logoBtn a").css("border","#cccccc solid 1px");
						$(".logoBtn a").html("");
						$(".logoBtn a").html("加载中...");
						alert("登录成功...没有界面");
						//if(result.url)window.location.href=result.url;//跳转到指定界面
					}else{
						alert("登录错误");
					}							
				},
				error: function() {
					alert("登录失败");
				}
		});
	}
});
</script>
</body>
</html>
