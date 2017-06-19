<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>机票订单</title>
<link rel="stylesheet" type="text/css"href="<%=basePath%>scripts/common/jquery-easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css">
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/default/datagrid.css">
<script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript"src="<%=basePath%>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<style>
	.seachBox{margin:10px 0px;}
	.seachBox ul{margin:0px; padding:0px; list-style-type:none; overflow:hidden;}
	.seachBox ul li{float:left; margin-left:10px;}
	.seachBox ul li span{}
	.seachBox ul li input{height:24px; outline:none; border:1px solid #cccccc; padding-left:10px; border-radius:5px;}
</style>
</head>
<body>
<div class="seachBox">
	<ul>
		<li><span></span><input type="text" id="countryNameIdBox" placeholder="请输入预约编号/证件号/登机号" style="width:225px;"/></li>
		<li><a onclick="query()" class="easyui-linkbutton" style="width:70px; height:28px;">搜索</a></li>
	</ul> 
</div>
<div style="height:25px; background-color:#fff;">
	<a href="<%=basePath %>console/framework/jporder/newOrder.jsp" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">录入订单</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cut',plain:true" onclick="removeit()">删除订单</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="shows()">查看订单</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="toUpdate()">修改乘机人证件</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="upTktlBtn()">修改出票时限</a>
	<!-- <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="AirSegment()">修改航段</a> -->
</div>
<div id="grideBox" style="width:100%;">
	<div id="dataBox" style="width:100%;height:100%;">
	</div>
</div>
<div id="lvkeInfoBox" class="easyui-dialog" style="width:360px; padding:30px;" closed="true" buttons="#dlg-buttons">
	<form id="lvkeInfoForm">
		<table border="0">
			<tr style="display:none;">
				<td><input name="id" class="easyui-textbox"/></td>
				<td><input name="pnr" class="easyui-textbox"/></td>
			</tr>
			<tr>
				<td>旅客姓名：</td>
				<td>
					<input id="linkName" name="linkName" class="easyui-textbox"/>
					<span style="display:none;"><input name="linkName" class="easyui-textbox" readonly/></span>
				</td>
			</tr>
			<tr>
				<td>年龄：</td>
				<td><input name="age" class="easyui-textbox" data-options="required:true"/></td>
			</tr>
			<tr>
				<td>性别：</td>
				<td>
					<select name="linkSex" class="easyui-combobox" data-options="required:true" style="width:173px;" panelHeight="auto">
						<option value="F">男</option>
						<option value="M">女</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>生日：</td>
				<td><input name="birthday" class="easyui-datebox" data-options="required:true"/></td>
			</tr>
			<tr>
				<td>旅客类型：</td>
				<td>
					<span style="display:none;"><input name="psgType" class="easyui-textbox"/></span>
					<select id="psgType" name="psgType" class="easyui-combobox" style="width:173px;" panelHeight="auto">
						<option value="ADT">成人</option>
						<option value="CHD">儿童</option>
						<option value="INF">婴儿</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					<select name="idcaseType" class="easyui-combobox" style="width:70px;" panelHeight="auto" data-options="required:true">
						<option value="NI">身份证</option>
						<option value="PP">护照</option>
						<option value="ID">其他</option>
					</select>
				</td>
				<td><input id="IDcase" name="idcase" class="easyui-textbox" data-options="required:true,validType:['IDcard']"/></td>
			</tr>
		</table>
	</form>
</div>
<div id="dlg-buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton c6" id="saveBean"	iconCls="icon-ok" onclick="saveBean()" style="displaly:block;width: 90px">保存</a> 
	<a href="javascript:void(0)" class="easyui-linkbutton" id="saveCancel" iconCls="icon-cancel" onclick="javascript:$('#lvkeInfoBox').dialog('close')" style="width:90px">取消</a>
</div>
<div id="TeickTimeBox" class="easyui-dialog" style="width:360px; padding:30px;" closed="true" buttons="#dlg-buttons2">
	<form id="TeickTimeForm"> 
		<table border="0">
			<tr style="display:none;">
				<td><input name="id" class="easyui-textbox"/></td>
				<td><input name="pnr" class="easyui-textbox"/></td>
			</tr>
			<tr>
				<td>出票时限：</td>
				<td><input name="getTeickTime" class="easyui-datetimebox" data-options="required:true"/></td>
			</tr>
		</table>
	</form>
</div>
<div id="dlg-buttons2">
	<a href="javascript:void(0)" class="easyui-linkbutton" id="saveBean" iconCls="icon-ok" onclick="saveBeanTltk()" style="displaly:block;width: 90px">保存</a> 
	<a href="javascript:void(0)" class="easyui-linkbutton" id="saveCancel" iconCls="icon-cancel" onclick="javascript:$('#TeickTimeBox').dialog('close')" style="width:90px">取消</a>
</div>
<div id="SegmentBox" class="easyui-dialog" style="width:360px; padding:30px;" closed="true" buttons="#dlg-buttons3">
	<form id="SegmentForm"> 
		<table border="0">
			<tr style="display:none;">
				<td><input name="id" class="easyui-textbox"/></td>
				<td><input name="pnr" class="easyui-textbox"/></td>
			</tr>
			<tr>
				<td>旧航班号：</td>
				<td><input name="hangbanNum" class="easyui-textbox"/></td>
			</tr>
			<tr>
				<td>旧起飞日期：</td>
				<td><input name="chufDate" class="easyui-textbox"/></td>
			</tr>
			<tr>
				<td>起飞城市：</td>
				<td><input name="newFlyCity" class="easyui-datetimebox" data-options="required:true"/></td>
			</tr>
			<tr>
				<td>到达城市：</td>
				<td><input name="newFlyddCity" class="easyui-datetimebox" data-options="required:true"/></td>
			</tr>
			<tr>
				<td>航班号：</td>
				<td><input name="newFlyNum" class="easyui-datetimebox" data-options="required:true"/></td>
			</tr>
			<tr>
				<td>舱位：</td>
				<td><input name="newCanbin" class="easyui-datetimebox" data-options="required:true"/></td>
			</tr>
			<tr>
				<td>起飞日期：</td>
				<td><input name="newFlyDate" class="easyui-datetimebox" data-options="required:true"/></td>
			</tr>
		</table>
	</form>
</div>
<div id="dlg-buttons3">
	<a href="javascript:void(0)" class="easyui-linkbutton" id="saveBean" iconCls="icon-ok" onclick="saveBeanSegment()" style="displaly:block;width: 90px">保存</a> 
	<a href="javascript:void(0)" class="easyui-linkbutton" id="saveCancel" iconCls="icon-cancel" onclick="javascript:$('#SegmentBox').dialog('close')" style="width:90px">取消</a>
</div>
<script>
$(function(){
	$("#grideBox").css("height",$(window).height()-82);
	$('#dataBox').datagrid({
		height:'80%',
	    fit:true,
	    url: '<%=basePath%>framework/order/getOrderList.action',
	    method: 'POST',
	    striped: true,
	    nowrap: true,
	    pageSize: 10,
	    pageNumber:1, 
	    pageList: [10, 20, 50, 100, 150, 200],
		pagination : true,
	    showFooter: true, 
		loadMsg : '数据加载中请稍后……',
	    toolbar:"#tb",
	    singleSelect: false,
		rownumbers:false,
	    columns: [[
	        { field: 'ck', checkbox: true },
	        { field: 'orderNum', title: '预约编号',align:'center', width: '15%'},
	        { field: 'linkName', title: '用户姓名',align:'center', width: '7%'},
	        { field: 'linkPhoneNum', title: '联系电话',align:'center', width: '11%'},
	        { field: 'stutisPay', title: '付款状态',align:'center', width: '6%',
	        	 formatter:function(value,rec,index){  
                     if(value == '0'){
							return "未支付";
					 }else if(value == '1'){
							return "已支付";
					 }else {
							return "未识别支付类型";
					 }
                 }	
	        },
	        { field: 'hangbanNum', title: '航班号',align:'center', width: '11%'},
	        { field: 'chufDate', title: '出发日期',align:'center', width: '11%'},
	        { field: 'chufTime', title: '出发时间',align:'center', width: '6%',
	        	formatter:function(value,rec,index){
	        		if(value==undefined){
	        			return "未知";
	        		}else{
	        			return value.substring(0,2)+":"+value.substring(2,4);
	        		}
	        	}
	        },
	        { field: 'idcase', title: '证件号码',align:'center', width: '16%'},
	        { field: 'createTime', title: '创建时间',align:'center', width: '14.5%',formatter: fotmateDate},
	    ]]
	});
});

function removeit(){
	var rows = $('#dataBox').datagrid('getChecked');	
	if (rows.length == "0") {
         $.messager.alert('操作提示', "选择删除的数据！", 'warning');
         return false;
    } 
    
	$.messager.confirm('确认', '真的要删除吗？', function (r) {
          if (r) {
                	var UUID = "";
                	var pnrNo = "";
                	for(var i=0; i<rows.length; i++){
                		UUID += rows[i].id+",";
                		pnrNo += rows[i].pnr+",";
                	}
                        $.ajax({
                            type: "POST",
                            data:{
                            	"ID":UUID.substring(0,UUID.length-1),
                            	"pnrNo":pnrNo.substring(0,pnrNo.length-1),
                            },
                            dataType: 'json',
                            url: "<%=basePath%>userOrderController/delete/order.action",
                            success: function (data) {
                                console.log(data);
                                if (data.msg == 1) {
                                    $('#dataBox').datagrid('reload');       
                                    $.messager.alert('订单删除成功！');                           
                                }else {
                                    $.messager.alert('Warning', '删除不成功！'); 
                                }
                            }
                        });
             }
      });
}

function shows(){
	var rows = $('#dataBox').datagrid('getChecked');	//多选的记录
	if (rows.length==0) {
         $.messager.alert('操作提示', "没有选择被操作的记录！", 'warning');
         return false;
    }
    if(rows.length > 1){
         $.messager.alert('操作提示', "只能查看一条数据", 'warning');
         return false;
    }
	var rowstr = rows[0].id;
	window.location.href="<%=basePath%>console/framework/jporder/lookInfo.jsp?numds="+rowstr;
}

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
    }
});
function toUpdate(){
	var rows = $('#dataBox').datagrid('getChecked');
	if (rows.length==0) {
        $.messager.alert('操作提示', "没有选择被操作的记录！", 'warning');
        return false;
   }
   if(rows.length > 1){
        $.messager.alert('操作提示', "只能选择一条数据", 'warning');
        return false;
   }
   $("#linkName").textbox({disabled:true});
   $("#psgType").combobox({disabled:true});
   $('#lvkeInfoForm').form('load',rows[0]);
   $('#lvkeInfoBox').dialog('open').dialog('setTitle','修改乘机人信息');
}

