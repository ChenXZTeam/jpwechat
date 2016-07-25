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
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css">
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/jquery.min.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<style type="text/css">
	table td {
		border:1px solid #666666;
	}
</style>
<script type="text/javascript">
	$(function(){
		$.getJSON("<%=basePath%>console/json/countries.json",function(countries){
			var l = 0;
			for ( var i in countries){ 
				var $table = $("#countries"+l+"");
	        	$table.append("<div class='exclude'>"+i+"</div>");
	        	var $tr = $("<tr></tr>");
	        	var j = 1;
	        	for(var k in countries[i]){
					$tr.append("<td><a href='<%=basePath%>framework/visa/findByVisaFreeID.action?id="+k+"'>"+countries[i][k]+"</a></td>");
					if(j%5==0){
						$table.append($tr);
						$tr = $("<tr></tr>");
					}
					j++;
	        	}
	        	$table.append($tr);
	        	l++;
	        }
			$(".exclude").removeClass().css("font-weight","bold");
		});
	});
</script>
</head>
<body>
	<table id="countries0">
	</table>
	<table id="countries1">
	</table>
	<table id="countries2">
	</table>
	<table id="countries3">
	</table>
	<table id="countries4">
	</table>
</body>
</html>