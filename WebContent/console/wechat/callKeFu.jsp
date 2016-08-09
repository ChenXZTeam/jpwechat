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
<title>在线客服</title>
<script type="text/javascript" src="<%=basePath %>console/js/jquery-1.8.3.min.js" ></script>
<style>
	body{padding:0px; margin:0px; font-size:12px; font-family:Microsoft YaHei;}
	#bigContent{ padding:10px; margin-top:25px;}
	#bigContent .kefuImg{ float:left; padding:10px;}
	#bigContent .jiantou{position:absolute; top:60px; left:60px; z-index:100;}
	#bigContent .textMsg{ width:70%; float:left; border:#E1DFE0 solid 1px; border-radius:5px; background-color:#FDFFFE; padding:20px 10px 10px 10px;}
	#bigContent .textMsg .zixun{ color:#666666;}
	#bigContent .textMsg .zixun span{display:block; line-height:20px;}
	#bigContent .textMsg ul{ overflow:hidden; padding:0px; margin:0px; list-style-type:none;}
	#bigContent .textMsg ul li{padding-top:10px; padding-bottom:5px; border-bottom:1px solid #E1DFE0; overflow:hidden;}
	#bigContent .textMsg ul li:last-child{border:none;} /*去掉最后一个<li>的下划线*/
	#bigContent .textMsg ul li span{float:left; color:#007AFE;}
</style>
</head>

<body  style="background-image:url(<%=basePath %>console/images/callkefu.jpg)";>
	<div id="bigContent">
		<div class="kefuImg"><img src="<%=basePath %>console/images/kefu_03.png" style="width:40px;"/></div>
		<div class="jiantou"><img src="<%=basePath %>console/images/jiantou_03.png"/></div>
		<div class="textMsg">
			<div class="zixun"><span>您好，这里是广州续日，我是客服某某，某某竭诚为您服务！</span><span>您是想咨询一下问题吗？</span></div>
			<ul>
				<li>
					<span>咨询电话：021-13567899</span>
					<span style="color:#C5C6C8; font-weight:bold; float:right;"></span>
				</li>
				<li>
					<span>联系邮箱：123567889@163.com</span>
					<span style="color:#C5C6C8; font-weight:bold; float:right;"></span>
				</li>
				<li>
					<span>QQ:02928371802</span>
					<span style="color:#C5C6C8; font-weight:bold; float:right;"></span>
				</li>
				<li>
					<span>公司地址：广州市天河区。。。。</span>
					<span style="color:#C5C6C8; font-weight:bold; float:right;"></span>
				</li>
				<li>
					<span>祝你旅途愉快！</span>
					<span style="color:#C5C6C8; font-weight:bold; float:right;"></span>
				</li>
				<li>
					<span id="findPAT">查看国内运价！</span>
					<span style="color:#C5C6C8; font-weight:bold; float:right;"></span>
				</li>
			</ul>
		</div>
	</div>
<script>
 	$(function(){
		$.ajax({ 
	    	type: "post",
	    	url: "<%=basePath%>wechatController/find/patPNR.action",
	    	data: {"pnrNo":"HE2MMF"},
	   	 	dataType: "json",//后台处理后返回的数据格式
	  		success: function (data) {
	  			console.log(data.SEG);
	    		alert("成功");
	    	},error:function(){
	    		
	    	}
	    }) 
	    
	    $("#findPAT").click(function(){
	    	$.ajax({
		    	type: "post",
		    	url: "<%=basePath%>wechatController/deletes/PNRno.action",
		    	data: {"pnrNo":"HE2MMF"},
		   	 	dataType: "json",//后台处理后返回的数据格式
		  		success: function (data) {
		    		alert("删除成功");
		    	},error:function(){
		    		
		    	}
	    	})
	    });
	}); 
</script>
</body>
</html>
