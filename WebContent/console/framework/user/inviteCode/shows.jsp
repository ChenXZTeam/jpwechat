<%@page import="com.solar.tech.bean.InvitationCode"%>
<%@page import="com.solar.tech.bean.User"%>
<%@ page import="com.solar.tech.exception.ResultCode" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%  
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css">
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/jquery.min.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<title>Insert title here</title>
<style type="text/css">
* {
	padding: 0px;
	margin: 0px;
}

#fm {
	margin: 0;
	padding: 10px 30px;
}

.ftitle {
	font-size: 14px;
	font-weight: bold;
	padding: 5px 0;
	margin-bottom: 10px;
	border-bottom: 1px solid #ccc;
}

.fitem {
	margin-bottom: 5px;
}

.fitem label {
	display: inline-block;
	width: 80px;
}

.fitem input {
	width: 160px;
}

.fitem input[type=radio] {
	width: 39px;
}
.textbox .textbox-text{white-space: pre-line;}
#table-send {
	border:1px solid #DDDDDD;
	 border-collapse: collapse;
	 width:100%;
}
#table-send th{
	border:1px solid #DDDDDD;
	text-align:center;
}
#table-send td{
	border:1px solid #DDDDDD;
	text-align:center;
	width:50%;
}
</style>
<script>

		$(function(){
			var lastIndex;
			var vac,ivID,timeNums;
			$('#tt').datagrid({
				height: '100%',
			    fit:true,
			    url: '<%= basePath %>framework/invite/getAllInvitCode.action',
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
					        { field: 'id', title: '编号ID', width: 250},
					        { field: 'invitationCode', title: '邀请码', width: 70},
					        { field: 'type', title: '类型', width:100},
					        { field: 'sum', title: '优惠金额', width: 80},
					        { field: 'discount', title: '折扣', width: 50},
					        { field: 'deadline', title: '到期时间', width: 100,formatter: formatDatebox},
					        { field: 'times', title: '使用次数', width: 80},
					        { field: 'remarks', title: '备注', width: 200},
				]]
			});
			
		});
		
		function addCode(){
			$("#preferential").eq(0).attr("disabled",true);
			console.log($("#preferential"));
			$("input[name='type']").attr("disabled",false);
			$("#dlg").dialog("open").dialog('setTitle','');
			$('#ftitle').html("添加邀请码");
			$('#fm').form('clear');
		}
		
		function deleteCode(){
			var rows = $('#tt').datagrid('getChecked');
		    if (rows.length>0){
		    	$.messager.confirm('温馨提示','你真的要删除么?',function(r){
		            if (r){
		            	var arr = new Array();
		            	for(var i=0; i<rows.length; i++){
		            		arr[i] = rows[i].invitationCode;
		            		
		            	}
		            	$.ajax({
	                        url: "<%=basePath%>framework/invite/deleteCode.action",
	                        type: "POST",
	                        dataType: "json",
	                        data: { "ids": JSON.stringify(arr) },
	                        success: function (res) {
	                           if(res>0){
	                        	   $("#tt").datagrid('reload');
	                        	   $.messager.alert("提示消息","删除成功！");
	                           }
	                        },
	                        error: function (error) {
	                            $.messager.alert("提示消息","删除失败!");
	                        }
	                    });
		            }
		        });
		    }
		    if(rows.length<=0){
		    	$.messager.alert("提示消息","请选择记录！");
		    }
		}
		
		function saveBean(){
			var title = $("#ftitle").html();
			var url;
			if(title.indexOf("添加")>=0){
				url = "<%=basePath%>framework/invite/addInviteID.action";
			}else {
				url = "<%=basePath%>framework/invite/updateCode.action";
			}
			$('#fm').form('submit',{
		        url: url,
		        onSubmit: function(){
		            return $(this).form('validate');
		        },
		        success: function(result){
		            $('#dlg').dialog('close');        // close the dialog
		            $('#tt').datagrid('reload');    // reload the user data
		        }
		    });
		}
		
		function updateCode(){
			var rows = $("#tt").datagrid("getChecked");
			if(rows.length==1){
                 $("input[name='invitationCode']").attr("value",rows[0].invitationCode);
                 $("input[name='id']").attr("value",rows[0].id);
                 $("#remarks").textbox("setValue",rows[0].remarks);
                 var date = new Date(rows[0].deadline);
                 $("#deadline_").datebox("setValue",date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate());
                 var sum = rows[0].sum;
                 var discount = rows[0].discount;
                 if(sum!=null&&sum!=''&&sum!=0){
                 		document.getElementById("preferential").checked=true;
                 		document.getElementById("discount").checked=false;
                 		$(".fitem").eq(1).find("label").html("优惠金额:");
             			$(".fitem").eq(1).find("input").attr("name","sum");
                 		$("#money").textbox('setValue',rows[0].sum);
                 }
                 if(discount!=null&&discount!=''&&discount!=0){
                 		document.getElementById("discount").checked=true;
                 		document.getElementById("preferential").checked=false;
                 		$(".fitem").eq(1).find("label").html("折扣:");
             			$(".fitem").eq(1).find("input").attr("name","discount");
                 		$("#money").textbox('setValue',rows[0].discount);
                }
				$("#dlg").dialog("open").dialog('setTitle',' ');
				$('#ftitle').html("修改邀请码");
			}
			if(rows.length>1){
				$.messager.alert("提示消息","只能选择一条记录！");
			}
			if(rows.length<1){
				$.messager.alert("提示消息","请先选择一条记录！");
			}
		}
		
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
		    if (/(y+)/.test(format))  
		        format = format.replace(RegExp.$1, (this.getFullYear() + "")  
		            .substr(4 - RegExp.$1.length));  
		    for (var k in o)  
		        if (new RegExp("(" + k + ")").test(format))  
		            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));  
		    return format;  
		}  
		
		function formatDatebox(value) {  
		    if (value == null || value == '') {  
		        return '';  
		    }  
		    var dt;  
		    if (value instanceof Date) {  
		        dt = value;  
		    } else {  
		        dt = new Date(value);  
		    }  
		  
		    return dt.format("yyyy-MM-dd"); //扩展的Date的format方法(上述插件实现)  
		} 
		
		function sendCode(){
			var rows = $("#tt").datagrid("getChecked");
			if(rows.length>1){
				$.messager.alert("提示消息","只能选择一条记录！");
				return false;
			}
			if(rows.length<=0){
				$.messager.alert("提示消息","请先选择一条记录！");
				return false;
			}
			vac = rows[0].invitationCode;
			ivID = rows[0].id;
			timeNums = rows[0].times;
			if(rows.length==1){	
				$("#dlg-send").dialog("open").dialog('setTitle',' ');
				$('#ftitle-send').html("发送邀请码");
				$("#users").combobox({
				    url:'<%= basePath%>framework/user/findAllUser.action',
				    valueField:'phoneNum',
				    textField:'userName'
				});
			}
		}
		
		function addEentry(){			
				var tel = $("#users").combobox('getValue');
				var userName = $("#users").combobox('getText');
				if((tel!=null&&tel!='')&&(userName!=null&&userName!='')){
					var obj = $("#table-send input[value='"+tel+"']");
					console.log(obj.length);
					if(obj.length==0){
						var input = '<tr><td><input name="users" type="checkbox" value="'+tel+'" class="ck" /></td><td><label>'+userName+'</label></td></tr>';				
						$("#table-send").append(input);
					}
				}else {
					$.messager.alert("提示消息","请先选择一个用户！");
				}
		}
		
		function delEentry(){
			var $users = $("input[name='users']:checked");
			$users.parents("tr").remove();
			console.log(users.length);
		}
		function doPreferential(){
			$("#money").textbox("setValue","");
			$(".fitem").eq(1).find("label").html("优惠金额:");
			$(".fitem").eq(1).find("input").attr("name","sum");
			$("#remarks").textbox("setValue","");
		}
		
		function doDiscount(){
			$("#money").textbox("setValue","");
			$(".fitem").eq(1).find("label").html("折扣:");
			$(".fitem").eq(1).find("input").attr("name","discount");
			$("#remarks").textbox("setValue","");
		}
		
		//发送短信邀请码的方法
		function send(){
			var arr =($(".ck"))
			console.log(arr);
			for(i=0;i<arr.length;i++){
				var user=($(arr[i]).prop("checked"));
				var tel =($(arr[i]).val());
				if(user==true){
					$.ajax({
		                url: "<%=basePath%>framework/invite/send.action",
		                type: "POST",
		                dataType: "json",
		                data: { "telnumber": tel, "invitationCode":vac, "ivID":ivID, "timeNums":timeNums},
		                success: function (res) {
		                    if(res==1){
		                 	   $.messager.alert("提示消息","发送成功！");
		                    }else{
		                       $.messager.alert("提示消息","发送失败！");
		                    }
		                 },
		                 error: function (error) {
		                     $.messager.alert("提示消息","发送失败!");
		                 }
					    });
			}
			else
			{
			      alert("请您先选择一位用户");
			}
			}
			

		
		};	
		
	</script>
