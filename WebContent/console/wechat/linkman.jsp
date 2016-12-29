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
<title>常用联系人管理</title>
<link rel="stylesheet" href="<%=basePath%>console/css/weui.min.css" />
<link rel="stylesheet" href="<%=basePath%>console/css/jquery-weui.css" />
<style>
	*{padding:0px; margin:0px;}
	body{text-align:center; font:normal Helvetica, Arial, sans-serif; background-color:#F9F9F9; font-family:Microsoft JhengHei;}
	#bigTable{width:100%; border:none; text-align:left; margin-left:auto; margin-right:auto; font-size:16px;}
	.title{height:40px; background-color:#E3E3E3;}
	.title td{border-bottom:#B7B7B7 solid 1px;}
	.cententTR{height:50px;}
	.cententTD{border-bottom:#E3E3E3 solid 1px;padding-left: 10px;}
	.hiddenClass{display:none;}
	.btnBox{background:url('<%=basePath%>console/images/newImg.png') no-repeat center 5px; background-size: 40px 40px; margin-left: auto;  margin-right: auto;  overflow: hidden;  height: 50px; border-top:1px solid #e1e1e1; position: fixed;  bottom: 0px;  left: 0px;  width: 100%;}
	.btnBox .aBtn{padding:10px 0px; float:left; width:48%;}
	.aBtn{margin-top:15px; display:block; padding:7px 0px; background-color:#007AFF; border-radius:5px; color:#FBFDFF; font-size:12px; text-align:center; width:88.55%; margin-left:90px; margin-right:auto;}
</style>
<script src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script src="<%=basePath %>console/js/jquery-weui.js"></script>
<script>
	$(function(){
		$.ajax({
			url:"<%=basePath %>userOrderController/loading/linkman.action",
			type:"POST",
			dataType:"json",
			success:function(data){
				if(data.msg==1){
					var res=data.linkList;
					for(var i=0;i<res.length;i++){
						$("#bigTable").append("<tr class='cententTR' ><td class='hiddenClass id'>"+res[i].id+"</td><td class='hiddenClass linkPhoneNum'>"+res[i].linkNumber+"</td><td class='cententTD linkName' >"+res[i].linkman+"</td></tr>");
					}
					$(".linkName").click(function(){
						var id =$(this).parent().children(".id").text();
						var linkName=$(this).text();
						var linkPhoneNum =$(this).parent().children(".linkPhoneNum").text();
						window.location.href="<%=basePath %>console/wechat/editLinkman.jsp?linkName="+linkName+"&linkPhoneNum="+linkPhoneNum+"&id="+id;
					})
				}else{
					$.alert("您还没有联系人");
				}
			},error:function(){
				
			}
		});
		
		
		<%-- $(".aBtn").click(function(){
				window.location.href="<%=basePath %>console/wechat/addLinkman.jsp";
		}) --%>
		$(".btnBox").click(function(){
				window.location.href="<%=basePath %>console/wechat/addLinkman.jsp";
		})
	});
</script>
</head>

<body>
<table id="bigTable" cellpadding="0" cellspacing="0" border="0">
	
</table>
<div class="btnBox">
<!-- <a class="aBtn">新建</a> -->

</div>
</body>
</html>
