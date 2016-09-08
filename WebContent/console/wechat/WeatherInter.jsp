<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>天气预报</title>
<link type="text/css" rel="stylesheet" href="<%=basePath %>console/css/lanrenzhijia.css"/>
<script type="text/javascript"  src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/kinetic-v5.0.1.min.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/lanrenzhijia.js" charset="utf-8"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=vKCQUCy8RGAuMMHU3iPH226z32Ojt6fI" charset="utf-8"></script>
<style>
	body{margin:0px; padding:0px; text-align:center; background-color:#F9F9F9;}
	.Temperature{width:95%; padding:20px 0px; margin-left:auto; margin-right:auto;}
	.Temperature .wendu{overflow:hidden; text-align:center;}
	.Temperature .wendu .tianqiClass{padding:0px; width:210px; margin-left:auto; margin-right:auto; padding-left:25px; overflow:hidden;}
	.Temperature .wendu .tianqiClass img{display:inline; float:left;}
	.Temperature .wendu .tianqiClass span{line-height:40px; display:inline; float:left; color:#007AFF; font-size:35px; font-family:SimHei;}
	.Temperature .wendu .tianqiClass .shangbiao{width:15px; height:15px; line-height:1px;}
	.Temperature .pingpan span{color:#007AFF; font-family:Microsoft YaHei; font-size:18px;}
	.Temperature .pingpan .you{color:#FFFFFF; background-color:#007AFF; width:30px; height:25px; padding:0px 17px; border:#007AFF solid 1px; border-radius:5px; margin-left:10px; font-size:13px;}
	.chaoxiTitle{width:95%; height:30px; margin-left:auto; margin-right:auto; text-align:left; border-bottom:#D4D4D2 solid 1px; font-family:Microsoft YaHei;}
	.chaoxiTitle span{color:#017AFF; line-height:30px;}
	.chaoxiTitle a{font-size:14px; color:#969696;}
	.winAndSun{width:95%; margin-left:auto; margin-right:auto; overflow:hidden; padding:10px 0px;}
	.winAndSun .img{float:left;}
	.winAndSun .img img{}
	.winAndSun .text{margin-left:5px; float:left;}
	.winAndSun .text span{display:block; clear:both; color:#66A2C4; font-size:14px; font-weight:100; font-family:Microsoft YaHei; line-height:15px;}
	.win{float:left;}
	.sun{float:right;}
	
	.product-1{background-color:#0099FF; width: 100%;height: 200px;}
	.product-1 .loaction{color:white; margin-top:-50px;}
	.product-1 .loaction input{background:none; border:none; color:white; width:30px;margin-top:60px;}
	.product-2{background-color:white; width: 100%;}
	.product-2 .product-2-1{width:20%; height:80px; float:left; margin:20px 2%}
	.product-2 .product-2-1 .nowClass{color:#4F5F6F;}
	.product-2 .product-2-1 p{height:25px; line-height:25px; color:#A7B5C5;}
	.product-2 .product-2-1 img{width:30px;}
</style>
</head>

<body>
<div class="lanrenzhijia">
  <div class="title cf">
    <ul class="title-list fr cf ">
      <li>周一</li>
      <li>周二</li>
      <li>周三</li>
      <li>周四</li>
      <li>周五</li>
	  <li>周六</li>
	  <li>周日</li>
      <p><b></b></p>
    </ul>
  </div>
  
  <div class="product-wrap">
    <!--案例1-->
    <div class="product show">
       <div class="product-1">
              <img src="<%=basePath %>console/images/bigRain.png" style="margin-top:20px; width:110px;"/>
              <div class="loaction">
                   <input type="text" value="24℃"/>
				   <span>广州市</span>
       		  </div>
       </div>
       <div class="product-2">
            <div class="product-2-1">
                 <p class="nowClass">现在</p>
                 <img src="<%=basePath %>console/images/lightRainImgNew.png"/>
                 <p class="nowClass">5℃</p>
               
           </div>
           <div class="product-2-1">
                 <p>10时</p>
                 <img src="<%=basePath %>console/images/rainImgNew.png"/>
                 <p>10℃</p>
               
           </div>
           <div class="product-2-1">
                  <p>11时</p>
                  <img src="<%=basePath %>console/images/duoyunImgNew.png"/>
                  <p>15℃</p>
                
           </div>
           <div class="product-2-1">
                <p>12时</p>
                <img src="<%=basePath %>console/images/sunImgNew.png"/>
                <p>-10℃</p>
           </div>        
      	</div>
    </div>
    <!--案例2-->
    <div class="product">
       <div class="product-1">
              <img src="<%=basePath %>console/images/bigRain.png" style="margin-top:20px; width:110px;"/>
              <div class="loaction">
                   <input type="text" value="30℃"/>
				   <span>广州市</span>
       		  </div>
       </div>
       <div class="product-2">
            <div class="product-2-1">
                 <p class="nowClass">现在</p>
                 <img src="<%=basePath %>console/images/lightRainImgNew.png"/>
                 <p class="nowClass">-5℃</p>
               
           </div>
           <div class="product-2-1">
                 <p>10时</p>
                 <img src="<%=basePath %>console/images/rainImgNew.png"/>
                 <p>17℃</p>
               
           </div>
           <div class="product-2-1">
                  <p>11时</p>
                  <img src="<%=basePath %>console/images/duoyunImgNew.png"/>
                  <p>20℃</p>
                
           </div>
           <div class="product-2-1">
                <p>12时</p>
                <img src="<%=basePath %>console/images/sunImgNew.png"/>
                <p>24℃</p>
           </div>        
      	</div>
    </div>
    <!--案例3-->
    <div class="product">
       <div class="product-1">
              <img src="<%=basePath %>console/images/bigRain.png" style="margin-top:20px; width:110px;"/>
              <div class="loaction">
                   <input type="text" value="50℃"/>
				   <span>广州市</span>
       		  </div>
       </div>
       <div class="product-2">
            <div class="product-2-1">
                 <p class="nowClass">现在</p>
                 <img src="<%=basePath %>console/images/lightRainImgNew.png"/>
                 <p class="nowClass">8℃</p>
               
           </div>
           <div class="product-2-1">
                 <p>10时</p>
                 <img src="<%=basePath %>console/images/rainImgNew.png"/>
                 <p>26℃</p>
               
           </div>
           <div class="product-2-1">
                  <p>11时</p>
                  <img src="<%=basePath %>console/images/duoyunImgNew.png"/>
                  <p>7℃</p>
                
           </div>
           <div class="product-2-1">
                <p>12时</p>
                <img src="<%=basePath %>console/images/sunImgNew.png"/>
                <p>34℃</p>
           </div>        
      	</div>
    </div>
    <!--案例4-->
    <div class="product">
       <div class="product-1">
              <img src="<%=basePath %>console/images/bigRain.png" style="margin-top:20px; width:110px;"/>
              <div class="loaction">
                   <input type="text" value="-5℃"/>
				   <span>广州市</span>
       		  </div>
       </div>
       <div class="product-2">
            <div class="product-2-1">
                 <p class="nowClass">现在</p>
                 <img src="<%=basePath %>console/images/lightRainImgNew.png"/>
                 <p class="nowClass">74℃</p>
               
           </div>
           <div class="product-2-1">
                 <p>10时</p>
                 <img src="<%=basePath %>console/images/rainImgNew.png"/>
                 <p>100℃</p>
               
           </div>
           <div class="product-2-1">
                  <p>11时</p>
                  <img src="<%=basePath %>console/images/duoyunImgNew.png"/>
                  <p>-25℃</p>
                
           </div>
           <div class="product-2-1">
                <p>12时</p>
                <img src="<%=basePath %>console/images/sunImgNew.png"/>
                <p>41℃</p>
           </div>        
      	</div>
    </div>
    <!--案例5-->
    <div class="product">
       <div class="product-1">
              <img src="<%=basePath %>console/images/bigRain.png" style="margin-top:20px; width:110px;"/>
              <div class="loaction">
                   <input type="text" value="10℃"/>
				   <span>广州市</span>
       		  </div>
       </div>
       <div class="product-2">
            <div class="product-2-1">
                 <p class="nowClass">现在</p>
                 <img src="<%=basePath %>console/images/lightRainImgNew.png"/>
                 <p class="nowClass">28℃</p>
               
           </div>
           <div class="product-2-1">
                 <p>10时</p>
                 <img src="<%=basePath %>console/images/rainImgNew.png"/>
                 <p>21℃</p>
               
           </div>
           <div class="product-2-1">
                  <p>11时</p>
                  <img src="<%=basePath %>console/images/duoyunImgNew.png"/>
                  <p>23℃</p>
                
           </div>
           <div class="product-2-1">
                <p>12时</p>
                <img src="<%=basePath %>console/images/sunImgNew.png"/>
                <p>28℃</p>
           </div>        
      	</div>
    </div>
	
	<!--案例6-->
    <div class="product">
       <div class="product-1">
              <img src="<%=basePath %>console/images/bigRain.png" style="margin-top:20px; width:110px;"/>
              <div class="loaction">
                   <input type="text" value="18℃"/>
				   <span>广州市</span>
       		  </div>
       </div>
       <div class="product-2">
            <div class="product-2-1">
                 <p class="nowClass">现在</p>
                 <img src="<%=basePath %>console/images/lightRainImgNew.png"/>
                 <p class="nowClass">29℃</p>
               
           </div>
           <div class="product-2-1">
                 <p>10时</p>
                 <img src="<%=basePath %>console/images/rainImgNew.png"/>
                 <p>35℃</p>
               
           </div>
           <div class="product-2-1">
                  <p>11时</p>
                  <img src="<%=basePath %>console/images/duoyunImgNew.png"/>
                  <p>-14℃</p>
                
           </div>
           <div class="product-2-1">
                <p>12时</p>
                <img src="<%=basePath %>console/images/sunImgNew.png"/>
                <p>-20℃</p>
           </div>        
      	</div>
    </div>
	
	 <!--案例7-->
    <div class="product">
       <div class="product-1">
              <img src="<%=basePath %>console/images/bigRain.png" style="margin-top:20px; width:110px;"/>
              <div class="loaction">
                   <input type="text" value="32℃"/>
				   <span>广州市</span>
       		  </div>
       </div>
       <div class="product-2">
            <div class="product-2-1">
                 <p class="nowClass">现在</p>
                 <img src="<%=basePath %>console/images/lightRainImgNew.png"/>
                 <p class="nowClass">28℃</p>
               
           </div>
           <div class="product-2-1">
                 <p>10时</p>
                 <img src="<%=basePath %>console/images/rainImgNew.png"/>
                 <p>29℃</p>
               
           </div>
           <div class="product-2-1">
                  <p>11时</p>
                  <img src="<%=basePath %>console/images/duoyunImgNew.png"/>
                  <p>12℃</p>
                
           </div>
           <div class="product-2-1">
                <p>12时</p>
                <img src="<%=basePath %>console/images/sunImgNew.png"/>
                <p>29℃</p>
           </div>        
      	</div>
    </div>
	
  </div>
</div>
<script>
	//百度定位的方法
	var geolocation = new BMap.Geolocation();    
	var gc = new BMap.Geocoder();     
	geolocation.getCurrentPosition( function(r) {  //定位结果对象会传递给r变量 
	        if(this.getStatus() == BMAP_STATUS_SUCCESS){  //通过Geolocation类的getStatus()可以判断是否成功定位。  
	            var pt = r.point; 
	            var mk = new BMap.Marker(r.point);  
        		//alert('您的位置：'+r.point.lng+','+r.point.lat);  //获取定位后的坐标  
	            gc.getLocation(pt, function(rs){    
	                var addComp = rs.addressComponents; 
	                $(".loaction>span").text(addComp.city);
	                //alert('您的位置：'+addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber);
	                console.log(addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber);    
	            }); 
	        }
	});
</script>
</body>
</html>
