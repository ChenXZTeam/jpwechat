<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>新建订单</title>
<script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
<style>
	#countryChBox{display:none; width:153px; height:173px; border:1px solid #ccc; overflow-x:auto; font-size:13px; color:#888; position:absolute; top:0px; left:0px; padding:10px; background:#fff;}
	#countryChBox ul{list-style-type:none; padding:0px; margin:0px;}
	#countryChBox ul li{margin-top:5px; padding:5px;}
	#countryChBox ul li:hover{border:1px solid #ccc; cursor:pointer; padding:5px;}
	#countryChBox ul li .countryId{display:none;}
	#RE_countBox{display:none; width:150px; height:173px; border:1px solid #ccc; overflow-x:auto; font-size:13px; color:#888; position:absolute; top:0px; left:0px; padding:10px; background:#fff;}
	#RE_countBox button{padding:0px; margin-top:-10px; border:none; margin-right:-10px; font-size:12px; background:none; float:right; cursor:pointer;}
	#RE_countBox ul{list-style-type:none; padding:0px; margin:0px;}
	#RE_countBox ul li{margin-top:5px; padding:5px;}
	#RE_countBox ul li:hover{border:1px solid #ccc; cursor:pointer; padding:5px;}
	#RE_countBox ul li .countryId{display:none;}
	table{border-top:1px solid #ccc; border-left:1px solid #ccc}
	table tr td{padding:10px; border-bottom:1px solid #ccc; border-right:1px solid #ccc;}
	table tr td input{height:20px; padding-left:7px;}
	table tr td select{height:25px; padding-left:3px;}
</style>
</head>
<body>
<div id="countryChBox">
	<ul id="countryListBox"></ul>
</div>
<div id="RE_countBox">
	<button><img style="width:20px; height:20px;" src="<%=basePath%>console/images/cha.png"/></button>
	<ul id="RE_countryListUl"></ul>
</div>
<table width="1000" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td style="width:100px;">申请国家：</td>
		<td><input type="text" name="applyCountry" id="applyCountry" oninput="findCountry()"/><span id="countryIdNum"></span></td>
	</tr>
	<tr>
		<td>申请人：</td>
		<td><input type="text" name="applyPerson" id="applyPerson"/></td>
	</tr>
	<tr>
		<td>客户类型：</td>
		<td>
			<select name="kehuType" id="kehuType">
				<option value="在职">在职</option>
				<option value="自由职业">自由职业</option>
				<option value="退休">退休</option>
				<option value="在校学生">在校学生</option>
				<option value="学龄儿童">学龄儿童</option>
				<option value="儿童">儿童</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>性别：</td>
		<td>
			<select name="sex" id="sex">
				<option value="男">男</option>
				<option value="女">女</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>支付状态：</td>
		<td>
			<select name="paystatus" id="paystatus">
				<option value="0">未支付</option>
				<option value="1">已支付</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>申请进度：</td>
		<td>
			<select name="progress" id="progress">
				<option value="0">预约中</option>
				<option value="1">进行中</option>
				<option value="2">已完成</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>手机号：</td>
		<td><input type="text" name="personPhone" id="personPhone"/></td>
	</tr>
	<tr>
		<td>电子邮件：</td>
		<td><input type="text" name="Email" id="Email"/></td>
	</tr>
	<tr>
		<td>旅客类型：</td>
		<td>
			<select name="lvkeType" id="lvkeType">
				<option value="成人">成人</option>
				<option value="儿童">儿童</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>身份证：</td>
		<td><input type="text" name="idNum" id="idNum"/></td>
	</tr>
	<tr>
		<td>
			<select name="peisType" id="peisType" style="border:none; outline:none; padding-left:0px; cursor:pointer;">
				<option value="送货上门">送货上门</option>
			</select>
		</td>
		<td><input type="text" name="peisAdd" id="peisAdd"/></td>
	</tr>
</table>
<button id="btnOrder" style="padding:5px 10px; margin-top:10px;">保　存</button>
</body>
<script>
	$(function(){
		//加载全部国家到国家输入框里面
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
						var listLi = '<li><span class="countryId">'+dataList[i].countryID+'</span><span class="countryName">'+dataList[i].country+'</span></li>';
						$("#countryListBox").append(listLi);
					}
				}
			},error:function(){
			
			}
		});
		
		//保存数据
		$("#btnOrder").click(function(){
			var linkName = $("#applyPerson").val();//申请人
			var personWorkIpnt = $("#kehuType").val();//客户类型
			var sexIpnt = $("#sex").val();//性别 
			var phoneNum = $("#personPhone").val();//手机号码
			var EmailAdd = $("#Email").val();//电子邮件
			var trayTypeIpnt = $("#lvkeType").val();//旅客类型
			var IDcase = $("#idNum").val()//身份证号
			var songTypeIpnt = $("#peisType").text();//配送方式
			var sondAdd = $("#peisAdd").val();//配送地址
			var countryIdNum = $("#countryIdNum").text(); //国家代码
			var countryName = $("#applyCountry").val();; //签证国家
			var paystatus = $("#paystatus").val(); //支付状态
			var progress = $("#progress").val(); //申请进度
			var dataList = {
				"linkName":linkName,
				"personWorkIpnt":personWorkIpnt,
				"sexIpnt":sexIpnt,
				"phoneNum":phoneNum,
				"EmailAdd":EmailAdd,
				"trayTypeIpnt":trayTypeIpnt,
				"IDcase":IDcase,
				"songTypeIpnt":songTypeIpnt,
				"sondAdd":sondAdd,
				"countryIdNum":countryIdNum,
				"countryName":countryName,
				"paystatus":paystatus,
				"progress":progress
			}
			$.ajax({
				url:"<%=basePath%>framework/visa/addVisaOrder.action",
				type:"post",
				data:dataList,
				dataType:"json",
				success:function(res){
					if(res.msg==1){
						alert("您的签证订单已生成成功");
						window.location.href="<%=basePath%>console/framework/order/index.jsp";
					}else{
						alert("订单生成失败，请稍后再试");
					}
				},
				error:function(res){
				}
			});
		});
		
		//国家的查找
		$("#applyCountry").click(function(){
			var top = $(this).offset().top;
			var left = $(this).offset().left;
			$("#RE_countBox").css("top",top+23);
			$("#RE_countBox").css("left",left-1);
			$("#RE_countBox").css("display","block");
		});
		
		//关闭搜索结果
		$("#RE_countBox button").click(function(){
			$("#RE_countBox").css("display","none");
			$("#applyCountry").val("");
		});
	});
	
	//输入关键字自动索引城市
	function findCountry(){
		var keyVal = document.getElementById("applyCountry").value;
		$("#countryChBox>#countryListBox>li>.countryName").removeClass("chCountry").filter(":contains(" + keyVal + ")").addClass("chCountry");
		$("#RE_countryListUl").html("");
		if($(".chCountry:eq(0)").text()==null||$(".chCountry:eq(0)").text()==""||$(".chCountry:eq(0)").text()=="null"){
			$("#RE_countryListUl").append('<li><span>无搜索结果</span></li>');
			$("#countryIdNum").text("");
		}else{
			for(var i=0; i<$(".chCountry").length; i++){
				var countryName = $(".chCountry:eq("+i+")").text();
				var countryNum = $(".chCountry:eq("+i+")").prev().text();
				var dateList = '<li onclick="getResult(this)"><span class="countryId">'+countryNum+'</span><span class="countryName">'+countryName+'</span></li>';
				$("#RE_countryListUl").append(dateList);
			}
		}
	}
	
	//搜索结果的点击事件
	function getResult(inc){
		var countryName = $(inc).children(".countryName").text();
		var countryId = $(inc).children(".countryId").text();
		$("#applyCountry").val(countryName);
		$("#countryIdNum").text(countryId);
		$("#RE_countBox").css("display","none");
	}
</script>
</html>