<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>我的优惠</title>
<style>
	*{padding:0px; margin:0px;}
	body{text-align:center; font:normal Helvetica, Arial, sans-serif; background-color:#F9F9F9; font-family:Microsoft JhengHei;}
	#bigTable{width:100%; border:none; text-align:center; margin-left:auto; margin-right:auto; font-size:14px;}
	.title{height:40px; background-color:#E3E3E3;}
	.title td{border-bottom:#B7B7B7 solid 1px;}
	.cententTR{height:40px;}
	.cententTD{border-bottom:#E3E3E3 solid 1px;}
	.demo {width:410px;	margin:0 auto;}
	.stamp * {padding: 0;margin: 0;list-style:none;font-family:"Microsoft YaHei", 'Source Code Pro', Menlo, Consolas, Monaco, monospace;}
	.stamp {width: 335px;padding: 0 1px;margin:10px 10px 10px 10px;position: relative;overflow: hidden;}
	.stamp:before {content: '';position: absolute;top:0;bottom:0;left:10px;right:10px;z-index: -1;}
	.stamp i {position: absolute;left: 20%;top: 45px;height: 190px;width: 390px;background-color: rgba(255, 255, 255, .15);transform: rotate(-30deg);}
	.stamp .par {float: left;padding: 16px 15px;border-right:2px dashed rgba(255, 255, 255, .3);text-align: left;}
	.stamp .par p {color:#fff;font-size: 16px;line-height: 21px;}
	.stamp .par span {font-size: 50px;color:#fff;margin-right: 5px;line-height: 65px;}
	.stamp .par .sign {font-size: 34px;}
	.stamp .par sub {	position: relative;	top:-5px;color:rgba(255, 255, 255, .8);}
	.stamp .copy {display: inline-block;	padding:21px 14px;width:100px;vertical-align: text-bottom;font-size: 30px;color:rgb(255,255,255);text-align: center;line-height: initial;}
	.stamp .copy p {font-size: 16px;margin-top: 15px;}
	.stamp01 {background: radial-gradient(rgba(0, 0, 0, 0) 0, rgba(0, 0, 0, 0) 5px, #F39B00 5px);background-size: 15px 15px;background-position: 9px 3px;}
	.stamp01:before {background-color:#F39B00;}
	.stamp02 {background: radial-gradient(transparent 0, transparent 5px, #D24161 5px);background-size: 15px 15px;background-position: 9px 3px;}
	.stamp02:before {background-color:#D24161;}
	.stamp03 {background: radial-gradient(transparent 0, transparent 5px, #7EAB1E 5px);background-size: 15px 15px;background-position: 9px 3px;}
	.stamp03:before {background-color:#7EAB1E;}
	.stamp03 .copy {padding: 10px 6px 10px 12px;font-size: 24px;}
	.stamp03 .copy p {font-size: 14px;margin-top: 5px;margin-bottom: 8px;}
	.stamp03 .copy a {background-color:#fff;	color:#333;	font-size: 14px;text-decoration:none;padding:5px 10px;border-radius:3px;display: block;}
	.stamp04 {width: 390px;background: radial-gradient(rgba(0, 0, 0, 0) 0, rgba(0, 0, 0, 0) 4px, #50ADD3 4px);background-size: 12px 8px;	background-position: -5px 10px;}
	.stamp04:before {background-color:#50ADD3;left: 5px;right: 5px;}
	.stamp04 .copy {padding: 10px 6px 10px 12px;font-size: 24px;}
	.stamp04 .copy p {font-size: 14px;margin-top: 5px;margin-bottom: 8px;}
	.stamp04 .copy a {background-color:#fff;color:#333;font-size: 14px;text-decoration:none;padding:5px 10px;border-radius:3px;display: block;}

</style>
<script src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script>
	$(function(){
		$.ajax({
			url:"<%=basePath %>userOrderController/loading/myDiscount.action",
			type:"POST",
			dataType:"json",
			success:function(data){
				console.log("data"+data.orderList1);
				var res=data.orderList2;
				if(data.msg==1){
					for(var i=0;i<res.length;i++){
						if(res[i].type=="preferential"){
							var date = new Date(res[i].deadline);
							var year=date.getFullYear();
							var month=date.getMonth()+1;
							var day=date.getDate();
							var deadline=year+"-"+month+"-"+day;
							$("#bigTable").append('<div class="stamp stamp01"><div class="par"><p>仁德优惠券</p><sub class="sign">￥</sub><span>'+res[i].sum+'</span><sub>优惠券</sub><p>'+res[i].remarks+'</p></div><div class="copy">副券<p>有效期至<br>'+deadline+'</p></div><i></i></div>');		
						}else{
							var date = new Date(res[i].deadline);
							var year=date.getFullYear();
							var month=date.getMonth()+1;
							var day=date.getDate();
							var deadline=year+"-"+month+"-"+day;
							$("#bigTable").append('<div class="stamp stamp01"><div class="par"><p>仁德折扣券</p><sub class="sign">￥</sub><span>'+res[i].discount+'</span><sub>折扣券</sub><p>'+res[i].remarks+'</p></div><div class="copy">副券<p>有效期至<br>'+deadline+'</p></div><i></i></div>');
						}
					}
				}else{
					alert("没有找到优惠信息");
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
