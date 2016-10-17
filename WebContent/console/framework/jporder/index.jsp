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
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cut',plain:true" onclick="removeit()">删除</a>
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
                	var OrderID = row.id;
                    // console.log("countryID: "+countryID); 
                    if (row) {
                    	alert("我开始删除了"+OrderID);
                        <%-- $.ajax({
                            cache: false,
                            async: false,
                            type: "POST",
                            data:{"countryID":countryID},
                            dataType: 'json',
                            url: "<%=basePath%>framework/visa/deleteVisa.action",
                            success: function (data) {
                                console.log(data);
                                if (data.state == 1) {
                                    $('#countryListBox').datagrid('reload');                                    
                                }
                                else {
                                    $.messager.alert('Warning', '删除不成功！'); 
                                }
                            }
                        }); --%>
                    } 
             }
      });
}
</script>
</body>
</html>