<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>新建订单</title>
<script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
<style>
	table{border-top:1px solid #ccc; border-left:1px solid #ccc}
	table tr td{padding:10px; border-bottom:1px solid #ccc; border-right:1px solid #ccc;}
	table tr td input{height:20px; padding-left:7px;}
	table tr td select{height:25px; padding-left:3px;}
</style>
</head>
<body>
<div >
	<ul>
		<li><span class="countryId"></span><span class="countryName"></span></li>
	</ul>
</div>
<table width="1000" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td style="width:100px;">申请国家：</td>
		<td><input type="text" name="applyCountry" id="applyCountry"/></td>
	</tr>
	<tr>
		<td>申请人：</td>
		<td><input type="text" name="applyPerson" id="applyPerson"/></td>
	</tr>
	<tr>
		<td>客户类型：</td>
		<td>
			<select name="kehuType" id="kehuType">
				<option value="在职">在职</option>
				<option value="自由职业">自由职业</option>
				<option value="退休">退休</option>
				<option value="在校学生">在校学生</option>
				<option value="学龄儿童">学龄儿童</option>
				<option value="儿童">儿童</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>性别：</td>
		<td>
			<select name="sex" id="sex">
				<option value="男">男</option>
				<option value="女">女</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>手机号：</td>
		<td><input type="text" name="personPhone" id="personPhone"/></td>
	</tr>
	<tr>
		<td>电子邮件：</td>
		<td><input type="text" name="Email" id="Email"/></td>
	</tr>
	<tr>
		<td>旅客类型：</td>
		<td>
			<select name="lvkeType" id="lvkeType">
				<option value="成人">成人</option>
				<option value="儿童">儿童</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>身份证：</td>
		<td><input type="text" name="idNum" id="idNum"/></td>
	</tr>
	<tr>
		<td>
			<select name="peisType" id="peisType" style="border:none; outline:none; padding-left:0px; cursor:pointer;">
				<option value="送货上门">送货上门</option>
			</select>
		</td>
		<td><input type="text" name="peisAdd" id="peisAdd"/></td>
	</tr>
</table>
<button id="btnOrder" style="padding:5px 10px; margin-top:10px;">保　存</button>
</body>
<script>
	$(function(){
		//加载全部国家到国家输入框里面
		$.ajax({
			url:"<%=basePath%>framework/visa/getVisaList.action",
			type:"POST",
			data:{"page":1,"rows":10000},
			dataType:"json",
			async:false,
			success:function(res){
				console.log(res.vList);
				if(res.msg==1){
					var dataList = res.vList;
					visaList = dataList;
				}
			},error:function(){
			
			}
		});
		
		//保存数据
		$("#btnOrder").click(function(){
			var linkName = $("#applyPerson").val();//申请人
			var personWorkIpnt = $("#kehuType").val();//客户类型
			var sexIpnt = $("#sex").val();//性别 
			var phoneNum = $("#personPhone").val();//手机号码
			var EmailAdd = $("#Email").val();//电子邮件
			var trayTypeIpnt = $("#lvkeType").val();//旅客类型
			var IDcase = $("#idNum").val()//身份证号
			var songTypeIpnt = $("#peisType").text();//配送方式
			var sondAdd = $("#peisAdd").val();//配送地址
			var payTry = "1520"; //价格
			var countryName = "日本"; //签证国家
			var dataList = {
				"linkName":linkName,
				"personWorkIpnt":personWorkIpnt,
				"sexIpnt":sexIpnt,
				"phoneNum":phoneNum,
				"EmailAdd":EmailAdd,
				"trayTypeIpnt":trayTypeIpnt,
				"IDcase":IDcase,
				"songTypeIpnt":songTypeIpnt,
				"sondAdd":sondAdd,
				"payTry":payTry,
				"countryName":countryName
			}
			$.ajax({
				url:"<%=basePath%>framework/visa/addVisaOrder.action",
				type:"post",
				data:dataList,
				dataType:"json",
				success:function(res){
					if(res.msg==1){
						alert("您的签证订单已生成成功");
						window.location.href="<%=basePath%>console/framework/order/index.jsp";
					}else{
						alert("订单生成失败，请稍后再试");
					}
				},
				error:function(res){
				}
			});
		});
	});
</script>
</html>