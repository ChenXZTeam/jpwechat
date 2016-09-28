<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>签证国家的输入</title>
<script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
<script src="<%=basePath%>console/js/ajaxfileupload.js"></script>
</head>
<body>
	<table width="1000" border="0" cellpadding="0" cellspacing="10">
		<tr>
			<td style="width:120px;">国家名：</td>
			<td style="width:400px;"><input id="countryName" type="text"/></td>
			<td>所属区域：</td>
			<td>
				<select id="belongArea">
					<option value="yz">亚洲</option>
					<option value="mz">美洲</option>
					<option value="oz">欧洲</option>
					<option value="fz">非洲</option>
					<option value="dyz">大洋洲</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>入境次数：</td>
			<td><input id="ruNum" type="text"/></td>
			<td>逗留天数：</td>
			<td><input id="douNumDay" type="text"/></td>
		</tr>
		<tr>
			<td>有效期限：</td>
			<td><input id="youxiaoDate" type="text"/></td>
			<td>办理时长：</td>
			<td><input id="banliDate" type="text"/></td>
		</tr>
		<tr>
			<td>签证价格：</td>
			<td><input id="payCost" type="text"/></td>
			<td>最早可定日期：</td>
			<td><input id="canOrderDate" type="text"/></td>
		</tr>
		<tr>
			<td>签证类型：</td>
			<td><input id="qzType" type="text"/></td>
			<td>签证政策：</td>
			<td>
				<select id="qzMode">
					<option value="1">没有特殊政策</option>
					<option value="2">落地签</option>
					<option value="3">免签</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>是否推荐热门：</td>
			<td>
				<select id="remenContry">
					<option value="0">否</option>
					<option value="1">是</option>
				</select>
			</td>
			<td>上传图片：</td>
			<td><form id="uploadForm" style=" float:left;"><input type="file" name="myFileImg" id="myFileImg" style="width:160px;"/><input type="button" id="btnId" onclick="updataImg()" value="上传" style="margin-left:10px;"/></form><span style="background:none; color:#ff0000; width:70px; line-height:22px; font-size:13px; float:left; margin-left:10px; display:none;" id="upTishi">上传中...</span><div style="clear:both;"></div></td>
		</tr>
		<tr>
			<td>受理范围：</td>
			<td><textarea id="shouArea" style="width:300px; height:100px;"></textarea></td>
			<td>办理流程：</td>
			<td><textarea id="banliTech" style="width:300px; height:100px;"></textarea></td>
		</tr>
		<tr>
			<td>服务内容：</td>
			<td colspan="3"><textarea id="serviceCont" style="width:842px; height:100px;"></textarea></td>
		</tr>
		<tr>
			<td>风景介绍：</td>
			<td colspan="3"><textarea id="TouryIntro" style="width:842px; height:100px;"></textarea></td>
		</tr>
		<tr>
			<td colspan="4"><button id="submitBtn">提交</button></td>
		</tr>
	</table>
</body>
<script>
	$(function(){
		$("#submitBtn").click(function(){
			$.ajax({
				url:"<%=basePath%>/framework/visa/addVisa.action",
				type:"POST",
				data:{
					"countryName":$("#countryName").val(),
					"belongArea":$("#belongArea").val(),
					"ruNum":$("#ruNum").val(),
					"douNumDay":$("#douNumDay").val(),
					"youxiaoDate":$("#youxiaoDate").val(),
					"banliDate":$("#banliDate").val(),
					"payCost":$("#payCost").val(),
					"canOrderDate":$("#canOrderDate").val(),
					"qzType":$("#qzType").val(),
					"serviceCont":$("#serviceCont").val(),
					"shouArea":$("#shouArea").val(),
					"banliTech":$("#banliTech").val(),
					"qzMode":$("#qzMode").val(),
					"remenContry":$("#remenContry").val(),
					"TouryIntro":$("#TouryIntro").val()
				},
				dataType:"json",
				success:function(res){
					alert("保存数据成功");
				},error:function(){}
			});
		});
		
		//选择上传文件的时候执行的方法
		$("#myFileImg").change(function(){
			$("#btnId").addClass("submit");
		});
	});
	
	//上传按钮点击事件
	function updataImg(){
		var formData = new FormData($( "#uploadForm" )[0]);  
	    $.ajax({  
	          url: "<%=basePath %>framework/visa/addVisaImg.action",  
	          type: "post",  
	          data: formData,  
	          async: false,  
	          cache: false,  
	          beforeSend:function(){$("#upTishi").css("display","block");},
			  complete:function(){$("#upTishi").css("display","block");},
	          contentType: false,  
	          processData: false,  //对参数进行序列化处理
	          success: function (returndata) { 
	          	  var jsondata = JSON.parse(returndata);
	          	  if(jsondata.status == "success"){
	          	  		$("#btnId").removeClass("submit");
	          	  		$("#myFileImg").val(""); //清空上传的文件名
	          	  		$("#upTishi").text("上传成功！");
	          	  }else{
	          	  		$("#upTishi").text("上传失败！");
	          	  } 
	          },  
	          error: function (returndata) {  
	              alert("上传失败！！");  
	              $("#upTishi").text("上传失败！");
	          }  
	    });  	
	}
</script>
</html>