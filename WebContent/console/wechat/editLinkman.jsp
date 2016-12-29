<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%
	String id=new String(request.getParameter("id").getBytes("ISO-8859-1"),"utf-8");
	String linkName=new String(request.getParameter("linkName").getBytes("ISO-8859-1"),"utf-8");
	String linkPhoneNum=new String(request.getParameter("linkPhoneNum").getBytes("ISO-8859-1"),"utf-8");
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
<script type="text/javascript" src="<%=basePath %>console/js/waritInforma.js"></script>
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
	.btnBox .aBtn{padding:10px 0px; float:left; width:48%;}
	.btnBox #btnQ{margin-top: 15px; float:right; display: block; padding:10px 0px; background-color:#ccc; border-radius: 5px; color: #FBFDFF; font-size: 12px; text-align: center; width:48%; margin-left: auto; margin-right: auto;}
</style>
<script>
	$(function(){
		//加载数据在表单中
		var linkName = "<%=linkName%>";
		var linkPhoneNum = "<%=linkPhoneNum%>";
		if(linkName!=null||linkName!="null"||linkName!=""){
			$.ajax({
				url:"<%=basePath%>userOrderController/loading/loadLinkman.action",
				type:"POST",
				data:{"linkName":linkName},
				dataType:"json",
				beforeSend:function(){
					$("#loading").css("display","block");
				},
				complete:function(){$("#loading").css("display","none");},
				success: function(result) {
					var dataList = (result.orderList);
					$("#linkName").val(dataList[0].linkman); //联系人
					$("#linkPhoneNum").val(dataList[0].linkNumber);//联系人电话
				},error:function(){
					
				}
			});			
		}
		//修改资料的方法
		$(".aBtn").click(function(){
			var id = "<%=id%>";
			var linkName = $("#linkName").val();
			var linkPhoneNum = $("#linkPhoneNum").val();
			$.ajax({ 
				url:"<%=basePath%>userOrderController/update/updateLinkman.action",
				type:"POST",
				data:{
					
					"id":id,
					"linkName":linkName,
					"linkPhoneNum":linkPhoneNum
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
		
	//删除的按钮
		$("#btnQ").click(function(){
			var id = "<%=id%>";
			$.ajax({ 
				url:"<%=basePath%>userOrderController/delete/deleteLinkman.action",
				type:"POST",
				data:{
					"id":id,
				},
				dataType:"json",
				success: function(result) {
					if(result.msg==1){
						window.location.href="<%=basePath %>console/wechat/linkman.jsp";
					}else{
						$.alert("删除失败");
					}
				},error:function(){
				
				}
			});		
			window.location.href="<%=basePath %>console/wechat/linkman.jsp";
		});
	});
	
</script>
</head>

<body>
<div class="writInfoBox">
	<ul>
		<li>
			<span class="spanTit">联系人：</span>
			<input id="linkName" type="text"/>
		</li>
		<li>
			<span class="spanTit">联系人电话：</span>
			<input id="linkPhoneNum" type="text"/>
		</li>
		
		
	</ul>
</div>

<div class="btnBox"><a class="aBtn">确定修改</a><a id="btnQ">删除</a></div>


</body>
</html>
