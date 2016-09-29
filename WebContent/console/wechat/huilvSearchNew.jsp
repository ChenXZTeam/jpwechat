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
	body{ background-color:#e1e1e1;}
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
	#resultBigBox{background-color:#FFFFFF; height:200px; margin-top:10px;}
	#resultBigBox .resultBox{font-size:18px; padding:10px; color:#999999; font-family:"微软雅黑";}
	#resultBigBox .resultBoxValue{color:#666; font-size:15px; padding:10px; text-align:center; line-height:70px;}
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
					<div class="inptBoxClass"><input type="text" id="changeMoney"/></div>
				</div>
				<div style="margin-top:10px; overflow:hidden;">
					<div class="titleBoxClass"><span>转换币种</span></div>
					<div class="inptBoxClass"><input type="text" id="changeMoney"/></div>
				</div>
			</div>
			<div id="changeBtn"><img src="<%=basePath%>console/images/changeImgBtn.png"/></div>
		</div>
		<div id="changeBoxBtn"><button>开始转换</button></div>
	</div>
	<div style="clear:both;"></div>
	<div id="resultBigBox">
		<div class="resultBox"><span>转换结果</span></div>
		<div class="resultBoxValue">
			<span>1</span>
			<span>英镑</span>
			<span>=</span>
			<span>8.6759</span>
			<span>人民币元</span>
		</div>
	</div>
<script>
	$(function(){
			alert("11");
			$.ajax({
					url:"<%=basePath%>framework/huilv/getList.action",
					type:"POST",
					data:{},
					dataType:"json",
					success:function(res){
						alert("请求成功");
					},error:function(){
						alert("请求失败");
					}
			});
	});
</script>
</body>
</html>
