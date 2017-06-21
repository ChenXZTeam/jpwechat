<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>新建常用联系人信息</title>
<link rel="stylesheet" href="<%=basePath %>console/css/waritInforma.css"/>
<link rel="stylesheet" href="<%=basePath %>console/css/normalize3.0.2.min.css" />
<link rel="stylesheet" href="<%=basePath %>console/css/mobiscroll.css"/>
<link rel="stylesheet" href="<%=basePath %>console/css/mobiscroll_date.css"/>
<link rel="stylesheet" href="<%=basePath%>console/css/weui.min.css" />
<link rel="stylesheet" href="<%=basePath%>scripts/common/weui/css/weui.css" />
<link rel="stylesheet" href="<%=basePath%>console/css/jquery-weui.css" />
<link rel="stylesheet" type="text/css"  href="<%=basePath%>console/css/loading.css" />
<script type="text/javascript" src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script src="<%=basePath %>console/js/mobiscroll_date.js" chatset="utf-8"></script> 
<script src="<%=basePath %>console/js/jquery-weui.js"></script>
<script src="<%=basePath %>scripts/common/weui/js/zepto.min.js"></script>
<script src="<%=basePath %>console/js/mobiscroll.js"></script> 
<style>
	.writInfoBox{margin-top:0px;}
	.writInfoBox ul li{line-height:50px;}
	.ChoosClassBox{width:80.5%; height:0px; overflow:hidden; border:1px solid #e1e1e1; position:absolute; top:400px; left:20px; background-color:#FFFFFF; padding:5px 10px; display:none; z-index:1;}
	.ChoosClassBox .ChoosSmallBox{padding:5px; border-bottom:1px solid #e1e1e1;}
	.checkboxA{ border:#C9C9C9 1px solid; background-color:#fff; width:16px; height:16px; display:block; z-index:-1; float:left; border-radius:8px; margin-top:3px;}
	.checkboxB{ background-color:#0079FE; border-radius:4px; width:8px; height:8px; display:block; float:left; margin-left:-11.544px; margin-top:6.599999px; display:none;}
	.btnBox{width:88.55%; margin-left:auto; margin-right:auto; overflow:hidden;}
	.btnBox .aBtn{padding:10px 0px; float:right; width:48%;font-size:15px; line-height:25px; height:24px;}
	.btnBox #btnQ{margin-top: 15px; float:left; display: block; padding:10px 0px; background-color:#ccc; border-radius: 5px; color: #FBFDFF; font-size: 15px; text-align: center; width:48%; margin-left: auto; margin-right: auto;}
</style>
<script>
$(function(){ 
		//保存联系人的方法
		$(".aBtn").click(function(){
			var linkName = $("#linkName").val();
			var linkPhoneNum = $("#linkPhoneNum").val();
			var sexIpnt = $("#sexIpntSource").text().trim();
			var birthIpnt = $("#birthIpnt").val();
			var caseIpnt = $("#caseIpntSource").text().trim();
			var IDcase = $("#IDcase").val();
			var chinaName = $("#chinaName").val();
			var caseTime = $("#caseTime").val();
			var contryName = $("#contryName").val();
			if(linkName==""||linkName==null){
				$.alert("联系人不能为空");
				return false;
			}
			if(linkPhoneNum==""||linkPhoneNum==null){
				$.alert("联系电话不能为空");
				return false;
			}
			if(birthIpnt==""||birthIpnt==null){
				$.alert("出生日期不能为空");
				return false;
			}
			if(IDcase==""||IDcase==null){
				$.alert("证件号码不能为空");
				return false;
			}
			if($("#caseIpntSource").text()=="NI"){
				if(codeSf()){}else{
					$.alert("身份证号码输入错误，请认真核实！");
					return false;
				}
				if(caseAndbirth(IDcase,birthIpnt)){}else{
					return false;
				}
			}
			var peopleType = "";
			var ages = ageFunc(birthIpnt,nowdate());
			//旅客类型
			if(ages<2){
				peopleType = "INF"; //婴儿  
			}else if(ages>=2&&ages<=12){
				peopleType = "CHD"; //儿童
			}else{
				peopleType = "ADT"; //成人票
			}
			console.log(linkName+","+linkPhoneNum+","+sexIpnt+","+birthIpnt+","+caseIpnt+","+IDcase+","+chinaName+","+caseTime+","+contryName+","+peopleType);
			//return false;
			$.ajax({ 
				url:"<%=basePath%>userOrderController/addInfoForUser.action",
				type:"POST",
				data:{
					"linkman":linkName,
					"linkNumber":linkPhoneNum,
					"sex":sexIpnt,
					"birthday":birthIpnt,
					"peopleType":peopleType,
					"caseType":caseIpnt,
					"caseNum":IDcase,
					"chinaName":chinaName,
					"caseTime":caseTime,
					"belongCtry":contryName
				},
				dataType:"json",
				success: function(data) {
					if(data==1||data=="1"){
						window.location.href="<%=basePath %>console/wechat/linkman.jsp";
					}else if(data==2||data=="2"){
						$.alert("保存失败，常用联系人已存在！");
					}else{
						$.alert("保存失败");
					}
				},error:function(){
				
				}
			});		
		});
		
		//取消保存的按钮
		$("#btnQ").click(function(){
			window.location.href="<%=basePath %>console/wechat/linkman.jsp";
		});
		
		//判断输入的身份证是否正确
		$("#IDcase").change(function(){
			//用户选择输入身份证的时候才会校验  选择护照或者其他 不会校验
			if($("#caseIpntSource").text()=="NI"){
				if(codeSf()){}else{
					$.alert("身份证号码输入错误，请认真核实！");
				}
			}
		});
		
		$("#sexIpnt").on('click',function (){  
	        weui.picker([{
							label:'先生', 
	            			value:'F'
	        		   },{  
	        		   		label:'女士',
	            			value:'M'
	        		   }],{  
	            			onChange: function (result) {  
	                			//改变函数
	            			},  
	            			onConfirm: function (result) {  
								$("#sexIpntSource").text(result); 
								$("#sexIpnt").val(sourceSex(1,result));
	            			}  
	        	});  
    	});
    	
    	$("#personIpnt").on('click',function (){  
	        weui.picker([{
							label:'成人', 
	            			value:'ADT'
	        		   },{  
	        		   		label:'儿童',
	            			value:'CHD'
	        		   },{  
	        		   		label:'婴儿',
	            			value:'INF'
	        		   }],{  
	            			onChange: function (result) {  
	                			//改变函数
	            			},  
	            			onConfirm: function (result) {  
								$("#personIpntSource").text(result); 
								$("#personIpnt").val(sourceSex(2,result)); 
	            			}  
	        	});  
    	});
		
		$("#caseIpnt").on('click',function (){  
	        weui.picker([{
							label:'身份证', 
	            			value:'NI'
	        		   },{  
	        		   		label:'护照',
	            			value:'PP'
	        		   },{  
	        		   		label:'其他',
	            			value:'ID' 
	        		   }],{  
	            			onChange: function (result) {  
	                			//改变函数
	            			},  
	            			onConfirm: function (result) {  
								$("#caseIpnt").text(sourceSex(3,result)); 
								$("#caseIpntSource").text(result); 
	            			}  
	        	});  
    	});
		
});

function codeSf(){
	var strVal = $("#IDcase").val();
    var arrExp = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2];//加权因子  
    var arrValid = [1, 0, "X", 9, 8, 7, 6, 5, 4, 3, 2];//校验码  
    if(/^\d{17}\d|x$/i.test(strVal)){   
        var sum = 0, idx;  
        for(var i = 0; i < strVal.length - 1; i++){  
            //对前17位数字与权值乘积求和  
            sum += parseInt(strVal.substr(i, 1), 10) * arrExp[i];  
        }  
        //计算模（固定算法）  
        idx = sum % 11;  
        //检验第18为是否与校验码相等  
        return arrValid[idx] == strVal.substr(17, 1).toUpperCase();  
    }else{ 
        return false;  
    }
}

function ageFunc(strBirthday,goDate){
    var returnAge;  
    var strBirthdayArr=strBirthday.split("-");  
    var birthYear = strBirthdayArr[0];  
    var birthMonth = strBirthdayArr[1];  
    var birthDay = strBirthdayArr[2];  
      
    d = new Date(goDate);  
    var nowYear = d.getFullYear();  
    var nowMonth = d.getMonth() + 1;  
    var nowDay = d.getDate();  
      
    if(nowYear == birthYear){  
        returnAge = 0;//同年 则为0岁  
    }  
    else{  
        var ageDiff = nowYear - birthYear ; //年之差  
        if(ageDiff > 0){  
            if(nowMonth == birthMonth){  
                var dayDiff = nowDay - birthDay;//日之差  
                if(dayDiff < 0){  
                    returnAge = ageDiff - 1;  
                }  
                else{  
                    returnAge = ageDiff ;  
                }  
            }  
            else{  
                var monthDiff = nowMonth - birthMonth;//月之差  
                if(monthDiff < 0){  
                    returnAge = ageDiff - 1;  
                }  
                else{  
                    returnAge = ageDiff ;  
                }  
            }  
        }  
        else{  
            returnAge = -1;//返回-1 表示出生日期输入错误 晚于今天  
        }  
    }  
    return returnAge;//返回周岁年龄  
}

function nowdate(){
	 var myDate = new Date();
	 var mon = myDate.getMonth()+1;
	 var day = myDate.getDate();
	 mon = mon>10?mon:"0"+mon;
	 day = day>10?day:"0"+day;
	 var time = myDate.getFullYear()+"-"+mon+"-"+day;
	 return time;
}

function sourceSex(num,val){
	var value = "";
	if(num==1){
		if(val=="F"){
			value = "先生";
		}else if(val=="M"){
			value = "女士";
		}
	}else if(num==2){
		if(val=="ADT"){
			value = "成人";
		}else if(val=="CHD"){
			value = "儿童";
		}else if(val=="INF"){
			value = "婴儿";
		}
	}else if(num==3){
		if(val=="NI"){
			value = "身份证";
		}else if(val=="PP"){
			value = "护照";
		}else if(val=="ID"){
			value = "其他证件";
		}
	}
	return value;
}

function caseAndbirth(caseNum,birthday){
	var birth = caseNum.substring(6,14);
	var birthdayNumXX = birth.substring(0,4)+"-"+birth.substring(4,6)+"-"+birth.substring(6,8);
	if(birthdayNumXX==birthday){
		return true;
	}else{
		$.alert("您的生日和身份证不匹配");
		return false;
	}
}
</script>
</head>

<body>
<div class="writInfoBox">
	<ul>
		<li><span class="spanTit">联系人：</span><input id="linkName" type="text"/></li>
		<li><span class="spanTit">联系电话：</span><input id="linkPhoneNum" type="text"/></li>
		<li><span class="spanTit">性别：</span><input type="text" id="sexIpnt" readonly="readonly" value="先生"/><span id="sexIpntSource" style="display:none;">F</span><span style="float:right; margin-top:18px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span></li>
		<li><span class="spanTit">出生日期：</span><input type="text" id="birthIpnt" readonly="readonly"/><span style="float:right; margin-top:17px;"><img src="<%=basePath %>console/images/riliImg.png" style="width:15px;"/></span></li>
		<%-- <li><span class="spanTit">旅客类型：</span><input type="text" id="personIpnt" readonly="readonly"/><span style="float:right; margin-top:18px;"><img src="<%=basePath %>console/images/xialaPonting.png"/></span></li> --%>
		<li><span class="spanTit" id="caseIpnt">身份证</span><span id="caseIpntSource" style="display:none;">NI</span><span><img src="<%=basePath %>console/images/xialaPonting.png" style="padding-top:4px;"/></span><input id="IDcase" type="text" placeholder="请输入证件号码"/></li>
		<li><span class="spanTit">中文姓名：</span><input id="chinaName" type="text"/></li>
		<li><span class="spanTit">证件有效期：</span><input id="caseTime" type="text"/></li>
		<li><span class="spanTit">国籍：</span><input id="contryName" type="text"/></li>
	</ul>
</div>
<div class="btnBox"><a id="btnQ">取消</a><a class="aBtn">保存</a></div>

<script>
$(function () {
	var currYear = (new Date()).getFullYear();	
	var opt={};
	opt.date = {preset : 'date'};
	opt.datetime = {preset : 'datetime'};
	opt.time = {preset : 'time'};
	opt.defaults = {
		theme: 'android-ics light', //皮肤样式
		display: 'modal', //显示方式 
		mode: 'scroller', //日期选择模式
		dateFormat: 'yyyy-mm-dd',
		lang: 'zh',
		showNow: false,
		nowText: "今天",
		startYear: currYear - 50, //开始年份
		endYear: currYear + 10 //结束年份
	};
	
	$("#birthIpnt").mobiscroll($.extend(opt['date'], opt['defaults']));
	$("#caseTime").mobiscroll($.extend(opt['date'], opt['defaults']));
});
</script>
<script src="<%=basePath %>scripts/common/weui/js/weui.min.js"></script>
</body>
</html>
