<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>新建常用联系人信息</title>
<link rel="stylesheet" href="<%=basePath %>console/css/waritInforma.css"/>
<link rel="stylesheet" href="<%=basePath %>console/css/normalize3.0.2.min.css" />
<link rel="stylesheet" href="<%=basePath %>console/css/mobiscroll.css"/>
<link rel="stylesheet" href="<%=basePath %>console/css/mobiscroll_date.css"/>
<link rel="stylesheet" href="<%=basePath%>console/css/weui.min.css" />
<link rel="stylesheet" href="<%=basePath%>scripts/common/weui/css/weui.css" />
<link rel="stylesheet" href="<%=basePath%>console/css/jquery-weui.css" />
<link rel="stylesheet" type="text/css"  href="<%=basePath%>console/css/loading.css" />
<script type="text/javascript" src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script src="<%=basePath %>console/js/mobiscroll_date.js" chatset="utf-8"></script> 
<script src="<%=basePath %>console/js/jquery-weui.js"></script>
<script src="<%=basePath %>scripts/common/weui/js/zepto.min.js"></script>
<script src="<%=basePath %>console/js/mobiscroll.js"></script> 
<style>
	.writInfoBox{margin-top:0px;}
	.writInfoBox ul li{line-height:50px;}
	.ChoosClassBox{width:80.5%; height:0px; overflow:hidden; border:1px solid #e1e1e1; position:absolute; top:400px; left:20px; background-color:#FFFFFF; padding:5px 10px; display:none; z-index:1;}
	.ChoosClassBox .ChoosSmallBox{padding:5px; border-bottom:1px solid #e1e1e1;}
	.checkboxA{ border:#C9C9C9 1px solid; background-color:#fff; width:16px; height:16px; display:block; z-index:-1; float:left; border-radius:8px; margin-top:3px;}
	.checkboxB{ background-color:#0079FE; border-radius:4px; width:8px; height:8px; display:block; float:left; margin-left:-11.544px; margin-top:6.599999px; display:none;}
	.btnBox{width:88.55%; margin-left:auto; margin-right:auto; overflow:hidden;}
	.btnBox .aBtn{padding:10px 0px; float:right; width:48%;font-size:15px; line-height:25px; height:24px;}
	.btnBox #btnQ{margin-top: 15px; float:left; display: block; padding:10px 0px; background-color:#ccc; border-radius: 5px; color: #FBFDFF; font-size: 15px; text-align: center; width:48%; margin-left: auto; margin-right: auto;}
</style>
<script>
$(function(){ 
		//保存联系人的方法
		$(".aBtn").click(function(){
			var linkName = $("#linkName").val();
			var linkPhoneNum = $("#linkPhoneNum").val();
			var sexIpnt = $("#sexIpnt").val();
			var birthIpnt = $("#birthIpnt").val();
			var personIpnt = $("#personIpnt").val();
			var caseIpnt = $("#caseIpnt").text().trim();
			var IDcase = $("#IDcase").val();

			$.ajax({ 
				url:"<%=basePath%>userOrderController/add/addLinkman.action",
				type:"POST",
				data:{
					"linkName":linkName,
					"linkPhoneNum":linkPhoneNum,
					"sexIpnt":sexIpnt,
					"birthIpnt":birthIpnt,
					"personIpnt":personIpnt,
					"caseIpnt":caseIpnt,
					"IDcase":IDcase
				},
				dataType:"json",
				success: function(data) {
					if(data.msg==1){
						window.location.href="<%=basePath %>console/wechat/linkman.jsp";
					}else{
						$.alert("保存失败");
					}
				},error:function(){
				
				}
			});		
		});
		
		//取消保存的按钮
		$("#btnQ").click(function(){
			window.location.href="<%=basePath %>console/wechat/linkman.jsp";
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
    	
    	$("#personIpnt").on('click',function (){  
	        weui.picker([{
							label:'成人', 
	            			value:'成人'
	        		   },{  
	        		   		label:'儿童',
	            			value:'儿童'
	        		   },{  
	        		   		label:'婴儿',
	            			value:'婴儿'
	        		   }],{  
	            			onChange: function (result) {  
	                			//改变函数
	            			},  
	            			onConfirm: function (result) {  
								$("#personIpnt").val(result); 
	            			}  
	        	});  
    	});
		
		$("#caseIpnt").on('click',function (){  
	        weui.picker([{
							label:'身份证', 
	            			value:'身份证'
	        		   },{  
	        		   		label:'护照',
	            			value:'护照'
	        		   },{  
	        		   		label:'其他',
	            			value:'其他' 
	        		   }],{  
	            			onChange: function (result) {  
	                			//改变函数
	            			},  
	            			onConfirm: function (result) {  
								$("#caseIpnt").text(result); 
	            			}  
	        	});  
    	});
		
	});
</script>
</head>

<body>
<div class="writInfoBox">
	<ul>
		<li><span class="spanTit">联系人：</span><input id="linkName" type="text"/></li>
		<li><span class="spanTit">联系人电话：</span><input id="linkPhoneNum" type="text"/></li>
		<li><span class="spanTit">性别：</span><input type="text" id="sexIpnt" readonly="readonly"/><span style="float:right; margin-top:18px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span></li>
		<li><span class="spanTit">出生日期：</span><input type="text" id="birthIpnt" readonly="readonly"/><span style="float:right; margin-top:17px;"><img src="<%=basePath %>console/images/riliImg.png" style="width:15px;"/></span></li>
		<li><span class="spanTit">旅客类型：</span><input type="text" id="personIpnt" readonly="readonly"/><span style="float:right; margin-top:18px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span></li>
		<li><span class="spanTit" id="caseIpnt">证件类型</span><span><img src="<%=basePath %>console/images/xialaPonting.png" style="padding-top:4px;"/></span><input id="IDcase" type="text" placeholder="请输入证件号码"/></li>
	</ul>
</div>
<div class="btnBox"><a id="btnQ">取消</a><a class="aBtn">保存</a></div>

<script>
	$(function () {
	var currYear = (new Date()).getFullYear();	
	var opt={};
	opt.date = {preset : 'date'};
	opt.datetime = {preset : 'datetime'};
	opt.time = {preset : 'time'};
	opt.default = {
		theme: 'android-ics light', //皮肤样式
		display: 'modal', //显示方式 
		mode: 'scroller', //日期选择模式
		dateFormat: 'yyyy-mm-dd',
		lang: 'zh',
		showNow: false,
		nowText: "今天",
		startYear: currYear - 50, //开始年份
		endYear: currYear + 10 //结束年份
	};
	
	$("#birthIpnt").mobiscroll($.extend(opt['date'], opt['default']));
});
</script>
<script src="<%=basePath %>scripts/common/weui/js/weui.min.js"></script>
</body>
</html>
