<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>临时页面</title>
	<script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
</head>
<body>
<ul style="list-style-type:none;">
	
</ul>
<script>
$(function(){
	//临时代码
	<%-- $.ajax({
			url:"<%=basePath%>wechatController/find/getplanCode.action",
			type:"POST",
			data:{},
			dataType:"json",
			success:function(result){
			 	console.log(result.c);
			 	var s = result.c;
			 	for(var i=0; i<s.length; i++){
			 		if(s[i][1]==null||s[i][1]=="null"){
			 		}else{
			 			var a = s[i][1];
			 			a = a.replace("公司","");
			 			a = a.replace("有限","");
			 			a = a.replace("责任","");
			 			if(a=="网上订票"){
			 				a = a;
			 			}else{
				 			if(a.indexOf("航空")<0){
				 				a = a+"航空";
				 			}
			 			}
			 			var li = '<li>"'+s[i][0]+'":"'+a+'",</li>';
			 			$("ul").append(li);
			 		}
			 	}
			},
			error:function(result){
			
			}
	}); --%>
	
	//草稿代码
	$.ajax({
			url:"<%=basePath%>wechatController/find/getplanCode.action",
			type:"POST",
			data:{},
			dataType:"json",
			success:function(result){
				
			},
			error:function(result){
			
			}
	});
});
</script>
</body>
</html>