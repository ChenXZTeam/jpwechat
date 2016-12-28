<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>资讯消息的添加</title>
<link rel="stylesheet" href="<%=basePath %>kinder/themes/default/default.css" />
<link rel="stylesheet" href="<%=basePath %>kinder/plugins/code/prettify.css" />
<script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
<script src="<%=basePath%>console/js/ajaxfileupload.js"></script>
<script charset="utf-8" src="<%=basePath %>kinder/kindeditor.js"></script>
<script charset="utf-8" src="<%=basePath %>kinder/lang/zh_CN.js"></script>
<script charset="utf-8" src="<%=basePath %>kinder/plugins/code/prettify.js"></script>
<script>
		KindEditor.ready(function(K) {
			var editor1 = K.create('textarea[name="conText"]', {
				cssPath : '<%=basePath %>kinder/plugins/code/prettify.css',
				uploadJson : '<%=basePath %>kinder/upload_json.jsp',
				fileManagerJson : '<%=basePath %>kinder/file_manager_json.jsp',
				allowFileManager : true,
				afterBlur:function(){this.sync();}
			});
		});
</script>
</head>
<body>
	<table width="1000" border="0" cellpadding="0" cellspacing="10">
		<tr>
			<td style="width:120px;">文章标题：</td>
			<td style="width:400px;"><input id="infoTitle" type="text"/></td>
		</tr>
		<tr>
			<td style="width:120px;">简介：</td>
			<td style="width:400px;"><input id="introduction" type="text"/></td>
		</tr>
		<tr>
			<td>文章内容：</td>
			<td colspan="3"><textarea id="info" name="conText" style="width:842px; height:400px;"></textarea></td>
		</tr>
		<tr>
			<td colspan="4"><button id="submitBtn">提交</button></td>
		</tr>
	</table>
</body>
<script>
	$(function(){
		$("#submitBtn").click(function(){
			var title = document.getElementById("infoTitle").value;
			var info = document.getElementById("info").value;
			var introduction = document.getElementById("introduction").value;
			var oneUrl = info.substring(info.indexOf("<img"),info.indexOf("alt="));
			var twoUrl = oneUrl.substring(oneUrl.indexOf("src=")+20,(oneUrl.length)-2);
			$.ajax({
				url:"<%=basePath%>/framework/outinfo/addInfo.action",
				type:"POST",
				data:{
					"title":title,
					"info":info,
					"introduction":introduction,
					"fmUrl":twoUrl
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