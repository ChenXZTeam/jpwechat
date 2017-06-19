<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%
	String orderNum=new String(request.getParameter("orderNum").getBytes("ISO-8859-1"),"utf-8");
	String pnrNo=new String(request.getParameter("pnrNo").getBytes("ISO-8859-1"),"utf-8");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>修改乘机人信息</title>
<link rel="stylesheet" href="<%=basePath %>console/css/waritInforma.css?time=201161"/>
<link rel="stylesheet" href="<%=basePath %>console/css/normalize3.0.2.min.css" />
<link rel="stylesheet" href="<%=basePath%>console/css/weui.min.css" />
<link rel="stylesheet" href="<%=basePath%>console/css/jquery-weui.css" />
<link rel="stylesheet" href="<%=basePath %>console/css/style.css?time=2016" />
<link rel="stylesheet" href="<%=basePath%>scripts/common/weui/css/weui.css" />
<link rel="stylesheet" href="<%=basePath %>console/css/mobiscroll.css"/>
<link rel="stylesheet" href="<%=basePath %>console/css/mobiscroll_date.css"/>
<link rel="stylesheet" type="text/css"  href="<%=basePath%>console/css/loading.css"/>
<script type="text/javascript" src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script src="<%=basePath %>console/js/mobiscroll_date.js"></script> 
<script src="<%=basePath %>console/js/mobiscroll.js"></script> 
<script src="<%=basePath %>console/js/jquery-weui.js"></script>
<script src="<%=basePath %>scripts/common/weui/js/zepto.min.js"></script>
<script src="<%=basePath %>console/js/airCodeVScity.js"></script>
<style>
	.writInfoBox{margin-top:0px;}
	.writInfoBox ul li{line-height:50px;}
	.ChoosClassBox{width:80.5%; height:0px; overflow:hidden; border:1px solid #e1e1e1; position:absolute; top:400px; left:20px; background-color:#FFFFFF; padding:5px 10px; display:none; z-index:1;}
	.ChoosClassBox .ChoosSmallBox{padding:5px; border-bottom:1px solid #e1e1e1;}
	.checkboxA{ border:#C9C9C9 1px solid; background-color:#fff; width:16px; height:16px; display:block; z-index:-1; float:left; border-radius:8px; margin-top:3px;}
	.checkboxB{ background-color:#0079FE; border-radius:4px; width:8px; height:8px; display:block; float:left; margin-left:-11.544px; margin-top:6.599999px; display:none;}
	.btnBox{width:88.55%; margin-left:auto; margin-right:auto; overflow:hidden;}
	.btnBox .aBtn{float:left; width:48%;}
	.btnBox #btnQ{margin-top: 15px; float:right; display: block; padding:10px 0px; background-color:#ccc; border-radius: 5px; color: #FBFDFF; font-size: 12px; text-align: center; width:48%; margin-left: auto; margin-right: auto;}
</style>
<script>
	$(function(){
		//加载数据在表单中
		var orderNum = "<%=orderNum%>";
		var orgDateTime = "";
		if(orderNum!=null||orderNum!="null"||orderNum!=""){
			$.ajax({
				url:"<%=basePath%>userOrderController/loading/userMsg.action",
				type:"POST",
				data:{"orderNum":orderNum},
				dataType:"json",
				beforeSend:function(){
					$("#loading").css("display","block");
				},
				complete:function(){$("#loading").css("display","none");},
				success: function(result) {
					var dataList = (result.orderList)[0];
					console.log(dataList);
					$("#linkName").val(dataList.linkName); //乘机人
					$("#birthIpnt").val(dataList.birthday);	//生日
					$("#IDcase").val(dataList.idcase);//证件号码
					$("#sexIpnt").val(sourceSex(1,dataList.linkSex));//性别
					$("#caseIpnt").text(sourceSex(3,dataList.idcaseType));//证件类型
					$("#personIpnt").text(dataList.psgType);
					orgDateTime = dataList.chufDate;
				},error:function(){
					
				}
			});			
		}

		//初始化日期选择控件
		var currYear = (new Date()).getFullYear();	
		var opt={};
		opt.date = {preset : 'date'};
		opt.datetime = {preset : 'datetime'};
		opt.time = {preset : 'time'};
		opt.defaults = {
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
		$("#birthIpnt").mobiscroll($.extend(opt['date'], opt['defaults']));
		
		//修改资料的方法
		$(".aBtn").click(function(){
			var orderNum = "<%=orderNum%>";
			var pnrNo = "<%=pnrNo%>";
			var username = $("#linkName").val();
			var usergender = $("#sexIpntSource").text();
			var userBirth = $("#birthIpnt").val();
			var userage = ageFunc(userBirth,orgDateTime);
			var usertype = $("#personIpnt").val();
			var userIDnum = $("#IDcase").val();
			var userIDtype = $("#caseIpntSource").text();
			var usertype = $("#personIpnt").text();
			console.log(orderNum+"/"+pnrNo+"/"+username+"/"+userage+"/"+usergender+"/"+userBirth+"/"+usertype+"/"+userIDnum+"/"+userIDtype);
			$.ajax({ 
				url:"<%=basePath%>framework/order/upTelkMen.action",
				type:"POST",
				data:{
					"id":orderNum,
					"pnr":pnrNo,
					"linkName":username,
					"age":userage,
					"linkSex":usergender,
					"birthday":userBirth,
					"psgType":usertype,
					"idcase":userIDnum,
					"idcaseType":userIDtype
				},
				dataType:"json",
				success: function(result) {
					if(result.msg==1){
						alert("修改成功");
						window.location.href="<%=basePath %>console/wechat/myPlaneTickek.jsp";
					}else{
						alert("修改失败");
					}
				},error:function(){
				
				}
			});		
		});
		
		$("#sexIpnt").on('click',function (){  
	        weui.picker([{
							label:'先生', 
	            			value:'F'
	        		   },{  
	        		   		label:'女士',
	            			value:'M'
	        		   }],{  
	            			onChange: function (result) {  
	                			//改变函数
	            			},  
	            			onConfirm: function (result) {  
								$("#sexIpntSource").text(result); 
								$("#sexIpnt").val(sourceSex(1,result));
	            			}  
	        	});  
    	});
    	
    	$("#personIpnt").on('click',function (){  
	        weui.picker([{
							label:'成人', 
	            			value:'ADT'
	        		   },{  
	        		   		label:'儿童',
	            			value:'CHD'
	        		   },{  
	        		   		label:'婴儿',
	            			value:'INF'
	        		   }],{  
	            			onChange: function (result) {  
	                			//改变函数
	            			},  
	            			onConfirm: function (result) {  
								$("#personIpntSource").text(result); 
								$("#personIpnt").val(sourceSex(2,result)); 
	            			}  
	        	});  
    	});
		
		$("#caseIpnt").on('click',function (){  
	        weui.picker([{
							label:'身份证', 
	            			value:'NI'
	        		   },{  
	        		   		label:'护照',
	            			value:'PP'
	        		   },{  
	        		   		label:'其他',
	            			value:'ID' 
	        		   }],{  
	            			onChange: function (result) {  
	                			//改变函数
	            			},  
	            			onConfirm: function (result) {  
								$("#caseIpnt").text(sourceSex(3,result)); 
								$("#caseIpntSource").text(result); 
	            			}  
	        	});  
    	});
		
		//取消修改的按钮
		$("#btnQ").click(function(){
			window.location.href="<%=basePath %>console/wechat/myPlaneTickek.jsp";
		});
	});
	//对生日进行拆分求出年龄
	function ageFunc(strBirthday,goDate){
	    var returnAge;  
	    var strBirthdayArr=strBirthday.split("-");  
	    var birthYear = strBirthdayArr[0];  
	    var birthMonth = strBirthdayArr[1];  
	    var birthDay = strBirthdayArr[2];  
	      
	    d = new Date(goDate);  
	    var nowYear = d.getFullYear();  
	    var nowMonth = d.getMonth() + 1;  
	    var nowDay = d.getDate();  
	      
	    if(nowYear == birthYear){  
	        returnAge = 0;//同年 则为0岁  
	    }  
	    else{  
	        var ageDiff = nowYear - birthYear ; //年之差  
	        if(ageDiff > 0){  
	            if(nowMonth == birthMonth){  
	                var dayDiff = nowDay - birthDay;//日之差  
	                if(dayDiff < 0){  
	                    returnAge = ageDiff - 1;  
	                }  
	                else{  
	                    returnAge = ageDiff ;  
	                }  
	            }  
	            else{  
	                var monthDiff = nowMonth - birthMonth;//月之差  
	                if(monthDiff < 0){  
	                    returnAge = ageDiff - 1;  
	                }  
	                else{  
	                    returnAge = ageDiff ;  
	                }  
	            }  
	        }  
	        else{  
	            returnAge = -1;//返回-1 表示出生日期输入错误 晚于今天  
	        }  
	    }  
	    return returnAge;//返回周岁年龄  
	}
	
	function sourceSex(num,val){
		var value = "";
		if(num==1){
			if(val=="F"){
				value = "先生";
			}else if(val=="M"){
				value = "女士";
			}
		}else if(num==2){
			if(val=="ADT"){
				value = "成人";
			}else if(val=="CHD"){
				value = "儿童";
			}else if(val=="INF"){
				value = "婴儿";
			}
		}else if(num==3){
			if(val=="NI"){
				value = "身份证";
			}else if(val=="PP"){
				value = "护照";
			}else if(val=="ID"){
				value = "其他证件";
			}
		}
		return value;
	}
</script>
</head>

<body>
<div class="writInfoBox">
	<ul>
		<li><span class="spanTit">姓名：</span><input id="linkName" type="text"/></li>
		<li id="sexBox"><span class="spanTit">性别：</span><input type="text" id="sexIpnt" readonly="readonly" value="先生"/><span id="sexIpntSource" style="display:none;">男</span><span style="float:right; margin-top:18px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span></li>
		<li id="birthdayBox"><span class="spanTit">出生日期：</span><input type="text" id="birthIpnt" readonly="readonly"/><span style="float:right; margin-top:17px;"><img src="<%=basePath %>console/images/riliImg.png" style="width:15px;"/></span></li>
		<%-- <li><span class="spanTit">旅客类型：</span><input type="hidden" id="m"/><input type="text" id="personIpnt" readonly="readonly"/><span id="personIpntSource" style="display:none;"></span><span style="float:right; margin-top:18px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span></li> --%>
		<li style="border:none;"><span class="spanTit" id="caseIpnt">身份证</span><span id="caseIpntSource" style="display:none;">NI</span><span><img src="<%=basePath %>console/images/xialaPonting.png" style="padding-top:4px;"/></span><input id="IDcase" type="text" placeholder="请输入证件号码"/></li>
		<li style="display:none;"><span id="personIpnt"></span></li>
	</ul>
</div>
<div class="btnBox"><a class="aBtn">确定修改</a><a id="btnQ">取消</a></div>


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
</body>
<script src="<%=basePath%>scripts/common/weui/js/weui.min.js"></script>
</html>
