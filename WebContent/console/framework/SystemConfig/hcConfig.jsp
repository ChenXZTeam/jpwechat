<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>缓存配置</title>
	<link rel="stylesheet" type="text/css"href="<%=basePath%>scripts/common/jquery-easyui/themes/default/easyui.css"/>
	<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css"/>
	<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/default/datagrid.css"/>
	<script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript"src="<%=basePath%>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript"src="<%=basePath %>console/js/airCodeVScity.js"></script>
</head>
<body>
<script>
$(function(){
	$("#grideBox").css("height",$(window).height()-41);
	$('#numListBox').datagrid({
	    height: '100%',
	    fit:true,
	    url: '<%=basePath%>framework/hcConfig/numList.action',
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
	        { field: 'orgCity', title: '出发城市', width: '15%' ,formatter:findByCity},
	        { field: 'dstCity', title: '到达城市', width: '15%' ,formatter:findByCity},
	        { field: 'hcType', title: '航班时间分类',align:'center', width: '10%' ,
	        	formatter:function(value,rec,index){  
	                if(value=="1"){
	               	 	return "出发当天";
	                }else if(value=="2"){
	               	 	return "3天以内出发";
	                }else if(value=="3"){
	               	 	return "3-7天出发";
	                } if(value=="4"){
	               	 	return "7-15天出发";
	                } if(value=="5"){
	               	 	return "15-30天出发";
	                } if(value=="6"){
	               	 	return "30天以上";
	                }
          	  	}
	        },
	        { field: 'createTime', title: '缓存创建时间',align:'center', width: '10%' ,formatter:fotmateDate},
	        { field: 'overTime', title: '缓存过期时间',align:'center', width: '10%' ,formatter:fotmateDate},
	        { field: 'isOver', title: '是否过期',align:'center', width: '10%',
	        	formatter:function(value,rec,index){  
	                if(value=="0"){
	               	 	return "已过期";
	                }else if(value=="1"){
	               	 	return "未过期";
	                }
          	  	}
	        },
	        { field: 'handUpTime', title: '管理员更新时间',align:'center', width: '10%' ,formatter:fotmateDate}
	    ]]
	});
});
	
	function upHcDate(){
		$('#numListBox').datagrid({
		    height: '100%',
		    fit:true,
		    url: '<%=basePath%>framework/hcConfig/reloadHc.action',
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
		        { field: 'orgCity', title: '出发城市', width: '15%' ,formatter:findByCity},
		        { field: 'dstCity', title: '到达城市', width: '15%' ,formatter:findByCity},
		        { field: 'hcType', title: '航班时间分类',align:'center', width: '10%' ,
		        	formatter:function(value,rec,index){  
		                if(value=="1"){
		               	 	return "出发当天";
		                }else if(value=="2"){
		               	 	return "3天以内出发";
		                }else if(value=="3"){
		               	 	return "3-7天出发";
		                } if(value=="4"){
		               	 	return "7-15天出发";
		                } if(value=="5"){
		               	 	return "15-30天出发";
		                } if(value=="6"){
		               	 	return "30天以上";
		                }
	          	  	}
		        },
		        { field: 'createTime', title: '缓存创建时间',align:'center', width: '10%' ,formatter:fotmateDate},
		        { field: 'overTime', title: '缓存过期时间',align:'center', width: '10%' ,formatter:fotmateDate},
		        { field: 'isOver', title: '是否过期',align:'center', width: '10%',
		        	formatter:function(value,rec,index){  
		                if(value=="0"){
		               	 	return "已过期";
		                }else if(value=="1"){
		               	 	return "未过期";
		                }
	          	  	}
		        },
		        { field: 'handUpTime', title: '管理员更新时间',align:'center', width: '10%' ,formatter:fotmateDate}
		    ]]
		});
	}
	
	function updateHc(){
		var rows = $('#numListBox').datagrid('getChecked');
		var sign = "";
		if(rows.length==0){
			$.messager.confirm('确认', '确定要更新全部缓存吗（耗时较长）？', function (r) {
    			if (r) {
    				sign = "all";
    				$.messager.alert('操作提示', "待开发！部分缓存的已开发，可以进行测试！", 'warning');
    				<%-- $.post("<%=basePath%>framework/hcConfig/relUpHc.action",{"sign":sign},function(result){
						
					}); --%>
    			}
			});
		}else{
			for(var i=0; i<rows.length; i++){
				sign+=rows[i].uuid+",";
			}
			sign = sign.substring(0,sign.length-1);
			$.ajax({
	             type: "POST",
	             url: "<%=basePath%>framework/hcConfig/relUpHc.action",
	             data: {"sign":sign},
	             dataType: "json",
	             beforeSend:function(){
	                 $("#loadBox").css("display","block");
	             },
	             success: function(data){
	            	 console.log("更新缓存结果："+data);
	            	 if(data==1||data=="1"){
	            		 window.location.reload();
	            	 }else if(data==0||data=="0"){
	            		 $.messager.alert('操作提示', "更新失败！", 'warning');
	            	 }
	             },error:function(){
	            	 $.messager.alert('操作提示', "更新失败！系统出错", 'warning');
	             }
	        });
			
		}
	}
	
	//格式化时间
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
<div style="height:25px; background-color:#fff;">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="upHcDate()">生成缓存数据</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="updateHc()">更新缓存数据</a>
</div>
<div id="grideBox" style="width:100%;">
	<div id="numListBox" style="width:100%;height:100%;"></div>
</div>
<div id="loadBox" style="display:none; width:100%;height:100%;position:absolute; top:0px; left:0px; background:rgba(0,0,0,0.1);">
	<div style="margin-left:auto; margin-right:auto; margin-top:20%; text-align:center; line-height:70px; width:180px; height:70px; background:rgba(0,0,0,0.5); color:#fff; border-radius:5px;">缓存更新中...</div>
</div>
</body>
</html>