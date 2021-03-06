<%@page import="com.solar.tech.bean.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";

%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登 录</title>
<style>
body {background-color:#EC4D0C;margin:0;scroll:no}
form {background: url("images/framework/login1.jpg") no-repeat scroll left top #ffffff;height:600px;left:320px;position:relative;width:900px;}
#msg{height:23px;left:500px;position:absolute;top:292px;width:189px;color:red;}
#<%=User.USERNAME%> {height:23px;left:500px;position:absolute;top:345px;width:189px;}
#<%=User.PASSWORD%> {height:23px;left:500px;position:absolute;top:395px;width:189px;}
#submit {left: 615px;position: absolute;top: 440px;}
</style>
<script src="scripts/common/jquery-1.8.3.min.js"></script>
<script>
$(document).ready(function(){
	$("#submit").click(function(){
		$.ajax({
			url:"<%=basePath  %>login.action", 
			type:"post",
			data:{<%=User.USERNAME%>:$("#<%=User.USERNAME%>").val(), <%=User.PASSWORD%>:$("#<%=User.PASSWORD%>").val()},
			dataType:"json",
			success:function(data){
			 // alert(data.msg);
			  // alert(data.url);
				if(data.msg)$("#msg").html(data.msg);
				if((data.chrdlogin)=="1"||(data.chrdlogin)==1){
					alert("您的账号正在登录，如不是本人登录请修改密码!");
				}
				if(data.url)window.location.href=data.url;
			},
			error:function(rq, status, e){
				console.error(e);
			}
		});
	});
})
</script>
</head>
<body>
<form>
	<span id="msg"></span>
	<input type="text" id="<%=User.USERNAME%>"/>
	<input type="password" id="<%=User.PASSWORD%>"/>
	<input type="image" src="images/framework/login_btn.gif" id="submit" onclick="return false;" value=""/>
</form>
</body>
</html>