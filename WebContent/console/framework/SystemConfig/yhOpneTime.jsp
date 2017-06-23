<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>优惠开放时间设置</title>
	<script type="text/javascript" src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
	<style>
		ul{list-style:none; height:50px; width:265px; float:right;}
		ul li{float:left; width:130px;}
	</style>
	<script>
	$(function(){
		$.post("<%=basePath%>framework/yhTime/reload.action",{},function(res){
			var date = JSON.parse(res);
			console.log(date);
			$("#yhNum").text(date[0].number);
			$("#yhStatus").text(date[0].status==1?"已启动":"未启动")
		});
	});
    function updatenumber(){
         var a=$("#newNum").val();
         var b=$("#yhStatus").text();
         $.ajax({
             type: "POST",
             url:"<%=basePath%>framework/yhTime/save.action",
             data:{"number":a,"status":b},
             dataType:"JSON",
             success:function(data){
               console.log(data)
               if(data=="1"||data==1){
                   $("#yhNum").text(a);
                   $("#newNum").val("");
                   history.go(0);
               }else{
                   alert("保存失败")
               }
             },error:function(){

        	 }
       });
   }
   
   function save(){
      var c=$("#yhNum").text();
      var a=$("input[type='checkbox']").attr("checked");
      if(a){
         $.ajax({
            type:"POST",
            url:"<%=basePath%>framework/yhTime/xigai.action",
            data:{"number":c,},
            dataType:"JSON",
            success:function(data){
               if(data=="1"||data==1){
                  $("#yhStatus").text("已启动");
               }else{
                   alert("保存失败")
               }
            },error:function(){

        }
         })
      }
      else{
        alert("请先勾选选项")
      }
   }
</script>
</head>
<body>

<div style="border:1px solid white;">
    <ul>
        <li><input type="checkbox" value=""/>启动优惠码</li>
        <li><a style="display:block; width:90px; text-align:center; padding:5px; border-radius:5px; background-color:blue; color:#fff; cursor:pointer;" onclick="save()">保存更改</a></li>
    </ul>
</div>
<div style="width:500px;margin:70px auto;">
<table style="width:100%; margin-top:100px;" border="0"  cellspacing="10">
	<tr>
		
		<td style="width:270px;margin-left:500px;"><span style="font-size:18px; font-weight:bold;">当前优惠码状态：</span><span id="yhStatus" style="font-size:14px; color:red;">未启动</span></td>
		<td></td>
		
	</tr>
	<tr>
		
		<td style="padding-top:20px"><span style="font-size:18px; font-weight:bold;">当前优惠码：</span><span id="yhNum" style="font-size:14px;"></span></td>
		<td></td>
	</tr>
	<tr>
	   
		<td style="padding-top:20px"><span style="font-size:18px; font-weight:bold;">新优惠码：</span><span><input type="text" id="newNum" value="" style="height:22px;width:170px"/></span></td>
		<td style="padding-top:20px"><a style="display:block; width:90px; text-align:center; padding:5px; border-radius:5px; background-color:blue; color:#fff; cursor:pointer;" onclick="updatenumber()">保存</a></td>
	</tr>
</table>
</div>
</body>
</html>