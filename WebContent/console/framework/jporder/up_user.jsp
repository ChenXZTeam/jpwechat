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
<link rel="stylesheet" href="<%=basePath %>console/css/waritInforma.css"/>
<link rel="stylesheet" href="<%=basePath %>console/css/normalize3.0.2.min.css" />
<link rel="stylesheet" href="<%=basePath %>console/css/style.css" />
<link rel="stylesheet" href="<%=basePath %>console/css/mobiscroll.css"/>
<link rel="stylesheet" href="<%=basePath %>console/css/mobiscroll_date.css"/>
<link rel="stylesheet" type="text/css"  href="<%=basePath%>console/css/loading.css" />
<script type="text/javascript" src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<%-- <script type="text/javascript" src="<%=basePath %>console/js/waritInforma.js"></script> --%>
<script src="<%=basePath %>console/js/mobiscroll_date.js" chatset="utf-8"></script> 
<script src="<%=basePath %>console/js/mobiscroll.js"></script> 
<style>
	body{font-size:15px; background-color:#fff;}
	.writInfoBox{margin-top:0px;}
	.writInfoBox ul li{line-height:50px;}
	.ChoosClassBox{width:80.5%; height:0px; overflow:hidden; border:1px solid #e1e1e1; position:absolute; top:400px; left:20px; background-color:#FFFFFF; padding:5px 10px; display:none; z-index:1;}
	.ChoosClassBox .ChoosSmallBox{padding:10px; border-bottom:1px solid #e1e1e1; cursor:pointer;}
	.checkboxA{ border:#C9C9C9 1px solid; background-color:#fff; width:16px; height:16px; display:block; z-index:-1; float:left; border-radius:8px; margin-top:3px;}
	.checkboxB{ background-color:#0079FE; border-radius:4px; width:8px; height:8px; display:block; float:left; margin-left:-11.544px; margin-top:6.599999px; display:none;}
	.btnBox{margin-left:0px; overflow:hidden; margin-left:20px;} 
	.btnBox .aBtn{padding:10px 0px; float:left; width:100px; font-size: 14px;} 
	.btnBox #btnQ{margin-top: 15px; float:left; display: block; padding:10px 0px; background-color:#aaa; border-radius: 5px; color: #FBFDFF; font-size: 14px; text-align: center; width:100px; margin-left:20px; margin-right: auto;}
</style>
<script>
	$(function(){
		//加载数据在表单中
		var orderNum = "<%=orderNum%>";
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
					$("#linkName").val(dataList.linkName); //乘机人
					$("#birthIpnt").val(dataList.birthday);	//生日
					var psgTypeJs = ""; //乘机人类型
					if(dataList.psgType=="CHD"){
						psgTypeJs = "儿童";
					}else if(dataList.psgType=="INF"){
						psgTypeJs = "婴儿";
					}else{
						psgTypeJs = "成人";
					}
					$("#personIpnt").val(psgTypeJs);	//乘机人类型
					$("#IDcase").val(dataList.idcase);//证件号码
					$("#sexIpnt").val(dataList.linkSex);//性别
					var idcaseTypeJs = ""; //证件类型
					if(dataList.idcaseType=="ID"){
						idcaseTypeJs = "其他证件";
					}else if(dataList.idcaseType=="PP"){
						idcaseTypeJs = "护照";
					}else{
						idcaseTypeJs = "身份证";
					}
					$("#caseIpnt").text(idcaseTypeJs);//证件类型
				},error:function(){
					
				}
			});			
		}
		//判断是否选择了证件类型
		$("#IDcase").focus(function(){
			if($("#caseIpnt").text()=="证件类型"){
				alert("请选择证件类型");
				$("#IDcase").blur();
				return false;
			}
		});
		//初始化日期选择控件
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
		
		//修改资料的方法
		$(".aBtn").click(function(){
			var orderNum = "<%=orderNum%>";
			var pnrNo = "<%=pnrNo%>";
			var username = $("#linkName").val();
			var usergender = $("#sexIpnt").val();
			var userBirth = $("#birthIpnt").val();
			var userage = ageFunc(userBirth);
			var usertype = $("#personIpnt").val();
			var userIDnum = $("#IDcase").val();
			var userIDtype = $("#caseIpnt").text();			
			/* if(userage==""||userage==null){
				alert("请填写年龄格式：19");
				return false;
			} */
			/* if(userBirth==""||userBirth==null){
				alert("请填写生日格式：1993-05-03");
				return false;
			} */
			console.log(orderNum+"/"+pnrNo+"/"+username+"/"+userage+"/"+usergender+"/"+userBirth+"/"+usertype+"/"+userIDnum+"/"+userIDtype);
			$.ajax({ 
				url:"<%=basePath%>userOrderController/update/changeCertificate.action",
				type:"POST",
				data:{
					"orderNum":orderNum,
					"pnrNo":pnrNo,
					"username":username,
					"userage":userage,
					"usergender":usergender,
					"userBirth":userBirth,
					"usertype":usertype,
					"userIDnum":userIDnum,
					"userIDtype":userIDtype
				},
				dataType:"json",
				success: function(result) {
					if(result.msg==1){
						alert("修改成功");
						window.location.href="<%=basePath %>console/framework/jporder/index.jsp";
					}else{
						alert("修改失败");
					}
				},error:function(){
				
				}
			});		
		});
		
		//取消修改的按钮
		$("#btnQ").click(function(){
			window.location.href="<%=basePath %>console/framework/jporder/index.jsp";
		});
		
		//性别选择
		$("#sexIpnt").click(function(){
				var top = $(this).offset().top;
				var left = $(this).offset().left;
				$("#sexType").css("top",top+25);
				$("#sexType").css("left",left-45);
				$("#sexType").css("display","block");
				$("#sexType").animate({height:"80px"},250);
		});
		
		$(".sexBoxCH").click(function(){
				$(this).text();	
				$("#sexIpnt").val($(this).text());
				$("#sexType").animate({height:"0px"},250);
				var t  = setTimeout(function(){$("#sexType").css("display","none")},250);
		})
		
		//旅客选择
		$("#personIpnt").click(function(){
				var top = $(this).offset().top;
				var left = $(this).offset().left;
				$("#personType").css("top",top+25);
				$("#personType").css("left",left-70);
				$("#personType").css("display","block");
				$("#personType").animate({height:"120px"},250);
		});
		
		$(".persBoxCH").click(function(){
				$(this).text();	
				$("#personIpnt").val($(this).text());
				$("#personType").animate({height:"0px"},250);
				var t  = setTimeout(function(){$("#personType").css("display","none")},250);
		})
		
		
		//证件选择
		$("#caseIpnt").click(function(){
				var top = $(this).offset().top;
				var left = $(this).offset().left;
				$("#CaseType").css("top",top+25);
				$("#CaseType").css("left",left);
				$("#CaseType").css("display","block");
				$("#CaseType").animate({height:"79px"},250);
		});
		
		$(".caseBoxCH").click(function(){
				$(this).text();	
				$("#caseIpnt").text($(this).text());
				$("#CaseType").animate({height:"0px"},250);
				var t  = setTimeout(function(){$("#CaseType").css("display","none")},250);
		})
	});
	//对生日进行拆分求出年龄
	function ageFunc(birthday){
		var age = 0;
		var birth = birthday.split("-");	//对生日进行拆分
		var today=new Date();				//创建今天的日期
	    var todayYear=today.getFullYear();	//今天的年
	    var ageNum = todayYear*1 - birth[0]*1;
	    if(ageNum > 0){
	    	age = ageNum;
	    }else{
	    	alert("年龄选择错误，请重新选择！");
	    	return false;
	    }
		return age;
	}
</script>
</head>

<body>
<div class="writInfoBox">
	<ul>
		<li>
			<span class="spanTit">姓名：</span>
			<input id="linkName" type="text"/>
		</li>
		<li>
			<span class="spanTit">性别：</span>
			<input type="text" id="sexIpnt" readonly="readonly" style="cursor:pointer;"/>
			<span style="float:right; margin-top:18px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span>
		</li>
		<li>
			<span class="spanTit">出生日期：</span>
			<input type="text" id="birthIpnt" readonly="readonly"/>
			<span style="float:right; margin-top:18px;"><img src="<%=basePath %>console/images/riliImg.png" style="width:15px;"/></span>
		</li>
		<li>
			<span class="spanTit">旅客类型：</span>
			<input type="text" id="personIpnt" readonly="readonly" style="cursor:pointer;"/>
			<span style="float:right; margin-top:18px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span>
		</li>
		<li>
			<span class="spanTit" id="caseIpnt" style="cursor:pointer;">证件类型</span>
			<span><img src="<%=basePath %>console/images/xialaPonting.png" style="padding-top:5px;"/></span>
			<input id="IDcase" type="text"/>
		</li>
	</ul>
</div>
<!--性别选择-->
<div class="ChoosClassBox" id="sexType">
	<div class="ChoosSmallBox sexBoxCH">男</div>
	<div class="ChoosSmallBox sexBoxCH" style="border:none;">女</div>
	<div style="clear:both;"></div>
</div>
<!--旅客类型-->
<div class="ChoosClassBox" id="personType">
	<div class="ChoosSmallBox persBoxCH">成人</div>
	<div class="ChoosSmallBox persBoxCH">儿童</div>
	<div class="ChoosSmallBox persBoxCH" style="border:none;">婴儿</div>	
	<input type="hidden" id="orderNum" value="<%=orderNum%>"/>
	<input type="hidden" id="pnrNo" value="<%=pnrNo%>"/>
	<div style="clear:both;"></div>
</div>
<!--证件类型-->
<div class="ChoosClassBox" id="CaseType" style="width:30%;">
	<div class="ChoosSmallBox caseBoxCH">身份证</div>
	<div class="ChoosSmallBox caseBoxCH">护照</div>
	<div class="ChoosSmallBox caseBoxCH" style="border:none;">其他</div>
	<div style="clear:both;"></div>
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
</html>
