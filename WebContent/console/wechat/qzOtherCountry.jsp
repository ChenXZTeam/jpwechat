<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>特优国家</title>
<link rel="stylesheet" href="<%=basePath %>console/css/QZplanTek.css" />
<script type="text/javascript"  src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/QZplanTek.js"></script>
<style>
	body{background-color:#F9F9F9;}
	#cityFind{margin-bottom:15px; background-color:#FFFFFF; padding:8px 0px;}
	.fangbigImgbox{ border-right:1px solid #D8D8D8;}
	.fangbigImgbox,.inputDivBox{float:left;}
	.fangbigImgbox img{width:25px; padding:0px 10px;}
	.inputDivBox input{height:20px; border:none; margin-left:10px; outline:none; margin-top:3px;}
	#findResult{width:99%; position:absolute; top:40px; left:0; border:#d8d8d8 solid 1px; border-bottom:#d8d8d8 solid 1px; background-color:#FFFFFF; overflow:hidden; z-index:99;}
	#findResult .pipeiChildren{padding:10px 5px; border-bottom:#d8d8d8 solid 1px;}
	.conteryBox{width:95%; margin-left:auto; margin-right:auto;}
	.conteryBox .zhouNameBoxClass{border-bottom:1px solid #D8D8D8; overflow:hidden;}
	.conteryBox .zhouNameBoxClass .zhouNameClass{font-family:'微软雅黑'; color:#666666;/*#AEADB3*/; display:block; float:left; padding-bottom:3px;}
	.conteryBox .conterListBox{overflow:hidden;}
	.conteryList{border-bottom:1px solid #D8D8D8; overflow:hidden; display:none;}
	.conteryList ul{list-style-type:none; padding:5px 10px 10px 10px; margin:0px; overflow:hidden; margin-top:5px;}
	.conteryList ul li{text-align:left; padding:5px 0px; margin-top:5px; color:#666666;}
	.shouImgBox{margin-top:1px; padding-bottom:10px;}
	.country_id{display:none;}
	.cityIDstr{display:none;}
</style>
</head>

<body>
<div id="cityFind">
	<div class="fangbigImgbox"><img src="<%=basePath %>console/images/FangBig.png"/></div>
	<div class="inputDivBox"><input type="text" id="citySearch" oninput="myFunction()" placeholder="请输入搜索的国家"/></div>
	<div style="clear:both;"></div>
</div>
<div id="findResult" >
	
</div>

<div class="lanrenzhijia">
  <div class="title cf">
    <ul class="title-list fr cf ">
      <li class="on">免签国家</li>
      <li>落地签国家</li>
      <p><b></b></p>
    </ul>
  </div>
  
  <div class="product-wrap">
    <!--案例1-->
    <div class="product show">
		<div class="conteryBox mianqCountry">
			<!--亚洲-->
			<div class="zhouNameBoxClass">
				<span class="zhouNameClass">亚洲</span>
				<span style="clear:both;"></span>
			</div>
			<div class="conterListBox yazhouArea">
				<div class="conteryList" style="display:block;">
					<ul></ul>
				</div>
				<div class="shouImgBox"><img src="<%=basePath %>console/images/threeLine.png"/></div>
			</div>
			
			<!--欧洲-->
			<div class="zhouNameBoxClass">
				<span class="zhouNameClass">欧洲</span>
				<span style="clear:both;"></span>
			</div>
			<div class="conterListBox ouzhouArea">
				<div class="conteryList">
					<ul></ul>
				</div>
				<div class="shouImgBox"><img src="<%=basePath %>console/images/threeLine.png"/></div>
			</div>
			
			<!--美洲-->
			<div class="zhouNameBoxClass">
				<span class="zhouNameClass">美洲</span>
				<span style="clear:both;"></span>
			</div>
			<div class="conterListBox meizhouArea">
				<div class="conteryList">
					<ul></ul>
				</div>
				<div class="shouImgBox"><img src="<%=basePath %>console/images/threeLine.png"/></div>
			</div>
			
			<!--非洲-->
			<div class="zhouNameBoxClass">
				<span class="zhouNameClass">非洲</span>
				<span style="clear:both;"></span>
			</div>
			<div class="conterListBox feizhouArea">
				<div class="conteryList">
					<ul></ul>
				</div>
				<div class="shouImgBox"><img src="<%=basePath %>console/images/threeLine.png"/></div>
			</div>
			
			<!--大洋洲-->
			<div class="zhouNameBoxClass">
				<span class="zhouNameClass">大洋洲</span>
				<span style="clear:both;"></span>
			</div>
			<div class="conterListBox dyzhouArea">
				<div class="conteryList">
					<ul></ul>
				</div>
				<div class="shouImgBox"><img src="<%=basePath %>console/images/threeLine.png"/></div>
			</div>
			
		</div>
    </div>
    <!--案例2-->
    <div class="product">
		<div class="conteryBox luodiqCountry">
			<!--亚洲-->
			<div class="zhouNameBoxClass">
				<span class="zhouNameClass">亚洲</span>
				<span style="clear:both;"></span>
			</div>
			<div class="conterListBox yazhouArea">
				<div class="conteryList" style="display:block;">
					<ul></ul>
				</div>
				<div class="shouImgBox"><img src="<%=basePath %>console/images/threeLine.png"/></div>
			</div>
			
			<!--欧洲-->
			<div class="zhouNameBoxClass">
				<span class="zhouNameClass">欧洲</span>
				<span style="clear:both;"></span>
			</div>
			<div class="conterListBox ouzhouArea">
				<div class="conteryList">
					<ul></ul>
				</div>
				<div class="shouImgBox"><img src="<%=basePath %>console/images/threeLine.png"/></div>
			</div>
			
			<!--美洲-->
			<div class="zhouNameBoxClass">
				<span class="zhouNameClass">美洲</span>
				<span style="clear:both;"></span>
			</div>
			<div class="conterListBox meizhouArea">
				<div class="conteryList">
					<ul></ul>
				</div>
				<div class="shouImgBox"><img src="<%=basePath %>console/images/threeLine.png"/></div>
			</div>
			
			<!--非洲-->
			<div class="zhouNameBoxClass">
				<span class="zhouNameClass">非洲</span>
				<span style="clear:both;"></span>
			</div>
			<div class="conterListBox feizhouArea">
				<div class="conteryList">
					<ul></ul>
				</div>
				<div class="shouImgBox"><img src="<%=basePath %>console/images/threeLine.png"/></div>
			</div>
			
			<!--大洋洲-->
			<div class="zhouNameBoxClass">
				<span class="zhouNameClass">大洋洲</span>
				<span style="clear:both;"></span>
			</div>
			<div class="conterListBox dyzhouArea">
				<div class="conteryList">
					<ul></ul>
				</div>
				<div class="shouImgBox"><img src="<%=basePath %>console/images/threeLine.png"/></div>
			</div>
		</div>
    </div>
  </div>
  
</div>
<script type="text/javascript">
	$(function(){
		//自动获取落地签、免签的国家有哪些
		$.ajax({
			url:"<%=basePath%>framework/visa/getVisaList.action",
			type:"POST",
			data:{"page":1,"rows":10000},
			dataType:"json",
			success:function(res){
				console.log(res.vList);
				if(res.msg==1){
					var dataList = res.vList;
					for(var i=0; i<dataList.length; i++){
						var htmlLi = '<li onclick="listClick(this)"><span class="country_name">'+dataList[i].country+'</span><span class="country_id">'+dataList[i].countryID+'</span></li>';
						if(dataList[i].qzMode==3){//免签
							if(dataList[i].cotryBelongWhat=="yz")$(".mianqCountry .yazhouArea>.conteryList>ul").append(htmlLi); //对大洲进行分类（亚洲）
							if(dataList[i].cotryBelongWhat=="oz")$(".mianqCountry .ouzhouArea>.conteryList>ul").append(htmlLi); //对大洲进行分类（欧洲）
							if(dataList[i].cotryBelongWhat=="mz")$(".mianqCountry .meizhouArea>.conteryList>ul").append(htmlLi); //对大洲进行分类（美洲）
							if(dataList[i].cotryBelongWhat=="fz")$(".mianqCountry .feizhouArea>.conteryList>ul").append(htmlLi); //对大洲进行分类（非洲）
							if(dataList[i].cotryBelongWhat=="dyz")$(".mianqCountry .dyzhouArea>.conteryList>ul").append(htmlLi); //对大洲进行分类（大洋洲）
						}else if(dataList[i].qzMode==2){ //落地签
							if(dataList[i].cotryBelongWhat=="yz")$(".luodiqCountry .yazhouArea>.conteryList>ul").append(htmlLi); //对大洲进行分类（亚洲）
							if(dataList[i].cotryBelongWhat=="oz")$(".luodiqCountry .ouzhouArea>.conteryList>ul").append(htmlLi); //对大洲进行分类（欧洲）
							if(dataList[i].cotryBelongWhat=="mz")$(".luodiqCountry .meizhouArea>.conteryList>ul").append(htmlLi); //对大洲进行分类（美洲）
							if(dataList[i].cotryBelongWhat=="fz")$(".luodiqCountry .feizhouArea>.conteryList>ul").append(htmlLi); //对大洲进行分类（非洲）
							if(dataList[i].cotryBelongWhat=="dyz")$(".luodiqCountry .dyzhouArea>.conteryList>ul").append(htmlLi); //对大洲进行分类（大洋洲）
						}else{

						}
					}
				}else{
					alert("系统错误，请稍后再试！");
				}
			},
			error:function(){}
		});
		//收起和展开的方法
		$(".shouImgBox").click(function(){			
			if(!$(this).prev().hasClass("nowShow"))$(".nowShow").slideUp("slow");
			$(".conteryList").removeClass("nowShow");
			$(this).prev().addClass("nowShow");
			$(".nowShow").slideToggle("slow");
		});
	});
	
//国家列表的点击事件
function listClick(inc){
	var countryId = $(inc).children(".country_id").text();
	window.location.href="<%=basePath%>console/wechat/qzOneCoInfo.jsp?countryId="+countryId;
}

//输入关键字的时候自动索引
function myFunction() {
	var keyVal = document.getElementById("citySearch").value;
	$(".conteryList>ul>li>.country_name").removeClass("chCity").filter(":contains(" + keyVal + ")").addClass("chCity");
	$("#findResult").text("");
	$("#findResult").css("display","block");
	for(var i=0; i<$(".chCity").length&&i!=10; i++){
		var contrayName = $(".chCity:eq("+i+")").text();
		var cityIDstr = $(".chCity:eq("+i+")").next().text();
		var dateList = '<div class="pipeiChildren" onclick="javascript:chaRes(this)"><span class="cityName01">'+contrayName+'</span><span class="cityIDstr">'+cityIDstr+'</span></div>';
		$("#findResult").append(dateList);
	}
}

//索引出来的结果的点击事件
function chaRes(inc){
	var countryName = $(inc).children(".cityName01").text();
	var cityIDstr = $(inc).children(".cityIDstr").text();
	window.location.href="<%=basePath%>console/wechat/qzOneCoInfo.jsp?countryId="+cityIDstr;
	$("#findResult").css("display","none");
}
</script>
</body>
</html>
