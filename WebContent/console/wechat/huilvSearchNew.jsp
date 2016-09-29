<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<% 
	String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>汇率查询</title>
<script type="text/javascript"  src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<style>
	html{height:100%;}
	body{height:95%; background-color:#e1e1e1;}
	#iptbtnBox{background-color:#fff; padding:15px 10px;}
	#iptbtnBox #inptMoneyClassBox{height:30px;}
	#iptbtnBox .titleBoxClass{border:1px solid #e1e1e1; height:30px; padding:0px 10px; border-radius:5px 0px 0px 5px; float:left; font-size:13px; font-family:"微软雅黑"; color:#999999;}
	#iptbtnBox .titleBoxClass span{display:block; line-height:30px;}
	#iptbtnBox .inptBoxClass{float:left; border:1px solid #e1e1e1; height:30px; border-left:none;}
	#iptbtnBox .inptBoxClass input{display:block; height:30px; border:none; background:none; width:90%; color:#666666; outline:none; padding-left:10px;}
	#iptbtnBox #choMoneyClass{overflow:hidden; margin-top:10px;}
	#iptbtnBox #choMoneyClass #choBiTypeBox{float:left;}
	#iptbtnBox #choMoneyClass #changeBtn{float:left; padding-top:10px;}
	#iptbtnBox #choMoneyClass #changeBtn img{width:28px;}
	#iptbtnBox #changeBoxBtn{ margin-top:10px; width:98%;}
	#iptbtnBox #changeBoxBtn button{ width:100%; padding:10px; background-color:#388BFF; color:#FFFFFF; border:none; display:block; border-radius:5px; outline:none;}
	#resultBigBox{background-color:#FFFFFF; height:55%; margin-top:10px;}
	#resultBigBox .resultBox{font-size:18px; padding:10px; color:#999999; font-family:"微软雅黑";}
	#resultBigBox .resultBoxValue{color:#666; font-size:15px; padding:10px; text-align:center;}
	#resultBigBox .resultBoxValue table{font-size:13px;}
	#resultBigBox .resultBoxValue table tr{height:25px;}
	#resultBigBox .resultBoxValue table tr td{}
	#bizhongBox{display:none; font-size:13px; color:#666; position:absolute; top:0px; left:0px; padding:0px; width:99%; background-color:#fff;}
	#bizhongBox ul{list-style-type:none; padding:0px; margin:0px;}
	#bizhongBox ul li{padding:5px; border-bottom:1px solid #e1e1e1;}
	#bizhongBox ul li:last-child{border:none;}
</style>
</head>

<body>
	<div id="iptbtnBox">
		<div id="inptMoneyClassBox">
			<div class="titleBoxClass"><span>转换金额</span></div>
			<div class="inptBoxClass"><input type="text" id="changeMoney"/></div>
		</div>
		<div id="choMoneyClass">
			<div id="choBiTypeBox">
				<div style="overflow:hidden;">
					<div class="titleBoxClass"><span>转换币种</span></div>
					<div class="inptBoxClass"><input type="text" id="fromChangebz" class="inputBiz"/></div>
				</div>
				<div style="margin-top:10px; overflow:hidden;">
					<div class="titleBoxClass"><span>转换币种</span></div>
					<div class="inptBoxClass"><input type="text" id="toChangebz" class="inputBiz"/></div>
				</div>
			</div>
			<div id="changeBtn"><img src="<%=basePath%>console/images/changeImgBtn.png"/></div>
		</div>
		<div id="changeBoxBtn"><button id="btnChange">开始转换</button></div>
	</div>
	<div style="clear:both;"></div>
	<div id="resultBigBox">
		<div class="resultBox"><span>转换结果</span></div>
		<div class="resultBoxValue">
			<table>
				<tr>
					<td>转换金额：</td>
					<td id="resCountMoney" style="text-align:left; padding-left:10px;"></td>
				</tr>
				<tr>
					<td>起始币种：</td>
					<td id="resqishBizh" style="text-align:left; padding-left:10px;"></td>
				</tr>
				<tr>
					<td>目的币种：</td>
					<td id="resbudiBizh" style="text-align:left; padding-left:10px;"></td>
				</tr>
				<tr>
					<td>当前汇率：</td>
					<td id="nowHuilv" style="text-align:left; padding-left:10px;"></td>
				</tr>
				<tr>
					<td>转换结果：</td>
					<td id="resultId" style="text-align:left; padding-left:10px; color:#ff0000; font-size:18px; font-weight:bold;"></td>
				</tr>
			</table>		
		</div>
	</div>
	<div id="bizhongBox">
		<ul></ul>
	</div>
<script>
	$(function(){
			$.ajax({
					url:"<%=basePath%>framework/exchangeRate/supperExchangeRate.action",
					type:"POST",
					data:{},
					dataType:"json",
					success:function(res){
						var dateList=JSON.parse(res.data);
						var bizhongList = dateList.retData;
						for(var i=0; i<bizhongList.length;i++){
							var listLi='<li onclick="liClick(this)">'+bizhongList[i]+'</li>';
							$("#bizhongBox ul").append(listLi);
						}
					},error:function(){
						//alert("请求失败");
					}
			});
			
			$("#btnChange").click(function(){
				var changeMoney=$("#changeMoney").val();
				var fromChangebz=$("#fromChangebz").val();
				var toChangebz=$("#toChangebz").val();
				$.ajax({
					url:"<%=basePath%>framework/exchangeRate/queryExchangeRate.action",
					type:"POST",
					data:{"fromCurrency":fromChangebz,"toCurrency":toChangebz,"amount":changeMoney},
					dataType:"json",
					success:function(res){
						var dateList=JSON.parse(res.data);
						var retaDa = dateList.retData;
						//console.log(dateList);
						$("#resCountMoney").text(retaDa.amount);
						$("#resqishBizh").text(retaDa.fromCurrency);
						$("#resbudiBizh").text(retaDa.toCurrency);
						$("#nowHuilv").text(retaDa.currency);
						$("#resultId").text(retaDa.convertedamount);
						
					},error:function(){
						alert("请求失败");
					}
				});
			});
			
			$("#changeBtn").click(function(){
				var foo=$("#fromChangebz").val(); bar=$("#toChangebz").val();
				bar = [foo,foo=bar][0];
				$("#fromChangebz").val(foo);
				$("#toChangebz").val(bar);
			});
	});
	
	function liClick(inc){
		var text = $(inc).text();
		$(".bizhType").val(text);
		$("#bizhongBox").css("display","none");
	}
	
	$(".inputBiz").click(function(){
		$(".inputBiz").removeClass("bizhType");
		$(this).addClass("bizhType");
		$("#bizhongBox").css("display","block");
	});
</script>
</body>
</html>