</head>	
<body>
	<!-- 功能按钮 -->
	<div id="toolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="addCode()">添加</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true" onclick="deleteCode()">删除</a>
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-reload" plain="true" onclick="updateCode()">修改</a>
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-redo" plain="true" onclick="sendCode()">发送</a>	
	</div>
	<!-- 数据表格 -->
	<div style="width:100%;height:420px;">
		<div id="tt" style="width:100%;height:420px;">
		</div>
	</div>
	<!-- 对话框 -->
	<div id="dlg" class="easyui-dialog" style="width: 40%; height: 400px; 
	padding: 10px 20px" closed="true" buttons="#dlg-buttons">
		<div class="ftitle" id="ftitle"></div>
		<form id="fm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="invitationCode"/>
		<input type="hidden" name="id"/>
		<div class="fitem">
			<label>邀请码类型:</label>		
			<input name="type" type="radio" value="<%= InvitationCode.PREFERENTIAL %>" onfocus="doPreferential()" id="preferential">优惠</input>
			<input name="type" type="radio" value="<%= InvitationCode.DISCOUNT %>" onfocus="doDiscount()" id="discount">折扣</input>
		</div>
		<div class="fitem">
			<label>优惠金额:</label> 		
			<input name="sum" class="easyui-textbox" data-options="required:true" id="money"/>
		</div>
		<div class="fitem">
			<label>备注:</label> 		
			<input name="remarks" class="easyui-textbox" value="" width="120" id="remarks"/>
		</div>
		<div class="fitem">
			<label>到期时间:</label> 		
			<input name="deadline_" class="easyui-datebox" width="120" id="deadline_" data-options="required:true"/>
		</div>
		</form>
	</div>
	
	<!-- 对话框内的按钮 -->
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="saveBean()" style="width: 90px" id="btn">保存</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" 
		onclick="javascript:$('#dlg').dialog('close')" style="width: 90px">取消</a>
	</div> 
	
	<!-- 发送短信对话框 -->
	<div id="dlg-send" class="easyui-dialog" style="width: 40%; height: 400px; 
	padding: 10px 20px" closed="true" buttons="#dlg-buttons">
		<div class="ftitle" id="ftitle-send"></div>
		<div class="fitem" id="test">
			<input id="users" name="users">
			<a type="button" onclick="addEentry()" iconCls="icon-add" class="easyui-linkbutton">添加用户</a>
			<a type="button" onclick="delEentry()" iconCls="icon-remove" class="easyui-linkbutton">删除用户</a>
		</div>
		<div class="fitem">
			<form action="" method="post" id="fm-send">
				<table id="table-send">
					<tr>
						<th>选择</th>
						<th>用户</th>
					</tr>
				</table>			
			</form>
		</div>
	</div>
	
	<!-- 发短信对话框内的按钮 -->
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="send()" style="width: 90px" id="btn">发送</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" 
		onclick="javascript:$('#dlg-send').dialog('close')" style="width: 90px">取消</a>
	</div>
</body>
</html>