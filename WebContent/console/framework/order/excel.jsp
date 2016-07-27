<%-- <%@ page import="com.solar.tech.bean.entity.YHorder"%> --%>
<%@ page import="com.solar.tech.exception.ResultCode" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>DataGrid inline editing - jQuery EasyUI Demo</title>
	<link rel="stylesheet" type="text/css"href="<%=basePath%>scripts/common/jquery-easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/default/datagrid.css">
	<script type="text/javascript"src="<%=basePath%>scripts/common/jquery-1.8.3.min.js"></script>
	<script type="text/javascript"src="<%=basePath%>scripts/common/jquery.form.js"></script>
	<script type="text/javascript"src="<%=basePath%>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
	
	
   <%--  <link href="<%=basePath%>console/excel/EasyUI/themes/gray/easyui.css" rel="stylesheet" /> --%>
    <script src="<%=basePath%>console/excel/ExportExcelDlg.js"></script>
</head>
<body>
  <div id="contain">
	<div style="width:100%;height:510px">
	<table id="exceldg" class="easyui-datagrid" title="" style="width:100%"
		data-options="
				iconCls: 'icon-edit',
				height: '100%',
	    		fit:true,
				pageSize: 10,
	    		pageNumber:1, 
	    		pageList: [10, 20, 50, 100, 150, 200],
	    		pagination : true,
	    		loadMsg : '数据加载中请稍后……',
				singleSelect: false,
				selectOnCheck: false,
				checkOnSelect: true,
				rownumbers:true,
				 toolbar: '#tb',
				url: '<%=basePath %>framework/yhorder/shows.action',
				method: 'POST'
			">
		<thead>
			<tr>
				<!-- singleSelect: true 则为单选  -->
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'orderNum',width:150">预约编号</th>
				<th data-options="field:'legalMan', width:120">纳税人名称</th>
				<th data-options="field:'phoneNum', width:120">法定代表人</th>
				<th data-options="field:'businessAddress',width:100">经营地址</th>
				<th data-options="field:'fNo',width:100">档号</th>
				<th data-options="field:'callOne',width:150">联系电话1</th>
				<th data-options="field:'callTwo', width:120">联系电话2</th>
				<th data-options="field:'phoneNum', width:120">联系电话</th>
				<th data-options="field:'fID',width:100">档主身份证号码</th>
				<th data-options="field:'businessLicenseNum',width:150">营业执照注册号</th>
				<th data-options="field:'yissueDate', width:120">出证日期</th>
				<th data-options="field:'taxpayerIDcode', width:120">国税纳税人识别码</th>
				<th data-options="field:'gissueDate',width:100">发证日期</th>
				<th data-options="field:'landtaxNum', width:120">地税登记号</th>
				<th data-options="field:'dissueDate', width:120">发证日期</th>
				<th data-options="field:'partnerOneName',width:100">股东姓名1</th>
				<th data-options="field:'pIDOne',width:150">股东身份证号码</th>
				<th data-options="field:'partnerTwoName',width:100">股东姓名2</th>
				<th data-options="field:'partnerID',width:150">股东身份证号码</th>
				<th data-options="field:'foreignIC',width:100">外汇IC卡号码</th>
				<th data-options="field:'status',width:100" formatter="formatStatus">业务状态</th>
				<th data-options="field:'commet',width:195">备注</th>
					
			</tr>
		</thead>
	</table>
	<div id="tb" style="height:auto;">
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-download',plain:true" onclick="toImportExcel()">导入</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-upload',plain:true" onclick="exportExcel()">导出</a>
		
	</div>
	
	</div>
  </div>
	
	 <div id="importdlg" class="easyui-dialog" style="margin-top:40px; width: 300px; height: 150px; padding: 10px 20px" closed="true">
	  <form id="importfm" method="post"  enctype="multipart/form-data"novalidate >
		 <input class="easyui-filebox" id="importfile" name="file" data-options="prompt:'选择文件路径'" style="width:100%">
	  </form>
	   <a href="javascript:void(0)" class="easyui-linkbutton c6" id="importExcel"
			iconCls="icon-ok" style="margin-top:20px;width: 90px">确定</a> 
		 <a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#importdlg').dialog('close')"
			style="width: 90px; margin-top:20px">取消</a>
	  </div>
	
	
	<script type="text/javascript">
		
		
		 function formatStatus(value, row){ //格式化状态
			if(value == '1' || value == 1){
				return "预约中";
			}else if(value == '2' || value == 2){
				return "进行中";
			}else if(value == '3' || value == 3){
				return "已完成";
			}else if(value == '4' || value == 4){
				return "正常";
			}else {
				return "欠费";
			}
		} 
		
		function exportExcel() {  //导出excel文件
			 var rows = $('#exceldg').datagrid('getChecked');
			if (rows.length == 0) {
             		$.messager.alert('操作提示', "请至少选择一条数据！", 'warning');
             		return;
             	 } 
           		 var orderNums1 = '', orderNums2 = '', orderNums3 = '';
           		 for(var i=0; i<rows.length; i++){
                 	if(rows[i].companyType == 1){  //个体户
                 		orderNums1 += rows[i].orderNum+',';
                 		
                 	}else if(rows[i].companyType == 2){ //内资企业
                 		orderNums2 += rows[i].orderNum+',';
                 		
                 	}else if(rows[i].companyType == 3){ //外资企业
                 		orderNums3 += rows[i].orderNum+',';
                 	}
                 }
                 orderNums1 = orderNums1.substring(0,orderNums1.lastIndexOf(","));
                 orderNums2 = orderNums2.substring(0,orderNums2.lastIndexOf(","));
                 orderNums3 = orderNums3.substring(0,orderNums3.lastIndexOf(",")); 
                 console.log(orderNums1+"| "+orderNums2+"| "+orderNums3);
			
			 location.href = "<%=basePath%>framework/excel/exportExcel.action?orderNums1="+orderNums1+"&orderNums2="+orderNums2+"&orderNums3="+orderNums3;
		}
		
		function toImportExcel() {  //打开导入excel对话框
			$('#importdlg').dialog('open').dialog('setTitle','导入Excel');
		}
		
		
		 //JS校验form表单信息
	     function checkData(){
	     	var fileDir = $("#importfile").filebox('getValue');
	     	//var fileDir = $("#upfile").val();
	     	var suffix = fileDir.substr(fileDir.lastIndexOf("."));
	     	if("" == fileDir){
	     		$.messager.alert('操作提示', "选择需要导入的Excel文件！", 'warning');
	     		return false;
	     	}
	     	if(".xls" != suffix && ".xlsx" != suffix ){
	     		$.messager.alert('操作提示', "选择Excel格式的文件导入！", 'warning');
	     		return false;
	     	}
	     	return true;
	     }
		
		 $(document).ready(function(){
     		$('#importExcel').click(function(){
         		if(checkData()){
         			$('#importfm').ajaxSubmit({  
         				url: '<%=basePath%>framework/excel/importExcel.action',
         				dataType: 'text',
         				success: resutlMsg,
         				error: errorMsg
         			}); 
         			function resutlMsg(msg){
         				var obj = JSON.parse(msg);
         				console.log(obj+", "+obj.state);
         				if(obj.state==1){
			       			$('#importdlg').dialog('close');        // close the dialog
			           		$('#exceldg').datagrid('reload');    // reload the user data
			       		}else {
			       			$.messager.alert('操作提示', "导入excel文件失败！", 'warning');
			       		}
							
						}
						function errorMsg(){
							$.messager.alert('操作提示', "导入excel出错！", 'warning');
						}
         		}
     		});
 	     });
		
			
	</script>
	
</body>
</html>