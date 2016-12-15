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
<title>用户管理</title>
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
</style>
<script type="text/javascript">
$(function(){
	
	
	$('#dg').datagrid({
	    height: '100%',
	    fit:true,
	    url: '<%=basePath %>framework/user/shows.action',
	    method: 'POST',
	    striped: true,
	    nowrap: true,
	    pageSize: 10,
	    pageNumber:1, 
	    pageList: [10, 20, 50, 100, 150, 200],
	    showFooter: true,
		loadMsg : '数据加载中请稍后……',
		pagination : true,
	    toolbar:"#toolbar",
	    checkOnSelect:false,
	    selectOnCheck:false,
	    columns: [[
	        { field: 'ck', checkbox: true },
	        { field: '<%=User.USERNAME%>', title: '用户名称', width: 150},
	        { field: 'email', title: '邮箱地址', width: 200},
	        { field: 'mobile', title: '手机号码', width: 200},
	        { field: '<%=User.USERCLASS %>', title: '用户类型', width: 150,
	        	 formatter:function(value,rec,index){  
                     if(value=="<%=User.UserClass.SYSADMIN%>"){
                    	 return "系统管理员";
                     }else if(value="<%=User.UserClass.SYSUSER%>"){
                    	 return "系统用户";
                     }else if(value="<%=User.UserClass.WEBMEMB%>"){
                    	 return "网站成员";
                     }else{
                    	 return "不明";
                     }
                 }	
	        },
	        { field: 'userType', title: '用户角色', width: 150,
	        	 formatter:function(value,rec,index){  
                    if(value=="ADMIN"){
                   	 return "管理员";
                    }else if(value="USER"){
                   	 return "用户";
                    }else{
                   	 return "不明";
                    }
                }	
	        },
	        { field: '<%=User.USERSTATUS %>', title: '用户状态', width: 150,
	        	 formatter:function(value,rec,index){  
                     if(value==<%=User.UserStatus.ACT %>){
                    	 return "活动";
                     }else if(value=<%=User.UserStatus.FRZ %>){
                    	 return "冻结";
                     }else{
                    	 return "不明";
                     }
                 }	
	        },
	        { field: 'createTime', title: '创建时间', width: 150,formatter:fotmateDate}
	    ]],

	    onDblClickRow :function(rowIndex,rowData){
	    	editBean(rowData);
	   	}
	});
});

var url;
function newBean(){
 	//if(fitemPassword!= undefined){
    //	$("#fitemPassword").append(fitemPassword);
    //}
 	$("#fitemPassword").show();
    $('#dlg').dialog('open').dialog('setTitle',' ');
    $('#fm').form('clear');
    <%-- $("[name='<%=User.USERCLASS %>']").eq(0)[0].checked=true; --%>
    $("[name='<%=User.USERTYPE %>']").eq(0)[0].checked=true;
    $("[name='<%=User.USERSTATUS %>']").eq(0)[0].checked=true;
    $('#headImg').attr("src", "").attr("value","");
    url = '<%=basePath%>framework/user/add.action';
    $('#ftitle').html("添加用户");
}
var fitemPassword;
function editBean(row){
    if (row){
        if(row.userClass=='SYST'){
        	//$("#fitemPassword").append(fitemPassword);
        	$("#fitemPassword").show();
        }else{
        	//fitemPassword=$(".fitem_password").remove();
        	$("#fitemPassword").hide();
        }
        row.password2=row.password="******";
        $('#dlg').dialog('open').dialog('setTitle','');
        $('#fm').form('load',row);
        //$("#headImgFile").val("");
        <%-- $('#headImg').attr("src", "<%=basePath%>/images/framework/headimgs/"+ $("[name='headImg']").eq(0).val()); --%>
        url = '<%=basePath%>framework/user/update.action';    
        $('#ftitle').html("修改用户信息");
    }
}


function saveBean(){
    $('#fm').form('submit',{
        url: url,
        onSubmit: function(){
            return $(this).form('validate');
        },
        success: function(result){
            $('#dlg').dialog('close');        // close the dialog
            $('#dg').datagrid('reload');    // reload the user data
        }
    });
}
function destroyBean(){
	var rows = $('#dg').datagrid('getChecked');
    if (rows.length>0){
        $.messager.confirm('温馨提示','你真的要删除么?',function(r){
            if (r){
            	for(var i=0; i<rows.length; i++){
            		var row=rows[i];
             $.post('<%=basePath%>framework/user/delete.action',{userUID:row.userUID},function(result){
                    if (result.success){
                        $('#dg').datagrid('reload');    // reload the user data
                    } else {
                        $.messager.show({    // show error message
                            title: 'Error',
                            msg: result.errorMsg
                        });
                    }
                },'json'); 
            }
            }
        });
    }
}
        

