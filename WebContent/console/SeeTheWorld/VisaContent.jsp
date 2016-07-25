<%@page import="com.solar.tech.bean.Visa"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	Visa visa = (Visa)request.getAttribute("visa");
%>     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/jquery.min.js"></script>
<title>签证信息</title>
<style type="text/css">
	.title{
		font-weight:bold;
		font-size:15px;
	}
	
	div{
		margin: 10px;
	}

	
	table {
		border-collapse: collapse;
	}
	table td{
		border:1px solid #666666;
	}
</style>
<script type="text/javascript">
	$(function(){
		$.ajax({
		  url: "<%=basePath%>framework/visa/getRequiredMaterialsList.action",
		  type:"post",
		  dataType: 'json',
		  success: function(result){
			  for(var i=0;result.length;i++){
				  console.log(result[i]);
				  var materialsID = result[i].materialsID;
				  var url = "<%=basePath%>framework/visa/findByMaterialsID.action?id="+materialsID;
				  $("#materials").append("<a href='"+url+"'>"+result[i].customerType+"</a><br>")
			  }
		  }
		});
	});
	function buyVisa(){
		//window.location.href="<%=basePath%>framework/visa/buyVisa.action?visaID=<%=visa.getVisaID()%>&visaPrice=<%=visa.getVisaPrice()%>";		
		window.location.href="<%=basePath%>console/SeeTheWorld/VisaOrder.jsp?visaID=<%=visa.getVisaID()%>&visaPrice=<%=visa.getVisaPrice()%>";
	}
</script>
</head>
<body>
	<!--标题-->
	<span><h3><%= visa.getVisaTitle() %></h3></span>
	<div>
		<label>¥ </label>
		<a><%=visa.getVisaPrice() %></a>
	</div>
		
	<div>	
		<table>		
			<tr class="title">
				<td>签证类型</td>
				<td>入境次数</td>
				<td>逗留天数</td>
			</tr>
			<tr>
				<td><%=visa.getVisaType() %></td>
				<td><%=visa.getImmigrationOfTimes() %></td>
				<td><%=visa.getSojournTime() %></td>
			</tr>
			<tr class="title">
				<td>有效期限</td>
				<td>最早可定日期</td>
				<td>办理时长</td>
			</tr>
			<tr>
				<td><%=visa.getPeriodOfValidity() %></td>
				<td><%=visa.getEarlyDates() %></td>
				<td><%=visa.getElapsedTime() %></td>
			</tr>
		</table>
	</div>
	<div>
		<label class="title">服务内容：</label>
		<p><%=visa.getServiceContent() %></p>
	</div>
	<div>
		<label class="title">受理范围：</label>
		<p><%=visa.getScopeOfAcceptance() %></p>
	</div>
	<div>
		<label class="title">办理流程：</label>
		<p><%=visa.getImmigrationFlow() %></p>
	</div>
	<div id="materials">
		<label class="title">所需材料：</label>
		<p></p>
	</div>
	<div>
		<input type="button" value="购买" onclick="buyVisa()">
	</div>
</body>
</html>