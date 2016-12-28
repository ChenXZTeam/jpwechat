<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<% 
	String title=new String(request.getParameter("title").getBytes("ISO-8859-1"),"utf-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>国内资讯详情</title>
<style>
	*{padding:0px; margin:10px;}
	body{ font:normal Helvetica, Arial, sans-serif; background-color:#F9F9F9; font-family:Microsoft JhengHei;}
	#bigTable{width:100%; border:none;  margin-left:auto; margin-right:auto; font-size:14px;}
	.title{height:40px; background-color:#E3E3E3;}
	.title td{border-bottom:#B7B7B7 solid 1px;}
	.cententTD{font-size:22px;}
	.cententTR{height:40px;}
	.titl{margin:10px;}
	
</style>
<script src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script>
	$(function(){
		$.ajax({
			url:"<%=basePath %>framework/info/findInfoByID.action",
			type:"POST",
			data:{"title":"<%=title%>"},
			dataType:"json",
			success:function(data){
				if(data.msg==1){
					var getInfo = data.rows;
					$("#bigTable").append("<tr class='cententTR'><td class='cententTD '>"+getInfo[0].title+"</td></tr><tr class='cententTR'><td class='cententTD1'><font color='darkgray'>来源：</font><font color='deepskyblue'>"+getInfo[0].introduction+"</td></tr><tr class='cententTR'><td class='cententTD'><div style='width:330px;height:1px;margin:0px auto;padding:0px;background-color:#D5D5D5;overflow:hidden;'></div></td></tr><tr class='cententTR'><td class='cententTD titl'>"+getInfo[0].info+"</td></tr>");
				}else{
					alert("没有找到资讯信息");
				}
			},error:function(){
			}
		});
	});
</script>
</head>

<body>
<table id="bigTable" cellpadding="0" cellspacing="0">
	
</table>
</body>
</html>
