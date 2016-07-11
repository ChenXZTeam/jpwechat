<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
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
<link rel="stylesheet" type="text/css" href="<%=basePath %>console/css/lanrenzhijia.css"  />
<script type="text/javascript" src="<%=basePath %>console/js/jquery-1.8.3.min.js" ></script>
<script type="text/javascript" src="<%=basePath %>console/js/lanrenzhijia.js"></script>
<script type="text/javascript" src="<%=basePath %>console/js/kinetic-v5.0.1.min.js" ></script>
<style type="text/css">
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
	
	
	.canvasDiv{margin-left:10px;}
	.canvasBox{width:100%; height:150px;}
	
	.todayDre{line-height:30px; color:#999999; font-family:Microsoft YaHei; text-align:left; width:95%; margin-left:auto; margin-right:auto; margin-top:5px; border-bottom:#D4D4D2 solid 1px;}
	
</style>

<script>

//执行浪潮的曲线
$(function(){	
	draw24('box1',1.5);
	draw24('box2',0.3);
	draw24('box3',1.5);
	draw24('box4',0.3);
	draw24('box5',1.5);
	draw24('box6',0.3);
	draw24('box7',1.5);
});

//绘制浪潮曲线的方法
function draw24(id,height) {

			/*
			 该传的值有：第一区域的浪高 时间段（第一区域决定后面的曲线变化）（如果第一区域浪为“高”，则第二区域浪就为“低”，规律只能是高、低、高、低 或者 低、高、低、高）
			 			 第二区域的浪高 时间段
						 第三区域的浪高 时间段
						 第四区域的浪高 时间段
			*/

             var canvas = document.getElementById(id);
             if (canvas == null) {
                 return false;
             }
             var context = canvas.getContext("2d");
			 var height; 			 
			 var x=5;
			 var y=60;	
			 
			 if(height>1.2){
			    var y2=y-40;
			 	var y4=y+40;
				var y6=y-40;
			 	var y8=y+40;
			 }else if(height<1.2){
			 	var y2=y+40;
			 	var y4=y-40;
				var y6=y+40;
			 	var y8=y-40;
			 }
			 
			 //下面是不变的坐标
			 var x1=x;		 
			 var x3=x+100;			 
			 var x5=x+200;			 
			 var x7=x+300;			 
			 var x9=x+400;
			 
			 //潮浪曲线
			 context.beginPath(); //分成几部分的函数
			 context.strokeStyle = 'rgba(135,179,208,1)'; 
             context.bezierCurveTo(x1, y, (x1+x3)/2, y2, x3, y);
			 context.bezierCurveTo(x3, y, (x3+x5)/2, y4, x5, y);
			 context.bezierCurveTo(x5, y, (x5+x7)/2, y6, x7, y);
			 context.bezierCurveTo(x7, y, (x7+x9)/2, y8, x9, y);			
             context.stroke();
			 
			 //潮浪提示
			 context.font = "12px Calibri";
			 context.fillStyle = "#666666";
			 if(height>1.2){
			 	//第一部分信息
				context.fillText("潮高", 45, 30);
				context.fillText("08:13", 45, 65);
				context.fillText("2.57m", 45, 80);
				
				//第二部分信息
			 	context.fillText("潮低", 145, 65);
				context.fillText("16:06", 145, 95);
				context.fillText("0.41m", 145, 110);
				
				//第三部分信息
				context.fillText("潮高",245,30);
				context.fillText("22:14", 245, 65);
				context.fillText("1.70m", 245, 80);
				
				//第四部分信息
			 	context.fillText("潮低",345,65);	
				context.fillText("02:21", 345, 95);
				context.fillText("1.23m", 345, 110);		 	
			 }else if(height<1.2){
			 	//第一部分信息 应有潮高时间和潮高数据
			 	context.fillText("潮低", 45, 65);
				context.fillText("02:21", 42, 95);
				context.fillText("1.23m", 40, 110);
				
				//第二部分信息
			 	context.fillText("潮高", 145, 30);
				context.fillText("08:13", 142, 65);
				context.fillText("2.57m", 140, 80);
				
				//第三部分信息
				context.fillText("潮低",245,65);
				context.fillText("16:06", 242, 95);
				context.fillText("0.41m", 240, 110);
				
				//第四部分信息
			 	context.fillText("潮高",345,30);	
				context.fillText("22:14", 342, 65);
				context.fillText("1.70m", 340, 80);
			 }			 
			 
			 
			 //第一条竖线
			 context.beginPath();
			 context.strokeStyle = "rgb(204,204,204)";
			 context.moveTo(105,10);
			 context.lineTo(105,140);
			 
			 //第二条竖线
			 context.moveTo(205,10);
			 context.lineTo(205,140);
			 
			 //第三条竖线
			 context.moveTo(305,10);
			 context.lineTo(305,140);
			 context.stroke();
			 			 
         }

</script>
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
    <div class="product">
        <div class="Temperature">
			<div class="wendu">
				<div class="tianqiClass">
					<img src="<%=basePath %>console/images/fengImg.png"/><span>46</span><span class="shangbiao">。</span><span>/</span><span>19</span><span class="shangbiao">。</span>
				</div>
			</div>
			<div style="clear:both;"></div>
			<div class="pingpan"><span>阴雨</span><span class="you">良</span></div>
		</div>
		<div style="clear:both;"></div>
		<div class="chaoxiTitle"><span>详情</span></div>
		<div class="winAndSun">
			<div class="win">
				<div class="img"><img src="<%=basePath %>console/images/winImg.png"/></div>
				<div class="text"><span style="color:#B6B6B6;">7级</span><span>大风</span></div>
			</div>
			<div class="sun">
				<div class="img"><img src="<%=basePath %>console/images/sunImg.png"/></div>
				<div class="text"><span>日出 06:54</span><span>日落 20:06</span></div>
			</div>
		</div>
		<div style="clear:both;"></div>
		<div class="chaoxiTitle"><span>潮汐</span></div>
		<div class="canvasDiv">
			<canvas id="box1" class="canvasBox" width="410px"></canvas>
		</div>
		<div class="chaoxiTitle" style="border:none; text-align:right;"><a>查看各港口详情></a></div>
		<div class="todayDre">今天穿什么？</div>
    </div>
    <!--案例2-->
    <div class="product">
		<div class="Temperature">
			<div class="wendu">
				<div class="tianqiClass">
					<img src="<%=basePath %>console/images/fengImg.png"/><span>45</span><span class="shangbiao">。</span><span>/</span><span>10</span><span class="shangbiao">。</span>
				</div>
			</div>
			<div style="clear:both;"></div>
			<div class="pingpan"><span>暴风预警</span><span class="you">良</span></div>
		</div>
		<div style="clear:both;"></div>
		<div class="chaoxiTitle"><span>详情</span></div>
		<div class="winAndSun">
			<div class="win">
				<div class="img"><img src="<%=basePath %>console/images/winImg.png"/></div>
				<div class="text"><span style="color:#B6B6B6;">12级</span><span>暴风</span></div>
			</div>
			<div class="sun">
				<div class="img"><img src="<%=basePath %>console/images/sunImg.png"/></div>
				<div class="text"><span>日出 07:54</span><span>日落 19:06</span></div>
			</div>
		</div>
		<div style="clear:both;"></div>
		<div class="chaoxiTitle"><span>潮汐</span></div>
		<div class="canvasDiv">
			<canvas id="box2" class="canvasBox" width="410px"></canvas>
		</div>
		<div class="chaoxiTitle" style="border:none; text-align:right;"><a>查看各港口详情></a></div>
		<div class="todayDre">今天穿什么？</div>
    </div>
    <!--案例3-->
    <div class="product">
        <div class="Temperature">
			<div class="wendu">
				<div class="tianqiClass">
					<img src="<%=basePath %>console/images/fengImg.png"/><span>-32</span><span class="shangbiao">。</span><span>/</span><span>-26</span><span class="shangbiao">。</span>
				</div>
			</div>
			<div style="clear:both;"></div>
			<div class="pingpan"><span>多云</span><span class="you">优</span></div>
		</div>
		<div style="clear:both;"></div>
		<div class="chaoxiTitle"><span>详情</span></div>
		<div class="winAndSun">
			<div class="win">
				<div class="img"><img src="<%=basePath %>console/images/winImg.png"/></div>
				<div class="text"><span style="color:#B6B6B6;">3级</span><span>微风</span></div>
			</div>
			<div class="sun">
				<div class="img"><img src="<%=basePath %>console/images/sunImg.png"/></div>
				<div class="text"><span>日出 05:54</span><span>日落 19:06</span></div>
			</div>
		</div>
		<div style="clear:both;"></div>
		<div class="chaoxiTitle"><span>潮汐</span></div>
		<div class="canvasDiv">
			<canvas id="box3" class="canvasBox" width="410px"></canvas>
		</div>
		<div class="chaoxiTitle" style="border:none; text-align:right;"><a>查看各港口详情></a></div>
		<div class="todayDre">今天穿什么？</div>
    </div>
    <!--案例4-->
    <div class="product">
        <div class="Temperature">
			<div class="wendu">
				<div class="tianqiClass">
					<img src="<%=basePath %>console/images/fengImg.png"/><span>45</span><span class="shangbiao">。</span><span>/</span><span>30</span><span class="shangbiao">。</span>
				</div>
			</div>
			<div style="clear:both;"></div>
			<div class="pingpan"><span>雷雨</span><span class="you">差</span></div>
		</div>
		<div style="clear:both;"></div>
		<div class="chaoxiTitle"><span>详情</span></div>
		<div class="winAndSun">
			<div class="win">
				<div class="img"><img src="<%=basePath %>console/images/winImg.png"/></div>
				<div class="text"><span style="color:#B6B6B6;">5级</span><span>中风</span></div>
			</div>
			<div class="sun">
				<div class="img"><img src="<%=basePath %>console/images/sunImg.png"/></div>
				<div class="text"><span>日出 09:10</span><span>日落 19:06</span></div>
			</div>
		</div>
		<div style="clear:both;"></div>
		<div class="chaoxiTitle"><span>潮汐</span></div>
		<div class="canvasDiv">
			<canvas id="box4" class="canvasBox" width="410px"></canvas>
		</div>
		<div class="chaoxiTitle" style="border:none; text-align:right;"><a>查看各港口详情></a></div>
		<div class="todayDre">今天穿什么？</div>
    </div>
    <!--案例5-->
    <div class="product">
        <div class="Temperature">
			<div class="wendu">
				<div class="tianqiClass">
					<img src="<%=basePath %>console/images/fengImg.png"/><span>25</span><span class="shangbiao">。</span><span>/</span><span>10</span><span class="shangbiao">。</span>
				</div>
			</div>
			<div style="clear:both;"></div>
			<div class="pingpan"><span>雷雨</span><span class="you">良</span></div>
		</div>
		<div style="clear:both;"></div>
		<div class="chaoxiTitle"><span>详情</span></div>
		<div class="winAndSun">
			<div class="win">
				<div class="img"><img src="<%=basePath %>console/images/winImg.png"/></div>
				<div class="text"><span style="color:#B6B6B6;">4级</span><span>微风</span></div>
			</div>
			<div class="sun">
				<div class="img"><img src="<%=basePath %>console/images/sunImg.png"/></div>
				<div class="text"><span>日出 10:54</span><span>日落 05:06</span></div>
			</div>
		</div>
		<div style="clear:both;"></div>
		<div class="chaoxiTitle"><span>潮汐</span></div>
		<div class="canvasDiv">
			<canvas id="box5" class="canvasBox" width="410px"></canvas>
		</div>
		<div class="chaoxiTitle" style="border:none; text-align:right;"><a>查看各港口详情></a></div>
		<div class="todayDre">今天穿什么？</div>
    </div>
	
	<!--案例6-->
    <div class="product">
		<div class="Temperature">
			<div class="wendu">
				<div class="tianqiClass">
					<img src="<%=basePath %>console/images/fengImg.png"/><span>25</span><span class="shangbiao">。</span><span>/</span><span>7</span><span class="shangbiao">。</span>
				</div>
			</div>
			<div style="clear:both;"></div>
			<div class="pingpan"><span>阴雨</span><span class="you">优</span></div>
		</div>
		<div style="clear:both;"></div>
		<div class="chaoxiTitle"><span>详情</span></div>
		<div class="winAndSun">
			<div class="win">
				<div class="img"><img src="<%=basePath %>console/images/winImg.png"/></div>
				<div class="text"><span style="color:#B6B6B6;">2级</span><span>微风</span></div>
			</div>
			<div class="sun">
				<div class="img"><img src="<%=basePath %>console/images/sunImg.png"/></div>
				<div class="text"><span>日出 03:54</span><span>日落 10:06</span></div>
			</div>
		</div>
		<div style="clear:both;"></div>
		<div class="chaoxiTitle"><span>潮汐</span></div>
		<div class="canvasDiv">
			<canvas id="box6" class="canvasBox" width="410px"></canvas>
		</div>
		<div class="chaoxiTitle" style="border:none; text-align:right;"><a>查看各港口详情></a></div>
		<div class="todayDre">今天穿什么？</div>
    </div>
	
	 <!--案例7-->
    <div class="product">
      	<div class="Temperature">
			<div class="wendu">
				<div class="tianqiClass">
					<img src="<%=basePath %>console/images/fengImg.png"/><span>50</span><span class="shangbiao">。</span><span>/</span><span>45</span><span class="shangbiao">。</span>
				</div>
			</div>
			<div style="clear:both;"></div>
			<div class="pingpan"><span>晴</span><span class="you">良</span></div>
		</div>
		<div style="clear:both;"></div>
		<div class="chaoxiTitle"><span>详情</span></div>
		<div class="winAndSun">
			<div class="win">
				<div class="img"><img src="<%=basePath %>console/images/winImg.png"/></div>
				<div class="text"><span style="color:#B6B6B6;">5级</span><span>中风</span></div>
			</div>
			<div class="sun">
				<div class="img"><img src="<%=basePath %>console/images/sunImg.png"/></div>
				<div class="text"><span>日出 04:54</span><span>日落 20:06</span></div>
			</div>
		</div>
		<div style="clear:both;"></div>
		<div class="chaoxiTitle"><span>潮汐</span></div>
		<div class="canvasDiv">
			<canvas id="box7" class="canvasBox" width="410px"></canvas>
		</div>
		<div class="chaoxiTitle" style="border:none; text-align:right;"><a>查看各港口详情></a></div>
		<div class="todayDre">今天穿什么？</div>
    </div>
	
  </div>
</div>

</body>
</html>
