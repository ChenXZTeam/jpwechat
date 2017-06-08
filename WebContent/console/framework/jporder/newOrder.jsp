<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>新增订单</title>
	<link rel="stylesheet" type="text/css"href="<%=basePath%>scripts/common/jquery-easyui/themes/default/easyui.css"/>
	<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css"/>
	<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/default/datagrid.css"/>
	<script type="text/javascript" src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=basePath %>console/js/airCodeVScity.js"></script>
</head>
<body>
<script>
$(function(){
	var data = [];
	var airCompany = JSON.stringify(getCityCode());
	airCompany = airCompany.substring(1,airCompany.length-1);
	var chCompany = airCompany.split(",");
	for(var i=0; i<chCompany.length; i++){
		var codeAndName = chCompany[i].split(":");
		data.push({"value":codeAndName[0].substring(1,codeAndName[0].length-1),"text":codeAndName[0].substring(1,codeAndName[0].length-1)+"("+codeAndName[1].substring(1,codeAndName[1].length-1)+")"});
	} 
	$("#chufCity").combobox("loadData", data);
	$("#daodCity").combobox("loadData", data);
});

$.extend($.fn.validatebox.defaults.rules, {  
	IDcard: {
        validator:function(value){
        	var strVal = value;
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
        },
        message:'身份证格式错误'
    },
    isExist: {
        validator:function(value){
        	var f=false;
        	$.ajax({  
                 type : "post",  
                 url : "<%=basePath%>framework/LinkMan/isExtie.action",
                 data : {"userName":value}, 
                 dataType: 'json',
                 async : false,  
                 success : function(data){
                	 if(data==true)f=true;
                 }  
            });
        	return f;
        },
        message:'用户未存在'
    },
    mobile:{
    	validator:function(value){
    		var phone=/^(13[0-9]|14[0-9]|15[0-9]|18[0-9])\d{8}$/;
			if(!phone.test(value)){
				return false;
			}else{
				return true;
			}
    	},
        message:'手机格式错误'
    }

}); 

function submitBtn(){
	 $('#subForm').form('submit',{
		   url: '<%=basePath%>framework/order/addOrderAdmin.action',
		   onSubmit: function(){
		        return $(this).form('validate');
		   },
		   success: function(data){
			   if(data==1||data=="1"){
					window.location.href="<%=basePath%>console/framework/jporder/index.jsp";
			   }else{
				    $.messager.alert('操作提示', "操作失败", 'warning');
			   }
		   }
	 }); 
}

function resetBtn(){
	$('#subForm').form('clear');
	$('#psgType').combobox('select', "ADT");
	$('#yiwaiBX').combobox('select', "0");
	$('#yanwuBX').combobox('select', "0");
	$('#isConsole').combobox('select', "0");
	$('#linkSex').combobox('select', "男");
}
</script>
<form id="subForm">
	<table style="border-radius:5px; margin:0px; color:#666; width:100%;" border="0" cellspacing="0" cellpadding="10">
		<tr>
			<td colspan="6" style="padding-left:10px; background:#9FBAD8; color:#fff; line-height:15px;">航班信息</td>
		</tr>
		<tr>
			<td style="width:80px;">出发城市：</td>
			<td style="width:230px;"><input id="chufCity" name="chufCity" class="easyui-combobox" data-options="required:true ,valueField:'value', textField:'text'"/></td>
			<td style="width:80px;">抵达城市：</td>
			<td style="width:193px;"><input id="daodCity" name="daodCity" class="easyui-combobox" data-options="required:true ,valueField:'value', textField:'text'"/></td>
			<td style="width:80px;">航班号：</td>
			<td><input class="easyui-textbox" name="hangbanNum" data-options="required:true"/></td>
		</tr>
		<tr>
			<td>航班日期：</td>
			<td><input class="easyui-datebox" name="chufDate" data-options="required:true"/></td>
			<td>抵达日期：</td>
			<td><input class="easyui-datebox" name="daodDate"/></td>
			<td>出发时间：</td>
			<td><input class="easyui-timespinner" name="chufTime"/></td>
		</tr>
		<tr>
			<td>抵达时间：</td>
			<td><input class="easyui-timespinner" name="daodTime"/></td>
			<td>舱位：</td>
			<td><input class="easyui-textbox" name="cabin" data-options="required:true"/></td>
			<td>票号：</td>
			<td><input class="easyui-textbox" name="telNum" data-options="required:true"/></td>
		</tr>
		<tr>
			<td>航意险：</td>
			<td>
				<select name="yiwaiBX" id="yiwaiBX" class="easyui-combobox" style="width:80px;" panelHeight="auto">
					<option value="0">未购买</option>
					<option value="1">已购买</option>
				</select>
			</td>
			<td>延误险：</td>
			<td colspan="3">
				<select name="yanwuBX" id="yanwuBX" class="easyui-combobox" style="width:80px;" panelHeight="auto">
					<option value="0">未购买</option>
					<option value="1">已购买</option>
				</select>
			</td>
		</tr>
		<tr>
			<td colspan="6" style="padding-left:10px; background:#9FBAD8; color:#fff; line-height:15px;">价钱</td>
		</tr>
		<tr>
			<td>总票价：</td>
			<td colspan="5"><input class="easyui-textbox" name="costMoney" data-options="required:true"/>&nbsp;/元</td>
		</tr>
		<tr>
			<td colspan="6" style="padding-left:10px; background:#9FBAD8; color:#fff; line-height:15px;">乘机人信息</td>
		</tr>
		<tr>
			<td>乘机人：</td>
			<td><input name="linkName" class="easyui-textbox" data-options="required:true"/></td>
			<td>联系电话：</td>
			<td><input name="linkPhoneNum" class="easyui-textbox" data-options="required:true,validType:['mobile']"/></td>
			<td>证件号码：</td>
			<td><input name="IDcase" class="easyui-textbox" data-options="required:true,validType:['IDcard']"/></td>
		</tr>
		<tr>
			<td>出生日期：</td>
			<td><input name="birthday" class="easyui-datebox" data-options="required:true"/></td>
			<td>年龄：</td>
			<td><input name="age" class="easyui-textbox"/></td>
			<td>旅客类型：</td>
			<td>
				<select id="psgType" name="psgType" class="easyui-combobox" style="width:173px;" panelHeight="auto">
					<option value="ADT">成人</option>
					<option value="CHD">儿童</option>
					<option value="INF">婴儿</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>性别：</td>
			<td>
				<select id="linkSex" name="linkSex" class="easyui-combobox" style="width:173px;" panelHeight="auto">
					<option value="男">男</option>
					<option value="女">女</option>
				</select>
			</td>
			<td>会员账号：</td>
			<td colspan="3"><input name="UserName" class="easyui-textbox" data-options="validType:['isExist']"/></td>
		</tr>
		<tr>
			<td colspan="6" style="padding-left:10px; background:#9FBAD8; color:#fff; line-height:15px;">其他信息</td>
		</tr>
		<tr>
			<td>是否报销：</td>
			<td colspan="5">
				<select id="isConsole" name="isConsole" class="easyui-combobox" style="width:80px;" panelHeight="auto">
					<option value="0">否</option>
					<option value="1">是</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>配送地址：</td>
			<td><input name="sendAdd" class="easyui-textbox"/></td>
			<td>快递单号：</td>
			<td colspan="3"><input name="kdOrderNum" class="easyui-textbox"/></td>
		</tr>
	</table>
</form>
<div style="text-align:center;">
	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitBtn()" style="width:120px; outline:none;">提 交</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="resetBtn()" style="width:120px; outline:none; margin-left:50px;">重 置</a>
</div>
</body>
</html>