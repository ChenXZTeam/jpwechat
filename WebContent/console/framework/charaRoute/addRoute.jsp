<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>添加特色路线</title>
	<link rel="stylesheet" href="<%=basePath %>kinder/themes/default/default.css" />
	<link rel="stylesheet" href="<%=basePath %>kinder/plugins/code/prettify.css" />
	<script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
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
<script>
	$(function(){
			$("#saveBtn").click(function(){
				var title = document.getElementById("title").value;
				var conText = document.getElementById("conText").value;
				var introduction = document.getElementById("introduction").value;
				var oneUrl = conText.substring(conText.indexOf("<img"),conText.indexOf("alt="));
				var twoUrl = oneUrl.substring(oneUrl.indexOf("src=")+20,oneUrl.length);
				twoUrl = twoUrl.substring(0,twoUrl.indexOf(" ")-1);
				$.ajax({
						url:"<%=basePath%>framework/route/createRoute.action",
						type:"POST",
						data:{
								"title":title,
								"conText":conText,
								"introduction":introduction,
								"fmUrl":twoUrl
						},
						dataType:"json",
						beforeSend:function(){$("#loading").css("display","block");},
						complete:function(){$("#loading").css("display","none");},
						success: function(result) {
							alert("保存数据成功");
							window.location.href="javascript:history.go(-1)";
						},error:function(){
							
						}
				});
			});
	});
</script>
<table border="0" cellpadding="10">
	<tr>
		<td>路线标题：</td>
		<td><input type="text" id="title"/></td>
	</tr>
	<tr>
		<td style="width:120px;">简介：</td>
		<td><input id="introduction" type="text" style="width:350px;"/></td>
	</tr>
	<tr>
		<td>路线内容：</td>
		<td><textarea name="conText" id="conText" style="width:780px; height:400px;"></textarea></td>
	</tr>
	<tr>
		<td colspan="2"><button id="saveBtn">保存</button></td>
	</tr>
</table>


</body>
</html>