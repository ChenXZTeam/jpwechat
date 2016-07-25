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
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css">
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/jquery.min.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<title>Insert title here</title>
<style type="text/css">
      #dd div{
      	border:1px solid #666666;
      	width: 100px;
      	height: 100px;
      	float: left;
      }
</style>
<script type="text/javascript">
	$(function(){
		$('#countries').combobox({
		    url:'<%= basePath %>console/json/countries_EN.json',
		    valueField:'id',
		    textField:'name',
		});
	});
	function findVisa(){
		var country = $("#countries").combobox('getValue');
		if(country!=''&&country!=null){
            location.href='<%=basePath%>framework/visa/findByCountry.action?country='+country;
		}
	}
</script>
</head>
<body>
	<input id="countries"><a class="easyui-linkbutton" iconCls="icon-search" onclick="findVisa()">搜索</a>
	<br>
	<br>
	<a href="<%= basePath%>console/SeeTheWorld/VisaFreeList.jsp">免签、落地签</a>
	
	<br>
	<br>
	<div id="dd">
		<div><a href="<%=basePath%>framework/visa/findByCountry.action?country=US">美国</a></div>
		<div><a href="<%=basePath%>framework/visa/findByCountry.action?country=JP">日本</a></div>
		<div><a href="<%=basePath%>framework/visa/findByCountry.action?country=KR">韩国</a></div>
	</div>
</body>
</html>