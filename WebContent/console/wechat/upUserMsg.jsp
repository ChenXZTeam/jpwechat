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
<link rel="stylesheet" type="text/css"  href="<%=basePath%>console/css/loading.css" />
<script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
<style>
	body{padding:0px; padding:0px;}
	#BigPanerTitle{}
	#BigPanerTitle span{ display:block; padding:10px 10px 5px 0px; border-bottom:#FF8204 solid 1px; width:95%; margin-left:auto; margin-right:auto; color:#FF8204; font-weight:bold; font-size:18px;}
	#BigPaner{ border-top:none; border-radius:0px 0px 5px 5px; padding:5px;}
	.inputClassStyle{ width:95%;  -webkit-tap-highlight-color:rgba(255,255,255,0); outline:none; display:block; height:30px; margin-top:10px; font-size:15px; color:#666666; border:#CCCCCC solid 1px; padding-left:10px; border-radius:5px;}
	.bigSelectDiv{ margin-top:10px;}
	.selectDivClassStyle{width:98px; height:30px; border:#CCCCCC solid 1px;}
	.selectDivClassStyle img{width:30px; float:right;}
	.selectClassStyle{padding-left:10px; background-color:transparent; border:solid 0px; -webkit-appearance:initial; width:80px; height:30px; position:relative; background:none; margin-top:-31px; border:none; outline:none; cursor:pointer; filter:alpha(opacity=1); -moz-opacity:1; opacity:1; color:#666666; font-size:15px;  -webkit-tap-highlight-color:rgba(255,255,255,0);}
	#buttonBtn{ margin-top:15px; overflow:hidden;}
	#buttonBtn a{ display:block; width:30%; float:left; margin-left:10px; padding:10px; background-color:#FF8204; color:#FFFFFF; font-family:"Times New Roman", Times, serif; text-align:center; font-size:18px; border:#FF8204 solid 1px; border-radius:5px;}
</style>
</head>
<body>
<input type="hidden" id="orderNum" value="<%=orderNum%>"/>
<input type="hidden" id="pnrNo" value="<%=pnrNo%>"/>
<!--  -->
	<div id="BigPanerTitle"><span>修改乘机人信息</span></div>
	<div id="BigPaner">
		<div>
			<input type="text" class="inputClassStyle" id="username" placeholder="乘机人姓名"/>
		</div>
		
		<div class="bigSelectDiv">		
			<div class="selectDivClassStyle"><img src="<%=basePath %>console/images/jiantou.png"/></div>
			<select class="selectClassStyle" id="sex">
				<option value="男">男</option>
				<option value="女">女</option>
			</select>
		</div>
		
		<div>
			<input type="text" class="inputClassStyle" id="userage" placeholder="乘机人年龄"/>
		</div>
		
		<div class="bigSelectDiv">		
			<div class="selectDivClassStyle"><img src="<%=basePath %>console/images/jiantou.png"/></div>
			<select class="selectClassStyle" id="usertype">
				<option value="ADT">成人</option>
				<option value="CHD">儿童</option>
				<option value="INF">婴儿</option>
			</select>
		</div>
		
		<div>
			<input type="text" class="inputClassStyle" id="userBirth" placeholder="乘机人生日"/>
		</div>
		
		<div class="bigSelectDiv">		
			<div class="selectDivClassStyle"><img src="<%=basePath %>console/images/jiantou.png"/></div>
			<select class="selectClassStyle" id="userIDtype">
				<option value="NI" class="option">身份证</option>
				<option value="PP" class="option">护照</option>
				<option value="ID" class="option">其他证件</option>
			</select>
		</div>
		
		<div><input type="text" class="inputClassStyle" id="userIDnum" placeholder="证件号码"/></div>
		
		<div id="buttonBtn"><a id="btnA">信息正确</a><a id="btnQ" style="float:right; margin-right:10px;">取消</a></div>
	</div>

<!-- 加载等待界面 -->	
	<div id="loading">
		<div id="loading-center">
			<div id="loading-center-absolute">
				<div class="object" id="object_four"></div>
				<div class="object" id="object_three"></div>
				<div class="object" id="object_two"></div>
				<div class="object" id="object_one"></div>
			</div>
			<div style="color:#ffffff; position:absolute; left:39%; top:58%;">数据加载中...</div>
		</div> 
	</div>
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
				beforeSend:function(){
					$("#loading").css("display","block");
				},
				complete:function(){$("#loading").css("display","none");},
				success: function(result) {
					var dataList = (result.orderList)[0];
					$("#username").val(dataList.linkName);
					$("#userage").val(dataList.age);
					$("#userBirth").val(dataList.birthday);	
					$("#usertype").find("option[value="+dataList.psgType+"]").attr("selected",true);						
					$("#usertype").attr("disabled","disabled");
					$("#userIDnum").val(dataList.idcase);
					$("#sex").find("option[value="+dataList.linkSex+"]").attr("selected",true);
					$("#userIDtype").find("option[value="+dataList.idcaseType+"]").attr("selected",true);
				},error:function(){
					
				}
			});			
		}
		
		//修改资料的执行的方法
		$("#btnA").click(function(){
			var orderNum = "<%=orderNum%>";
			var pnrNo = "<%=pnrNo%>";
			var username = $("#username").val();
			var userage = $("#userage").val();
			var usergender = $("#sex").val();
			var userBirth = $("#userBirth").val();
			var usertype = $("#usertype").val();
			var userIDnum = $("#userIDnum").val();
			var userIDtype = $("#userIDtype").val();			
			if(userage==""||userage==null){
				alert("请填写年龄格式：19");
				return false;
			}
			if(userBirth==""||userBirth==null){
				alert("请填写生日格式：1993-05-03");
				return false;
			}
			console.log(orderNum+"/"+pnrNo+"/"+username+"/"+userage+"/"+usergender+"/"+userBirth+"/"+usertype+"/"+userIDnum+"/"+userIDtype);
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
		
		$("#btnQ").click(function(){
			window.location.href="<%=basePath %>console/wechat/myPlaneTickek.jsp";
		});
	});
</script>
</html>