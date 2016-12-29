<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%
	String id=new String(request.getParameter("id").getBytes("ISO-8859-1"),"utf-8");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>修改常用联系人信息</title>
<link rel="stylesheet" href="<%=basePath %>console/css/waritInforma.css"/>
<link rel="stylesheet" href="<%=basePath %>console/css/normalize3.0.2.min.css" />
<link rel="stylesheet" href="<%=basePath %>console/css/style.css" />
<link rel="stylesheet" href="<%=basePath %>console/css/mobiscroll.css"/>
<link rel="stylesheet" href="<%=basePath %>console/css/mobiscroll_date.css"/>
<link rel="stylesheet" href="<%=basePath%>console/css/weui.min.css" />
<link rel="stylesheet" href="<%=basePath%>console/css/jquery-weui.css" />
<link rel="stylesheet" type="text/css"  href="<%=basePath%>console/css/loading.css" />
<script type="text/javascript" src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script src="<%=basePath %>console/js/mobiscroll_date.js" chatset="utf-8"></script> 
<script src="<%=basePath %>console/js/jquery-weui.js"></script>
<script src="<%=basePath %>console/js/mobiscroll.js"></script> 
<style>
	.writInfoBox{margin-top:0px;} 
	.writInfoBox ul li{line-height:50px;}
	.ChoosClassBox{width:80.5%; height:0px; overflow:hidden; border:1px solid #e1e1e1; position:absolute; top:400px; left:20px; background-color:#FFFFFF; padding:5px 10px; display:none; z-index:1;}
	.ChoosClassBox .ChoosSmallBox{padding:5px; border-bottom:1px solid #e1e1e1;}
	.checkboxA{ border:#C9C9C9 1px solid; background-color:#fff; width:16px; height:16px; display:block; z-index:-1; float:left; border-radius:8px; margin-top:3px;}
	.checkboxB{ background-color:#0079FE; border-radius:4px; width:8px; height:8px; display:block; float:left; margin-left:-11.544px; margin-top:6.599999px; display:none;}
	.btnBox{width:88.55%; margin-left:auto; margin-right:auto; overflow:hidden;}
	.btnBox .aBtn{padding:10px 0px; float:left; width:100%;}
	.btnBox #btnQ{margin-top: 15px; float:right; display: block; padding:10px 0px; background-color:#ccc; border-radius: 5px; color: #FBFDFF; font-size: 12px; text-align: center; width:48%; margin-left: auto; margin-right: auto;}
</style>
<script>
	$(function(){
		//加载数据在表单中
		var id = "<%=id%>";
		if(id!=null||id!="null"||id!=""){
			$.ajax({
				url:"<%=basePath%>userOrderController/loading/loadLinkman.action",
				type:"POST",
				data:{"id":id},
				dataType:"json",
				beforeSend:function(){
					$("#loading").css("display","block");
				},
				complete:function(){$("#loading").css("display","none");},
				success: function(result) {
					var dataList = (result.orderList);
					$("#linkName").val(dataList[0].linkman); 
					$("#linkPhoneNum").val(dataList[0].linkNumber);
					$("#sexIpnt").val(dataList[0].sex);
					$("#birthIpnt").val(dataList[0].birthday);
					$("#personIpnt").val(dataList[0].peopleType);
					$("#caseIpnt").text(dataList[0].caseType);
					$("#IDcase").val(dataList[0].caseNum);
				},error:function(){
					
				}
			});			
		}
		//修改资料的方法
		$(".aBtn").click(function(){
			var linkName = $("#linkName").val();
			var linkPhoneNum = $("#linkPhoneNum").val();
			var sexIpnt = $("#sexIpnt").val();
			var birthIpnt = $("#birthIpnt").val();
			var personIpnt = $("#personIpnt").val();
			var caseIpnt = $("#caseIpnt").text().trim();
			var IDcase = $("#IDcase").val();
			$.ajax({ 
				url:"<%=basePath%>userOrderController/update/updateLinkman.action",
				type:"POST",
				data:{
					"id":id,
					"linkName":linkName,
					"linkPhoneNum":linkPhoneNum,
					"sexIpnt":sexIpnt,
					"birthIpnt":birthIpnt,
					"personIpnt":personIpnt,
					"caseIpnt":caseIpnt,
					"IDcase":IDcase
				},
				dataType:"json",
				success: function(result) {
					if(result.msg==1){
						window.location.href="<%=basePath %>console/wechat/linkman.jsp";
					}else{
						$.alert("修改失败");
					}
				},error:function(){
				
				}
			});		
		});
		
		//性别选择
		$("#sexIpnt").click(function(){
				var top = $(this).offset().top;
				var left = $(this).offset().left;
				$("#sexType").css("top",top+25);
				$("#sexType").css("left",left-45);
				$("#sexType").css("display","block");
				$("#sexType").animate({height:"70px"},250);
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
				$("#personType").animate({height:"100px"},250);
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
				$("#CaseType").animate({height:"100px"},250);
		});
		
		$(".caseBoxCH").click(function(){
				$(this).text();	
				$("#caseIpnt").text($(this).text());
				$("#CaseType").animate({height:"0px"},250);
				var t  = setTimeout(function(){$("#CaseType").css("display","none")},250);
		})
	});
	
</script>
</head>

<body>
<div class="writInfoBox">
	<ul>
		<li><span class="spanTit">联系人：</span><input id="linkName" type="text"/></li>
		<li><span class="spanTit">联系人电话：</span><input id="linkPhoneNum" type="text"/></li>
		<li><span class="spanTit">性别：</span><input type="text" id="sexIpnt" readonly="readonly"/><span style="float:right; margin-top:12px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span></li>
		<li><span class="spanTit">出生日期：</span><input type="text" id="birthIpnt" readonly="readonly"/><span style="float:right; margin-top:10px;"><img src="<%=basePath %>console/images/riliImg.png" style="width:15px;"/></span></li>
		<li><span class="spanTit">旅客类型：</span><input type="text" id="personIpnt" readonly="readonly"/><span style="float:right; margin-top:12px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span></li>
		<li><span class="spanTit" id="caseIpnt">证件类型</span><span><img src="<%=basePath %>console/images/xialaPonting.png" style="padding-top:4px;"/></span><input id="IDcase" type="text" placeholder="请输入证件号码"/></li>
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
	<div style="clear:both;"></div>
</div>
<!--证件类型-->
<div class="ChoosClassBox" id="CaseType" style="width:30%;">
	<div class="ChoosSmallBox caseBoxCH">身份证</div>
	<div class="ChoosSmallBox caseBoxCH">护照</div>
	<div class="ChoosSmallBox caseBoxCH" style="border:none;">其他</div>
	<div style="clear:both;"></div>
</div>
<div class="btnBox"><a class="aBtn">确定修改</a></div>

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
</body>
</html>