$.extend($.fn.validatebox.defaults.rules, {  
    equalTo: {
        validator:function(value,param){
            return $(param[0]).val() == value;
        },
        message:'两次密码不匹配'
    },
    isExist: {
        validator:function(value,param){
        	var r=false;
        	$.ajax({  
                type : "post",  
                 url : "<%=basePath%>framework/user/isExist.action",
                 data : {userUID:$("#userUID").val(), <%=User.USERNAME%>:value}, 
                 dataType: 'json',
                 async : false,  
                 success : function(data){
                	 if(data==false) r=true;
                 }  
            }); 
            return r;
        },
        message:'用户已存在'
    }

}); 

function fotmateDate(value){
	var dateStr = "";
	if(value=="undefined"||value=="null"||value==null){}else{
		var date = new Date(value);
		dateStr = date.format("yyyy-MM-dd");
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
</head>
<body>
	<div id="dg" style="width: 100%;height:100%"></div>
	<div id="toolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="newBean()">添加用户</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true" onclick="destroyBean()">删除用户</a>
	</div>

	<div id="dlg" class="easyui-dialog"
		style="width: 580px; height: 450px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons">
		<div class="ftitle" id="ftitle"></div>
		<form id="fm" method="post" enctype="multipart/form-data" novalidate>
			<input id="<%=User.USERUID %>" name="<%=User.USERUID %>"  type="hidden">
			<div class="fitem">
				<label>用户名称:</label>
				 <input name="<%=User.USERNAME%>" class="easyui-textbox"
				 	data-options="required:true,validType:['length[3,15]', 'isExist']"  />

			</div>
			<div id="fitemPassword">
				<div class="fitem fitem_password">
					<label>用户密码:</label>
					 <input id="<%=User.PASSWORD %>" name="<%=User.PASSWORD %>" type="password" class="easyui-textbox" 
					 	data-options="required:true,validType:['length[5,15]']" />
				</div>
				<div class="<%=User.PASSWORD %>2 fitem fitem_password">
					<label>验证密码:</label>
					 <input name="<%=User.PASSWORD %>2" type="password" class="easyui-textbox"
					 	data-options="required:true,validType:['equalTo[\'#password\']']"/>
				</div>
			</div>
			<%-- <div class="fitem">
				<label>用户类型:</label>
				 <input name="<%=User.USERCLASS %>" type="radio" value="<%=User.UserClass.SYSADMIN %>"/>系统管理员
				 <input name="<%=User.USERCLASS %>" type="radio" value="<%=User.UserClass.SYSUSER %>"/>系统用户
				 <input name="<%=User.USERCLASS %>" type="radio" value="<%=User.UserClass.WEBMEMB %>"/>网站成员
			</div> --%>
			<div class="fitem">
				<label>用户角色:</label>
				 <input name="userType" type="radio" value="ADMIN"/>管理员
				 <input name="userType" type="radio" value="USER"/>用户
			</div>
			<div class="fitem">
				<label>用户状态:</label>
				 <input name="<%=User.USERSTATUS %>" type="radio" value="1"/>活动
				 <input name="<%=User.USERSTATUS %>" type="radio" value="2"/>冻结
			</div>
			<div class="fitem">
				<label>电子邮件地址:</label>
				 <input name="email" class="easyui-textbox"
				 	data-options="validType:['email']" style="width:255px;"/>
			</div>
			<div class="fitem">
				<label>手机号码:</label>
				 <input name="mobile" class="easyui-textbox"
				 	data-options="validType:['length[0,25]']" />
			</div>
			<!-- <input name="headImg" type="hidden"/>
			<div class="fitem">
				<label>用户头像:</label>
				<input id="headImg" type="image" onclick="return false;"/>
			</div>
			<div class="fitem">
				<label>上传头像:</label>
				 <input id="headImgFile" type="file" name="headImgFile" accept=".jpg"/>
			</div>
			<div class="fitem">
				<label>用户扩展属性:</label>
				 <input name="userExtProps" class="easyui-textbox"  style="width:300px;height:100px"
				 	data-options="multiline:true"/>
			</div>
			<div class="fitem">
				<label>描述:</label>
				 <input name="description" class="easyui-textbox"  style="width:300px;height:100px;white-space: pre-wrap;"
				 	data-options="multiline:true"/>
			</div> -->
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="saveBean()" style="width: 90px">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')"
			style="width: 90px">取消</a>
	</div>
</body>
</html>