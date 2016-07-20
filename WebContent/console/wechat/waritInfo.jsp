<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%	
	//session.invalidate();
	String username=(String) session.getAttribute("userName");
	String chufTime=new String(request.getParameter("chufTime").getBytes("ISO-8859-1"),"utf-8");
	String arrDTime=new String(request.getParameter("arrDTime").getBytes("ISO-8859-1"),"utf-8");
	String shiPlace=new String(request.getParameter("shiPlace").getBytes("ISO-8859-1"),"utf-8");
	String zhongPlace=new String(request.getParameter("zhongPlace").getBytes("ISO-8859-1"),"utf-8");
	String cost=new String(request.getParameter("cost").getBytes("ISO-8859-1"),"utf-8");
	String TekNum=new String(request.getParameter("TekNum").getBytes("ISO-8859-1"),"utf-8");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>填写信息_订票</title>
<script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
</head>
<body>
<script>
$(function(){
	var username="<%=username%>";
	if(username==""||username=="null"){
		alert("登录才能订票");
		$("#loginPage").css("display","block");
	}else{
		<%-- window.location.href="<%=basePath%>console/wechat/logo.jsp"; --%>
		alert("我已经登录了"+username);
	}
});

</script>
来到这一步就需要你填写信息进行订票，并且判断是否登录

传递过来的值有：<br/>
出发时间：<%=chufTime %><br/>
到达时间：<%=arrDTime %><br/>
起始航班：<%=shiPlace %><br/>
到达航班：<%=zhongPlace %><br/>
价钱：<%=cost %><br/>
剩余的票数：<%=TekNum %><br/>

<div id="loginPage" style="width:100%; height:100%; background-color:rgba(0,0,0,0.5); position:absolute; top:0px; left:0px; z-index:999; display:none;">
	<div id="loginDiv" style="width:80%; height:130px; position:absolute; background-color:rgb(255,255,255);  top:10%; left:10%;">
		<div style="font-family:Arial, Helvetica, sans-serif; font-size:12px; color:#666666; border-bottom:1px solid #E4E4E4; padding:6px 5px;"><span>登录名</span><input type="text" id="userN" style="margin-left:20px; border:none; outline:none;" placeholder="用户名/手机号"/></div>
		<div style="font-family:Arial, Helvetica, sans-serif; font-size:12px; color:#666666; border-bottom:1px solid #E4E4E4; padding:6px 5px;"><span>密　码</span><input type="text" id="passW" style="margin-left:20px; border:none; outline:none;" placeholder="请输入1~16位密码"/></div>
		<div id="buttom"><button style="width:90%; margin-left:5%; margin-top:15px; background-color:#FF9913; color:#ffffff; font-size:16px; border:none; padding:10px; font-weight:bold;">登　录</button></div>
	</div>
</div>
</body>
<script>
	$(function(){
		$("button").click(function(){
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
							//上面的条件正确时候改变按钮格式
							$("button").css("background-color","#dddddd");
							$("button").css("color","#666666");
							$("button").css("border","#cccccc solid 1px");
							$("button").html("");
							$("button").html("加载中...");
							alert("登录成功，可以订票咯^_^");
							$("#loginPage").css("display","none");
						}else{
							alert("登录失败");
							$("#loginPage").css("display","block");
						}							
					},
					error: function() {
						alert("登录失败");
					}
			});
		});
	});
</script>
</html>