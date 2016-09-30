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
		<li><span></span><input type="text" id="countryNameIdBox" placeholder="请输入用户名/证件号"/></li>
		<li><a onclick="query()">搜索</a></li>
	</ul>
</div>
<div style="height:25px; background-color:#fff;">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cut',plain:true" onclick="removeit(this)">删除</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="toUpdate()">修改</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="shows()">查看</a>
	<a href="" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新增</a>
</div>
<div id="dataBox"></div>
<script>
$(function(){
	$('#dataBox').datagrid({
	    height: '100%',
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
	        { field: 'chufTime', title: '出发时间', width: 200},
	        { field: 'idcase', title: '证件号码', width: 250}
	    ]],
	    onDblClickRow :function(rowIndex,rowData){
	    	details(rowData);
	   	}
	});
});
</script>
</body>
</html>