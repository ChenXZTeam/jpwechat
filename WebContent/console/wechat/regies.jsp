<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
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
<link rel="stylesheet" href="<%=basePath%>console/css/weui.min.css" />
<link rel="stylesheet" href="<%=basePath%>console/css/jquery-weui.css" />
<script src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script src="<%=basePath %>console/js/jquery-weui.js"></script>
<script src="<%=basePath %>console/js/md5.js"></script>
<style>
	*{padding:0px; margin:0px;}
	body{text-align:center; font:normal 100% Helvetica, Arial, sans-serif; background-color:#F9F9F9; font-family:Microsoft JhengHei;}
	#bigContent{padding:0px;}
	.divInput{width:90%; margin-left:auto; margin-right:auto; background-color:#FFFFFF;}
	.divInput input{width:95%; height:40px; border:none; border-bottom:#E8E8E8 solid 1px; outline:none; font-size:14px;}
	.divInput>#userPhone{width:60%; float:left; margin-left:3%;}
	.divInput>a{width:25%; float:right; background-color:#007AFF; margin-top:5px; padding:5px 5px; margin-right:2%; border-radius:5px; font-size:14px; color:#FFFFFF;}
	.buttonRegist{width:90%; margin-left:auto; margin-right:auto; margin-top:30px;}
	.buttonRegist a{background-color:#007AFF; padding:10px 10px; display:block; color:#FFFFFF; font-size:20px; border-radius:8px; border:1px solid #007AFF;}
	.RegistXY{width:85%; margin-left:auto; margin-right:auto; margin-top:20px; overflow:hidden;}
	.RegistXY span{color:#C8C8C8; float:left;}
	.RegistXY a{color:#1584FE; float:left;}
</style>
</head>

<body onload="qingkong()">
	<div id="bigContent">
		<div class="divInput" style="margin-top:40px;">
			<input type="text" id="userName" placeholder="请输入用户名"/>
		</div>
		<div class="divInput">
			<input type="text" id="userPhone" placeholder="请输入手机号"/>
			<a>获取验证码</a>
			<div style="clear:both;"></div>
		</div>		
		<div class="divInput" style="border:none;">
			<input type="text" id="PhoneCode" placeholder="手机验证码"/>
		</div>
		<div class="divInput">
			<input type="password" id="passWord" placeholder="请输入6~16位密码"/>
		</div>
		<div class="divInput">
			<input type="password" id="passWordAg" placeholder="请再次输入密码"/>
		</div>
		<div class="divInput" style="border:none;">
			<input type="text" id="Aoqing" placeholder="邀请码"/>
		</div>
		<span id="spanMsg" style="color:#ff0000; font-size:15px; margin-top:5px;"></span>
		<div class="buttonRegist">
			<a>注 册</a>		
		</div>
		<div class="RegistXY">
			<span>注册即表示同意</span><a>《永弘网络服务协议》</a>		
		</div>
		<div style="clear:both;"></div>
	</div>
	
	<script>		
		var code = ""; //保存验证码
		$(function(){
			//验证码倒计时
			var wait = 60;
			function time(o){		
				if(wait == 0){
					o.css("background-color","#007AFF");
					o.css("color","#ffffff");
					o.css("border","none");
					o.text("");
					o.text("获取验证码");
					wait = 60;
				}else{
					o.text("");
					o.text("重发" + wait + "s");
					wait--;
					setTimeout(function(){time(o)}, 1000)
				}
			}
			
			//获取验证码按钮事件
			$(".divInput>a").click(function(){
				//首先判断手机号码是否存在
				$.ajax({
					url:"<%=basePath%>/wechatController/register/userNameIsExist.action",
					type:"POST",
					data:{"userName":$("#userPhone").val()},
					dataType:"json",
					success:function(res){
						if(res.msg==1){
							$("#spanMsg").text("");
							if(chexPhone()&&wait==60){	//发短信时检查手机号码格式	
								$.ajax({
									url:"<%=basePath%>/wechatController/register/message.action",
									type:"POST",
									data:{"phoneNum":$("#userPhone").val()},
									dataType:"json",
									success:function(res,textStatus){
										if (textStatus == "success") {		
											time($(".divInput>a"));
											$(".divInput>a").css("background-color","#dddddd");
											$(".divInput>a").css("color","#666666");
											$(".divInput>a").css("border","#cccccc solid 1px");					
											$.alert("发送成功","消息提醒");
											//能否获取到后台传回来的code
											code = res;
										} 
									},error:function(){								
									}
								});
							}
						}else if(res.msg==0){
							$("#spanMsg").text("");
							$("#spanMsg").text("手机号码已存在"); 
							return false;
						}
					},error:function(){
					}
				});
			});	
			
			/**change事件， 对输入的验证码进行比对*/		
			$("#PhoneCode").change(function(){
				checkCode();
			});
			
			//检查手机号码格式
			function chexPhone(){
				var phone=/^(13[0-9]|14[0-9]|15[0-9]|18[0-9])\d{8}$/;
				if(!phone.test($("#userPhone").val())){
					$.alert("请输入正确的手机号码","填写错误");
					$("#iPhone").focus();
					return false;
				}else{
					return true;
				}
			}
			
			//验证用户名是否被注册
			$("#userName").change(function(){
				$.ajax({
					url:"<%=basePath%>/wechatController/register/userNameIsExist.action",
					type:"POST",
					data:{"userName":$("#userName").val()},
					dataType:"json",
					success:function(res){
						if(res.msg==1){
							$("#spanMsg").text("");
						}else if(res.msg==0){
							$("#spanMsg").text("");
							$("#spanMsg").text("用户名已存在");
							return false;
						}
					},error:function(){
					}
				});
			});
			
			//注册按钮事件
			$(".buttonRegist a").click(function(){
				/*判断步骤：先判断用户名是否被注册，然后再判断手机格式是否正确，再然后就是检查手机是否被注册
				 *再然后就是各种条件了
				 */
				var fale=true;	//防止重复提交注册信息
				var userName=$("#userName").val();
				var userPhone=$("#userPhone").val();
				var password=$("#passWord").val();
				var passwordAgr=$("#passWordAg").val();
				var aoqing=$("#Aoqing").val();
				
				//用户名是否被注册
				$.ajax({
					url:"<%=basePath%>/wechatController/register/userNameIsExist.action",
					type:"POST",
					data:{"userName":$("#userName").val()},
					dataType:"json",
					success:function(res){
						if(res.msg==1){
							$("#spanMsg").text("");
							//验证手机号码是否正确
							var phone=/^(13[0-9]|14[0-9]|15[0-9]|18[0-9])\d{8}$/;
							if(!phone.test($("#userPhone").val())){
								$.alert("请输入正确的手机号码","填写错误");
								$("#userPhone").focus();
								fale=false;
								return false;
							}
							
							//手机号码是否被注册
							$.ajax({
								url:"<%=basePath%>/wechatController/register/userNameIsExist.action",
								type:"POST",
								data:{"userName":$("#userPhone").val()},
								dataType:"json",
								success:function(res){
									if(res.msg==1){
										$("#spanMsg").text("");
										//判断信息是否填写完成
										if(userName==""||userPhone==""||password==""||passwordAgr==""||aoqing==""){
											$.alert("信息填写未完成","填写错误");
											fale=false;
											return false;
										}
										
										//验证验证码是否正确
										if(checkCode() == false){
											fale=false;
											return false;
										}	
									
										//判断密码是否输入一样
										if(password!=passwordAgr){
											$.alert("密码不一致","填写错误");
											fale=false;
											return false;
										}
									
										//提交信息注册
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
													if(result.msg==1){
														$.alert("注册成功","消息提醒");
														window.location.href="<%=basePath%>console/wechat/logo.jsp";
													}else{
														$.alert("注册错误","消息提醒");
													}							
												},
												error: function() {
													$.alert("注册失败","消息提醒");
												}
											});
										}
										
									}else if(res.msg==0){
										$("#spanMsg").text("");
										$("#spanMsg").text("手机号码已存在");
										fale=false;
										return false;
									}
								},error:function(){
								}
							});				
							
						}else if(res.msg==0){
							$("#spanMsg").text("");
							$("#spanMsg").text("用户名已存在");
							fale=false;
							return false;
						}
					},error:function(){
					}
				});
			});
		});
		
		//检查验证码是否正确的方法		
		function checkCode(){
			var message = $("#PhoneCode").val();
			/*对输入的验证码进行md5加密*/
			if(message.length == 4){ 
				var md5_code = hex_md5(message);
				if(code != md5_code){
					$.alert("请输入正确的验证码","填写错误");
					return false;
				}
				
			}else{
				$.alert("请输入正确的验证码","填写错误");
				return false;
			}					    
		}
		
		//检查用户名或者手机是否被注册
<%-- 		function isEixst(num){
			var userDate='';
			//var IsCanGo = false;
			if(num==1){
				userDate=$("#userName").val();
			}else if(num==0){
				userDate=$("#userPhone").val();
			}			
			$.ajax({
					url:"<%=basePath%>/wechatController/register/userNameIsExist.action",
					type:"POST",
					data:{"userName":userDate},
					dataType:"json",
					success:function(res){
						if(res.msg==1){
							$("#spanMsg").text("");
							fale=true;
						}else if(res.msg==0){
							$("#spanMsg").text("");
							$("#spanMsg").text("用户名/手机号码已存在，可以进行登录");
							fale=false;
							return false;
						}
					},error:function(){
					}
			});
		} --%>
		
		// 加载界面的时候清空原有的数据
		function qingkong(){
			$(".divInput>input").val("");
		}
	</script>
</body>
</html>
