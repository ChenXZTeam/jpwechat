<%@ page language="java" contentType="text/html; charset=utf-8"   pageEncoding="utf-8"%>


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
<style type="text/css">
	body{ font-family:"Microsoft YaHei" ! important; text-align:center;}
	.bank{padding:10px 3px; font-size:15px;}
	.huobiTitle{font-size:15px;}
	.huobiTitle .bizhong{width:15%; border-bottom:#CCCCCC solid 1px;}
	.huobiTitle .centerJia{width:30%; border-bottom:#CCCCCC solid 1px;}
	.huobiTitle .cmj{width:30%; border-bottom:#CCCCCC solid 1px;}
	.huobiTitle .hmj{width:25%; border-bottom:#CCCCCC solid 1px;}
	.content{font-size:12px; background-color:#F9F9F9;}
	.content span{width:100%; display:block;}
	.content .yw{color:#B5B5B5;}
	.content td{border-bottom:#CCCCCC solid 1px;}
</style>
</head>

<body>
	<div id="bigContent">
		<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:1px solid #cccccc; border-bottom:none;">
			<tr>
				<td class="bank" colspan="4" style="text-align:left;">基准货币（单位100）中国银行</td>
			</tr>
			<tr class="huobiTitle" style="background-color:#F9F9F9;">
				<td class="bizhong">币种</td>
				<td class="centerJia">◀中间价</td>
				<td class="cmj">钞买价</td>
				<td class="hmj">汇买价▶</td>
			</tr>
		</table>
	</div>
</body>
<script type="text/javascript">
$(function(){
	for(var i=0; i<20; i++){
		$(".huobiTitle").after('<tr class="content"> <td><span>美元</span><span class="yw">USD</span></td> <td>650.4100</td> <td>644.110</td> <td>649.3200</td> </tr>');
	}
});
</script>
</html>
