<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String imgPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/images/";
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css">
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/jquery.min.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=vKCQUCy8RGAuMMHU3iPH226z32Ojt6fI" charset="utf-8"></script>
 <script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=6cef820710cfcb9bb54f192f30d2f0f5&plugin=AMap.CitySearch"></script> 
 <script type="text/javascript" src="http://counter.sina.com.cn/ip/"></script>
<title>Insert title here</title>
<style type="text/css">
      #tt td{
      	border:1px solid #666666;
      	width: 100px;
      	height: 100px;
      	float: left;
      }
      #tt img{
      	width: 100px;
      	height: 100px;
      }
</style>
<script type="text/javascript">
	$(function(){ 
		$('#countries').combobox({
		    url:'<%= basePath %>console/json/countries_EN.json',
		    valueField:'id',
		    textField:'name',
		});
		
		var geolocation = new BMap.Geolocation();    
		var gc = new BMap.Geocoder();     
		  
		geolocation.getCurrentPosition( function(r) {   //定位结果对象会传递给r变量  
		  
		        if(this.getStatus() == BMAP_STATUS_SUCCESS){  //通过Geolocation类的getStatus()可以判断是否成功定位。  
		            var pt = r.point;    
		            gc.getLocation(pt, function(rs){    
		                var addComp = rs.addressComponents; 
		                $("#city").html(addComp.city);
		                console.log(addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber);    
		            });  
		        }
		});
		
		$.ajax({
			url:'<%=basePath%>framework/visa/getHotCountriesList.action',
			dataType:'json',
			method:'post',
			success:function(result){
				console.log(result);
				var arr = bubbleSort(result);
				
				var $tr = $('<tr></tr>');
				for(var i=0;i<arr.length;i++){
					$tr.append("<td><a href='<%=basePath%>framework/visa/findByCountry.action?country="+arr[i].countryID+"'>"+arr[i].countryName+""+
							"<img src='<%=imgPath%>"+arr[i].imagePath+"'>"+
							"</a></td>");
					if((i+1)%3==0){
						$("#tt").append($tr);
						$tr = $("<tr></tr>");
					}
				}
				$("#tt").append($tr);
				console.log(arr);
			},
			error:function(result){
				console.log(result);
			}
		});
		
	});
	
	function findVisa(){
		var country = $("#countries").combobox('getValue');
		if(country!=''&&country!=null){
            location.href='<%=basePath%>framework/visa/findByCountry.action?country='+country;
		}
	}
	
	//对热门国家进行排序
	function bubbleSort(arr) {
	    var i = arr.length, j;
	    var tempExchangVal;
	    while (i > 0) {
	        for (j = 0; j < i - 1; j++) {
	            if (arr[j].priority > arr[j + 1].priority) {
	                tempExchangVal = arr[j];
	                arr[j] = arr[j + 1];
	                arr[j + 1] = tempExchangVal;
	            }
	        }
	        i--;
	    }
	    return arr;
	}

</script>
</head>
<body>
	
	<label id="city"></label>
	<input id="countries"><a class="easyui-linkbutton" iconCls="icon-search" onclick="findVisa()">搜索</a>
	<br>
	<br>
		<a href="<%=basePath%>console/SeeTheWorld/ProgressList.jsp">签证进度</a>
		<a href="<%=basePath%>console/SeeTheWorld/VisaOrderList.jsp">我的订单</a>
		<a href="<%= basePath%>console/SeeTheWorld/VisaFreeList.jsp">免签、落地签</a>
	<br>
	<br>
	<table id="tt">

	</table>
</body>
</html>