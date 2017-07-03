<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>平均乘机率</title>
	<link rel="stylesheet" type="text/css"href="<%=basePath%>scripts/common/jquery-easyui/themes/default/easyui.css"/>
	<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css"/>
	<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/default/datagrid.css"/>
	<script type="text/javascript" src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=basePath %>console/js/echarts.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>console/js/airCodeVScity.js"></script>
</head>
<body>
<div>
	<table border="0" cellspacing="10">
		<tr>
			<td>
				<span style="color:#666; font-size:13px;">时间范围：</span>
				<!-- <select name="dateType" class="easyui-combobox" style="width:60px;" panelHeight="auto">
					<option value="1">天</option>
					<option value="2">月</option>
					<option value="3">季</option>
					<option value="4">年</option>
				</select> -->
			</td>
			<td><input id="staTime" name="staTime" class="easyui-datebox" data-options="prompt:'选择查询起始日期'"/></td>
			<td style="color:#999">至</td>
			<td><input id="overTime" name="overTime" class="easyui-datebox" data-options="prompt:'选择查询结束日期'"/></td>	
			<td><input id="airCode" name="airCode" class="easyui-combobox" data-options="prompt:'航空公司二字码',panelHeight:'276',valueField:'value', textField:'text'"/></td>
			<td><a href="javascript:void(0)" class="easyui-linkbutton" onclick="findBtnfunc()" style="width:120px; outline:none;">搜 索</a></td>
		</tr>
	</table>
