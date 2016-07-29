<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
 
<%
	String path= request.getContextPath();
	String basePath= request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+ path +"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>机票订单</title>
<link type="text/css" rel="stylesheet" href="<%=basePath %>console/css/planDD.css"/>
<script type="text/javascript"  src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/planDD.js" charset="utf-8"></script>
<style>
	body{background-color:#e1e1e1; font-family:Microsoft YaHei; font-size:14px;}
	.product ul{list-style-type:none; padding:0px; margin:0px; padding-bottom:10px;}
	.product ul li{overflow:hidden; margin-top:10px; padding-bottom:10px; background:#fff;}
	.product ul li .hiddenClass{display:none;}
	.product ul li .planTitle{border-bottom:1px solid #E0E0E0; overflow:hidden; padding:10px;}
	.product ul li .planTitle img,span{float:left;}
	.product ul li .TekMas{border-bottom:1px solid #E0E0E0; padding:10px;}
	.product ul li .hangban{float:left;}
	.product ul li .hangban span{ clear:both; display:block; line-height:24px;}
	.product ul li .money{ float:right;}
	.product ul li .xialaImg{ padding:3px; margin-left:15px; border:1px solid #0A8CD2; border-radius:3px; margin-top:10px; float:left;}	
	.product ul li .xialaImg img{width:20px; height:20px;}
	.product ul li .payBtn{padding:10px; overflow:hidden; float:right;}
	.product ul li .payBtn a{padding:5px 10px; float:right; border:1px solid #FE8204; border-radius:3px; color:#FE8204;}
	.product ul li .movement{height:0px; line-height:50px; overflow:hidden;}
	.product ul li .movement a{margin-left:10px; padding:5px 10px; border:1px solid #FE8204; border-radius:3px; color:#FE8204;}
</style>
</head>

<body>
	<div class="lanrenzhijia">
	  <div class="title cf">
		<ul class="title-list fr cf ">
		  <li class="on">全部订单</li>
		  <li>待付款</li>
		  <li>已出票</li>
		  <p><b></b></p>
		</ul>
	  </div>
	  
	  <div class="product-wrap">
		<!--案例1-->
		<div class="product show">
			<ul id="orderUL">
				<%-- <li>
					<div class="planTitle">
						<img src="<%=basePath %>console/images/plan.png" style="width:20px;"/>
						<span style="margin-left:7px; line-height:23px;">机票</span>
						<span style="float:right; color:#FE8204;">请支付</span>
					</div>					
					<div style="clear:both;"></div>
					
					<div class="TekMas">
						<div class="hangban">
							<span>深圳-北京</span>
							<span>2016-03-09 08:30-11:35</span>
							<span style="color:#B5B5B5;">海南航空HU7710</span>
						</div>
						<div class="money"><span>￥1265</span></div>
						<div style="clear:both;"></div>
					</div>
					<div class="xialaImg"><img src="<%=basePath%>console/images/123.png" /></div>
					<div class="payBtn"><a>立即支付</a></div>
					<div style="clear:both;"></div>
					<div class="movement">
						<a>改签</a>
						<a>修改资料</a>
						<a>退票</a>
						<a>删除订单</a>
					</div>
				</li> --%>
				
				
				
			</ul>
		</div>
		<!--案例2-->
		<div class="product">
		2
		</div>
		
		<!--案例3-->
		<div class="product">
		3
		</div>
		
	  </div>
	</div>
	<div id="basePathJava" style="display:none"><%=basePath %></div>
</body>
<script>
	$(function(){
		$.ajax({
				url: "<%=basePath %>userOrderController/loading/order.action",
				type: "POST",
				data: {},
				dataType: "json",
				success: function(res) {
					var data = res.orderList;
					if(res.msg==1){
						for(var i=0; i<data.length; i++){
							var orderlist = '<li><div class="hiddenClass"><div class="pnrNoDel">'+data[i].pnr+'</div><div class="orderNumDel">'+data[i].orderNum+'</div><div class="IDDel">'+data[i].id+'</div></div><div class="planTitle"><img src="<%=basePath %>console/images/plan.png" style="width:20px;"/><span style="margin-left:7px; line-height:23px;">机票</span>	<span style="float:right; color:#FE8204;">请支付</span></div><div style="clear:both;"></div><div class="TekMas"><div class="hangban"><span>'+data[i].chufCity+'-'+data[i].daodCity+'</span><span>'+data[i].chufDate+' '+data[i].chufTime+'-'+data[i].daodTime+'</span><span style="color:#B5B5B5;">南方航空'+data[i].hangbanNum+'</span></div><div class="money"><span>'+data[i].costMoney+'</span></div><div style="clear:both;"></div></div><div class="xialaImg"><img src="<%=basePath%>console/images/123.png" /></div><div class="payBtn"><a>立即支付</a></div><div style="clear:both"></div><div class="movement"><a>改签</a><a>修改资料</a>	<a>退票</a><a class="deleteThis">删除订单</a></div></li>';
							$("#orderUL").append(orderlist);
						}						
						loadjs();
					}else{
						alert("没有找到订单");
					}
					//console.log(res.orderList); 					
				},
				error: function() {					
				}
		});
	});
	
	//动态加载指定js文件
	function loadjs(){
		var jsElem = document.createElement('script');
		jsElem.src='<%=basePath%>console/js/myPlaneTick.js';
		document.getElementsByTagName('head')[0].appendChild(jsElem);
	}
</script>
</html>
