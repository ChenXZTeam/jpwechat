<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加模板</title>
<link rel="stylesheet" href="<%=basePath %>kinder/themes/default/default.css" />
<link rel="stylesheet" href="<%=basePath %>kinder/plugins/code/prettify.css" />
<script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
<script src="<%=basePath%>console/js/ajaxfileupload.js"></script>
<script charset="utf-8" src="<%=basePath %>kinder/kindeditor.js"></script>
<script charset="utf-8" src="<%=basePath %>kinder/lang/zh_CN.js"></script>
<script charset="utf-8" src="<%=basePath %>kinder/plugins/code/prettify.js"></script>
</head>
<body>
	<table width="1000" border="0" cellpadding="0" cellspacing="10">
		<tr>
			<td style="width:1200px;">绑定人：</td>
			<td style="width:400px;"><input id="banPeople" type="text"/></td>
		</tr>
		<tr>
			<td style="width:120px;">绑定组：</td>
			<td style="width:400px;"><input id="banZu" type="text"/></td>
		</tr>
		<tr>
			<td style="width:200px;">模板内容：</td>
			<td colspan="8"><textarea id="text" name="conText" style="width:842px; height:400px;"></textarea></td>
		</tr>
		<tr>
			<td colspan="4"><button id="submitBtn">提交</button></td>
		</tr>
	</table>
</body>
<script>
	$(function(){
		$("#submitBtn").click(function(){
			var banPeople = document.getElementById("banPeople").value;
			var banZu = document.getElementById("banZu").value;
			var text = document.getElementById("text").value;
			$.ajax({
				url:"<%=basePath%>/framework/duanxin/addExample.action",
				type:"POST",
				data:{
					"banPeople":banPeople,
					"banZu":banZu,
					"text":text
				},
				dataType:"json",
				success:function(res){
					alert("保存数据成功");
					window.location.href="javascript:history.go(-1)";
				},error:function(){}
			});
		});
	});
</script>
</html>