</div>
<div>
<div id="main" style="width:100%;height:500px; margin-top:20px;"></div>
<script type="text/javascript">
	$(function(){
		//默认加载当月的方法
		$.post("<%=basePath%>framework/atdcontroller/morenList.action",{},function(res){
			var date = JSON.parse(res);
			console.log(date.length);
			if(date.length==0||date.length=="0"){
			  $.messager.alert('操作提示',"目前没有订单!","warning");
			  
			 }
			doDate(date,"当月的平均乘机率","");
			
		});
		
		//加载航空公司的二字码信息到下拉框
		var data = [];
		var airCompany = JSON.stringify(getAircode());
		airCompany = airCompany.substring(1,airCompany.length-1);
		var chCompany = airCompany.split(",");
		for(var i=0; i<chCompany.length; i++){
			var codeAndName = chCompany[i].split(":");
			data.push({"value":codeAndName[0].substring(1,codeAndName[0].length-1),"text":codeAndName[0].substring(1,codeAndName[0].length-1)+"("+codeAndName[1].substring(1,codeAndName[1].length-1)+")"});
		}
		$("#airCode").combobox("loadData", data);		
	});
	
	//查找的方法
	function findBtnfunc(){
		var staTime = $("#staTime").textbox("getValue");
		var overTime = $("#overTime").textbox("getValue");
		if(staTime==""||overTime==""){
			$.messager.alert('操作提示', "请输入查询起始日期和结束日期！", 'warning');
			return false;
		}
		$.post("<%=basePath%>framework/atdcontroller/getOrderList.action",{starTime:staTime,overTime:overTime},function(res){
			var date = JSON.parse(res);
			doDate(date,staTime+"至",overTime+"平均乘机率");
		});
	}
	
	//整理数据的封装方法
	function doDate(date,staTime,overTime){
		var airCode = $("#airCode").combobox("getValue").trim();
		var airCodeCh = []; //用来装航段数的
		var airPerson = []; //用来装人头数的
		var airCh = []; //用来装航段数的航司的
		var valueCh = []; //用来装航段数的数量的
		var persAirc = []; //航司和人头的数量
		var persAndCode = [];
		var condition = [];
		if(airCode==""){}else{ //如果用户输入了航空二字码搜索项
			for(var i in date){
				if(date[i].hangbanNum.substring(0,2) == airCode){
					condition.push(date[i]);
				}
			}
			date = condition;
			overTime+="("+findByCode(airCode)+")";
		}
		
		//算航段数和算人头数
		for(var i in date){
			airCodeCh.push(framAirCode(date[i].hangbanNum.substring(0,2))); //航段数
			airPerson.push(fromPersen(date[i].hangbanNum.substring(0,2),date[i].idcase)); //人头数
		}
		var norepat = countJson(airCodeCh); //对json格式去重并且加1
		var lastDate="["+norepat.substring(0,norepat.length-1)+"]";
		lastDate = eval('(' + lastDate + ')'); 
		
		airPerson = uniquePay(airPerson);
		//console.log(lastDate); //航段数和航司对应的最终数据
		//console.log(airPerson); //人头数和航司对应的最终数据
		
		for(var i=0; i<lastDate.length; i++){
			persAirc.push(framAirPers(lastDate[i].aircode));
		}
		
		for(var i in airPerson){
			for(var j in persAirc){
				if(airPerson[i].aircode == persAirc[j].aircode){
					persAirc[j].value = parseInt(persAirc[j].value) + 1;
				}
			}
		}
		
		//console.log(persAirc); //最终数据
		for(var i in persAirc){
			for(var j in lastDate){
				if(persAirc[i].aircode == lastDate[j].aircode){
					persAndCode.push(fromPropor(persAirc[i].aircode,parseFloat(parseInt(lastDate[j].value)/parseInt(persAirc[i].value)).toFixed(2)));
				}
			}
		}
		
		for(var i in persAndCode){
			airCh.push(persAndCode[i].aircode);
			valueCh.push(Math.round(parseFloat(persAndCode[i].propor)*100));
		}

		//air = airCh;
		//value = valueCh;
		reloadImg(airCh,valueCh,staTime,overTime); //然后执行画图
	}
		
	//格式化航空公司的二字码
	function framAirCode(aircode){
		var jsondate = {};
		jsondate.aircode = aircode;
		jsondate.value = 1;
		return jsondate;
	}
	
	//格式化航空公司的二字码
	function framAirPers(aircode){
		var jsondate = {};
		jsondate.aircode = aircode;
		jsondate.value = 0;
		return jsondate;
	}
	
	//格式化航空公司和人头数对应
	function fromPersen(aircode,idcard){
		var jsondate = {};
		jsondate.aircode = aircode;
		jsondate.idcard = idcard;
		return jsondate;
	}
	
	//格式化航空公司和乘机率
	function fromPropor(aircode,propor){
		var jsondate = {};
		jsondate.aircode = aircode;
		jsondate.propor = propor;
		return jsondate;
	}
	
	//拆分重复的航空公司
	 function filterRepeatStr(str){
		var ar2 = str.split(",");
		var array = new Array();
		var j=0
		for(var i=0;i<ar2.length;i++){ 
			if((array == "" || array.toString().match(new RegExp(ar2[i],"g")) == null)&&ar2[i]!=""){ 
				array[j] =ar2[i]; 
				array.sort();
				j++;
			}
		}
		return array.toString();
	}
	
	//解析json数据中的重复数据
	function countJson(json){
		    var rdata = {};
			for(var i in json){
				var c = json[i].aircode;
				rdata[c] ? (rdata[c]++) : (rdata[c] = 1) ;
			}
			
			var strResult = "";
			for(var k in rdata){
				if(rdata[k] >= 1){
					for(var j=0;j<json.length;j++){
						if(json[j].aircode==k){
							strResult += "{'aircode':'"+k+"','value':"+rdata[k]+"},";
							break;
						}
					}
				}
			}
			return strResult;
	}
	
	/* function CalculTime(staTime,overTime,timeType){
		switch(n)
		{
			case 1:
			  	
				break;
			case 2:
			  
				break;
			default:
		}
	} */
	
	//绘制图形的方法
	function reloadImg(air,value,staTime,overTime){
		var myChart = echarts.init(document.getElementById('main'));
	    option = {
	        	 	color: ['#3398DB'],
	        	 	title: {
	        	 		text:staTime+overTime,
	        	 		left:"40%",
	        	 		textStyle:{
	        	 			color:"#666",
	        	 			fontFamily: 'sans-serif',
	        	 			fontStyle: 'normal'
	        	 		}
	        	 	},
	        	    tooltip : {
	        	        trigger: 'axis',
	        	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
	        	            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	        	        },
	    				formatter: function(params){
	    					//console.log(params);
	    					return findByCode(params[0].name)+'<br/>平均乘机率:'+params[0].data+'%';
	    				}
	        	    },
	        	    grid: {
	        	        left: '3%',
	        	        right: '4%',
	        	        bottom: '3%',
	        	        containLabel: true
	        	    },
	        	    xAxis : [
	        	        {
	        	            type : 'category',
	        	            data : air,
	        	            axisTick: {
	        	                alignWithLabel: true
	        	            }
	        	        }
	        	    ],
	        	    yAxis : [
	        	        {
	        	        	name : '乘机率',
	        	            type : 'value',
	        	            axisTick: {
	        	                alignWithLabel: true
	        	            },
	        	            axisLabel: {
	                            formatter: '{value}%',
	                        }
	        	        }
	        	    ],
	        	    series : [
	        	        {
	        	            name:'平均乘机率',
	        	            type:'bar',
	        	            barWidth: '60%',
	        	            data:value
	        	        }
	        	    ]
	   	};
	    myChart.setOption(option,true);
	}
	
	//json数据去重的方法
	function uniquePay(paylist){ 
	    var payArr = [paylist[0]];
	    for(var i = 1; i < paylist.length; i++){
	        var payItem = paylist[i];
	        var repeat = false;
	        for (var j = 0; j < payArr.length; j++) {
	          if (payItem.aircode == payArr[j].aircode && payItem.idcard == payArr[j].idcard ) {
	                 repeat = true;
	                 break;
	          }
	     	}
	        if (!repeat) {
	             payArr.push(payItem);
	        }
	    }
	    return payArr;
	}
</script>
</div>
</body>
</html>