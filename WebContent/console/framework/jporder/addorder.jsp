<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>同舱改期</title>
	<script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
<style>
	#radioClassBox{}
	#radioClassBox span{ display:block;}
	#conditionId{ font-size:13px; overflow:hidden;}
	#conditionId div{float:left; margin-left:10px; margin-top:10px;}
	#conditionId>div input{width:137px;}
	.planeTitle{ background:#f0f0f0; color:#666666; margin-top:15px; padding-left:2px;}
	.planeTitle .planeTitleCh{ float:left; width:150px; text-align:center; height:30px; margin-left:15px; line-height:30px;}
	#ulBox{list-style-type:none; padding:0px; font-family:'微软雅黑'; margin:0px; color:#666666;}
	#ulBox li{border:1px solid #E1E1E1; border-bottom:none; font-size:14px; width:99.7777%; margin-left:auto; margin-right:auto; padding:10px 0;}
	#ulBox li:last-child{ border-bottom:1px solid #e1e1e1;}
	#ulBox li .infoContent{ float:left; margin-left:15px; width:150px; text-align:center; height:50px;}
	#ulBox li .planeName{ width:200px;}
	#ulBox li .infoContent .airPlane{font-size:16px; height:30px; line-height:37px;}
	#ulBox li .infoContent .timeClass{ font-size:20px; font-weight:bold;}
	#ulBox li .infoContent .planeNameText{}
	#ulBox li .infoContent .btnclass{ padding:8px 13px; margin-top:7px; cursor:pointer; background-color:#0099CC; color:#FFFFFF; border:none; border-radius:5px;}
	
	.InfoTure{ position:fixed; display:none; top:15%; left:35%; background-color:#FFFFFF; border:#0099CC solid 1px; border-radius:5px; width:30%; color:#666666;}
	.InfoTure .infoTitle{ font-size:18px; border-bottom:#0099CC solid 1px; padding:10px; text-align:center; font-family:'微软雅黑'; background-color:#0099CC; border-radius:5px 5px 0px 0px; color:#FFFFFF;}
	.InfoTure ul{ list-style-type:none; padding:0px; margin:0px; padding:15px 20px;}
	.InfoTure ul li{ height:30px;}
	.InfoTure .btnClassBox{}
	.InfoTure .btnClassBox button{ width:52%; border:none; background:none; padding:10px; font-size:16px; cursor:pointer; outline:none; color:#0099CC; font-weight:bold;}
	.goWhere{position:fixed; top:30%; display:none; left:37%; width:300px; border:1px solid #0099CC; background-color:#FFFFFF; border-radius:5px; font-size:16px; color:#666666;font-family:'微软雅黑';}
	.goWhere .colseImg{display:block; width:20px; height:20px; line-height:20px; float:right; text-align:center; cursor:pointer; font-size:12px; color:#999; font-family:'微软雅黑';}
	.goWhere .goWhereBtn{width:52%; margin-left:0px; border:none; padding:15px; cursor:pointer; outline:none; margin:0px; background-color:#FFFFFF;}
</style>
</head>

<body>
	<div id="conditionId" style="border:1px solid #e1e1e1; padding:10px 8px;">
		<div id="radioClassBox" style="margin-top:0px;">
			<span><input type="radio" value="0" name="cityArea" style="width:20px;"/>国内</span>
			<span><input type="radio" value="1" name="cityArea" style="width:20px;"/>国际</span>
		</div>
		<div>
			<select style="width:70px;">
				<option value="单程">单程</option>
				<option value="往返">往返</option>
			</select>
		</div>
		<div>
			<span>出发城市</span>
			<input/>
		</div>
		<div>
			<button style="border:1px solid #e1e1e1; background:none; cursor:pointer; height:21px;">换</button>
		</div>
		<div>
			<span>到达城市</span>
			<input/>
		</div>
		<div>
			<span>出发日期</span>
			<input id="NewchufDate"/>
		</div>
		<div>
			<span>返程日期</span>
			<input disabled="disabled"/>
		</div>
		<div>
			<button id="findBtn" onclick="ajaxjson()">搜索航班</button>
		</div>
		<div>
			<input type="hidden" id="arrTimeNew"/>
			<input type="hidden" id="chufDate"/>
			<input type="hidden" id="fildNO"/>
			<input type="hidden" id="chufPlanCode"/>
			<input type="hidden" id="daodPlanCode"/>
			<input type="hidden" id="canbin"/>
		</div>
		<div style="clear:both;"></div>
	</div>
	
	<div class="planeTitle">
		<div class="planeTitleCh" style="margin-left:0px;"><span>航空公司</span></div>
		<div class="planeTitleCh" style="width:200px;"><span>出发时间</span></div>
		<div class="planeTitleCh"></div>
		<div class="planeTitleCh" style="width:200px;"><span>到达时间</span></div>
		<div class="planeTitleCh"><span>价格</span></div>
		<div style=" clear:both;"></div>
	</div>
	
	<!-- 查询结果 -->
	<ul id="ulBox">
	</ul>
	<!---航班信息确认框-->
	<div class="InfoTure">
		<div class="infoTitle">请确认信息</div>
		<ul>
			<li><span>出发机场：</span><span id="chufCityPlane"></span></li>
			<li><span>目的机场：</span><span id="daodCityPlane"></span></li>
			<li><span>出发时间：</span><span id="NoTime"></span></li>
			<li><span>乘机人：</span><span id="linkName"></span></li>
			<li><span>联系电话：</span><span id="linkPhone"></span></li>
			<li><span>航班号：</span><span id="newFileNo"></span></li>
			<li><span id="IDcaseType">证件号码：</span><span id="IDcase">46000319930203044</span></li>
		</ul>
		<div class="btnClassBox" style="border-top:#0099CC solid 1px;">
			<button id="trueBtn" style="border-right:1px solid #0099CC; color:#fff; background-color:#0099CC;">正确</button>
			<button id="errorBtn" style="width:44%;">错误</button>
		</div>
	</div>
	<!--修改去向-->
	<div class="goWhere">
		<div><span class="colseImg">X</span></div>
		<div style="clear:both;"></div>
		<div style="height:80px; line-height:80px; margin-left:20px;">你想修改哪种信息？</div>
		<div style="border-top:1px solid #0099CC">
			<button class="goWhereBtn" style="border-right:1px solid #0099CC; color:#0099CC;">修改航班</button>
			<button class="goWhereBtn" id="up_user" style="width:45%">修改资料</button>
		</div>
	</div>
	<!-- 加载等待的界面 -->
	<!-- 加载等待界面 -->	
	<div id="loading" style="display:none;">
		数据加载中...
	</div>
	<script>
		$(function(){
			//错误信息按钮
			$("#errorBtn").click(function(){
				$(".InfoTure").css("display","none");
				$(".goWhere").css("display","block");
			});
			
			//关闭按钮
			$(".colseImg").click(function(){
				$(".goWhere").css("display","none");
			});
			
			//修改资料
			$("#up_user").click(function(){
				window.location.href="<%=basePath%>console/framework/jporder/up_user.jsp?orderNum="+orderNum+"&pnrNo="+pnrNo;
			});
			
			//信息确认正确
			$("#trueBtn").click(function(){
				var chufDate = $("#chufDate").val(); //旧的出发日期
				var fildNO = $("#fildNO").val(); //旧的航班号
				var NoTime = $("#NoTime").text();
				var newChufDate = NoTime.split(" ")[0];//新的出发日期
				var newChufTime = NoTime.split(" ")[1];//新的出发时间
				var fildNum = $("#newFileNo").text(); //新的航班号
				var daodTime = $("#arrTimeNew").val(); //新的到达时间
				$.ajax({
					url:"<%=basePath %>userOrderController/update/changeDate.action",
					type:"POST",
					data:{"pnrNo":pnrNo,"orderNum":orderNum,"fltDateOld":chufDate,"fltNoOld":fildNO,"fltDateNew":newChufDate,"chufTime":newChufTime,"fltNoNew":fildNum,"daodTime":daodTime},
					dataType:"json",
					success:function(res){
						if(res.msg==1){
							alert("改签成功！");
							window.location.href="<%=basePath%>console/framework/jporder/index.jsp";
						}else{
							alert("改签失败！");
						}
					},error:function(){
						
					}
				});
			});
		});
		
		//根据（出发地、到达地、航班号、出发时间、舱位）查找是否有座位。在改签中需要查找是否有位置才能预定
		function ajaxjson(){
			var chufCity = $("#chufPlanCode").val();
			var daodCity = $("#daodPlanCode").val();
			var chufDate = $("#NewchufDate").val();
			var fildNo = $("#fildNO").val();
			var canbin = $("#canbin").val();
			//console.log(chufCity+","+daodCity+","+chufDate+","+fildNo+","+canbin);
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
						var chufCityPlane = $("#chufCityPlane").text();
						var daodCityPlane = $("#daodCityPlane").text();
						for(var i=0;i<dataList.length;i++){
							for(var j=0;j<dataList[i].seatList.length;j++){
								if((dataList[i].seatList)[j].cangwei==canbin){ //只查找对应舱位的信息 比如用户原先订的是Y舱位的票，那就只能查询Y舱位的票
									var teickNum = (dataList[i].seatList)[j].cangwei_data;
									var arrTime = changeType(dataList[i].arrTime);//到达时间
									var depTime = changeType(dataList[i].depTime);//出发时间
									var costPay = (dataList[i].seatList)[j].onewayPrice; //价格
									var liList='<li><div class="infoContent" style="margin-left:0px;"><div class="airPlane">南方航空('+dataList[i].airCode+')</div><div class="filetNo">'+dataList[i].flightNo+'</div></div><div class="infoContent planeName"><div class="timeClass newttime">'+depTime+'</div><div class="planeNameText">'+chufCityPlane+'</div></div><div class="infoContent"><div style="line-height:50px;"><img src="<%=basePath%>console/images/bigtip1.png"/></div></div><div class="infoContent planeName"><div class="timeClass arrTimenews">'+arrTime+'</div><div class="planeNameText">'+daodCityPlane+'</div></div><div class="infoContent"><span>￥</span><span class="costPayMoney" style="line-height:50px; font-size:30px; color:#FF9900; font-weight:bold;">'+costPay+'</span></div><div class="infoContent"><button class="btnclass" onclick="yudingBtn(this)">预定航班</button></div><div style="clear:both;"></div></li>';
									$("#ulBox").append(liList);									
								}						
							}
						}
					},error:function(){
						
					}
			});
		}
		
		//格式化时间类型
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
		
		//预定该航班按钮
		function yudingBtn(inc){
			var ss = $(inc).parent().parent().children(".infoContent").children(".filetNo").text();//新航班号
			$("#newFileNo").text(ss);
			var newdd = $("#NewchufDate").val(); //新的出发日期
			var newTt = $(inc).parent().parent().children(".infoContent").children(".newttime").text();//新出发时间
			$("#NoTime").text(newdd+" "+newTt);
			var arrTimeNew = $(inc).parent().parent().children(".infoContent").children(".arrTimenews").text();//新出发时间
			$("#arrTimeNew").val(arrTimeNew);
			$(".InfoTure").css("display","block");
		}
	</script>
</body>
</html>
