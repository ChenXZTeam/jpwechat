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
<title>汇率查询</title>
<script type="text/javascript" src="<%=basePath %>scripts/common/jquery-easyui/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$.ajax({
            type: "GET",
            url: "<%= basePath %>framework/exchangeRate/queryCurrency.action",
            dataType: "json",
            success: function(data){
            			var result = $.parseJSON(data); 
            			var currencies = result.retData;
            			console.log(result.retData);
            			for(var i=0;i<currencies.length;i++){
	                     	$(".currency").append("<option value='"+currencies[i]+"'>"+currencies[i]+"</option>");   
            			 }
                     }
        });
	});
	function toCurrency(){
		var fromCurrency = $("#fromCurrency").val();
		var toCurrency = $("#toCurrency").val();
		var amount = $("#amount").val();
		$.ajax({
            type: "GET",
            url: "<%= basePath %>framework/exchangeRate/queryExchangeRate.action",
            data:{"amount":amount,"fromCurrency":fromCurrency,"toCurrency":toCurrency},
            dataType: "json",
            success: function(data){
            			var result = $.parseJSON(data);
            			if(result.errNum==0){
	            			var exchangeRate = result.retData;
	            			console.log(exchangeRate.convertedamount);
	            			$("#toCurrencySum").val(exchangeRate.convertedamount);
	            			$("#currency").html(exchangeRate.currency);
            			}else{
            				alert("查询失败！");
            			}
                     },
           error:function(result){
        	   alert("查询失败！")
           }          
        });
	}
</script>
</head>
<body>
	<table>
		<tr>
			<td>
				<label>待转化币种:</label>
				<select id="fromCurrency" class="currency"></select>
			</td>
			<td>
				<label>待转后币种:</label>
				<select id="toCurrency" class="currency"></select>
			</td>
		</tr>
		<tr>
			<td><input type="text" id="amount"/></td>
			<td><input type="text" id="toCurrencySum"/></td>
		</tr>
		<tr>
			<td>
				<label>汇率：</label>
				<a id="currency">
			</td>
			<td><input type="submit" value="转换" onclick="toCurrency()"/></td>
		</tr>
	</table>
</body>
</html>