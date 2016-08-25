<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%	
	//session.invalidate();
	String username=(String) session.getAttribute("userName");
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
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>填写信息_订票</title>
<script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
<style>
	#querenInfo{width:100%; height:100%; background-color:rgba(255,255,255,1); position:absolute; top:0px; left:0px; z-index:999; display:none;}
	#querenInfo ul{list-style-type:none; padding:0px;}
	#querenInfo .threeBtn{}
	#querenInfo .threeBtn .infoError{background-color:#FF9913; padding:5px; display:block; float:left; margin-left:10px; color:#ffffff;}
</style>
</head>
<body>
<script>
$(function(){
	var username="<%=username%>";
	if(username==""||username=="null"){
		alert("登录才能订票");
		$("#loginPage").css("display","block");
	}else{
		<%-- window.location.href="<%=basePath%>console/wechat/logo.jsp"; --%>
		alert("我已经登录了"+username);
	}
});

</script>
<div>来到这一步就需要你填写信息进行订票，并且判断是否登录</div>

<div id="bigContent">
	<div style="display:block;">
		<div><input type="text" id="chufTime" value="<%=chufTime %>"/></div>
		<div><input type="text" id="daodTime" value="<%=arrDTime %>"/></div>
		<div><input type="text" id="chufDate" value="<%=chufDate%>"/></div>
		<div><input type="text" id="chufCity" value="<%=chufCityID%>"/></div>
		<div><input type="text" id="daodCity" value="<%=daodCityID%>"/></div>
		<div><input type="text" id="qishiPlan" value="<%=shiPlace %>"/></div>
		<div><input type="text" id="daodPlan" value="<%=zhongPlace %>"/></div>
		<div><input type="text" id="costPay" value="<%=cost %>"/></div>
		<div><input type="text" id="isDengJi" value="no"/></div>
		<div><input type="text" id="payCost" value="no"/></div>
		<div><input type="text" id="zhekou" value="<%=zhekou %>"/></div>
		<div><input type="text" id="cangweiType" value="<%=cangweiType %>"/></div>
	</div>
	
	<div>旅客类型：
		<select id="menType">  
			<option value="ADT" selected="selected">成人</option>  
			<option value="CHD">儿童</option>
			<option value="INF">婴儿</option>
		</select>
	</div>
	<div><input type="text" id="linkName"/></div>
	<div><input type="radio" name="sex" value="男" checked="checked"/>男 <input type="radio" name="sex" value="女"/>女</div>
	<div>
		<select id="IDcaseType">  
			<option value="NI" selected="selected">身份证</option>  
			<option value="PP">护照</option>
			<option value="ID">其他</option>
		</select> 
		<input type="text" id="IDcase"/>
	</div>
	<div>手机号码：<input type="text" id="phoneNum"/></div>
	<div>出生时间: <input type="text" id="birthday"/></div>
	<div><input type="checkbox" name="yiwaiBX" id="yiwaiBX" value="yes"/>是否购买意外险</div>
	<div><input type="checkbox" name="yanwuBX" id="yanwuBX" value="yes"/>是否购买延误险</div>
	<div><a style="display:block; padding:5px; color:#ffffff; text-align:center; background-color:#FF9913;" id="nextButton">下一步</a></div>
</div>


<!-- 登录界面 -->
<div id="loginPage" style="width:100%; height:100%; background-color:rgba(0,0,0,0.5); position:absolute; top:0px; left:0px; z-index:999; display:none;">
	<div id="loginDiv" style="width:80%; height:130px; position:absolute; background-color:rgb(255,255,255);  top:10%; left:10%;">
		<div style="font-family:Arial, Helvetica, sans-serif; font-size:12px; color:#666666; border-bottom:1px solid #E4E4E4; padding:6px 5px;"><span>登录名</span><input type="text" id="userN" style="margin-left:20px; border:none; outline:none;" placeholder="用户名/手机号"/></div>
		<div style="font-family:Arial, Helvetica, sans-serif; font-size:12px; color:#666666; border-bottom:1px solid #E4E4E4; padding:6px 5px;"><span>密　码</span><input type="text" id="passW" style="margin-left:20px; border:none; outline:none;" placeholder="请输入1~16位密码"/></div>
		<div id="buttom"><button style="width:90%; margin-left:5%; margin-top:15px; background-color:#FF9913; color:#ffffff; font-size:16px; border:none; padding:10px; font-weight:bold;">登　录</button></div>
	</div>
