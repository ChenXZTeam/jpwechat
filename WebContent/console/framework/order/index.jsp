<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>签证订单_订单列表</title>
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
	.seachBox ul li input{height:24px; outline:none; border:1px solid #cccccc; padding-left:10px;}
	.seachBox ul li a{padding:5px 20px; font-size:13px; border:1px solid blue; color:blue; cursor:pointer; display:block; text-align:center;}
	.titleClass{width:100px; font-size:12px; color:#666666;}
	textarea{width:100%; height:100px; color:#777777;}
	input{height:20px; color:#777777;}
	select{width:164px; height:23px; color:#777777;}
	.dispayNoneClass{display:none;}
</style>
</head>
<body>
<div class="seachBox">
	<ul>
		<li><span></span><input type="text" id="yuyueNumber" placeholder="请输入预约编号"/></li>
		<li><a onclick="query()">搜索</a></li>
	</ul>
</div>
<div style="height:25px; background-color:#fff;">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cut',plain:true" onclick="removeit(this)">删除</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="toUpdate()">修改</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="shows()">查看</a>
	<a href="<%=basePath%>console/framework/order/orderInput.jsp" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新增</a>
</div>
<div style="width:100%;height:420px;">
	<div id="orderListBox" style="width:100%;height:420px;">
	</div>
</div>
<div id="upInfoBox" class="easyui-dialog" style="width:720px; height:350px; padding: 10px 20px" closed="true" buttons="#dlg-buttons" iconCls="icon-edit">
	<form id="fm" method="post" enctype="multipart/form-data" novalidate>
		<table border="0" cellpadding="0" cellspacing="10">
			<tr class="dispayNoneClass">
				<td colspan="4"><input name="visaID"/></td>
			</tr>
			<tr class="dispayNoneClass">
				<td colspan="4"><input name="orderNum"/></td>
			</tr>
			<tr class="dispayNoneClass">
				<td colspan="4"><input name="visaOrderID"/></td>
			</tr>
			<tr class="dispayNoneClass">
				<td colspan="4"><input name="newOrderNum"/></td>
			</tr>
			<tr class="dispayNoneClass">
				<td colspan="4"><input name="userID"/></td>
			</tr>
			<tr class="dispayNoneClass">
				<td colspan="4"><input name="deleteSige"/></td>
			</tr>
			<tr>
				<td class="titleClass">申请人：</td>
				<td><input name="contactsName"/></td>
				<td class="titleClass">手机号：</td>
				<td><input name="contactsPhone" /></td>
			</tr>
			<tr>
				<td class="titleClass">申请价格：</td>
				<td colspan="3"><input name="totalCost"/></td>
			</tr>
			<tr>
				<td class="titleClass">工作状态：</td>
				<td><input name="customerType"/></td>
				<td class="titleClass">性别：</td>
				<td><input name="contactsSex"/></td>
			</tr>
			<tr>
				<td class="titleClass">E-mail：</td>
				<td><input name="contactsEmail"/></td>
				<td class="titleClass">客户类型：</td>
				<td><input name="trayTypeIpnt"/></td>
			</tr>
			<tr>
				<td class="titleClass">申请国家：</td>
				<td><input name="applyCountry"/></td>
				<td class="titleClass">证件号码：</td>
				<td><input name="idcase" id="idcase" type="text"/></td>
			</tr>
			<tr>
				<td class="titleClass">配送方式：</td>
				<td><input name="deliveryMethod" type="text"/></td>
				<td class="titleClass">配送地址：</td>
				<td><input name="deliveryAddress"/></td>
					<!-- <select name="qzMode">
						<option value="1">没有特殊政策</option>
						<option value="2">落地签</option>
						<option value="3">免签</option>
					</select> -->
			</tr>
			<tr>
				<td class="titleClass">支付状态：</td>
				<td>
					<select name="paystatus">
						<option value="0">未支付</option>
						<option value="1">已支付</option>
					</select>
				</td>
				<td class="titleClass">申请进度：</td>
				<td>
					<select name="progress">
						<option value="0">预约中</option>
						<option value="1">进行中</option>
						<option value="2">已完成</option>
					</select>
				</td>
			</tr>
		</table>
	</form>
</div>
<div id="dlg-buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton c6" id="saveBean"	iconCls="icon-ok" onclick="saveBean()" style="displaly:block;width: 90px">保存</a> 
	<a href="javascript:void(0)" class="easyui-linkbutton" id="saveCancel" iconCls="icon-cancel" onclick="javascript:$('#upInfoBox').dialog('close')" style="width:90px">取消</a>
</div>
<div class="seeContryInfoBox">
	
</div>
<script>
$(function(){
	$('#orderListBox').datagrid({
	    height: '100%',
	    fit:true,
	    url: '<%=basePath%>framework/visa/getVisaOrderList.action',
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
		rownumbers:true,
	    columns: [[
	        { field: 'ck', checkbox: true },
	        { field: 'orderNum', title: '预约编号', width: 150},
	        { field: 'contactsName', title: '用户姓名', width: 150},
	        { field: 'contactsPhone', title: '联系电话', width: 120},
	        { field: 'applyCountry', title: '申请国家', width: 120},
	        { field: 'paystatus', title: '付款状态', width: 100,
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
	        { field: 'idcase', title: '申请人身份证号码', width: 250},
	        { field: 'trayTypeIpnt', title: '旅客类型', width: 100},
	        { field: 'createTimeBox', title: '创建时间', width: 200}
	    ]],
	    onDblClickRow :function(rowIndex,rowData){
	    	details(rowData);
	   	}
	});
});

//删除方法
function removeit(){  //删除
	var rows = $('#orderListBox').datagrid('getSelections');	
	//var row = $('#orderListBox').datagrid('getSelected');
	console.log(rows);
	//alert(row);	
	if (rows == undefined||rows == null||rows == "") {
         $.messager.alert('操作提示', "没有选择被操作的记录！", 'warning');
         return false;
    }
	$.messager.confirm('确认', '真的要删除这些数据吗?', function (r) {
          if (r) {
                    if (rows) {
                    	for(var i=0; i<rows.length; i++){
                    		var orderNum = rows[i].orderNum;
	                        $.ajax({
	                            cache: false,
	                            async: false,
	                            type: "POST",
	                            data:{"orderNum":orderNum},
	                            dataType: 'json',
	                            url: "<%=basePath%>framework/visa/deleteVisaOrder.action",
	                            success: function (data) {
	                                if (data.state == 1) {
	                                    $('#orderListBox').datagrid('reload');                                    
	                                }
	                                else {
	                                    $.messager.alert('Warning', '删除不成功！'); 
	                                }
	                            }
	                        });
                    	}
                    }
                }
      });
}

//修改信息
function toUpdate(){  //弹出修改框
       var rows = $('#orderListBox').datagrid('getSelections');	
       console.log(rows);
       if (rows == undefined||rows == null||rows == "") {
           $.messager.alert('操作提示', "没有选择被操作的记录！", 'warning');
           return;
       } 
       if(rows.length>1){
            $.messager.alert('操作提示', "请选择一条数据！", 'warning');
            return false;
       } 	 
	   $('#upInfoBox').dialog('open').dialog('setTitle','修改订单信息');
	   $('#fm').form('load',rows[0]);
}
//确认修改信息的保存按钮	    
function saveBean(){ 	
      $('#fm').form('submit',{
		       url: "<%=basePath%>framework/visa/updateVisaOrder.action?idcase="+$('#idcase').val(),
		       onSubmit: function(){
		           return $(this).form('validate');
		       },
		       success: function(data){
		       	var obj = JSON.parse(data);
		       	console.log(data+", "+obj+", "+obj.state);
		       	   if(obj.state == 1){
			           $('#upInfoBox').dialog('close');        // close the dialog
			           $('#orderListBox').datagrid('reload');    // reload the user data
		           }else{
		           	   $.messager.alert('操作提示', "修改不成功！", 'warning');
		           }
		       }
	 }); 
}

//查看详情的方法
function details(row){
	if(row){
			var str = JSON.stringify(row); 
			window.location.href="<%=basePath%>console/framework/order/viewDetails.jsp?str="+str;		
	}
}

function shows(){ //查看
		    var row = $('#orderListBox').datagrid('getSelected');
		    var rows = $('#orderListBox').datagrid('getSelections');
		    if (row == undefined) {
             		$.messager.alert('操作提示', "没有选择被操作的记录！", 'warning');
             		return;
             	 } 
            if(rows.length>1){
            	$.messager.alert('操作提示', "请选择一条数据！", 'warning');
             	return false;
            }  
			if (row){
				console.log(row);
				var str = JSON.stringify(row); 
				console.log(str);
				window.location.href="<%=basePath%>console/framework/order/viewDetails.jsp?str="+str;
			}
}

//查找的方法
function query(){
	var countryName = $("#yuyueNumber").val();	 
	$('#orderListBox').datagrid({
		height: '100%',
		fit:true,
		url: '<%=basePath %>framework/visa/findVisa.action?countryName='+countryName,
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
	        { field: 'country', title: '国家', width: 150},
	        { field: 'immigrationOfTimes', title: '入境次数', width: 120},
	        { field: 'periodOfValidity', title: '有效期限', width: 120},
	        { field: 'qzMode', title: '特殊签证类型', width: 100,
	        	 formatter:function(value,rec,index){  
                     if(value == '3'){
						return "免签";
						}else if(value == '2'){
							return "落地签";
						}else {
							return "其他";
						}
                 }	
	        },
	        { field: 'sojournTime', title: '逗留天数', width: 100},
	        { field: 'touryIntro', title: '风景介绍', width: 100},
	        { field: 'createTimeBox', title: '创建时间', width: 200}
	    ]],
		onDblClickRow :function(rowIndex,rowData){
			    details(rowData);
		}
	});
}
		
</script>
</body>
</html>