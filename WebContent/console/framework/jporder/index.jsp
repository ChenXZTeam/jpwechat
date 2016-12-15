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
	.seachBox ul li input{height:24px; outline:none; border:1px solid #cccccc; padding-left:10px;}
	.seachBox ul li a{padding:5px 20px; font-size:13px; border:1px solid blue; color:blue; cursor:pointer; display:block; text-align:center;}
</style>
</head>
<body>
<div class="seachBox">
	<ul>
		<li><span></span><input type="text" id="countryNameIdBox" placeholder="请输入预约编号/证件号/登机号"/></li>
		<li><a onclick="query()">搜索</a></li>
	</ul>
</div>
<div style="height:25px; background-color:#fff;">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cut',plain:true" onclick="removeit()">删除</a>
<!-- 	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="toUpdate()">修改</a> -->
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="shows()">查看</a>
	<a href="<%=basePath %>console/framework/jporder/addorder.jsp" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">预定机票</a>
</div>
<div style="width:100%;height:420px;">
	<div id="dataBox" style="width:100%;height:420px;">
	</div>
</div>
<script>
$(function(){
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
		rownumbers:true,
	    columns: [[
	        { field: 'ck', checkbox: true },
	        { field: 'orderNum', title: '预约编号', width: 150},
	        { field: 'linkName', title: '用户姓名', width: 150},
	        { field: 'linkPhoneNum', title: '联系电话', width: 120},
	        { field: 'stutisPay', title: '付款状态', width: 100,
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
	        { field: 'hangbanNum', title: '航班号', width: 50},
	        { field: 'chufDate', title: '出发日期', width: 100},
	        { field: 'chufTime', title: '出发时间', width: 100},
	        { field: 'idcase', title: '证件号码', width: 200},
	        { field: 'createTime', title: '创建时间', width: 200,formatter: fotmateDate},
	    ]],
	    onDblClickRow :function(rowIndex,rowData){
	    	details(rowData);
	   	}
	});
});

function removeit(){
	var rows = $('#dataBox').datagrid('getSelections');	
	var row = $('#dataBox').datagrid('getSelected');
	console.log(row);
	if (row == undefined||row == null||row == "") {
         $.messager.alert('操作提示', "没有选择被操作的记录！", 'warning');
         return false;
    } 
    if(rows.length > 1){
         $.messager.alert('操作提示', "只能删除一条数据", 'warning');
         return false;
    }
    
	$.messager.confirm('确认', '真的要删除吗？', function (r) {
          if (r) {
                	var UUID = row.id;
                	var orderNum = row.orderNum;
                	var pnrNo = row.pnr; 
                    if (row){
                        $.ajax({
                            cache: false,
                            async: false,
                            type: "POST",
                            data:{
                            	"ID":UUID,
                            	"orderNum":orderNum,
                            	"pnrNo":pnrNo
                            },
                            dataType: 'json',
                            url: "<%=basePath%>userOrderController/delete/order.action",
                            success: function (data) {
                                console.log(data);
                                if (data.msg == 1) {
                                    $('#dataBox').datagrid('reload');       
                                    alert('订单删除成功！');                           
                                }else {
                                    $.messager.alert('Warning', '删除不成功！'); 
                                }
                            }
                        });
                    } 
             }
      });
}

function shows(){
	var row = $('#dataBox').datagrid('getSelected');	//单选的记录
	var rows = $('#dataBox').datagrid('getSelections');	//多选的记录
	if (row == undefined||row == null||row == "") {
         $.messager.alert('操作提示', "没有选择被操作的记录！", 'warning');
         return false;
    }
    if(rows.length > 1){
         $.messager.alert('操作提示', "只能查看一条数据", 'warning');
         return false;
    }
	var rowstr = JSON.stringify(row);
	window.location.href="<%=basePath%>console/framework/jporder/lookInfo.jsp?strRow="+rowstr;
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
	        { field: 'orderNum', title: '预约编号', width: 150},
	        { field: 'linkName', title: '用户姓名', width: 150},
	        { field: 'linkPhoneNum', title: '联系电话', width: 120},
	        { field: 'stutisPay', title: '付款状态', width: 100,
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
	        { field: 'hangbanNum', title: '航班号', width: 50},
	        { field: 'chufDate', title: '出发日期', width: 100},
	        { field: 'chufTime', title: '出发时间', width: 100},
	        { field: 'idcase', title: '证件号码', width: 200},
	        { field: 'createTime', title: '创建时间', width: 200,formatter: fotmateDate},
	    ]],
	    onDblClickRow :function(rowIndex,rowData){
	    	details(rowData);
	   	}
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