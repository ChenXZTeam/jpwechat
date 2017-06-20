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
<link rel="stylesheet" type="text/css"  href="<%=basePath%>console/css/loading.css" />
<link rel="stylesheet" href="<%=basePath%>console/css/weui.min.css" />
<link rel="stylesheet" href="<%=basePath%>console/css/jquery-weui.css" />
<link rel="stylesheet" href="<%=basePath%>scripts/common/weui/css/weui.css" />
<script type="text/javascript"  src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/planDD.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=basePath %>console/js/jquery-weui.js"></script>
<script src="<%=basePath %>console/js/airCodeVScity.js"></script>

<style>
	body{background-color:#e1e1e1; font-family:Microsoft YaHei; font-size:14px;}
	.product ul{list-style-type:none; padding:0px; margin:0px; padding-bottom:10px;}
	.product ul li{overflow:hidden; margin-top:10px; padding-bottom:10px; background:#fff;}
	.product ul li .hiddenClass{display:none;}
	.product ul li .planTitle{border-bottom:1px solid #E0E0E0; overflow:hidden; padding:10px;background:#10a9ec; color:#fff;}
	.product ul li .planTitle img,span{float:left;}
	.product ul li .TekMas{border-bottom:1px solid #E0E0E0; padding:10px;}
	.product ul li .hangban{float:left;}
	.product ul li .hangban span{ clear:both; display:block; line-height:24px;}
	.product ul li .money{ float:right;color:#FF4500}
	.product ul li .xialaImg{ padding:3px; margin-left:15px; border:1px solid #0A8CD2; border-radius:3px; margin-top:10px; float:left;}	
	.product ul li .xialaImg img{width:20px; height:20px;}
	.product ul li .payBtn{padding:10px; overflow:hidden; float:right;}
	.product ul li .payBtn a{padding:5px 10px; float:right; border:1px solid #FE8204; border-radius:3px; color:#FE8204;}
	.product ul li .movement{height:50px; line-height:50px; overflow:hidden; display:none;}
	.product ul li .movement a{margin-left:10px; padding:5px 10px; border:1px solid #FE8204; border-radius:3px; color:#FE8204;}
	.intro{transition:all 0.4s ease-in-out; transform:rotateZ(90deg);}
	.intor{transition:all 0.4s ease-in-out; transform:rotateZ(-0deg);}
	.tpStatus{margin-top: 12px; float: right; margin-right: 10px; color: #FF4500;}
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
				
			</ul>
		</div>
		<!--案例2-->
		<div class="product">
			<ul id="NOpay">
				
			</ul>
		</div>
		
		<!--案例3-->
		<div class="product">
			<ul id="YESpay">
				
			</ul>
		</div>
		
	  </div> 
	</div>
	<!-- 加载等待界面 -->	
	<div id="loading">
		<div id="loading-center">
			<div id="loading-center-absolute">
				<div class="object" id="object_four"></div>
				<div class="object" id="object_three"></div>
				<div class="object" id="object_two"></div>
				<div class="object" id="object_one"></div>
			</div>
			<div style="color:#ffffff; position:absolute; left:39%; top:58%;">数据加载中...</div>
		</div> 
	</div>
	<div id="basePathJava" style="display:none"><%=basePath %></div>
	<div id="ydresuletBox" style="position:absolute; width:100%; height:100%; background:rgba(51,51,51,0.7); top:0px; left:0px; z-index:99; display:none;">
		<div style="margin:60% auto; width:300px; border-radius:5px; background:#fff;">
			<div id="alertTitle" style="text-align:center; color:#666; font-size:18px; line-height:45px;"></div>
			<div id="commitRes" style="font-size:15px; text-align:center;"></div>
			<div style="border-top:1px #e1e1e1 solid; margin-top:10px; overflow: hidden;"> 
				<a style="display:block; float:left; width:49%; line-height:49px; text-align:center; border-right:1px solid #e1e1e1;" onclick="tureBtn(this)">确定</a>
				<a style="display:block; float:right; width:50%; line-height:49px; text-align:center;" onclick="closeBox()">取消</a>
				<a style="clear:both;"></a>
				<a id="uuidBox" style="display:none"></a>
				<a id="pnrBox" style="display:none"></a>
			</div>
		</div>
	</div>
</body>
<script>
	$(function(){
		
		$.ajax({
				url: "<%=basePath %>userOrderController/loading/order.action",
				type: "POST",
				data: {},
				dataType: "json",
				beforeSend:function(){
					$("#loading").css("display","block");
				},
				complete:function(){$("#loading").css("display","none");},
				success: function(res) {
					var data = res.orderList;
					console.log(data);
					if(res.msg==1){
						for(var i=0; i<data.length; i++){
							if(data[i].stutisPay=="0"){	//判断支付状态（0：未支付、1：已出票）							
								var orderlist = '<li><div class="hiddenClass"><div class="pnrNoDel" >'+data[i].pnr+'</div><div class="IDDel">'+data[i].id+'</div><div class="yiwaiBX">'+data[i].yiwaiBX+'</div><div class="yanwuBX">'+data[i].yanwuBX+'</div></div><div class="planTitle"><img src="<%=basePath %>console/images/plan2.png" style="width:20px;"/><span style="margin-left:7px; line-height:23px;color:#FFFFFF;">机票</span><span style="float:right; color:#FFFFFF;">请支付</span></div><div style="clear:both;"></div><div class="TekMas"><div class="hangban"><span>'+findByCity(data[i].chufCity)+'-'+findByCity(data[i].daodCity)+'</span><span >'+data[i].chufDate+' '+changeType(data[i].chufTime)+'-'+changeType(data[i].daodTime)+'</span><span style="color:#B5B5B5;">'+findByCode(data[i].hangbanNum.substring(0,2))+' '+data[i].hangbanNum+'</span></div><div class="money"><span>￥'+data[i].costMoney+'</span></div><div style="clear:both;"></div></div><div class="xialaImg" onclick="xiala(this)"><img src="<%=basePath%>console/images/orderTip.png" /></div><div class="payBtn" onclick="payNow(this)"><a>立即支付</a></div><div style="clear:both"></div><div class="movement"><a id="gaiqianCode" style="display:none;"></a><a class="deleteThis" onclick="delor(this)">删除订单</a><a class="upUserMsg" style="margin-right:0px;">修改证件</a></div></li>';
								$("#orderUL").append(orderlist);//全部订单	
								$("#NOpay").append(orderlist);
							}else if(data[i].stutisPay=="1"){
								var orderlist = "";
								if(data[i].tpStatus=="1"||data[i].tpStatus=="2"){
									orderlist = '<li><div class="hiddenClass"><div class="pnrNoDel">'+data[i].pnr+'</div><div class="IDDel">'+data[i].id+'</div></div><div class="planTitle"><img src="<%=basePath %>console/images/plan2.png" style="width:20px;"/><span style="margin-left:7px; line-height:23px;">机票</span><span style="float:right; color:#FFFFFF;">已支付</span></div><div style="clear:both;"></div><div class="TekMas"><div class="hangban"><span>'+findByCity(data[i].chufCity)+'-'+findByCity(data[i].daodCity)+'</span><span>'+data[i].chufDate+' '+changeType(data[i].chufTime)+'-'+changeType(data[i].daodTime)+'</span><span class="fildNum" style="color:#B5B5B5;">'+findByCode(data[i].hangbanNum.substring(0,2))+' '+data[i].hangbanNum+'</span></div><div class="money"><span>￥'+data[i].costMoney+'</span></div><div style="clear:both;"></div></div><div class="tpStatus"><a>'+tpStats(data[i].tpStatus)+'</a></div><div style="clear:both"></div></li>';
								}else{
									orderlist = '<li><div class="hiddenClass"><div class="pnrNoDel">'+data[i].pnr+'</div><div class="IDDel">'+data[i].id+'</div></div><div class="planTitle"><img src="<%=basePath %>console/images/plan2.png" style="width:20px;"/><span style="margin-left:7px; line-height:23px;">机票</span><span style="float:right; color:#FFFFFF;">已支付</span></div><div style="clear:both;"></div><div class="TekMas"><div class="hangban"><span>'+findByCity(data[i].chufCity)+'-'+findByCity(data[i].daodCity)+'</span><span>'+data[i].chufDate+' '+changeType(data[i].chufTime)+'-'+changeType(data[i].daodTime)+'</span><span class="fildNum" style="color:#B5B5B5;">'+findByCode(data[i].hangbanNum.substring(0,2))+' '+data[i].hangbanNum+'</span></div><div class="money"><span>￥'+data[i].costMoney+'</span></div><div style="clear:both;"></div></div><div class="xialaImg" onclick="xiala(this)"><img src="<%=basePath%>console/images/orderTip.png" /></div><div style="clear:both"></div><div class="movement"><a id="gaiqianCode" style="display:none;"></a><a class="exitTel" onclick="exitTel(this)" style="float:right; margin-top:5px; line-height:20px; margin-right:10px;">申请退票</a><a style="clear:both; display:none;"></a></div></li>';
								}
								$("#orderUL").append(orderlist);//全部订单	
								$("#YESpay").append(orderlist);
							}
						}						
						loadjs();
					}else{
						alert("没有找到订单");
					}
				},
				error: function() {					
				}
		});
	});
	
	function xiala(inc){
		if($(inc).children("img").hasClass("intro")){
			$(inc).children("img").removeClass("intro").addClass("intor");
		}else{
			$(inc).children("img").addClass("intro").removeClass("intor");
		}
		$(inc).siblings(".movement").slideToggle();
	}
	
	var num = "";
	function delor(inc){
		$("#alertTitle").text("删除警告");
		$("#commitRes").text("你确定删除该订单吗？");
		$("#pnrBox").text($(inc).parents("li").children(".hiddenClass").children(".pnrNoDel").text());
		$("#uuidBox").text($(inc).parents("li").children(".hiddenClass").children(".IDDel").text());
		$("#ydresuletBox").css("display","block");
		num = "1";
	}
	
	function exitTel(inc){
		$("#alertTitle").text("退票提醒");
		$("#commitRes").text("你确定退掉该订单吗？");
		$("#pnrBox").text($(inc).parents("li").children(".hiddenClass").children(".pnrNoDel").text());
		$("#uuidBox").text($(inc).parents("li").children(".hiddenClass").children(".IDDel").text());
		$("#ydresuletBox").css("display","block");
		num = "2";
	}
	
	function tureBtn(inc){
		var basePathJava = $("#basePathJava").text();
		var pnr = $(inc).siblings("#pnrBox").text();
		var id = $(inc).siblings("#uuidBox").text();
		if(pnr==""||pnr=="null"||pnr==null){
			alert("参数不匹配，删除失败1");
			return false;
		}else if(id==""||id=="null"||id==null){
			alert("参数不匹配，删除失败3");
			return false;
		}else{
			if(num == "1"){
				$("#ydresuletBox").css("display","none");
				$.ajax({
					url:basePathJava+"userOrderController/delete/order.action",
					type:"POST",
					data:{"pnrNo":pnr, "ID":id},
					dataType:"json",
					success:function(res){
						if(res.msg=="1"){
							$.alert("删除成功");
							history.go(0);
						}else{
							$.alert("删除失败");
						}
					},error:function(){
						
					}
				});
			}else{
				$("#ydresuletBox").css("display","none");
				$.ajax({
					url:basePathJava+"userOrderController/signout/order.action",
					type:"POST",
					data:{"pnrNo":pnr, "ID":id},
					dataType:"json",
					success:function(res){	
						$.alert("退票成功，待审核成功之后金额将退回到您的支付账户");
						history.go(0);
					},error:function(){
						
					}
				});
			}
			
		}
	}
	
	function tpStats(num){
		return num=="1"?"退票进行中...":"退票已完成";
	}
	
	function changeType(GoTime){	
		if(4<GoTime.length){
			var firstTime=GoTime.substring(0,2);
			var conterTime=GoTime.substring(2,4);
			var lastTime=GoTime.substring(4,GoTime.length);
			return firstTime+":"+conterTime+"<span style='color:#ff0000; font-size:10px;'>+"+lastTime+"</span>";
		}else{			
			var firstTime=GoTime.substring(0,2);
			var lastTime=GoTime.substring(2,GoTime.length);
			return firstTime+":"+lastTime;
		}
	}
	
	function payNow(inc){
		$.alert("暂未开放支付功能！");	
		return false;
		var uuid = $(inc).parents("li").children(".hiddenClass").children(".IDDel").text().trim();
		var pn_tr = $(inc).parents("li").children(".hiddenClass").children(".pnrNoDel").text().trim();
		var yiwai = $(inc).parents("li").children(".hiddenClass").children(".yiwaiBX").text().trim();
		var yanwu = $(inc).parents("li").children(".hiddenClass").children(".yanwuBX").text().trim();
		var infojson = '{"sign":"0","yawai":"'+yiwai+'","yanwu":"'+yanwu+'","pn_tr":"'+pn_tr+'","uuid":"'+uuid+'"}';
		$.ajax({
				url:"<%=basePath%>wechatController/payCost/orderPay.action",
				type:"POST",
				data:{"subDateJson":infojson},
				dataType:"json",
				success:function(result){
					var obj = result;
					if(obj.state==1){
						WeixinJSBridge.invoke('getBrandWCPayRequest',{
							"appId" : obj.appId, //公众号名称，由商户传入
							"timeStamp" : obj.timeStamp, //时间戳
							"nonceStr" : obj.nonceStr, //随机串
							"package" : obj.wxPackage,//统一支付接口返回的prepay_id 参数值，提交格式如：prepay_id=***
							"signType" : obj.signType, //微信签名方式:sha1
							"paySign" : obj.paySign //微信签名
						},function(res){
							if (res.err_msg == "get_brand_wcpay_request:ok") {

							} else if (res.err_msg == "get_brand_wcpay_request:cancel") {
											
							} else if (res.err_msg == "get_brand_wcpay_request:fail") {
									$.alert("支付失败，请重新下单！");
							}
						});
					} else if(obj.state == 0) {
						$.alert("支付失败！"+obj.msg)
					}
				},
				error:function(result){
				}
			});
	}
	
	function closeBox(){
		$("#ydresuletBox").css("display","none");
	}
	
	//动态加载指定js文件
	function loadjs(){
		var jsElem = document.createElement('script');
		jsElem.src='<%=basePath%>console/js/myPlaneTick.js?sd=91230';
		document.getElementsByTagName('head')[0].appendChild(jsElem);
	}
</script>
</html>
