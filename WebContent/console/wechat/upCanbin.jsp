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
<link rel="stylesheet" type="text/css"  href="<%=basePath%>console/css/loading.css" />
<link rel="stylesheet" type="text/css"  href="<%=basePath %>console/css/upcanbinDate.css"/>
<script type="text/javascript"  src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/upCanbinDate.js"></script>
<style>
	.canweiMsg{width:100%; background:rgba(0,0,0,0.5); height:100%; z-index:9998; position:absolute; left:0; top:0;}	
	.canweiMsg .SmallcanweiMsg{width:70%; border-radius:5px 5px 0 0; background-color:#ffffff; font-size:14px; dispaly:block; margin-left:auto; margin-right:auto; margin-top:20%;}
	.wenxinTitle{height:30px;}
	.wenxinTitle img{float:right; width:30px; border-radius:5px;}
	.yesNoBTN{width:50%; border:none; height:50px; line-height:50px; color:#fff; float:left;}
	#findCanUpFilght{position:absolute; top:0px; left:0px; display:none; background-color:#fff; width:100%;}
	.classLiStyle{border:1px solid #cccccc; margin-top:10px; padding-buttom:10px;}
	.fildOneDiv{ padding:5px 10px 10px 10px; overflow:hidden;}
	.styleClass{font-size:12px; margin-top:5px;}
	.styleClass .upMSGbtn{padding:5px; border:1px solid #FF6F43; color:#FF6F43;}
	
	.MsgSureBox{display:none; position:absolute; left:0px; top:0px; background:rgba(0,0,0,0.5); overflow:hidden; z-index:9998; width:100%; height:100%;}
	.MsgSureBox #qrMSG{position:fixed; top:15%; left:15%; padding-top:5px; display:block; background-color:#fff; z-index:9999; border-radius:5px; font-size:12px; color:#666666; font-family:"Microsoft YaHei"; width:232px;}
	.MsgSureBox #qrMSG .spanDiv{ height:20px; padding:0px 5px 0px 15px;}
	.MsgSureBox #qrMSG .spanDiv span{ line-height:20px;}
	.MsgSureBox #qrMSG #submitBtn{ width:50%; padding:20px 0px 20px 0px; border:none; background-color:#FC716A; color:#FFFFFF; border-radius:0px 0px 0px 5px; outline:none; margin-top:10px;display: block;text-align: center;float: left;}
	.MsgSureBox #qrMSG #colseThis{ width:50%; padding:20px 0px 20px 0px; border:none; background-color:#B5BECD; color:#FFFFFF; border-radius:0px 0px 5px 0px; outline:none; margin-top:10px;display: block;text-align: center;float: left;}
		
	.infoFiletghtLi{background-color:#FFFFFF; padding:10px 0px 10px 10px; font-family:Microsoft Yahei; margin-top:5px; border-radius:5px;}
	.infoFiletghtLi .infoFiletght{width:65%; float:left;}
	/*.infoFiletghtLi .infoFiletght .smalldivClass:first-child{margin-top:5px;}选择第一个css*/
	.infoFiletghtLi .infoFiletght .smalldivClass{margin-top:2px;overflow:hidden;}	
	.infoFiletghtLi .infoFiletght span{padding:0px 3px;float:left; display:block; font-size:12px; color:#666666;}
	.infoFiletghtLi .filetBtn{width:30%; font-size:12px; color:#666666; float:right; margin-right:5px; text-align:center;}
	.infoFiletghtLi .filetBtn .upMSGbtn{font-size:10px; display:block; background-color:#007AFF; border-radius:4px; padding:8px; margin-top:3px; margin-bottom:5px; color:#FFFFFF;}
	.ovfHiden{overflow: hidden;height: 100%;}
</style>
</head>
<body>
	<!-- 温馨提示框 -->
	<div class="canweiMsg">
		<div class="SmallcanweiMsg">
			<div class="wenxinTitle">
				<img src="<%=basePath %>console/images/cha.png"/>
			</div>
			<div class="wenxinContent" >
				<span style="text-align:left; color:#A2A3A8; font-size:12px; line-height:25px; padding:10px 5px 10px 15px; display:block;">改签的功能只能是在相同舱位的情况下修改出发时间和航班号，如想升舱：请退掉该票重新预定</span>
			</div>
			<div>
				<button class="yesNoBTN" style="border-radius:0 0 0 5px; background-color:#FC716A;">好的</button>
				<button class="yesNoBTN" style="border-radius:0 0 5px 0; background-color:#B7BDCD;">关闭</button>
			</div>		
		</div>
	</div>
	
	<div>
		<input type="hidden" id="orderNum" value="<%=orderNum%>"/>
		<input type="hidden" id="pnrNo" value="<%=pnrNo%>"/>
		<input type="hidden" id="chufDate"/>
		<input type="hidden" id="fildNO"/>
		
		<input type="hidden" id="NewchufDate" class="jcDate" readonly="readonly"/>
		<div id="basePathJava" style="display:none;"><%=basePath %></div>
	</div>
	
	<!-- 航班列表 -->
	<div id="findCanUpFilght">
		<ul id="fildDataList" style="list-style-type:none; padding:1px 10px; margin:0px; background-color:#E9E8E6;">
		</ul>
	</div>
	
	<!-- 订单信息确认div框 -->
<div class="MsgSureBox">
	<div id="qrMSG">
		<div class="spanDiv"><img id="colseBTN" src="<%=basePath %>console/images/cha.png" style="width:20px; float:right;"/></div>
		<div class="spanDiv"><span>起飞时间：</span><span id="chufDateTime"></span></div>
		<div class="spanDiv"><span>起始城市：</span><span id="chufCity"></span><span id="chufPlanCode" style="display:none;"></span></div>
		<div class="spanDiv"><span>终点城市：</span><span id="daodCity"></span><span id="daodPlanCode" style="display:none;"></span></div>
		<div class="spanDiv"><span>航班号：</span><span id="fildNum"></span></div>
		<div class="spanDiv"><span>舱位：</span><span id="canbin"></span></div>
		<div class="spanDiv"><span>乘机人：</span><span id="linkName"></span></div>
		<div class="spanDiv"><span>联系电话：</span><span id="linkPhone"></span></div>
		<div class="spanDiv"><span>性别：</span><span id="sex"></span></div>
		<div class="spanDiv"><span>旅客类型：</span><span id="userType"></span></div>
		<div class="spanDiv"><span>证件类型：</span><span id="IDcaseType"></span></div>
		<div class="spanDiv"><span>证件号码：</span><span id="IDcase"></span></div>
		<a id="submitBtn">信息正确</a><a id="colseThis">取消</a>
	</div>
</div>
	
	<!-- 加载等待界面 -->	
	<div id="loading">
		<div id="loading-center">
			<div id="loading-center-absolute">
				<div class="object" id="object_four"></div>
				<div class="object" id="object_three"></div>
				<div class="object" id="object_two"></div>
				<div class="object" id="object_one"></div>
			</div>
			<div style="color:#ffffff; position:absolute; left:39%; top:60%; font-size:12px;">数据加载中...</div>
		</div> 
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
				beforeSend:function(){
					$("#loading").css("display","block");
				},
				complete:function(){$("#loading").css("display","none");},
				success: function(result) {
					var dataList = (result.orderList)[0];
					$("#chufDate").val(dataList.chufDate);
					$("#fildNO").val(dataList.hangbanNum);
					
					$("#chufCity").text(dataList.chufCity);
					$("#daodCity").text(dataList.daodCity);
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
		
		//初始化日期控件
        $("#NewchufDate").calendar();
        
        //提示框关闭时间
        $(".yesNoBTN").click(function(){
        	$(".canweiMsg").css("display","none");
        });
        
        $(".wenxinTitle img").click(function(){
       		$(".canweiMsg").css("display","none");
        });
        
        $("#colseBTN").click(function(){
        	$(".MsgSureBox").css("display","none");
        });
	});
	
//计算剩余票价张数的方法
function tekNum(date){
	if(date=="A"){
		date="9";
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
		return firstTime+":"+conterTime+"<a style='color:#ff0000; font-size:10px;'>"+lastTime+"</a>";
	}else{			
		var firstTime=GoTime.substring(0,2);
		var lastTime=GoTime.substring(2,GoTime.length);
		return firstTime+":"+lastTime;
	}
}

//ajax提交的方法(在upCanbinDate.js文件的方法中应用到)
function ajaxjson(){
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
			beforeSend:function(){
				$("#loading").css("display","block");
			},
			complete:function(){$("#loading").css("display","none");},
			success: function(result) {
				var dataList = result.dataList;
				console.log(result.dataList);
				for(var i=0;i<dataList.length;i++){
					for(var j=0;j<dataList[i].seatList.length;j++){
						if((dataList[i].seatList)[j].cangwei==canbin){ //只查找对应舱位的信息 比如用户原先订的是Y舱位的票，那就只能查询Y舱位的票
							var teickNum = (dataList[i].seatList)[j].cangwei_data;
							//var liList='<li class="classLiStyle"><div class="fildOneDiv"><div class="styleClass">'+(i+1)+'、广州->北京</div><div class="styleClass">航班号：<span class="flightNo">'+dataList[i].flightNo+'</span><span class="cangwei">'+(dataList[i].seatList)[j].cangwei+'</span>剩余的票：'+tekNum(teickNum)+'</div><div class="styleClass">出发时间：<span class="chufDate">'+chufDate+'</span><span class="depTime">'+changeType(dataList[i].depTime)+'</span></div><div class="styleClass">到达时间：<span class="daodTime">'+changeType(dataList[i].arrTime)+'</span></div><div class="styleClass"><a class="upMSGbtn">改为该航班</a></div></div></li>';     
							var liList='<li class="infoFiletghtLi"><div class="infoFiletght"><div class="smalldivClass"><span>广州</span><span style="color:#999999;"><img src="<%=basePath%>console/images/to.png" style="height:12px; margin-top:1px;"></span><span>北京</span></div><div style="clear:both;"></div><div class="smalldivClass"><span>出发时间</span><span class="chufDate">'+chufDate+'</span><span class="depTime">'+changeType(dataList[i].depTime)+'</span></div><div style="clear:both;"></div><div class="smalldivClass"><span>到达时间</span><span class="daodTime">'+changeType(dataList[i].arrTime)+'</span></div><div style="clear:both;"></div>	<div class="smalldivClass"><span>航班编号 </span><span class="flightNo">'+dataList[i].flightNo+'</span></div></div><div class="filetBtn"><span class="upMSGbtn">改为该航班</span><span>舱位：</span><span class="cangwei">'+(dataList[i].seatList)[j].cangwei+'</span><br/><span>余数：</span><span>'+tekNum(teickNum)+'</span></div><div style="clear:both;"></div></li>';
							$("#fildDataList").append(liList);									
						}						
					}
				}
				$("#findCanUpFilght").css("display","block");
				loadjs();//动态加载外部js文件
			},error:function(){
				
			}
	});
}

//重新加载指定js文件
function loadjs(){
	var jsElem = document.createElement('script');
	jsElem.src='<%=basePath%>console/js/upCanbin.js?v=79';
	document.getElementsByTagName('head')[0].appendChild(jsElem);
}
</script>
</html>