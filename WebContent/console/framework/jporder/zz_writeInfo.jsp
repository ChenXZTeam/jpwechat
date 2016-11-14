<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%	
	String rowstr1=new String(request.getParameter("rowstr1").getBytes("ISO-8859-1"),"utf-8");
	String rowstr2=new String(request.getParameter("rowstr2").getBytes("ISO-8859-1"),"utf-8");
	String cangdate=new String(request.getParameter("cang").getBytes("ISO-8859-1"),"utf-8");
	String chufDate=new String(request.getParameter("chufDate").getBytes("ISO-8859-1"),"utf-8");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>填写信息</title>
	<link href="<%=basePath %>console/css/hDate.css" rel="stylesheet" />
	<script src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
	<script src="<%=basePath%>console/js/hDate.js"></script>
	<script type="text/javascript" src="<%=basePath %>console/js/waritInforma.js"></script>
	<script src="<%=basePath %>console/js/airCodeVScity.js"></script>
<style type="text/css">
    body{margin: 20px 13px;}
    .head{color:#429EFF;}
    .head p{width: 100px;}
    .line{position: relative;border: 1px solid #429EFF;width:93%;float: right;margin-top: -27px;overflow: hidden;}
    .body{border: 1px solid white;}
    .left{position:relative;float:left;border: 1px solid #e1e1e1;width:43%;padding:10px 20px 20px 20px; font-size:14px; color:#666; overflow: hidden;border-radius:5px;}
    .left>div{ margin-top:10px;}
    .pict{position: relative;margin: -250px 420px;color:#429EFF;width: 150px;}
    .right{position: relative;border: 1px solid #429EFF;width: 400px;height: 300px;margin:0px 540px;overflow: hidden;border-radius: 8px;}
    .sum{border: 1px solid #e1e1e1;width:95%;height:30px;margin-top:15px;border-radius: 8px; padding:0px 30px; line-height:30px;}
    .sum>span{float: right; font-size:13px;}
    .information{color:#429EFF;margin-top:30px;}
    .information p{width: 100px;}
    .line2{position: relative;border: 1px solid #429EFF;width:93%;float: right;margin-top: -27px;overflow: hidden;}
    
    .writInfoBox{ margin-top:15px; font-size:14px; color:#666;}
	.writInfoBox ul{list-style-type:none; margin:0px; padding:0px;} 
	.writInfoBox ul li{padding:5px 0px; overflow:hidden;}
	.writInfoBox ul li .spanTit{}
	.writInfoBox ul li input{float:left; border:1px solid #e1e1e1; height:25px; width:346px; padding-left:10px;}
	.writInfoBox ul li span{display:block; float:left; width:85px; line-height:30px;} 
	.writInfoBox ul li img{width:15px;}
	.ChoosClassBox{width:80.5%; height:0px; overflow:hidden; border:1px solid #e1e1e1; position:absolute; top:400px; left:20px; background-color:#FFFFFF; padding:5px 10px; display:none; z-index:1;}
	.ChoosClassBox .ChoosSmallBox{padding:5px; border-bottom:1px solid #e1e1e1;}
	.baoxianBox{margin-top:15px; font-size:14px; color:#666;}
	.baoxianBox .oneClassBX{float:left;}
	.aBtn{margin-top:15px; cursor:pointer; display:block; padding:10px 0px; background-color:#007AFF; border-radius:5px; color:#FBFDFF; font-size:12px; text-align:center; width:100px; margin-left:0px;}
</style>
</head>
<body>

	<div class="head">
         <p><b>确认信息</b></p>
         <div class="line">
         </div>
	</div>
	<div class="body">
	     <div class="left">
	      <div>第一航段信息</div>
          <div>
            <span>出发日期:</span>
            <span id="ChufDate"></span>
          </div>
          <div>
            <span>起始机场:</span>
            <span id="QishiPlan"></span>
          </div>
          <div>
            <span>到达机场:</span>
            <span id="DaodPlan"></span>
          </div>
          <div>
            <span>起飞时间:</span>
            <span id="ChufTime"></span>
          </div>
          <div>
            <span>到达时间:</span>
            <span id="DaodTime"></span>
          </div>
          <div>
            <span>航班号:</span>
            <span id="fildNumfly"></span>
          </div>
          <div>
            <span>航空公司:</span>
            <span id="airCode"></span>
          </div>
          <div>
            <span>飞行历时:</span>
            <span id="countTime"></span>
          </div>
          <div><span>费用：</span><span id="countMoney"></span></div>
	   </div>
       <div class="left" style="margin-left:5%;"> 
	      <div>第二航段信息</div>
          <div>
            <span>出发日期:</span>
            <span id="ChufDate2"></span>
          </div>
          <div>
            <span>起始机场:</span>
            <span id="QishiPlan2"></span>
          </div>
          <div>
            <span>到达机场:</span>
            <span id="DaodPlan2"></span>
          </div>
          <div>
            <span>起飞时间:</span>
            <span id="ChufTime2"></span>
          </div>
          <div>
            <span>到达时间:</span>
            <span id="DaodTime2"></span>
          </div>
          <div>
            <span>航班号:</span>
            <span id="fildNumfly2"></span>
          </div>
          <div>
            <span>航空公司:</span>
            <span id="airCode2"></span>
          </div>
          <div>
            <span>飞行历时:</span>
            <span id="countTime2"></span>
          </div>
          <div><span>费用：</span><span id="countMoney2"></span><span id="TurecostPay" style="display:none;"></span></div>
      </div>
      <div style="clear:both;"></div>
      <div style="display:none;"><span id="countMoney3"></span><span id="countMoney4"></span></div>
  </div>
  <div class="sum">
       <span style="color:#ff0000; font-weight:bold; font-size:18px;"><b id="costPay">2500</b></span><span style="font-family:'微软雅黑'">￥</span>
  </div>
  <div class="information">
       <p><b>资料填写</b></p>
       <div class="line2"></div>
  </div>
<!-- 填写乘机人信息 -->
<div class="writInfoBox">
	<ul>
		<li><span class="spanTit">姓名：</span><input id="linkName" type="text"/><span style="clear:both;"></span></li>
		<li><span class="spanTit">性别：</span><input type="text" id="sexIpnt" readonly="readonly" style="cursor:pointer;"/><span style="margin-top:7px; margin-left:-20px; cursor:pointer;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span><span style="clear:both;"></span></li>
		<li><span class="spanTit">出生日期：</span><input type="text" id="birthIpnt" onclick="calendar.show({ id: this })" style="cursor:pointer;"/><span style="float:left; margin-top:7px; margin-left:-20px;"><img src="<%=basePath %>console/images/riliImg.png" style="width:15px;"/></span><span style="clear:both;"></span></li>
		<li><span class="spanTit">手机号：</span><input id="phoneNum" type="text"/><span style="clear:both;"></span></li>
		<li><span class="spanTit">旅客类型：</span><input type="text" id="personIpnt" readonly="readonly" style="cursor:pointer;"/><span style="margin-top:7px; margin-left:-20px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span><span style="clear:both;"></span></li>
		<li><span class="spanTit" id="caseIpnt" style="width:68px; cursor:pointer;">证件类型</span><span style="width:15px; padding-top:4px;"><img src="<%=basePath %>console/images/xialaPonting.png" style="padding-top:4px;"/></span><input id="IDcase" type="text" placeholder="请输入证件号码"/><span style="clear:both;"></span></li>
	</ul>
</div>
<div class="baoxianBox">
	<div class="oneClassBX"><a class="checkboxA"></a><a class="checkboxB"></a><input type="checkbox" class="checkBoxId flindYw" name="flindYw" value="购买"/><span class="spanTitBX">航空意外险</span></div>
	<div class="oneClassBX" style="margin-left:20px;"><a class="checkboxA"></a><a class="checkboxB"></a><input type="checkbox" class="checkBoxId delayBx" name="delayBx" value="购买"/><span class="spanTitBX">延误取消险</span></div>
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
	<div style="display:none;"><span class="firstair"></span><span class="scondair"></span></div>
	<div style="clear:both;"></div>
</div>
<a class="aBtn">提交订单</a>
<script>
	var strRow1 = '<%=rowstr1%>';
	var strRow2 = '<%=rowstr2%>';
	var obj1 = JSON.parse(strRow1);
	var obj2 = JSON.parse(strRow2);
	obj1.sign = "1";  //为第一航班添加一个标志
	obj2.sign = "2";  //为第二航班也添加一个标志
	console.log(obj1);
	console.log(obj2);
	var cangwei = "<%=cangdate%>";
	var chufDate = "<%=chufDate%>";
	var chufDateTaO = chufDate.split(",");
	if(chufDateTaO.length>1){
		$("#ChufDate").text(chufDateTaO[0]);
		$("#ChufDate2").text(chufDateTaO[1]);
	}else{
		$("#ChufDate").text(chufDate);
		$("#ChufDate2").text(gsDate(obj2.depTime,chufDate));
	}
	//第一航段信息
	$("#ChufTime").text(gTime(obj1.depTime));
	$("#DaodTime").text(gTime(obj1.arrTime));
	$("#ChufCity").text(obj1.orgCity);
	$("#DaodCity").text(obj1.dstCity);
	$("#QishiPlan").text(obj1.deplaneName);
	$("#fildNumfly").text(obj1.flightNo);
	$("#airCode").text(findByCode(obj1.airCode));//航空公司
	$("#DaodPlan").text(obj1.arrPlaneName);
	$("#countTime").text(cuntTime(obj1.depTime,obj1.arrTime));
	$(".firstair").text(obj1.airCode);
	
	//第二航段信息
	$("#ChufTime2").text(gTime(obj2.depTime));
	$("#DaodTime2").text(gTime(obj2.arrTime));
	$("#ChufCity2").text(obj2.orgCity);
	$("#DaodCity2").text(obj2.dstCity);
	$("#QishiPlan2").text(obj2.deplaneName);
	$("#fildNumfly2").text(obj2.flightNo);
	$("#airCode2").text(findByCode(obj2.airCode));//航空公司
	$("#DaodPlan2").text(obj2.arrPlaneName);
	$("#countTime2").text(cuntTime(obj2.depTime,obj2.arrTime));
	$(".scondair").text(obj2.airCode);
	//价格显示
	var onePay,twoPay,oneCang,twoCang;
	var rowseatInfo1 = obj1.seatList;
	var rowseatInfo2 = obj2.seatList;
	for(var k=0; k<rowseatInfo1.length; k++){  //第一段航班的对应舱位的价格
		if(rowseatInfo1[k].cangwei == cangwei){
			onePay = rowseatInfo1[k].onewayPrice;
			oneCang = rowseatInfo1[k].cangwei; //第一段航班的舱位
		}
	}
	for(var k=0; k<rowseatInfo2.length; k++){	//第二段航班的对应舱位的价格
		if(rowseatInfo2[k].cangwei == cangwei){
			twoPay = rowseatInfo2[k].onewayPrice;
			twoCang = rowseatInfo2[k].cangwei; //第二段航班的舱位
		}
	}
	
	$("#costPay").text((parseFloat(onePay)+parseFloat(twoPay)).toFixed(2));
	$("#TurecostPay").text((parseFloat(onePay)+parseFloat(twoPay)).toFixed(2));
	$("#countMoney").text(onePay);
	$("#countMoney2").text(twoPay);
	
	//提交订单按钮的点击事件
	$(".aBtn").click(function(){
		//第一段航班
		var ChufDate1 = $("#ChufDate").text();//出发日期
		var ChufTime1 = $("#ChufTime").text();//出发时间
		var DaodTime1 = $("#DaodTime").text();//到达时间
		var ChufCity1 = findByCity(obj1.orgCity);//出发城市
		var DaodCity1 = findByCity(obj1.dstCity);//到达城市
		var QishiPlan1 = $("#QishiPlan").text();//起始机场
		var hangbanNum1 = $("#fildNumfly").text(); //航班号
		var airCode1 = $(".firstair").text(); //航空公司
		var DaodPlan1 = $("#DaodPlan").text();//到达机场
		var lishiTime1 = $("#countTime").text(); //历时多长时间
		var CostPay1 = $("#countMoney").text();//该付金额
		
		//第二段航班
		var ChufDate2 = $("#ChufDate2").text();//出发日期
		var ChufTime2 = $("#ChufTime2").text();//出发时间
		var DaodTime2 = $("#DaodTime2").text();//到达时间
		var ChufCity2 = findByCity(obj2.orgCity);//出发城市
		var DaodCity2 = findByCity(obj2.dstCity);//到达城市
		var QishiPlan2 = $("#QishiPlan2").text();//起始机场
		var hangbanNum2 = $("#fildNumfly2").text(); //航班号
		var airCode2 = $(".scondair").text(); //航空公司
		var DaodPlan2 = $("#DaodPlan2").text();//到达机场
		var lishiTime2 = $("#countTime2").text(); //历时多长时间
		var CostPay2 = $("#countMoney2").text();//该付金额
		
		//乘机人资料
		var LinkName=$("#linkName").val();//乘机人
		var Sex=$("#sexIpnt").val();//性别
		var iDcaseType=$("#caseIpnt").text();//证件类型
		var iDcase=$("#IDcase").val();//证件号码
		var PhoneNum=$("#phoneNum").val();//手机号码
		var YiwaiBX=$("input[name='flindYw']:checked").val();//意外保险
		var YanwuBX=$("input[name='delayBx']:checked").val();//延误险
		var cangweiType=oneCang;
		var birthDay = $("#birthIpnt").val();//生日
		var age = ageFunc(birthDay);//年龄
		var menType = $("#personIpnt").val();//乘机人类型
		
		//将航班数据打包到json数据里面
		var jsondatastr = '{"firstFild":[{"ChufDate":"'+ChufDate1+'","ChufTime":"'+ChufTime1+'","DaodTime":"'+DaodTime1+'","ChufCity":"'+ChufCity1+'","DaodCity":"'+DaodCity1+'","QishiPlan":"'+QishiPlan1+'","hangbanNum":"'+hangbanNum1+'","airCode":"'+airCode1+'","DaodPlan":"'+DaodPlan1+'","lishiTime":"'+lishiTime1+'","CostPay":"'+CostPay1+'","LinkName":"'+LinkName+'","Sex":"'+Sex+'","iDcaseType":"'+iDcaseType+'","iDcase":"'+iDcase+'","PhoneNum":"'+PhoneNum+'","YiwaiBX":"'+YiwaiBX+'","YanwuBX":"'+YanwuBX+'","cangweiType":"'+cangweiType+'","birthDay":"'+birthDay+'","age":"'+age+'","menType":"'+menType+'","depcityCode1":"'+obj1.orgCity+'","arrcityCode1":"'+obj1.dstCity+'"}],"sconedFild":[{"ChufDate":"'+ChufDate2+'","ChufTime":"'+ChufTime2+'","DaodTime":"'+DaodTime2+'","ChufCity":"'+ChufCity2+'","DaodCity":"'+DaodCity2+'","QishiPlan":"'+QishiPlan2+'","hangbanNum":"'+hangbanNum2+'","airCode":"'+airCode2+'","DaodPlan":"'+DaodPlan2+'","lishiTime":"'+lishiTime2+'","CostPay":"'+CostPay2+'","LinkName":"'+LinkName+'","Sex":"'+Sex+'","iDcaseType":"'+iDcaseType+'","iDcase":"'+iDcase+'","PhoneNum":"'+PhoneNum+'","YiwaiBX":"'+YiwaiBX+'","YanwuBX":"'+YanwuBX+'","cangweiType":"'+cangweiType+'","birthDay":"'+birthDay+'","age":"'+age+'","menType":"'+menType+'","depcityCode2":"'+obj2.orgCity+'","arrcityCode2":"'+obj2.dstCity+'"}]}';
		//var jsondata = JSON.parse(jsondatastr);
		$.ajax({
					url:"<%=basePath%>userOrderController/add/zrorder.action",
					type:"POST",
					data:{"jsStr":jsondatastr},
					dataType:"json",
					beforeSend:function(){$(".loadingBox").css("display","block");},
					complete:function(){$(".loadingBox").css("display","none");},
					success:function(result){
						alert(result);
					},
					error:function(result){
					}
		});	
	});
	
	//保险的计算价格
	$(".flindYw").click(function(){
		var SubPayMoney = $("#TurecostPay").text();
		var oneMoney = $("#countMoney3").text();
		var twoMoney = $("#countMoney4").text();
		var newPayMoney = 0;
		var newoneMoney = 0;
		var newtwoMoney = 0;
		if($(this).attr("checked")=="checked"){
			newPayMoney = (parseFloat(SubPayMoney)+parseFloat(60)).toFixed(2);
			$("#costPay").text(newPayMoney);
			$("#TurecostPay").text(newPayMoney);
			newoneMoney = (parseFloat(oneMoney)+parseFloat(30)).toFixed(2);
			newtwoMoney = (parseFloat(twoMoney)+parseFloat(30)).toFixed(2);
			$("#countMoney").text(newoneMoney);
			$("#countMoney2").text(newtwoMoney);
			$("#countMoney3").text(newoneMoney);
			$("#countMoney4").text(newtwoMoney);
		}else{
			if(newPayMoney!=SubPayMoney){
				newPayMoney = (parseFloat(SubPayMoney)-parseFloat(60)).toFixed(2);
				newoneMoney = (parseFloat(oneMoney)-parseFloat(30)).toFixed(2);
				newtwoMoney = (parseFloat(twoMoney)-parseFloat(30)).toFixed(2);
			}
			$("#costPay").text(newPayMoney);
			$("#TurecostPay").text(newPayMoney);	
			$("#countMoney").text(newoneMoney);
			$("#countMoney2").text(newtwoMoney);	
			$("#countMoney3").text(newoneMoney);
			$("#countMoney4").text(newtwoMoney);
		}	
	});
	
	$("#countMoney3").text(onePay);
	$("#countMoney4").text(twoPay);
	
	$(".delayBx").click(function(){
		var SubPayMoney = $("#TurecostPay").text();
		var oneMoney = $("#countMoney3").text();
		var twoMoney = $("#countMoney4").text();
		var newPayMoney = 0;
		var newoneMoney = 0;
		var newtwoMoney = 0;
		if($(this).attr("checked")=="checked"){
			newPayMoney = (parseFloat(SubPayMoney)+parseFloat(40)).toFixed(2);
			$("#costPay").text(newPayMoney);
			$("#TurecostPay").text(newPayMoney);
			newoneMoney = (parseFloat(oneMoney)+parseFloat(20)).toFixed(2);
			newtwoMoney = (parseFloat(twoMoney)+parseFloat(20)).toFixed(2);
			$("#countMoney").text(newoneMoney);
			$("#countMoney2").text(newtwoMoney);
			$("#countMoney3").text(newoneMoney);
			$("#countMoney4").text(newtwoMoney);
		}else{
			if(newPayMoney!=SubPayMoney){
				newPayMoney = (parseFloat(SubPayMoney)-parseFloat(40)).toFixed(2);
				newoneMoney = (parseFloat(oneMoney)-parseFloat(20)).toFixed(2);
				newtwoMoney = (parseFloat(twoMoney)-parseFloat(20)).toFixed(2);
			}
			$("#costPay").text(newPayMoney);
			$("#TurecostPay").text(newPayMoney);
			$("#countMoney").text(newoneMoney);
			$("#countMoney2").text(newtwoMoney);	
			$("#countMoney3").text(newoneMoney);
			$("#countMoney4").text(newtwoMoney);
		}	
	});


		//计算历经多长时间到达
		function cuntTime(depTime,arrTime){
			var sTime = changesTime(depTime); //出发时间的秒
			var oTime = changesTime(arrTime); //到达时间的秒
			var chaTime = oTime-sTime; //两个时间相差的秒
			var liTime = parseInt(chaTime/3600)+"时"+parseInt((chaTime%3600)/60)+"分";
			//alert(depTime+"->"+changesTime(depTime)+"/"+arrTime+"->"+changesTime(arrTime)+"/"+liTime);
			return liTime;
		}
		
		//根据时间参数化成秒
		function changesTime(time){
			var ohh,omm,ocount;
			if(time.indexOf("+")>0||time.indexOf(" ")>0){
				ohh = time.substring(0,2);
				omm = time.substring(2,4);
				ocount = ohh*3600+omm*60+24*3600;
			}else{
				ohh = time.substring(0,2);
				omm = time.substring(2,time.length);
				ocount = ohh*3600+omm*60;
			}
			return ocount;
		}
		
		//格式化时间
		function gTime(timestr){
			//timestr = timestr.replace(" ","+"); 
			if(timestr.length>4){
				timestr = timestr.substring(0,4);
			}
			return timestr.substring(0,2)+":"+timestr.substring(2,timestr.length);
		}
		
		//格式化舱位
		function cnCang(basicCabin){
			if(basicCabin=="公务舱"){
				basicCabin="C";
			}else if(basicCabin=="头等舱"){
				basicCabin="F";
			}else if(basicCabin=="经济舱"){
				basicCabin="Y";
			}
			return basicCabin;
		}
		
		//格式化第二段的出发日期
		function gsDate(detTime, chufDate){
			if(detTime.indexOf("+")>0||detTime.indexOf(" ")>0){
				var date = new Date(chufDate);
			 	date.setDate(date.getDate() + 1);
			 	var yy = date.getFullYear();
			 	var mm = date.getMonth()+1;
			 	var dd = date.getDate();
			 	if(mm < 10){
			 		mm = "0"+mm;
			 	}
			 	if(dd<10){
			 		dd = "0"+dd;
			 	}
				chufDate = yy+"-"+mm+"-"+dd;
			}
			return chufDate;
		}
		
	function ageFunc(birthday){
		var age = 0;
		var birth = birthday.split("-");	//对生日进行拆分
		var today=new Date();				//创建今天的日期
	    var todayYear=today.getFullYear();	//今天的年
	    var ageNum = todayYear*1 - birth[0]*1;
	    if(ageNum > 0){
	    	age = ageNum;
	    }else{
	    	alert("年龄选择错误，请重新选择！");
	    	return false;
	    }
		return age;
	}
</script>
</body>
</html>