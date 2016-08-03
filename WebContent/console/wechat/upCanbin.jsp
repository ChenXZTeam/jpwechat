<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	String path= request.getContextPath();
	String basePath= request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+ path +"/";
%>
<%
	String orderNum=new String(request.getParameter("orderNum").getBytes("ISO-8859-1"),"utf-8");
	String pnrNo=new String(request.getParameter("pnrNo").getBytes("ISO-8859-1"),"utf-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>改签</title>
<script type="text/javascript"  src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<style>
	#findCanUpFilght{position:absolute; top:0px; left:0px; display:none; background-color:#fff; width:100%;}
	.classLiStyle{border:1px solid #cccccc; margin-top:10px;}
	.fildOneDiv{ padding:5px; overflow:hidden;}
	.styleClass{font-size:12px; margin-top:5px;}
	.styleClass .upMSGbtn{padding:5px; border:1px solid #FF6F43; color:#FF6F43;}
	#qrMSG{position:fixed; top:30%; left:15%; padding:15px; display:none; background-color:#fff; z-index:9999; border:1px solid #cccccc;}
</style>
</head>
<body>
	<p style="color:#ff0000; font-size:14px;">温馨提示：改签的功能只能是在相同舱位的情况下修改出发时间和航班号，如果想升舱：那只能退掉该票重新订了</p>
	<div>
		<p>旧的出发时间和航班号</p>
		<input type="text" id="orderNum" value="<%=orderNum%>"/>
		<input type="text" id="pnrNo" value="<%=pnrNo%>"/>
		<input type="text" id="chufDate"/>
		<input type="text" id="fildNO"/>
		<p>选择时间</p>
		<input type="text" id="NewchufDate"/>
		<button id="findFild">查找可预订航班</button>
		<div id="basePathJava"><%=basePath %></div>
		<!-- <p>以下是为您匹配到可以修改的航班</p>
		<input type="text" id="NewchufDate"/>
		<input type="text" id="NewfildNO"/>
		<button>确定修改</button> -->
	</div>
	
	<div id="findCanUpFilght">
		<p>以下是为您匹配到可以修改的航班</p>
		<ul id="fildDataList" style="list-style-type:none; padding:0px;">
		</ul>
	</div>
	
	<!-- 订单信息确认div框 -->
	<div id="qrMSG">
		<div><span>起飞时间：</span><span id="chufDateTime"></span></div>
		<div><span>起始城市：</span><span id="chufCity"></span><span id="chufPlanCode"></span></div>
		<div><span>终点城市：</span><span id="daodCity"></span><span id="daodPlanCode"></span></div>
		<div><span>航班号：</span><span id="fildNum"></span></div>
		<div><span>舱位：</span><span id="canbin"></span></div>
		<div><span>乘机人：</span><span id="linkName"></span></div>
		<div><span>联系电话：</span><span id="linkPhone"></span></div>
		<div><span>性别：</span><span id="sex"></span></div>
		<div><span>旅客类型：</span><span id="userType"></span></div>
		<div><span>证件类型：</span><span id="IDcaseType"></span></div>
		<div><span>证件号码：</span><span id="IDcase"></span></div>
		<div><button id="submitBtn">信息正确</button><button id="colseThis">取消</button></div>
	</div>
</body>
<script>
	$(function(){		
		//加载旧数据在表单中
		var orderNum = "<%=orderNum%>";
		if(orderNum!=null||orderNum!="null"||orderNum!=""){
			$.ajax({
				url:"<%=basePath%>userOrderController/loading/userMsg.action",
				type:"POST",
				data:{"orderNum":orderNum},
				dataType:"json",
				success: function(result) {
					var dataList = (result.orderList)[0];
					$("#chufDate").val(dataList.chufDate);
					$("#fildNO").val(dataList.hangbanNum);
					
					$("#chufCity").text(dataList.chufCity);
					$("#daodCity").text(dataList.daodCity);
					//$("#fildNum").text(dataList.hangbanNum);
					$("#canbin").text(dataList.cabin);
					$("#linkName").text(dataList.linkName);
					$("#linkPhone").text(dataList.linkPhoneNum);
					$("#sex").text(dataList.linkSex);
					$("#userType").text(dataList.psgType);
					$("#IDcaseType").text(dataList.idcaseType);
					$("#IDcase").text(dataList.idcase);
					$("#chufPlanCode").text(dataList.qishiPlaneCode);
					$("#daodPlanCode").text(dataList.daodPlaneCode);
				},error:function(){
					
				}
			});			
		}
		
		
		$("#findFild").click(function(){
			var chufCity = $("#chufPlanCode").text();
			var daodCity = $("#daodPlanCode").text();
			var chufDate = $("#NewchufDate").val();
			var fildNo = $("#fildNO").val();
			var canbin = $("#canbin").text();
			$.ajax({
				url:"<%=basePath%>wechatController/find/planTekOne.action",
				type:"POST",
				data:{"chufCity":chufCity,"daodCity":daodCity,"chufDate":chufDate,"fildNo":fildNo,"canbin":canbin},
				dataType:"json",
				success: function(result) {
					var dataList = result.dataList;
					console.log(result.dataList);
					$("#findCanUpFilght").css("display","block");
					for(var i=0;i<dataList.length;i++){
						for(var j=0;j<dataList[i].seatList.length;j++){
							if((dataList[i].seatList)[j].cangwei==canbin){ //只查找对应舱位的信息 比如用户原先订的是Y舱位的票，那就只能查询Y舱位的票
								var teickNum = (dataList[i].seatList)[j].cangwei_data;
								var liList='<li class="classLiStyle"><div class="fildOneDiv"><div class="styleClass">'+(i+1)+'、广州->北京</div><div class="styleClass">航班号：<span class="flightNo">'+dataList[i].flightNo+'</span><span class="cangwei">'+(dataList[i].seatList)[j].cangwei+'</span>剩余的票：'+tekNum(teickNum)+'</div><div class="styleClass">出发时间：<span class="chufDate">'+chufDate+'</span><span class="depTime">'+changeType(dataList[i].depTime)+'</span></div><div class="styleClass">到达时间：<span class="daodTime">'+changeType(dataList[i].arrTime)+'</span></div><div class="styleClass"><a class="upMSGbtn">改为该航班</a></div></div></li>';
								$("#fildDataList").append(liList);									
							}						
						}
					}
					loadjs();//动态加载外部js文件
				},error:function(){
					
				}
			});
		});	

	});
	
//计算剩余票价张数的方法
function tekNum(date){
	if(date=="A"){
		date="充足";
	}else if(date=="L"||date=="Q"||date=="S"||date=="C"||date=="X"||date=="Z"){
		date="";
	}else if(date!=""){
		date=date;
	}
	return date;
}

//改变出发时间和到达时间的类型
function changeType(GoTime){	
	if(4<GoTime.length){
		var firstTime=GoTime.substring(0,2);
		var conterTime=GoTime.substring(2,4);
		var lastTime=GoTime.substring(4,GoTime.length);
		return firstTime+":"+conterTime+"<span style='color:#ff0000; font-size:10px;'>"+lastTime+"</span>";
	}else{			
		var firstTime=GoTime.substring(0,2);
		var lastTime=GoTime.substring(2,GoTime.length);
		return firstTime+":"+lastTime;
	}
}

//重新加载指定js文件
function loadjs(){
	var jsElem = document.createElement('script');
	jsElem.src='<%=basePath%>console/js/upCanbin.js';
	document.getElementsByTagName('head')[0].appendChild(jsElem);
}
</script>
</html>