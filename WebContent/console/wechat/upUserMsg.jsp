<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%
	String orderNum=new String(request.getParameter("orderNum").getBytes("ISO-8859-1"),"utf-8");
	String pnrNo=new String(request.getParameter("pnrNo").getBytes("ISO-8859-1"),"utf-8");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>修改乘机人资料</title>
<script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
</head>
<body>
预约编号：<input type="text" id="orderNum" value="<%=orderNum%>"/><br/>
中航信ID：<input type="text" id="pnrNo" value="<%=pnrNo%>"/><br/>
乘机人姓名：<input type="text" id="username"/><br/>
乘机人年龄：<input type="text" id="userage"/><br/>
乘机人性别：<input type="text" id="usergender"/><br/>
乘机人生日：<input type="text" id="userBirth"/><br/>
乘机人旅客类型：<input type="radio" id="usertype" name="usertype" value="ADT" checked="checked"/>成人<input type="radio" id="usertype" name="usertype" value="CHD"/>儿童 <input type="radio" id="usertype" name="usertype" value="INF"/>婴儿<br/>
乘机人证件号码：<input type="text" id="userIDnum"/><br/>
乘机人证件类型：<input type="radio" id="userIDtype" name="userIDtype" value="NI" checked="checked"/>身份证<input type="radio" id="userIDtype" name="userIDtype" value="PP"/>护照 <input type="radio" id="userIDtype" name="userIDtype" value="ID"/>其他证件<br/>
<button>确认修改</button>
</body>
<script>
	$(function(){		
		//加载数据在表单中
		var orderNum = "<%=orderNum%>";
		if(orderNum!=null||orderNum!="null"||orderNum!=""){
			$.ajax({
				url:"<%=basePath%>userOrderController/loading/userMsg.action",
				type:"POST",
				data:{"orderNum":orderNum},
				dataType:"json",
				success: function(result) {
					var dataList = (result.orderList)[0];
					$("#username").val(dataList.linkName);
					$("#userage").val(dataList.age);
					$("#usergender").val(dataList.linkSex);
					$("#userBirth").val(dataList.birthday);
					if(dataList.stutisPay==1){					
						$("input[type=radio][name='usertype'][value="+dataList.psgType+"]").attr("checked",'checked');
						$("input[type=radio][name='usertype']").attr("disabled",'disabled');
					}
					$("#userIDnum").val(dataList.idcase);
					$("input[type=radio][name='userIDtype'][value="+dataList.idcaseType+"]").attr("checked",'checked');
				},error:function(){
					
				}
			});			
		}
		
		//修改资料的执行的方法
		$("button").click(function(){
			var orderNum = $("#orderNum").val();
			var pnrNo = $("#pnrNo").val();
			var username = $("#username").val();
			var userage = $("#userage").val();
			var usergender = $("#usergender").val();
			var userBirth = $("#userBirth").val();
			var usertype = $("#usertype").val();
			var userIDnum = $("#userIDnum").val();
			var userIDtype = $("#userIDtype").val();
			$.ajax({ 
				url:"<%=basePath%>userOrderController/update/changeCertificate.action",
				type:"POST",
				data:{
					"orderNum":orderNum,
					"pnrNo":pnrNo,
					"username":username,
					"userage":userage,
					"usergender":usergender,
					"userBirth":userBirth,
					"usertype":usertype,
					"userIDnum":userIDnum,
					"userIDtype":userIDtype
				},
				dataType:"json",
				success: function(result) {
					if(result.msg==1){
						alert("修改成功");
					}else{
						alert("修改失败");
					}
					
				},error:function(){
				
				}
			});		
		});
	});
</script>
</html>