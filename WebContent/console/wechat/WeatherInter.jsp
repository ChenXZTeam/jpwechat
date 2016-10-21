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
<link type="text/css" rel="stylesheet" href="<%=basePath %>console/css/cityname.css" />
<script type="text/javascript" src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/kinetic-v5.0.1.min.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/lanrenzhijia.js" charset="utf-8"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=vKCQUCy8RGAuMMHU3iPH226z32Ojt6fI" charset="utf-8"></script>
<script type="text/javascript" src="<%=basePath %>console/js/cities.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/jquery.autocomplete.js" ></script>
<script type="text/javascript" src="<%=basePath %>console/js/chengshiming.js" ></script>
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
	
	.product-1{background-color:#0099FF; width: 100%;height: 300px;}
	.product-1 .loaction{color:white; margin-top:-50px;}
	.product-1 .loaction input{background:none; border:none; color:white; width:30px;margin-top:60px;}
	.product-2{background-color:white; width: 100%;}
	.product-2 .product-2-1{width:100%; height:150px; background-color:#ECECEC
}
    .product-2 .product-2-2{width:100%; height:150px;  margin-top:20px  ;background-color:#ECECEC
}
    .product-2 .product-2-3{width:100%; height:150px;  margin-top:20px  ;background-color:#ECECEC
}
    .product-2 .product-2-4{width:100%; height:150px;  margin-top:50px  ;background-color:#ECECEC
}
    .product-2 .product-2-5{width:100%; height:150px;  margin-top:20px  ;background-color:#ECECEC
}
    .product-2 .product-2-6{width:100%; height:150px;  margin-top:20px  ;background-color:#ECECEC
}
	.product-2 p{height:25px; line-height:18px; color:#888888;}
	.product-2 .product-2-1 img{width:30px;}
	.product-1 p{color:white};
	.body p{color:white;};
	.product span{color:white};
    .product-2 .product-2-1 p{height:25px; line-height:25px; color:#A7B5C5;}
    .product-2 .product-2-1 img{width:30px;}
    
    .body img{width:25% ;height:30px;}
    .body p{color:white;}
    .pullute p{color:white;}
    .pullute span{color:white;}
    .date p{color:white;}
    .date span{color:white;}
    .data-1 img{width:30px;height:30px}
    .data-2 img{width:30px;height:30px}
    
    
   
</style>
</head>

<body>
<div class="lanrenzhijia">
 <!-- 查找城市名部分 -->
  <div class="product-wrap">
    <div class="find" style="width:100%;height:40px;background:gray;">
         <div class="search-citys">				
              <input class="text" id="city_name" type="text" value="请输入城市中文或拼音 / 点击选择城市" onKeyUp="input_keyup();" onClick="append_city();" onBlur="input_blur()" onFocus="if(value=='请输入城市中文或拼音 / 点击选择城市'){value='';style.color='#606060';}" />	
              <input class="text" id="hid_city_name" name="index_city" style="display:none">
              <input class="text" id="hid_real_city_name" name="real_index_city" style="display:none">
              
              <!--热门城市下拉-->
             <div class="pop search-citys-pop click" style="display:none;z-index:9999;margin-left:-1%;" id="cityarea">
                  <a href="javascript:void(0)" class="pop-close" ></a>
                  <div class="search-citys-tit click">热门城市(可直接输入中文名/拼音/三字码)</div>
                  <div class="search-citys-tt click">
                       <a class="current click" onClick="tabCutover(this,'s-citys1')" href="javascript:void(0)" style="margin-left:5px; width:10%;">热门<span></span></a>
                       <a class="click" onClick="tabCutover(this,'s-citys2')" href="javascript:void(0)" style="width:15%;margin-left:-2%;">ABCDEFG<span></span></a>
                       <a class="click" onClick="tabCutover(this,'s-citys3')" href="javascript:void(0)" style="width:10%;">HIJKL<span></span></a>
                       <a class="click" onClick="tabCutover(this,'s-citys4')" href="javascript:void(0)" style="width:18%;margin-left:-2%;">MNOPQRST<span></span></a>
                       <a class="click" onClick="tabCutover(this,'s-citys5')" href="javascript:void(0)" style="width:12%;">UVWXYZ<span></span></a>
                  </div>
                  <div class="search-citys-list click" id="citylist"></div>
            </div>
         </div>
    </div>       
    <!--案例1-->
    <div class="product show">
       <div class="product-1">
              <img src="<%=basePath %>console/images/bigRain.png" style="margin-top:10px; width:110px;" id="wp"/>
              <div class="loaction" style="margin-top:10px;margin-left:-45%">
                   <span style="margin-left:30%;width:10% ;" id="numb" >32℃</span><span>℃</span>
                   
                   <span style="width:165px;" class="loca">广州市</span>
            </div>
            
            <div class="weather" style="margin-top:10px;height:30px;">
                 <img src="<%=basePath %>console/images/humidity_Res.png" style="height:20px;margin-left:-83%;">
                 <p style="color:white; font-size:11px;height:27px ;width:30%;margin:-14px 4%;">相对湿度</p><p style="margin:-29px 27%;width:8%;"id="h">20</p>
                 <img src="<%=basePath %>console/images/wind_Res.png" style="height:17px;margin-top:13px;width:8% ;margin-left:-10%">
                 <p style="color:white;font-size:11px;width:18%;margin:-15px 45%;" id="k">东北风</p><p style="margin:-17px 59%;width:8% ;" id="w">2级</p>
                 <img src="<%=basePath %>console/images/leaf_Res.png" style="height:17px;margin-left:58%;margin-top:-1px;"> 
                 <p style="color:white; font-size:11px; margin-left:75%;margin-top:-15px;" id="d1">54良</p>    
            </div>
            <div class="date" style="font-size:11px; background-color:#009BFF; margin-top:10px;" >
            <div class="date-1" style="width:14%;margin-left:1%;line-height:35px;">
                 <p id="week1">今天</p>
                 <p id="c1">9/19</p>
                 <img id="p1" style="width:30px;height:30px;"/>
                 <p id="a">阴天</p>
                 <span id="f1">32</span><span >℃</span>
               
           </div>
           <div class="date-2" style="float:right;margin:-169px 71%;width:14% ;line-height:35px;"> 
                 <p id="week2">周二</p>
                 <p id="c2">9/20</p>
                 <img id="p2" style="width:30px;height:30px;"/>
                 <p id="b" style="width:100%">多云</p>
                 <span id="f2">32</span><span>℃</span>
               
           </div>
           <div class="date-3" style="float:right;margin:-169px 57%;width:14%;line-height:35px;">
                 <p id="week3">周三</p>
                 <p id="c3">9/21</p>
                 <img id="p3" style="width:30px;height:30px;"/>
                 <p id="c">多云</p>
                 <span id="f3">32</span><span>℃</span>
                
           </div>
           <div class="date-4" style="float:right;margin:-169px 43%;width:14%; line-height:35px;">
                 <p id="week4">周四</p>
                 <p id="c4">9/21</p>
                 <img id="p4" style="width:30px;height:30px;"/>
                 <p id="d">多云</p>
                 <span id="f4">32</span><span>℃</span>
           </div>
           <div class="date-5" style="float:right;margin:-169px 30%;width:14%;line-height:35px;">
                 <p id="week5">周五</p>
                 <p id="c5">9/21</p>
                 <img id="p5" style="width:30px;height:30px;"/>
                 <p id="e">多云</p>
                 <span id="f5">32</span><span>℃</span>
           </div>
           <div class="date-6" style="float:right;margin:-169px 16%;width:14%;line-height:35px;">
                 <p id="week6">周六</p>
                 <p id="c6">9/21</p>
                 <img id="p6" style="width:30px;height:30px;"/>
                 <p id="f">多云</p>
                 <span id="f6">32</span><span>℃</span>
           </div>
           <div class="date-7" style="float:right;margin:-169px 2%;width:14%; line-height:35px;">
                 <p id="week7">周日</p>
                 <p id="c7">9/21</p>
                 <img id="p7" style="width:30px;height:30px;"/>
                 <p id="g">多云</p>
                 <span id="f7">32</span><span>℃</span>
           </div>
                    
        </div>
         
       </div>
       
      
      
       <p style="float:left;height:20px; font-size:17px;margin-top:80px;margin-left:10px; color:#888888;">生活指数</p>
       
       <div class="product-2" style="margin-top:110px;">
            <div class="left" style="width:49%;margin:80px 0%">
             <div class="product-2-1"  >
                  <div class="pict" style="width:35%;">
                       <img src="<%=basePath %>console/images/uv_new.png" style="width:37px;height:37px;margin-top:24px;">
                       <p style="color:#0270E3;">紫外线指数</p>
                  </div>
                  <div class="write" style="float:right;margin:-60px 1%;width:55%;">
                       <p style="font-size:16px;margin:0 auto;" id="uv">中等</p>
                       <p style="margin-top:10px;text-align:left;" id="sj1">涂抹防晒SPF大于15,PA+防晒产品</p>
                  </div>
            </div>
           <div class="product-2-2" style="margin-top:10px;" >
                <div class="pict" style="width:35%;">
                       <img src="<%=basePath %>console/images/wash_new.png" style="width:40px;height:40px;margin-top:30px;">
                       <p style="color:#0270E3;">洗车指数</p>
                  </div>
                  <div class="write" style="float:right;margin:-70px 1%;width:55%; ">
                       <p style="font-size:16px;margin:0 auto;" id="wc">不宜</p>
                       <p style="margin-top:10px;text-align:left;" id="sj2">春雨，雨水和泥水会弄脏爱车您的</p>
                  </div>
            </div>
            <div class="product-2-3" style="margin-top:10px;" >
                 <div class="pict" style="width:35%;">
                       <img src="<%=basePath %>console/images/cold_new.png" style="width:40px;height:40px;margin-top:30px;">
                       <p style="color:#0270E3;">感冒指数</p>
                  </div>
                  <div class="write" style="float:right;margin:-65px 1%;width:55%;">
                       <p style="font-size:16px;margin:0 auto;" id="cd">少发</p>
                       <p style="margin-top:10px;text-align:left;" id="sj3">感冒机率较低，避免长期处于空调屋中。</p>
                  </div>
            </div>
          </div>
          <div class="right" style="width:48%; float:right;margin-top:-600px; margin-right:0%;">
              <div class="product-2-4" style="border:1px solid #ECECEC">
                   <div class="pict" style="width:35%;margin-top:-12px;">
                       <img src="<%=basePath %>console/images/sport_new.png" style="width:40px;height:40px;margin-top:35px;">
                       <p style="color:#0270E3;">运动指数</p>
                  </div>
                  <div class="write" style="float:right;margin:-64px 1%;width:55%;">
                       <p style="font-size:16px;margin:0 auto;" id="sp">较不宜</p>
                       <p style="margin-top:10px;text-align:left;" id="sj4">有降水，推荐您在室内进行休闲的运动</p>
                  </div>
              </div>
              <div class="product-2-5" style="margin-top:10px;" >
                   <div class="pict" style="width:35%;">
                       <img src="<%=basePath %>console/images/cloth_new.png" style="width:40px;height:40px;margin-top:30px;">
                       <p style="color:#0270E3;">穿衣指数</p>
                  </div>
                  <div class="write" style="float:right;margin:-70px 1%;width:55%;">
                       <p style="font-size:16px;margin:0 auto;" id="ct">舒适</p>
                       <p style="margin-top:10px;text-align:left;" id="sj5">建议穿长袖衬衫单裤等服装</p>
                  </div>
              </div>
              <div class="product-2-6" style="margin-top:10px;" >
                  <div class="pict" style="width:35%;">
                       <img src="<%=basePath %>console/images/3.png" style="width:40px;height:40px;margin-top:30px;">
                       <p style="color:#0270E3;">空气指数</p>
                  </div>
                  <div class="write" style="float:right;margin:-65px 1%;width:55%;">
                       <p style="font-size:16px;margin:0 auto;" id="ai">较差</p>
                       <p style="margin-top:10px;text-align:left;" id="sj6">涂抹防晒SPF大于15,PA+防晒产品</p>
                  </div>
              </div>
          </div>
      	</div>  
    </div>
    <!--案例2-->
   
            <p style="margin:-29px 54%;" id="pm"></p>      
                
<script>
	$(document).ready(function(){
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
			              $(".loca").text(addComp.city);
			              //alert('您的位置：'+addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber);
			              console.log(addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber);    
			        
			              ajaxfunc($(".loca").text());
			        }); 
		       		
			   }
		        
		        	                      
		        
		});
		
	
		
		
	});
	
	function ajaxfunc(city_Name){
		$.ajax({
			  url:"<%=basePath%>wechatController/findweather/areaCityName.action",
			  type:"POST",
			  data:{"cityname":city_Name},
			  dataType:"json",
			  async:true,
			  success:function(res){
				  
				 
				  var data = JSON.parse(res.strDate);
				  console.log(data);//打印输出data
				  
				  document.getElementById("h").innerHTML=data.showapi_res_body.now.sd;//获取空气湿度
				  document.getElementById("d1").innerHTML=data.showapi_res_body.now.aqi;//获取空气质量指数
				  document.getElementById("k").innerHTML=data.showapi_res_body.now.wind_direction;//获取风向
				  document.getElementById("w").innerHTML=data.showapi_res_body.now.wind_power;//获取风力
				  document.getElementById("numb").innerHTML=data.showapi_res_body.now.temperature; //今天此时的气温
				  document.getElementById("uv").innerHTML=data.showapi_res_body.f1.index.uv.title;//获取紫外线的强度
				  document.getElementById("sj1").innerHTML=data.showapi_res_body.f1.index.uv.desc; //获取紫外线的建议
				  document.getElementById("wc").innerHTML=data.showapi_res_body.f1.index.wash_car.title;//获取洗车指数
				  document.getElementById("sj2").innerHTML=data.showapi_res_body.f1.index.wash_car.desc;//获取洗车建议
				  document.getElementById("cd").innerHTML=data.showapi_res_body.f1.index.cold.title; //获取感冒指数
				  document.getElementById("sj3").innerHTML=data.showapi_res_body.f1.index.cold.desc; //获取感冒建议
				  document.getElementById("sp").innerHTML=data.showapi_res_body.f1.index.sports.title; //获取运动指数
				  document.getElementById("sj4").innerHTML=data.showapi_res_body.f1.index.sports.desc; //获取运动建议
				  document.getElementById("ct").innerHTML=data.showapi_res_body.f1.index.clothes.title; //获取穿衣指数
				  document.getElementById("sj5").innerHTML=data.showapi_res_body.f1.index.clothes.desc; //获取穿衣建议
				  document.getElementById("ai").innerHTML=data.showapi_res_body.f1.index.aqi.title;//获取空气指数
				  document.getElementById("sj6").innerHTML=data.showapi_res_body.f1.index.aqi.desc;//获取空气指数的建议
				  document.getElementById("pm").innerHTML=data.showapi_res_body.now.aqiDetail.pm2_5; //获取pm2.5的指数
				  document.getElementById("week2").innerHTML=data.showapi_res_body.f2.weekday;//获取f2的日期
				  document.getElementById("week3").innerHTML=data.showapi_res_body.f3.weekday;//获取f3的日期
				  document.getElementById("week4").innerHTML=data.showapi_res_body.f4.weekday;//获取f4的日期
				  document.getElementById("week5").innerHTML=data.showapi_res_body.f5.weekday;//获取f5的日期
				  document.getElementById("week6").innerHTML=data.showapi_res_body.f6.weekday;//获取f6 的日期
				  document.getElementById("week7").innerHTML=data.showapi_res_body.f7.weekday;//获取f7的日期
				  document.getElementById("f1").innerHTML=data.showapi_res_body.f1.day_air_temperature;//获取今天白天的气温
				  document.getElementById("f2").innerHTML=data.showapi_res_body.f2.day_air_temperature;//获取f2白天的气温
				  document.getElementById("f3").innerHTML=data.showapi_res_body.f3.day_air_temperature; //获取f3白天的气温
				  document.getElementById("f4").innerHTML=data.showapi_res_body.f4.day_air_temperature; //获取f4白天的气温
				  document.getElementById("f5").innerHTML=data.showapi_res_body.f5.day_air_temperature;//获取f5白天的气温
				  document.getElementById("f6").innerHTML=data.showapi_res_body.f6.day_air_temperature;//获取f6白天天气的气温
				  document.getElementById("f7").innerHTML=data.showapi_res_body.f7.day_air_temperature; //获取f7白天天气的气温
				  document.getElementById("a").innerHTML=data.showapi_res_body.f1.day_weather; //今天白天的气候
				  document.getElementById("b").innerHTML=data.showapi_res_body.f2.day_weather;//f2白天的气候
				  document.getElementById("c").innerHTML=data.showapi_res_body.f3.day_weather;//f3白天的气候
				  document.getElementById("d").innerHTML=data.showapi_res_body.f4.day_weather;//f4白天的气候
				  document.getElementById("e").innerHTML=data.showapi_res_body.f5.day_weather;//f5白天的气候
				  document.getElementById("f").innerHTML=data.showapi_res_body.f6.day_weather;//f6白天的气候
				  document.getElementById("g").innerHTML=data.showapi_res_body.f7.day_weather;//f7白天的气候
				  document.getElementById("c1").innerHTML=splitTime(data.showapi_res_body.f1.day); //获取今天的日期
				  document.getElementById("c2").innerHTML=splitTime(data.showapi_res_body.f2.day); //获取f2的日期
				  document.getElementById("c3").innerHTML=splitTime(data.showapi_res_body.f3.day); //获取f3的日期
				  document.getElementById("c4").innerHTML=splitTime(data.showapi_res_body.f4.day); //获取f4的日期
				  document.getElementById("c5").innerHTML=splitTime(data.showapi_res_body.f5.day); //获取f5的日期
				  document.getElementById("c6").innerHTML=splitTime(data.showapi_res_body.f6.day); //获取f3的日期
				  document.getElementById("c7").innerHTML=splitTime(data.showapi_res_body.f7.day); //获取f7的日期
				 
				  
					var url1=data.showapi_res_body.f1.day_weather_pic
					var url2=data.showapi_res_body.f2.day_weather_pic
					var url3=data.showapi_res_body.f3.day_weather_pic
					var url4=data.showapi_res_body.f4.day_weather_pic
					var url5=data.showapi_res_body.f5.day_weather_pic
					var url6=data.showapi_res_body.f6.day_weather_pic
					var url7=data.showapi_res_body.f7.day_weather_pic
					$("#wp").attr("src",url1);
					$("#p1").attr("src",url1);
					$("#p2").attr("src",url2);
					$("#p3").attr("src",url3);
					$("#p4").attr("src",url4);
					$("#p5").attr("src",url5);
					$("#p5").attr("src",url5);
					$("#p6").attr("src",url6);
					$("#p7").attr("src",url7);
					
				
				    var week=data.showapi_res_body.f2.weekday;
					  switch(week){
					  case 1:
						  document.getElementById("week2").innerHTML="周一";
						  document.getElementById("week3").innerHTML="周二";
						  document.getElementById("week4").innerHTML="周三";
						  document.getElementById("week5").innerHTML="周四";
						  document.getElementById("week6").innerHTML="周五";
						  document.getElementById("week7").innerHTML="周六";
						  break;
					  case 2:
						  document.getElementById("week2").innerHTML="周二";
						  document.getElementById("week3").innerHTML="周三";
						  document.getElementById("week4").innerHTML="周四";
						  document.getElementById("week5").innerHTML="周五";
						  document.getElementById("week6").innerHTML="周六";
						  document.getElementById("week7").innerHTML="周日";
						  break;
					  case 3:
						  document.getElementById("week2").innerHTML="周三";
						  document.getElementById("week3").innerHTML="周四";
						  document.getElementById("week4").innerHTML="周五";
						  document.getElementById("week5").innerHTML="周六";
						  document.getElementById("week6").innerHTML="周日";
						  document.getElementById("week7").innerHTML="周一";
						  break;
					  case 4:
						  document.getElementById("week2").innerHTML="周四";
						  document.getElementById("week3").innerHTML="周五";
						  document.getElementById("week4").innerHTML="周六";
						  document.getElementById("week5").innerHTML="周日";
						  document.getElementById("week6").innerHTML="周一";
						  document.getElementById("week7").innerHTML="周二";
						  break;
					  case 5:
						  document.getElementById("week2").innerHTML="周五";
						  document.getElementById("week3").innerHTML="周六";
						  document.getElementById("week4").innerHTML="周日";
						  document.getElementById("week5").innerHTML="周一";
						  document.getElementById("week6").innerHTML="周二";
						  document.getElementById("week7").innerHTML="周三";
						  break;
					  case 6:
						  document.getElementById("week2").innerHTML="周六";
						  document.getElementById("week3").innerHTML="周日";
						  document.getElementById("week4").innerHTML="周天";
						  document.getElementById("week5").innerHTML="周一";
						  document.getElementById("week6").innerHTML="周二";
						  document.getElementById("week7").innerHTML="周三";
						  break;
					  case 7:
						  document.getElementById("week2").innerHTML="周日";
						  document.getElementById("week3").innerHTML="周一";
						  document.getElementById("week4").innerHTML="周二";
						  document.getElementById("week5").innerHTML="周三";
						  document.getElementById("week6").innerHTML="周四";
						  document.getElementById("week7").innerHTML="周五";
						  break;
					  
					  }
				
				 
				 
					    var ai=data.showapi_res_body.now.aqi;
					   
						  if(ai<51){
						  
							  document.getElementById("d1").innerHTML=ai+"优";
						  }
						  else if((ai>51)&&(ai<101)){
							  document.getElementById("d1").innerHTML=ai+"良";
						  }
						  else if((ai>102)&&(ai<151)){
							  document.getElementById("d1").innerHTML=ai+"中";
						  }
						  else if((ai>152)&&(ai<201)){
							  document.getElementById("d1").innerHTML=ai+"差";
						  }
						  else if((ai>202)&&(ai<300)){
							  document.getElementById("d1").innerHTML=ai+"极差";
						  }
						  else{
							  document.getElementById("d1").innerHTML=ai+"爆表";
						  }
					  
				       
				      $(".loca").text(city_Name);
				   

				
				  
				  
				  
			  },
			  error:function(){
				  alert("更新失败，请稍后再试!");
			  },		 
		  });
	}
	
	function splitTime(strTime){
		var mm=strTime.substring(4,6);
		var dd=strTime.substring(6,9);
		return mm+"/"+dd;
	}
	
	
	
	
	
	

var name=$("#city_name").attr("value");
$(".loca").text(name);

	
	
	
</script>


</body>
</html>
