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
<title>汇率查询</title>
<script type="text/javascript"  src="<%=basePath %>console/js/jquery-1.8.3.min.js"></script>
<style>
	html{height:100%;}
	body{height:95%; background-color:#e1e1e1; padding:0px; margin:0px;}
	#iptbtnBox{background-color:#fff; padding:15px 10px;}
	#iptbtnBox #inptMoneyClassBox{height:30px;}
	#iptbtnBox .titleBoxClass{border:1px solid #e1e1e1; height:30px; padding:0px 10px; border-radius:5px 0px 0px 5px; float:left; font-size:13px; font-family:"微软雅黑"; color:#999999;}
	#iptbtnBox .titleBoxClass span{display:block; line-height:30px;}
	#iptbtnBox .inptBoxClass{float:left; border:1px solid #e1e1e1; height:30px; border-left:none;}
	#iptbtnBox .inptBoxClass input{display:block; height:30px; border:none; background:none; width:90%; color:#666666; outline:none; padding-left:10px;}
	#iptbtnBox #choMoneyClass{overflow:hidden; margin-top:10px;}
	#iptbtnBox #choMoneyClass #choBiTypeBox{float:left;}
	#iptbtnBox #choMoneyClass #changeBtn{float:left; padding-top:10px;}
	#iptbtnBox #choMoneyClass #changeBtn img{width:28px;}
	#iptbtnBox #changeBoxBtn{ margin-top:10px; width:98%;}
	#resultBigBox{background-color:#FFFFFF; height:55%; margin-top:10px;}
	#resultBigBox .resultBox{font-size:18px; padding:20px 0px 0px 10px; color:#388BFF; font-family:"微软雅黑";}
	#resultBigBox .resultBoxValue{color:#666; font-size:15px; padding:0px 10px 10px 10px; text-align:center;}
	#resultBigBox .resultBoxValue table{font-size:13px;}
	#resultBigBox .resultBoxValue table tr{height:25px;}
	#resultBigBox .resultBoxValue table tr td{}
	#bizhongBox{display:none; font-size:13px; color:#666; position:absolute; top:0px; left:0px; padding:0px; width:99%; background-color:#fff;}
	#bizhongBox ul{list-style-type:none; padding:0px; margin:0px;}
	#bizhongBox ul li{padding:10px 10px 10px 25px; border-bottom:1px solid #e1e1e1;}
	#bizhongBox ul li:last-child{border:none;}
	#bizhongBox ul .titleMoney{padding-left:10px; font-weight:bold; background-color:#eee;}
	#changeBoxBtn button{ width:95%; padding:15px; background-color:#007AFF; color:#FFFFFF; font-size: 17px; border:none; display:block; border-radius:5px; outline:none; margin-left:auto; margin-right:auto; margin-top:40px;}
</style>
</head>

<body>
	<div style="overflow:hidden; padding:18px 15px; background-color:#fff; font-family:'微软雅黑';">
		<div style="border-bottom:1px solid #e1e1e1; overflow:hidden; padding:10px;">
			<span style="float:left;display:block; color:#666; font-size:17px;">待转化币种</span>
			<span class="chooseMoney" style="float:right;display:block;"><img src="<%=basePath %>console/images/pojiantou.png" style="width:24px;"/></span>
			<span id="fromChangebz" class="moneySign" style="float:right;display:block; color:#007AFF; font-size:15px;">COP</span>
			<span style="clear:both;"></span>
		</div>
		<div>
			<input id="changeMoney" type="text" style="width:94%; height:35px; font-size:15px; outline:none; color:#666; padding-left:10px; border:none;"/>
		</div>
	</div>
	<div style="overflow:hidden; padding:18px 15px; background-color:#fff; margin-top:10px; font-family:'微软雅黑';">
		<div style="border-bottom:1px solid #e1e1e1; overflow:hidden; padding:10px;">
			<span style="float:left;display:block; color:#666; font-size:17px;">转化后币种</span>
			<span class="chooseMoney" style="float:right;display:block;"><img src="<%=basePath %>console/images/pojiantou.png" style="width:24px;"/></span>
			<span id="toChangebz" class="moneySign" style="float:right;display:block; color:#007AFF; font-size:15px;">COP</span>
			<span style="clear:both;"></span>
		</div>
		<div>
			<input type="text" id="resultId" style="width:94%; height:35px; outline:none; font-size:15px; color:#666; padding-left:10px; border:none;" readonly/>
		</div>
	</div>
	<div id="huilvResult" style="display:none; color:#666; font-size:15px; font-family:'微软雅黑'; padding-left:20px; margin-top:10px;">
		<span>汇率：</span>
		<span id="nowHuilv"></span>
	</div>
	<div id="changeBoxBtn"><button id="btnChange">开始转换</button></div>
	<div id="bizhongBox">
		<ul>
			<li class="titleMoney">热门货币</li>
			<li onclick="liClick(this)">人民币CNY</li>
			<li onclick="liClick(this)">美元USD</li>
			<li onclick="liClick(this)">日元JPY</li>
			<li onclick="liClick(this)">欧元EUR</li>
			<li onclick="liClick(this)">英镑GBP</li>
			<li onclick="liClick(this)">韩元KRW</li>
			<li onclick="liClick(this)">港元HKD</li>
			<li onclick="liClick(this)">澳元AUD</li>
			<li onclick="liClick(this)">加元CAD</li>
			<li class="titleMoney">A</li>
			<li onclick="liClick(this)">阿联酋迪拉姆AED</li>
			<li onclick="liClick(this)">澳元AUD</li>
			<li onclick="liClick(this)">澳门元MOP</li>
			<li onclick="liClick(this)">阿尔及利亚第纳尔DZD</li>
			<li onclick="liClick(this)">阿曼里亚尔OMR</li>
			<li onclick="liClick(this)">埃及镑EGP</li>
			<li class="titleMoney">B</li>
			<li onclick="liClick(this)">白俄罗斯卢布BYR</li>
			<li onclick="liClick(this)">巴西雷亚尔BRL</li>
			<li onclick="liClick(this)">波兰兹罗提PLN</li>
			<li onclick="liClick(this)">巴林第纳尔BHD</li>
			<li onclick="liClick(this)">保加利亚列弗BGN</li>
			<li onclick="liClick(this)">冰岛克朗ISK</li>
			<li class="titleMoney">D</li>
			<li onclick="liClick(this)">丹麦克朗DKK</li>
			<li class="titleMoney">E</li>
			<li onclick="liClick(this)">俄罗斯卢布RUB</li>
			<li class="titleMoney">F</li>
			<li onclick="liClick(this)">菲律宾比索PHP</li>
			<li class="titleMoney">G</li>
			<li onclick="liClick(this)">港元HKD</li>
			<li onclick="liClick(this)">哥伦比亚比索COP</li>
			<li onclick="liClick(this)">哥斯达黎加科朗CRC</li>
			<li class="titleMoney">H</li>
			<li onclick="liClick(this)">韩元KRW</li>
			<li class="titleMoney">J</li>
			<li onclick="liClick(this)">加元CAD</li>
			<li onclick="liClick(this)">捷克克朗CZK</li>
			<li onclick="liClick(this)">柬埔寨瑞尔KHR</li>
			<li class="titleMoney">K</li>
			<li onclick="liClick(this)">克罗地亚库纳HRK</li>
			<li onclick="liClick(this)">卡塔尔里亚尔QAR</li>
			<li onclick="liClick(this)">科威特第纳尔KWD</li>
			<li onclick="liClick(this)">肯尼亚先令KES</li>
			<li class="titleMoney">L</li>
			<li onclick="liClick(this)">老挝基普LAK</li>
			<li onclick="liClick(this)">罗马尼亚列伊RON</li>
			<li onclick="liClick(this)">黎巴嫩镑LBP</li>
			<li onclick="liClick(this)">离岸人民币CNH</li>
			<li class="titleMoney">M</li>
			<li onclick="liClick(this)">美元USD</li>
			<li onclick="liClick(this)">缅甸元BUK</li>
			<li onclick="liClick(this)">马来西亚林吉特MYR</li>
			<li onclick="liClick(this)">摩洛哥道拉姆MAD</li>
			<li onclick="liClick(this)">墨西哥元MXN</li>
			<li class="titleMoney">N</li>
			<li onclick="liClick(this)">挪威克朗NOK</li>
			<li onclick="liClick(this)">南非兰特ZAR</li>
			<li class="titleMoney">O</li>
			<li onclick="liClick(this)">欧元EUR</li>
			<li class="titleMoney">R</li>
			<li onclick="liClick(this)">人民币CNY</li>
			<li onclick="liClick(this)">瑞士法郎CHF</li>
			<li onclick="liClick(this)">日元JPY</li>
			<li onclick="liClick(this)">瑞典克朗SEK</li>
			<li class="titleMoney">S</li>
			<li onclick="liClick(this)">沙特里亚尔SAR</li>
			<li onclick="liClick(this)">斯里兰卡卢比LKR</li>
			<li onclick="liClick(this)">塞尔维亚第纳尔RSD</li>
			<li class="titleMoney">T</li>
			<li onclick="liClick(this)">泰铢THB</li>
			<li onclick="liClick(this)">坦桑尼亚先令TZS</li>
			<li class="titleMoney">W</li>
			<li onclick="liClick(this)">文莱元BND</li>
			<li onclick="liClick(this)">乌干达先令UGX</li>
			<li class="titleMoney">X</li>
			<li onclick="liClick(this)">新的赞比亚克瓦查ZMK</li>
			<li onclick="liClick(this)">叙利亚镑SYP</li>
			<li onclick="liClick(this)">新西兰元NZD</li>
			<li onclick="liClick(this)">新土耳其里拉TRY</li>
			<li onclick="liClick(this)">新加坡元SGD</li>
			<li onclick="liClick(this)">新台币TWD</li>
			<li onclick="liClick(this)">匈牙利福林HUF</li>
			<li class="titleMoney">Y</li>
			<li onclick="liClick(this)">英镑GBP</li>
			<li onclick="liClick(this)">约旦第纳尔JOD</li>
			<li onclick="liClick(this)">伊拉克第纳尔IQD</li>
			<li onclick="liClick(this)">越南盾VND</li>
			<li onclick="liClick(this)">以色列新锡克尔ILS</li>
			<li onclick="liClick(this)">印度卢比INR</li>
			<li onclick="liClick(this)">印尼卢比IDR</li>
			<li class="titleMoney">Z</li>
			<li onclick="liClick(this)">智利比索CLP</li>
		</ul>
	</div>
	<div id="jiazaiBox" style="display:none; height:100%; position:absolute; width:100%; background-color:rgba(0,0,0,0.5); z-index:2; top:0px; left:0px; text-align:center;"><span style="display:block; color:#fff; margin-top:50%;">换算中...</span></div>
<script>
	$(function(){

			$("#btnChange").click(function(){
				var money=$("#changeMoney").val();
				var fromCode=$("#fromChangebz").text().trim();
				var toCode=$("#toChangebz").text().trim();
				$.ajax({ 
					url:"<%=basePath%>framework/exchangeRate/queryExchangeRate.action",
					type:"POST",
					data:{"fromCurrency":fromCode,"toCurrency":toCode,"amount":money},
					dataType:"json",
					beforeSend:function(){$("#jiazaiBox").css("display","block");},
					complete:function(){$("#jiazaiBox").css("display","none");},
					success:function(resut){
						var dateList=JSON.parse(resut.date);
						console.log(dateList);
						var retaDa = dateList.showapi_res_body.money;
						var sum=0;
						sum=retaDa/money;
						$("#nowHuilv").text(sum);
						$("#resultId").val(dateList.showapi_res_body.money);
						$("#huilvResult").css("display","block");
					},error:function(){
						alert("请求失败");
					}
				});
			});
			
			$("#changeBtn").click(function(){
				var foo=$("#fromChangebz").val(); bar=$("#toChangebz").val();
				bar = [foo,foo=bar][0];
				$("#fromChangebz").val(foo);
				$("#toChangebz").val(bar);
			});
	});
	
	function liClick(inc){
		var text = $(inc).text();
		$(".bizhType").text(text.substring(text.length-3,text.length));
		$("#bizhongBox").css("display","none");
	}
	
	$(".chooseMoney").click(function(){
		$(".moneySign").removeClass("bizhType");
		$(this).next().addClass("bizhType");
		$("#bizhongBox").css("display","block");
	});
</script>
</body>
</html>