function upTktlBtn(){
	var rows = $('#dataBox').datagrid('getChecked');
	if (rows.length==0) {
        $.messager.alert('操作提示', "没有选择被操作的记录！", 'warning');
        return false;
   }
   if(rows.length > 1){
        $.messager.alert('操作提示', "只能选择一条数据", 'warning');
        return false;
   } 
   $('#TeickTimeForm').form('load',rows[0]);
   $('#TeickTimeBox').dialog('open').dialog('setTitle','修改出票时限');
}

function AirSegment(){ 
	var rows = $('#dataBox').datagrid('getChecked');
	if (rows.length==0) {
        $.messager.alert('操作提示', "没有选择被操作的记录！", 'warning');
        return false;
   }
   if(rows.length > 1){
        $.messager.alert('操作提示', "只能选择一条数据", 'warning');
        return false;
   } 
   console.log(rows[0]);
   $('#SegmentForm').form('load',rows[0]);
   $('#SegmentBox').dialog('open').dialog('setTitle','修改航段');
}

function saveBean(){
	 $('#lvkeInfoForm').form('submit',{
		   url: "<%=basePath%>framework/order/upTelkMen.action",
		   onSubmit: function(){
		        return $(this).form('validate');
		   },
		   success: function(data){
			   if(data==1||data=="1"){
				   $('#lvkeInfoBox').dialog('close');
				   $('#dataBox').datagrid('reload');
			   }else{
				   $.messager.alert('操作提示', "操作失败", 'warning');
			   }
		   }
	 }); 
}

