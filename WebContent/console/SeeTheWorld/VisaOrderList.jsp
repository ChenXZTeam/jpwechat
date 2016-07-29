<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>        
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$.ajax({
			url:"<%=basePath%>framework/visa/findByUserID.action",
			dataType:"json",
			method:"post",
			data:{"userID":"4028668150178a650150178b0b010001"},
			success:function(result){
				console.log(result);
				for(var i=0;i<result.length;i++){
					$("#tt").append("<tr><td>"+
						"<a href='<%=basePath%>framework/visa/findByVisaOrderID.action?id="+result[i].visaOrderID+"'>"+result[i].visaTitle+"</a>"+
					"</td></tr>")
				}
			},
			error:function(result){
				alert("查询失败！");
			}
		});
		
	});
</script>
</head>
<body>
	<table id="tt">
	</table>	
</body>
</html>