</div>

<!-- 信息确认界面 -->
<div id="querenInfo" style="height:700px;">
	<ul>
		<li><span>出发日期：</span><span id="ChufDate"></span></li>
		<li><span>出发时间：</span><span id="ChufTime"></span></li>
		<li><span>到达时间：</span><span id="DaodTime"></span></li>
		<li><span>出发城市：</span><span id="ChufCity"></span></li>
		<li><span>到达城市：</span><span id="DaodCity"></span></li>
		<li><span>起始机场：</span><span id="QishiPlan"></span></li>
		<li><span>到达机场：</span><span id="DaodPlan"></span></li>
		<li><span>价　　格：</span><span id="CostPay"></span></li>
		<li><span>姓　　名：</span><span id="LinkName"></span></li>
		<li><span>性　　别：</span><span id="Sex"></span></li>
		<li><span id="iDcaseType">证 件 号</span><span>：</span><span id="iDcase"></span></li>
		<li><span>乘机人类型：</span><span id="MenType"></span></li>
		<li><span>手机号码：</span><span id="PhoneNum"></span></li>
		<li><span>购买意外险：</span><span id="YiwaiBX"></span></li>
		<li><span>购买延误险：</span><span id="YanwuBX"></span></li>
	</ul>
	<div class="threeBtn"><a class="infoError" id="yesTrue">信息正确</a><a class="infoError" id="selfFalse">个人信息错误</a><a class="infoError" id="hanbanFalse">航班信息错误</a></div>