function saveBeanTltk(){
	 $('#TeickTimeForm').form('submit',{
		   url: "<%=basePath%>framework/order/Corder.action",
		   onSubmit: function(){
		        return $(this).form('validate');
		   },
		   success: function(data){
			   console.log("====>>>>>"+data);
			   if(data==1||data=="1"){
				   $('#TeickTimeBox').dialog('close');
				    $('#dataBox').datagrid('reload');
			   }else{
				   $.messager.alert('操作提示', "操作失败", 'warning');
			   }
		   }
	 }); 
}

function saveBeanSegment(){
	 $('#SegmentForm').form('submit',{
		   url: "<%=basePath%>framework/order/hangeAirSegment.action",
		   onSubmit: function(){
		        return $(this).form('validate');
		   },
		   success: function(data){
			   console.log("====>>>>>"+data);
			   if(data==1||data=="1"){
				   $('#SegmentBox').dialog('close');
				    $('#dataBox').datagrid('reload');
			   }else{
				   $.messager.alert('操作提示', "操作失败", 'warning');
			   }
		   }
	 }); 
}

//查找的方法
function query(){
	var Info = $("#countryNameIdBox").val();	 
	$('#dataBox').datagrid({
		height: '100%',
		fit:true,
		url: '<%=basePath %>framework/order/findOrder.action?Info='+Info,
		method: 'POST',
		striped: true,
		nowrap: true,
		pageSize: 10,
		pageNumber:1, 
		pageList: [10, 20, 50, 100, 150, 200],
		showFooter: true, 
		loadMsg : '数据加载中请稍后……',
		pagination : true,
		toolbar:"#tb",
		singleSelect: false,
		rownumbers:true,
		columns: [[
	        { field: 'ck', checkbox: true },
	        { field: 'orderNum', title: '预约编号',align:'center', width: '15%'},
	        { field: 'linkName', title: '用户姓名',align:'center', width: '7%'},
	        { field: 'linkPhoneNum', title: '联系电话',align:'center', width: '11%'},
	        { field: 'stutisPay', title: '付款状态',align:'center', width: '6%',
	        	 formatter:function(value,rec,index){  
                     if(value == '0'){
							return "未支付";
					 }else if(value == '1'){
							return "已支付";
					 }else {
							return "未识别支付类型";
					 }
                 }	
	        },
	        { field: 'hangbanNum', title: '航班号',align:'center', width: '11%'},
	        { field: 'chufDate', title: '出发日期',align:'center', width: '11%'},
	        { field: 'chufTime', title: '出发时间',align:'center', width: '6%',
	        	formatter:function(value,rec,index){
	        		if(value==undefined){
	        			return "未知";
	        		}else{
	        			return value.substring(0,2)+":"+value.substring(2,4);
	        		}
	        	}
	        },
	        { field: 'idcase', title: '证件号码',align:'center', width: '16%'},
	        { field: 'createTime', title: '创建时间',align:'center', width: '14.5%',formatter: fotmateDate},
	    ]]
	});
}

function fotmateDate(value){
	var dateStr = "";
	if(value=="undefined"||value=="null"||value==null){}else{
		var date = new Date(value);
		dateStr = date.format("yyyy-MM-dd HH:mm:ss");
	}
    return dateStr;    
}

//js格式化日期插件代码
Date.prototype.format = function (format) {  
		 var o = {  
		        "M+": this.getMonth() + 1, // month  
		        "d+": this.getDate(), // day  
		        "H+": this.getHours(), // hour  
		        "m+": this.getMinutes(), // minute  
		        "s+": this.getSeconds(), // second  
		        "q+": Math.floor((this.getMonth() + 3) / 3), // quarter  
		        "S": this.getMilliseconds()  
		        // millisecond  
		 }
		 if (/(y+)/.test(format)){
		        format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length)); 
		 } 
		 for (var k in o){  
		      if (new RegExp("(" + k + ")").test(format)){
		            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length)); 
		 	  }
		 } 
		 return format;  
} 
</script>
</body>
</html>