<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%	
	String chufTime=new String(request.getParameter("chufTime").getBytes("ISO-8859-1"),"utf-8");
	String arrDTime=new String(request.getParameter("arrDTime").getBytes("ISO-8859-1"),"utf-8");
	String shiPlace=new String(request.getParameter("shiPlace").getBytes("ISO-8859-1"),"utf-8");
	String zhongPlace=new String(request.getParameter("zhongPlace").getBytes("ISO-8859-1"),"utf-8");
	String cost=new String(request.getParameter("cost").getBytes("ISO-8859-1"),"utf-8");
	String zhekou=new String(request.getParameter("zhekou").getBytes("ISO-8859-1"),"utf-8");
	String cangweiType=new String(request.getParameter("cangweiType").getBytes("ISO-8859-1"),"utf-8");
	String chufCityID=new String(request.getParameter("chufCityID").getBytes("ISO-8859-1"),"utf-8");
	String daodCityID=new String(request.getParameter("daodCityID").getBytes("ISO-8859-1"),"utf-8");
	String chufDate = request.getParameter("chufDate");
	System.out.println(chufTime+"/"+arrDTime+"/"+shiPlace+"/"+zhongPlace+"/"+cost+"/"+zhekou+"/"+cangweiType+"/"+chufCityID+"/"+daodCityID+"/"+chufDate);
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>填写信息</title>
	<script src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
	<style>
		.massInfoBox{text-align:left;}
		.massInfoBox ul{list-style-type:none; padding:0px; margin:0px; color:#333;}
		.massInfoBox ul li{padding:5px;}
		.massInfoBox .trueCost{text-align:right; margin-right:50px; font-size:14px;}
		.massInfoBox .trueCost .payMoney{color:#ff0000; font-weight:bold; font-size:20px;}
		
		.writInfoBox{border:1px solid #ff0000;}
		.writInfoBox ul{list-style-type:none; margin:0px; padding:0px;} 
		.writInfoBox ul li{padding:5px 0px; border:1px solid #ff0000; overflow:hidden;}
		.writInfoBox ul li .spanTit{}
		.writInfoBox ul li input{float:left;}
		.writInfoBox ul li span{display:block; float:left;}
		.writInfoBox ul li img{width:15px;}
		.ChoosClassBox{width:80.5%; height:0px; overflow:hidden; border:1px solid #e1e1e1; position:absolute; top:400px; left:20px; background-color:#FFFFFF; padding:5px 10px; display:none; z-index:1;}
		.ChoosClassBox .ChoosSmallBox{padding:5px; border-bottom:1px solid #e1e1e1;}
	</style>
</head>
<body>
<!-- 信息反馈 -->
<div class="massInfoBox">
	<ul>
		<li><span class="spanTit">出发时间：</span><span class="spanCont chufDate"></span><span class="chufTime" style="margin-left:5px;"></span></li>
		<li><span class="spanTit">到达时间：</span><span class="spanCont chufDate"></span><span class="arrDTime" style="margin-left:5px;"></span></li>
		<li><span class="spanTit">出发城市：</span><span class="spanCont chufCityID"></span></li>
		<li><span class="spanTit">到达城市：</span><span class="spanCont daodCityID"></span></li>
		<li><span class="spanTit">起始机场：</span><span class="spanCont shiPlace"></span><span class="flidNum" style="margin-left:5px;"></span></li>
		<li><span class="spanTit">到达机场：</span><span class="spanCont zhongPlace"></span></li>
		<li><span class="spanTit">飞行历时：</span><span class="spanCont countTime"></span><span class="cangweiType" style="display:none;"></span><span class="zhekou" style="display:none;"></span></li>
	</ul>
	<div class="trueCost"><span class="spanTit">实付价格：</span><span class="payMoney cost"></span></div>
</div>
<!-- 填写乘机人信息 -->
<div class="writInfoBox">
	<ul>
		<li><span class="spanTit">姓名：</span><input id="linkName" type="text"/><span style="clear:both;"></span></li>
		<li><span class="spanTit">性别：</span><input type="text" id="sexIpnt" readonly="readonly"/><span style="margin-top:2px; margin-left:-20px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span><span style="clear:both;"></span></li>
		<li><span class="spanTit">出生日期：</span><input type="text" id="birthIpnt" readonly="readonly"/><span style="float:right; margin-top:10px;"><img src="<%=basePath %>console/images/riliImg.png" style="width:15px;"/></span><span style="clear:both;"></span></li>
		<li><span class="spanTit">手机号：</span><input id="phoneNum" type="text"/><span style="clear:both;"></span></li>
		<li><span class="spanTit">旅客类型：</span><input type="text" id="personIpnt" readonly="readonly"/><span style="margin-top:2px; margin-left:-20px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span><span style="clear:both;"></span></li>
		<li><span class="spanTit" id="caseIpnt">证件类型</span><span><img src="<%=basePath %>console/images/xialaPonting.png" style="padding-top:4px;"/></span><input id="IDcase" type="text" placeholder="请输入证件号码"/><span style="clear:both;"></span></li>
	</ul>
</div>
<div class="baoxianBox">
	<div class="oneClassBX"><a class="checkboxA"></a><a class="checkboxB"></a><input type="checkbox" class="checkBoxId flindYw" value="购买"/><span class="spanTitBX">航空意外险</span></div>
	<div class="oneClassBX" style="margin-left:20px;"><a class="checkboxA"></a><a class="checkboxB"></a><input type="checkbox" class="checkBoxId delayBx" value="购买"/><span class="spanTitBX">延误取消险</span></div>
	<div style="clear:both;"></div>
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
<a class="aBtn">下 一 步</a>
<script>
	//获取上个界面传过来的值
	var chufTime = "<%=chufTime%>"; //出发时间
	var arrDTime = "<%=arrDTime%>"; //到达时间
	var shiPlace = "<%=shiPlace%>";	//起始机场和航班（集合）
	var chufPlane = shiPlace.split(" "); //拆分shiPlace
	shiPlace = chufPlane[0]; //起始机场
	var flidNum = chufPlane[1];//航班
	var zhongPlace = "<%=zhongPlace%>"; //终止机场和历时（集合）
	var mudiPlane = zhongPlace.split(" ");//拆分zhongPlace
	zhongPlace = mudiPlane[0];//终止机场
	var countTime = mudiPlane[1];//历时多长时间
	var cost = "<%=cost%>"; //价格
	var zhekou = "<%=zhekou%>"; //折扣
	var cangweiType = "<%=cangweiType%>"; //舱位类型
	var chufCityID = "<%=chufCityID%>"; //出发城市
	var daodCityID = "<%=daodCityID%>"; //目的城市
	var chufDate = "<%=chufDate%>"; //出发日期
	//为信息框赋值
	console.log(chufTime+","+arrDTime+","+shiPlace+","+flidNum+","+zhongPlace+","+countTime+","+cost+","+zhekou+","+cangweiType+","+chufCityID+","+daodCityID+","+chufDate); 
	$(".chufTime").text(chufTime);
	$(".arrDTime").text(arrDTime);
	$(".shiPlace").text(shiPlace);
	$(".flidNum").text(flidNum);
	$(".zhongPlace").text(zhongPlace);
	$(".countTime").text(countTime);
	$(".cost").text(cost);
	$(".zhekou").text(zhekou);
	$(".cangweiType").text(cangweiType);
	$(".chufCityID").text(chufCityID);
	$(".daodCityID").text(daodCityID);
	$(".chufDate").text(chufDate);
</script>
</body>
</html>