</div>
</body>
<script>
	$(function(){
		//确认信息是否正确
		$("#nextButton").click(function(){
			$("#ChufDate").text($("#chufDate").val());
			$("#ChufTime").text($("#chufTime").val());
			$("#DaodTime").text($("#daodTime").val());
			$("#ChufCity").text($("#chufCity").val());
			$("#DaodCity").text($("#daodCity").val());
			$("#QishiPlan").text($("#qishiPlan").val());
			$("#DaodPlan").text($("#daodPlan").val());
			$("#CostPay").text($("#costPay").val());
			$("#LinkName").text($("#linkName").val());
			$("#Sex").text($("input[name='sex']:checked").val());
			$("#iDcaseType").text($("#IDcaseType").val());
			$("#MenType").text($("#menType").val());
			$("#iDcase").text($("#IDcase").val());
			$("#PhoneNum").text($("#phoneNum").val());
			//意外险的值
			if($("input[name='yiwaiBX']").is(':checked')){
				$("#YiwaiBX").text($("input[name='yiwaiBX']:checked").val());
			}else{
				$("#YiwaiBX").text("");
			}
			//延误险值
			if($("input[name='yanwuBX']").is(':checked')){
				$("#YanwuBX").text($("input[name='yanwuBX']:checked").val());
			}else{
				$("#YanwuBX").text("");
			}
			$(document).attr("title","机票预定_确认信息");
			$("#querenInfo").css("display","block");
		});
		
		//信息正确按钮		
		var fals=true;//防止重复提交
		$("#yesTrue").click(function(){
			//$("#querenInfo").css("display","none");			
			var ChufDate=$("#ChufDate").text();//出发日期
			var ChufTime=$("#ChufTime").text();//出发时间
			var DaodTime=$("#DaodTime").text();//到达时间
			var ChufCity=$("#ChufCity").text();//到达时间
			var DaodCity=$("#DaodCity").text();//到达时间
			var QishiPlan=$("#QishiPlan").text();//起始机场(包含起始机场和航班号，所以得进行拆分)
			var arr = QishiPlan.split(" ");
				QishiPlan=arr[0];
			var hangbanNum=arr[1];
			var airCode = hangbanNum.substring(0,2);
			var DaodPlan=$("#DaodPlan").text();//到达机场(包含到达机场和历经的时候，所以得进行拆分)
			var arr1 = DaodPlan.split(" ");
				DaodPlan=arr1[0];
			var lishiTime=arr1[1];
			var CostPay=$("#CostPay").text().substr(1,$("#CostPay").text().length);//该付金额
			var LinkName=$("#LinkName").text();//乘机人
			var Sex=$("#Sex").text();//性别
			var iDcaseType=$("#iDcaseType").text();//证件类型
			var iDcase=$("#iDcase").text();//证件号码
			var PhoneNum=$("#PhoneNum").text();//手机号码
			var YiwaiBX=$("#YiwaiBX").text();//意外保险
			var YanwuBX=$("#YanwuBX").text();//延误险
			var cangweiType=$("#cangweiType").val();
			var birthDay = $("#birthday").val();//生日
			var age = ageFunc(birthDay);//年龄
			var menType = $("#MenType").text();//乘机人类型
			var date={
				"ChufDate":ChufDate,
				"ChufTime":ChufTime,
				"DaodTime":DaodTime,
				"ChufCity":ChufCity,
				"DaodCity":DaodCity,
				"QishiPlan":QishiPlan,
				"hangbanNum":hangbanNum,
				"DaodPlan":DaodPlan,
				"lishiTime":lishiTime,
				"CostPay":CostPay,
				"LinkName":LinkName,
				"Sex":Sex,
				"iDcaseType":iDcaseType,
				"iDcase":iDcase,
				"PhoneNum":PhoneNum,
				"YiwaiBX":YiwaiBX,
				"YanwuBX":YanwuBX,
				"cabin":cangweiType,
				"birthday":birthDay,
				"menType":menType,
				"airCode":airCode,
				"age":age
			};
			if(fals==true){
				$.ajax({
					url:"<%=basePath%>userOrderController/add/order.action",
					type:"POST",
					data:date,
					dataType:"json",
					success:function(result){
						alert("机票预定成功");
						console.log(result.planMsg);	
						window.location.href="<%=basePath%>console/wechat/myPlaneTickek.jsp";					
						fals=false;
					},
					error:function(result){
						alert("订单提交失败");
					}
				});			
			}
		});
		
		//航班定错的时候
		$("#hanbanFalse").click(function(){
			history.go(-1); 
		});
		
		//个人信息错误的时候
		$("#selfFalse").click(function(){
			$(document).attr("title","填写信息_订票");			
			$("#querenInfo").css("display","none");
		});
	
		$("button").click(function(){
			var userN=$("#userN").val();
			var passW=$("#passW").val();
			$.ajax({
					url: "<%=basePath %>wechatController/wechat/login.action",
					type: "POST",
					data: {
							"userName":userN, "PassWord":passW
					},
					dataType: "json",
					success: function(result) {
						if(result.msg==1){						
							//上面的条件正确时候改变按钮格式
							$("button").css("background-color","#dddddd");
							$("button").css("color","#666666");
							$("button").css("border","#cccccc solid 1px");
							$("button").html("");
							$("button").html("加载中...");
							alert("登录成功，可以订票咯^_^");
							$("#loginPage").css("display","none");
						}else{
							alert("登录失败");
							$("#loginPage").css("display","block");
						}							
					},
					error: function() {
						alert("登录失败");
					}
			});
		});
	});
	
	function ageFunc(birthday){
		var age = 0;
		var birth = birthday.split("-");	//对生日进行拆分
		var today=new Date();				//创建今天的日期
	    var todayYear=today.getFullYear();	//今天的年
	    var ageNum = todayYear*1 - birth[0]*1;
	    if(ageNum > 0){
	    	age = ageNum;
	    	alert("年龄是："+age);
	    }else{
	    	alert("年龄选择错误，请重新选择！");
	    	return false;
	    }
		return age;
	}
</script>
</html>