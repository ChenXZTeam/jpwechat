<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%
	String payTry = new String(request.getParameter("payTry").getBytes("ISO-8859-1"),"utf-8");
	String countryName = new String(request.getParameter("countryName").getBytes("ISO-8859-1"),"utf-8");
	String countryId = new String(request.getParameter("countryId").getBytes("ISO-8859-1"),"utf-8");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.maximum-scale=1,user-scalable=no"/>
<title>申请签证</title>
<link rel="stylesheet" href="<%=basePath %>console/css/qz_waritInfo.css?time=90"/>
<link rel="stylesheet" href="<%=basePath%>console/css/weui.min.css" />
<link rel="stylesheet" href="<%=basePath%>scripts/common/weui/css/weui.css" />
<link rel="stylesheet" href="<%=basePath%>console/css/jquery-weui.css" />
<script type="text/javascript" src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script src="<%=basePath %>console/js/jquery-weui.js"></script>
<style>
	.chooseBox{position:absolute; top:0px; left:0px; padding:0px; margin:0px;width:88.55%; display:none;}
	.chooseBox ul{list-style-type:none; padding:0px 10px; background-color:#FFF; margin:0px; border:1px solid #e1e1e1;}
	.chooseBox ul li{border-bottom:1px solid #e1e1e1; line-height:35px;}
	.chooseBox ul li:last-child{ border:none;}
	#qztrueBtn{display:block; width:88.55%; margin:10px auto 0 auto; background-color:#007AFF; font-size:16px; padding:10px 0; text-align:center; color:#FFFFFF; border-radius:5px;}
</style>
</head>
<body>
<div class="writInfoBox">
	<ul>
		<li><span class="spanTit">姓名：</span><input id="linkName" type="text"/></li>
		<li><span class="spanTit">客户类型：</span><input type="text" id="personWorkIpnt" readonly="readonly"/><span style="float:right; margin-top:18px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span></li>
		<li><span class="spanTit">性别：</span><input type="text" id="sexIpnt" readonly="readonly"/><span style="float:right; margin-top:18px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span></li>
		<li><span class="spanTit">手机号：</span><input id="phoneNum" type="text"/></li>
		<li><span class="spanTit">电子邮件：</span><input id="EmailAdd" type="text"/></li>
		<li><span class="spanTit">旅客类型：</span><input type="text" id="trayTypeIpnt" readonly="readonly"/><span style="float:right; margin-top:18px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span></li>
		<li><span class="spanTit">身份证：</span><input id="IDcase" type="text" placeholder="请输入证件号码"/></li>
		<li><span class="spanTit" id="songTypeIpnt">配送方式</span><span><img src="<%=basePath %>console/images/xialaPonting.png" style="padding-top:6px;"/></span><input id="sondAdd" type="text" placeholder="请输入配送地址"/></li>	
	</ul>
</div>

<a id="qztrueBtn">提交申请</a>

<script>
	$(function(){
		$("#qztrueBtn").click(function(){
			var linkName = $("#linkName").val();//申请人
			var personWorkIpnt = $("#personWorkIpnt").val();//客户类型
			var sexIpnt = $("#sexIpnt").val();//性别
			var phoneNum = $("#phoneNum").val();//手机号码
			var EmailAdd = $("#EmailAdd").val();//电子邮件
			var trayTypeIpnt = $("#trayTypeIpnt").val();//旅客类型
			var IDcase = $("#IDcase").val();//身份证号
			var songTypeIpnt = $("#songTypeIpnt").text();//配送方式
			var sondAdd = $("#sondAdd").val();//配送地址
			var payTry = "<%=payTry%>";
			var countryName = "<%=countryName%>";
			var countryIdNum = "<%=countryId%>";
			var dataList = {
				"linkName":linkName,
				"personWorkIpnt":personWorkIpnt,
				"sexIpnt":sexIpnt,
				"phoneNum":phoneNum,
				"EmailAdd":EmailAdd,
				"trayTypeIpnt":trayTypeIpnt,
				"IDcase":IDcase,
				"songTypeIpnt":songTypeIpnt,
				"sondAdd":sondAdd,
				"payTry":payTry,
				"countryName":countryName,
				"countryIdNum":countryIdNum
			}
			$.ajax({
				url:"<%=basePath%>framework/visa/addVisaOrder.action",
				type:"post",
				data:dataList,
				dataType:"json",
				success:function(res){
					if(res.msg==1){
						$.alert("您的签证订单已生成成功");
					}else{
						$.alert("订单生成失败，请稍后再试");
					}
				},
				error:function(res){
				}
			});
		});
		
		
		$("#sexIpnt").on('click',function (){  
	        weui.picker([{
							label:'先生', 
	            			value:'先生'
	        		   },{  
	        		   		label:'女士',
	            			value:'女士'
	        		   }],{  
	            			onChange: function (result) {  
	                			//改变函数
	            			},  
	            			onConfirm: function (result) {  
								$("#sexIpnt").val(result); 
	            			}  
	        	});  
    	});
    	
    	$("#personWorkIpnt").on('click',function (){  
	        weui.picker([{
							label:'在职', 
	            			value:'在职'
	        		   },{  
	        		   		label:'自由职业',
	            			value:'自由职业'
	        		   },{  
	        		   		label:'退休',
	            			value:'退休'
	        		   },{  
	        		   		label:'在校学生',
	            			value:'在校学生'
	        		   },{  
	        		   		label:'学龄儿童',
	            			value:'学龄儿童'
	        		   }],{  
	            			onChange: function (result) {  
	                			//改变函数
	            			},  
	            			onConfirm: function (result) {  
								$("#personWorkIpnt").val(result); 
	            			}  
	        	});  
    	});
		
		$("#trayTypeIpnt").on('click',function (){  
	        weui.picker([{  
	        		   		label:'成人',
	            			value:'成人'
	        		   },{
							label:'儿童', 
	            			value:'儿童'
	        		   }],{  
	            			onChange: function (result) {  
	                			//改变函数
	            			},  
	            			onConfirm: function (result) {  
								$("#trayTypeIpnt").val(result); 
	            			}  
	        	});  
    	});
    	
    	$("#songTypeIpnt").on('click',function (){  
	        weui.picker([{  
	        		   		label:'送货上门',
	            			value:'送货上门'
	        		   }],{  
	            			onChange: function (result) {  
	                			//改变函数
	            			},  
	            			onConfirm: function (result) {  
								$("#songTypeIpnt").text(result); 
	            			}  
	        	});  
    	});
	});
</script>
<script src="<%=basePath %>scripts/common/weui/js/weui.min.js"></script>
</body>
</html>