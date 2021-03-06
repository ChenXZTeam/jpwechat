<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>机票预定</title>
	<link rel="stylesheet" type="text/css"href="<%=basePath%>scripts/common/jquery-easyui/themes/default/easyui.css"/>
	<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css"/>
	<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/default/datagrid.css"/>
	<link type="text/css" rel="stylesheet" href="<%=basePath %>console/css/BeatPicker.min.css"/>
	<script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript"src="<%=basePath%>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
	<script src="<%=basePath %>console/js/BeatPicker.min.js"></script>
	<script src="<%=basePath %>console/js/airCodeVScity.js"></script>
<style>
	#radioClassBox{}
	#radioClassBox span{ display:block;}
	#conditionId{ font-size:13px; overflow:hidden;}
	#conditionId .inputstyle{padding-left:5px; width:137px; height:20px; border-radius:5px; border:#77C0F1 solid 1px;}
	.planeTitle{ background:#f0f0f0; color:#666666; margin-top:15px; padding-left:2px;}
	.planeTitle .planeTitleCh{ float:left; width:150px; text-align:center; height:30px; margin-left:15px; line-height:30px;}
	#ulBox{list-style-type:none; padding:0px; font-family:'微软雅黑'; margin:0px; color:#666666;}
	#ulBox li{border:1px solid #E1E1E1; border-bottom:none; font-size:14px; width:99.7777%; margin-left:auto; margin-right:auto; padding:10px 0px 2px 0px;}
	#ulBox li:last-child{ border-bottom:1px solid #e1e1e1;}
	#ulBox li .otherCang{margin-top:15px;}
	#ulBox li .otherCang .childBoxClass{border-top:#e1e1e1 solid 1px; overflow:hidden;}
	#ulBox li .otherCang .kongBox{width:500px; height:46px;}
	#ulBox li .otherCang .otherCangweiClass{width:200px; height:46px; text-align:left; line-height:46px;}
	#ulBox li .otherCang .otherCangweiClass span{ color:#666666; font-family:'微软雅黑';}
	#ulBox li .otherCang .otherCangweiClass .cangweiNum{ color:#FF0000; font-size:14px;}
	#ulBox li .otherCang .jiagePay{width:179px; height:39px; padding-top:7px; text-align:right; font-family:'微软雅黑';}
	#ulBox li .otherCang .jiagePay .payMoneyBox{ font-size:25px; color:#FF9900; font-weight:bold;}
	#ulBox li .otherCang .yudingBtn{width:250px; text-align:center;}
	#ulBox li .otherCang .yudingBtn>button{ padding:8px 20px; margin-top:7px; margin-bottom:7px; cursor:pointer; background-color:#0099CC; color:#FFFFFF; border:none; border-radius:5px;}
	#ulBox li .otherCang .kongBox,.otherCang .otherCangweiClass,.otherCang .jiagePay,.otherCang .yudingBtn{ float:left;}
	#ulBox li .infoContent{ float:left; margin-left:15px; width:150px; text-align:center; height:50px;}
	#ulBox li .planeName{ width:200px;}
	#ulBox li .infoContent .airPlane{font-size:16px; height:30px; line-height:37px;}
	#ulBox li .infoContent .timeClass{font-size:20px; font-weight:bold;}
	#ulBox li .infoContent .planeNameText{}
	#ulBox li .infoContent .btnclass{ padding:8px 13px; margin-top:7px; cursor:pointer; background-color:#0099CC; outline:none; color:#FFFFFF; border:none; border-radius:5px;}
	#ulBox li .infoContent .btnclass:hover{background-color:#0080ab;}
	#ulBox li .otherCang{overflot:hidden;}
	.InfoTure{ position:fixed; display:none; top:15%; left:35%; background-color:#FFFFFF; border:#00CCCC solid 1px; border-radius:5px; width:30%; color:#666666;}
	.InfoTure .infoTitle{ font-size:18px; border-bottom:#00CCCC solid 1px; padding:25px; text-align:center; font-family:'微软雅黑'; background-color:#00CCCC; border-radius:5px 5px 0px 0px; color:#FFFFFF;}
	.InfoTure ul{ list-style-type:none; padding:0px; margin:0px; padding:15px 20px;}
	.InfoTure ul li{ height:30px;}
	.InfoTure .btnClassBox{}
	.InfoTure .btnClassBox button{ width:52%; border:none; background:none; padding:20px; font-size:16px; cursor:pointer; outline:none; color:#00CCCC; font-weight:bold;}
	.goWhere{position:fixed; top:30%; display:none; left:37%; width:300px; border:1px solid #e1e1e1; background-color:#FFFFFF; border-radius:5px; font-size:16px; color:#666666;font-family:'微软雅黑';}
	.goWhere .colseImg{display:block; width:20px; height:20px; line-height:20px; float:right; text-align:center; cursor:pointer; font-size:12px; color:#999; font-family:'微软雅黑';}
	.goWhere .goWhereBtn{width:52%; margin-left:0px; border:none; padding:15px; cursor:pointer; outline:none; margin:0px; background-color:#FFFFFF;}
	.zaClass{text-decoration:none; padding:8px 13px; display:block; width:92px; margin-left: 30px; margin-top:7px; cursor:pointer; background-color:#0099CC; outline:none; color:#FFFFFF; border:none; border-radius:5px;}
	.zaClass:hover{background-color:#0080ab;}
	#ulBox li .zhzfildBox{margin-top:15px;}
	#ulBox li .zhzfildBox .childBoxClass{border-top:#e1e1e1 solid 1px; overflow:hidden;}
	#ulBox li .zhzfildBox .kongBox{width:500px; height:46px;}
	#ulBox li .zhzfildBox .otherCangweiClass{width:200px; height:46px; text-align:left; line-height:46px;}
	#ulBox li .zhzfildBox .otherCangweiClass span{ color:#666666; font-family:'微软雅黑';}
	#ulBox li .zhzfildBox .otherCangweiClass .cangweiNum{ color:#FF0000; font-size:14px;}
	#ulBox li .zhzfildBox .jiagePay{width:179px; height:39px; padding-top:7px; text-align:right; font-family:'微软雅黑';}
	#ulBox li .zhzfildBox .jiagePay .payMoneyBox{ font-size:25px; color:#FF9900; font-weight:bold;}
	#ulBox li .zhzfildBox .yudingBtn{width:250px; text-align:center;}
	#ulBox li .zhzfildBox .yudingBtn>a{display: block; width: 50px; margin-left: 75px; padding:8px 20px; margin-top:7px; margin-bottom:7px; cursor:pointer; background-color:#0099CC; color:#FFFFFF; border:none; border-radius:5px;}
	#ulBox li .zhzfildBox .kongBox,.zhzfildBox .otherCangweiClass,.zhzfildBox .jiagePay,.zhzfildBox .yudingBtn{ float:left;}
	#findBtn{padding:30px; background-color:#3879D9; cursor:pointer; outline:none; border:none; color:#fff; font-size:15px; border-radius:10px;}
	
	/*城市选择切换css*/
	a,img{border:0;}
	body{font:12px Arial, Helvetica, sans-serif, "新宋体";}
	.tab1{width:500px;border:#cccccc solid 1px; position:absolute; left:40%; top:30%; padding:20px; display:none; background-color:#FFFFFF;}
	.colseImgCity{display:block; float:right; width:13px; height:15px; text-align:center; cursor:pointer;}
	.colseImgCity:hover{ border:#CCCCCC solid 1px;}
	.citymenu{height:30px;font-size:14px;}
	.citymenu ul{ overflow:hidden; margin:0px; padding:0px;}
	.citymenu li{float:left;text-align:center;line-height:20px;height:20px;padding:5px 21px; font-size:13px; cursor:pointer;color:#666;overflow:hidden;}
	.citymenu li.off{background:#fff;border-bottom:2px solid #0000FF; color:#0000FF; font-weight:bold;}
	.menudiv{ border-top:2px solid #ccc;}
	.menudiv>div{padding:15px 15px 5px 15px;line-height:28px; overflow:auto; max-height:335px;}
	.menudiv div ul{ list-style:none; overflow:hidden; margin:0px; padding:0px;}
	.menudiv div ul li{ float:left; overflow:hidden; width:70px; padding-left:6px; cursor:pointer; overflow:hidden;}
	.menudiv div ul li:hover{background-color:#0066CC; color:#FFFFFF;}
	.menudiv div ul li.chLiBox{ background-color:#0066CC; color:#FFFFFF;}
	.airportCode,.planeNameNew{ display:none;}
	.zimuBox{overflow:hidden; padding:0px;}
	.zimuBox .shouzimu{ border-bottom:#E1E1E1 solid 1px; color:#0000CC; font-size:14px; font-weight:bold;}
	.zimuBox .nameBoxDiv{padding:0px;}
	.zimuBox .nameBoxDiv ul{margin:0px;}
	#pipeiValue{display:none; border:1px solid #e1e1e1; position:absolute; top:100px; background-color:#fff; left:0px; z-index:9; height:auto; width:300px;}
	#pipeiValue .pipeiChildren{padding:10px 0px; padding-left:20px; cursor:pointer;}
	#pipeiValue .pipeiChildren:hover{background-color:#e1e1e1;}
	
	/* 往返 */
	ul .wfresListBox{overflow:hidden; border-bottom:#e1e1e1 solid 1px;}
	.wfresListBox .zuheFildClass{ float:left;}
	.hangbanbtn{float:left; margin-top:60px; margin-left:30px;}
	.hangbanbtn button{background-color:#0099CC; border-radius:5px; border:none; color:#FFFFFF; padding:8px 13px; cursor:pointer; outline:none;}
	.countMoney{float:left; margin-top:45px;}
	.countMoney .countNumPay{ display:block; text-align:center; font-size:12px; color:#999999;}
	.countMoney .deoole{float:left; width:10px; font-family:'微软雅黑'; line-height:55px; margin-left:15px;}
	.countMoney .payMoey{ font-size:25px; color:#FF9900; text-align:left;line-height:45px;float:left; width:110px;}
	.countMoney .qiClass{float:left; width:20px; line-height:55px; font-size:12px;}
	.hangbanInfo{padding:5px;}
	.hangbanInfo .childBox .depDateClass{float: left; margin-left:-175px; margin-top:23px;}
	.hangbanInfo .childBox{float:left; text-align:center;}
	.spanClass{display:block; width:175px;}
	.arrTime,.depTime{font-size:25px; font-weight:bold;}
	.depPlane,.arrPlane{font-size:13px; color:#666666;}
	.airName,.filgNo{line-height:23px;}
	
	.childBoxCang{ padding:0px 0px 15px 0px;}
	.childBoxCang .wfchildBoxClass{margin-top:10px;}
	.childBoxCang .wfchildBoxClass .kongBox{float:left; width:400px; height:30px;}
	.childBoxCang .wfchildBoxClass .otherCangweiClass{float:left; width:300px; height:30px; line-height: 30px;}
	.childBoxCang .wfchildBoxClass .otherCangweiClass .cangweiNum{color:#f00;}
	.childBoxCang .wfchildBoxClass .jiagePay{float:left; width:165px; height:30px; line-height: 30px;}
	.childBoxCang .wfchildBoxClass .jiagePay .payMoneyBox{color:#FF9900; font-size: 20px;}
	.childBoxCang .wfchildBoxClass .yudingBtn{float:left; height:30px;}
	.childBoxCang .wfchildBoxClass .yudingBtn .trueYuBtn{padding: 8px 20px;background-color: #0099CC;color: #fff;border: none;border-radius: 5px; cursor:pointer;text-decoration:none}
	
	/*日期控件*/
	.input-parent.input-container{float:left; margin-left:5px;}
</style>
</head>

<body>
	<!--搜索条件-->
	<div id="conditionId" style="border:1px solid #e1e1e1; padding:10px 8px;">
		<table border="0" cellpadding="5" cellspacing="0" width="90%">
			<tr>
				<td>国际范围：</td>
				<td>
					<select id="cityArea" class="easyui-combobox" style="width:110px;" panelHeight="45">
						<option value="1">国内</option>
						<option value="2">国际</option>
					</select>
				</td>
				<td>出发城市：</td>
				<td><input class="cityIpnt inputstyle" id="gofaCity" oninput="myFunction(this)"/></td>
				<td rowspan="2">
					<button id="changeBtn" style="border:1px solid #77C0F1; border-radius:5px; outline:none; background:none; cursor:pointer; height:21px;">换</button>
				</td>
				<td>出发日期：</td>
				<td><input id="gofaTime" class="inputstyle" data-beatpicker="true"/></td>
				<td rowspan="2"><button id="findBtn" onclick="ajaxjson()">搜索航班</button></td>
			</tr>
			<tr>
				<td>单返类型：</td>
				<td>
					<select id="danAndFan" class="easyui-combobox" style="width:110px;" panelHeight="55">
						<option value=""></option>
						<option value="1">单程</option>
						<option value="2">往返</option>
					</select>
				</td>
				<td>到达城市：</td>
				<td><input class="cityIpnt1 inputstyle" id="arrCity" oninput="myFunction(this)"/></td>
				<td>返回日期：</td>
				<td><input id="fancDate" class="inputstyle" disabled="disabled" data-beatpicker="true"/></td>
			</tr>
		</table>
		<!-- <div>
			<select id="cangwei" style="width:70px;">
				<option value="经济舱">经济舱</option>
				<option value="头等舱">头等舱</option>
				<option value="公务舱">公务舱</option>
			</select>
		</div> -->		
	</div>
	<!--结果标题-->
	<div class="planeTitle">
		<div class="planeTitleCh" style="margin-left:0px;"><span>航空公司</span></div>
		<div class="planeTitleCh" style="width:200px;"><span>出发时间</span></div>
		<div class="planeTitleCh"></div>
		<div class="planeTitleCh" style="width:200px;"><span>到达时间</span></div>
		<div class="planeTitleCh"><span>价格</span></div>
		<div style=" clear:both;"></div>
	</div>
	<!--查询结果-->
	<ul id="ulBox"></ul>
	<!---航班信息确认框-->
	<div class="InfoTure">
		<div class="infoTitle">请确认信息</div>
		<ul>
			<li><span>出发机场：</span><span>三亚凤凰机场</span></li>
			<li><span>目的机场：</span><span>太原武宿机场</span></li>
			<li><span>出发时间：</span><span>2016-05-12 08:12</span></li>
			<li><span>乘机人：</span><span>李向前</span></li>
			<li><span>联系电话：</span><span>15799024022</span></li>
			<li><span>航班号：</span><span>CZ2011</span></li>
			<li><span>证件号码：</span><span>46000319930203044</span></li>
		</ul>
		<div class="btnClassBox" style="border-top:#00CCCC solid 1px;">
			<button style="border-right:1px solid #00CCCC; color:#fff; background-color:#00CCCC;">正确</button>
			<button id="errorBtn" style="width:44%;">错误</button>
		</div>
	</div>
	<!--修改去向-->
	<div class="goWhere">
		<div><span class="colseImg">X</span></div>
		<div style="clear:both;"></div>
		<div style="height:80px; line-height:80px; margin-left:20px;">你想修改哪种信息？</div>
		<div style="border-top:1px solid #e1e1e1">
			<button class="goWhereBtn" style="border-right:1px solid #e1e1e1;">修改航班</button>
			<button class="goWhereBtn" style="width:45%">修改资料</button>
		</div>
	</div>
	<!--城市查找（国内）-->
	<div class="tab1" id="tab1">
		<div style="overflow:hidden;"><span>国内城市</span><span id="colseImgCity" class="colseImgCity">X</span><span style="clear:both;"></span></div>
		<div class="citymenu">
			<ul>
				<li id="one1" onclick="setTab('one',1)">热门</li>
				<li id="one2" onclick="setTab('one',2)">ABCDEF</li>
				<li id="one3" onclick="setTab('one',3)">GHIJ</li>
				<li id="one4" onclick="setTab('one',4)">KLMN</li>
				<li id="one5" onclick="setTab('one',5)">PQRSTUVW</li>
				<li id="one6" onclick="setTab('one',6)">XYZ</li>
			</ul>
		</div>
		<div class="menudiv">
			<!--热门推荐-->
			<div id="con_one_1">
				<ul><li><span class="cityName">北京</span><span class="planeNameNew">北京首都国际机场</span><span class="airportCode">PEK</span></li><li><span class="cityName">广州</span><span class="planeNameNew">广州新白云国际机场</span><span class="airportCode">CAN</span></li><li><span class="cityName">海口</span><span class="planeNameNew">海口美兰国际机场</span><span class="airportCode">HAK</span></li><li><span class="cityName">三亚</span><span class="planeNameNew">三亚凤凰国际机场</span><span class="airportCode">SYX</span></li><li><span class="cityName">贵阳</span><span class="planeNameNew">贵阳龙洞堡国际机场</span><span class="airportCode">KWE</span></li><li><span class="cityName">大同</span><span class="planeNameNew">大同怀仁机场</span><span class="airportCode">DAT</span></li><li><span class="cityName">安庆</span><span class="planeNameNew">安庆大龙山机场</span><span class="airportCode">AQG</span></li><li><span class="cityName">上海</span><span class="planeNameNew">上海浦东机场</span><span class="airportCode">PVG</span></li><li><span class="cityName">青岛</span><span class="planeNameNew">青岛流亭国际机场</span><span class="airportCode">TAO</span></li><li><span class="cityName">深圳</span><span class="planeNameNew">深圳宝安国际机场</span><span class="airportCode">SZX</span></li><li><span class="cityName">石家庄</span><span class="planeNameNew">石家庄正定国际机场</span><span class="airportCode">SJW</span></li><li><span class="cityName">太原</span><span class="planeNameNew">太原武宿国际机场</span><span class="airportCode">TYN</span></li></ul>
			</div>
			<div id="con_one_2" style="display:none;">
				<div class="zimuBox">
					<div class="shouzimu">A</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">阿勒泰</span><span class="planeNameNew">阿勒泰机场</span><span class="airportCode">AAT</span></li><li><span class="cityName">阿坝藏族羌族自治州</span><span class="planeNameNew">阿坝红原机场</span><span class="airportCode">AHJ</span></li><li><span class="cityName">安康</span><span class="planeNameNew">安康五里铺机场 </span><span class="airportCode">AKA</span></li><li><span class="cityName">阿克苏</span><span class="planeNameNew">阿克苏机场</span><span class="airportCode">AKU</span></li><li><span class="cityName">鞍山</span><span class="planeNameNew">鞍山腾鳌机场</span><span class="airportCode">AOG</span></li><li><span class="cityName">安庆</span><span class="planeNameNew">安庆大龙山机场</span><span class="airportCode">AQG</span></li><li><span class="cityName">阿拉善左旗</span><span class="planeNameNew">阿拉善左旗巴彦浩特机场</span><span class="airportCode">AXF</span></li><li><span class="cityName">阿里地区</span><span class="planeNameNew">阿里昆莎机场</span><span class="airportCode">NGQ</span></li><li><span class="cityName">阿拉善右旗</span><span class="planeNameNew">阿拉善右旗巴丹吉林机场</span><span class="airportCode">RHT</span></li><li><span class="cityName">阿尔山市</span><span class="planeNameNew">阿尔山伊尔施机场</span><span class="airportCode">YIE</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">B</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">百色</span><span class="planeNameNew">百色田阳机场</span><span class="airportCode">AEB</span></li><li><span class="cityName">包头</span><span class="planeNameNew">包头二里半机场</span><span class="airportCode">BAV</span></li><li><span class="cityName">毕节</span><span class="planeNameNew">毕节飞雄机场</span><span class="airportCode">BFJ</span></li><li><span class="cityName">北海</span><span class="planeNameNew">北海福成机场  </span><span class="airportCode">BHY</span></li><li><span class="cityName">博乐</span><span class="planeNameNew">新疆博乐机场</span><span class="airportCode">BPL</span></li><li><span class="cityName">保山</span><span class="planeNameNew">保山云瑞机场</span><span class="airportCode">BSD</span></li><li><span class="cityName">佛山</span><span class="planeNameNew">佛山沙堤机场</span><span class="airportCode">FUO</span></li><li><span class="cityName">北京</span><span class="planeNameNew">北京南苑机场</span><span class="airportCode">NAY</span></li><li><span class="cityName">白山</span><span class="planeNameNew">长白山机场</span><span class="airportCode">NBS</span></li><li><span class="cityName">北京</span><span class="planeNameNew">北京首都国际机场</span><span class="airportCode">PEK</span></li><li><span class="cityName">巴彦淖尔市</span><span class="planeNameNew">巴彦淖尔天吉泰机场</span><span class="airportCode">RLK</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">C</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">昌都</span><span class="planeNameNew">昌都邦达机场</span><span class="airportCode">BPX</span></li><li><span class="cityName">常德</span><span class="planeNameNew">常德桃花源机场</span><span class="airportCode">CGD</span></li><li><span class="cityName">赤峰</span><span class="planeNameNew">赤峰玉龙机场 </span><span class="airportCode">CIF</span></li><li><span class="cityName">成都</span><span class="planeNameNew">成都双流国际机场</span><span class="airportCode">CTU</span></li><li><span class="cityName">常州</span><span class="planeNameNew">常州奔牛机场</span><span class="airportCode">CZX</span></li><li><span class="cityName">池州</span><span class="planeNameNew">池州</span><span class="airportCode">JUH</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">D</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">大同</span><span class="planeNameNew">大同怀仁机场</span><span class="airportCode">DAT</span></li><li><span class="cityName">达县</span><span class="planeNameNew">达县河霸机场</span><span class="airportCode">DAX</span></li><li><span class="cityName">稻城县</span><span class="planeNameNew">稻城亚丁机场</span><span class="airportCode">DCY</span></li><li><span class="cityName">东莞</span><span class="planeNameNew">东莞</span><span class="airportCode">DDB</span></li><li><span class="cityName">丹东</span><span class="planeNameNew">丹东浪头机场</span><span class="airportCode">DDG</span></li><li><span class="cityName">德阳</span><span class="planeNameNew">德阳</span><span class="airportCode">DEY</span></li><li><span class="cityName">迪庆</span><span class="planeNameNew">迪庆香格里拉机场</span><span class="airportCode">DIG</span></li><li><span class="cityName">大连</span><span class="planeNameNew">大连周水子国际机场</span><span class="airportCode">DLC</span></li><li><span class="cityName">大理</span><span class="planeNameNew">大理机场</span><span class="airportCode">DLU</span></li><li><span class="cityName">敦煌</span><span class="planeNameNew">敦煌机场</span><span class="airportCode">DNH</span></li><li><span class="cityName">东营</span><span class="planeNameNew">东营永安机场</span><span class="airportCode">DOY</span></li><li><span class="cityName">大庆</span><span class="planeNameNew">大庆萨尔图机场</span><span class="airportCode">DQA</span></li><li><span class="cityName">德令哈市</span><span class="planeNameNew">德令哈机场</span><span class="airportCode">HXD</span></li><li><span class="cityName">大兴安岭地区</span><span class="planeNameNew">加格达奇机场</span><span class="airportCode">JGD</span></li><li><span class="cityName">德宏芒市</span><span class="planeNameNew">芒市面上机场</span><span class="airportCode">LUM</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">E</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">鄂尔多斯</span><span class="planeNameNew">鄂尔多斯东胜机场 </span><span class="airportCode">DSN</span></li><li><span class="cityName">额济纳旗</span><span class="planeNameNew">额济纳旗桃来机场</span><span class="airportCode">EJN</span></li><li><span class="cityName">恩施</span><span class="planeNameNew">恩施许家坪机场</span><span class="airportCode">ENH</span></li><li><span class="cityName">二连浩特市</span><span class="planeNameNew">二连浩特赛乌苏机场</span><span class="airportCode">ERL</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">F</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">福州</span><span class="planeNameNew">福州长乐国际机场</span><span class="airportCode">FOC</span></li><li><span class="cityName">阜阳</span><span class="planeNameNew">阜阳西关机场</span><span class="airportCode">FUG</span></li><li><span class="cityName">抚远</span><span class="planeNameNew">抚远</span><span class="airportCode">FYJ</span></li>
						</ul>
					</div>
				</div>
			</div>
			<div id="con_one_3" style="display:none;">
				<div class="zimuBox">
					<div class="shouzimu">G</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">广州</span><span class="planeNameNew">广州新白云国际机场</span><span class="airportCode">CAN</span></li><li><span class="cityName">广汉</span><span class="planeNameNew">广汉机场</span><span class="airportCode">GHN</span></li><li><span class="cityName">格尔木</span><span class="planeNameNew">格尔木机场</span><span class="airportCode">GOQ</span></li><li><span class="cityName">广元</span><span class="planeNameNew">广元盘龙机场</span><span class="airportCode">GYS</span></li><li><span class="cityName">固原市</span><span class="planeNameNew">固原六盘山机场</span><span class="airportCode">GYU</span></li><li><span class="cityName">甘南藏族自治州</span><span class="planeNameNew">甘南夏河机场</span><span class="airportCode">JXH</span></li><li><span class="cityName">甘孜</span><span class="planeNameNew">康定机场</span><span class="airportCode">KGT</span></li><li><span class="cityName">赣州</span><span class="planeNameNew">赣州黄金机场</span><span class="airportCode">KOW</span></li><li><span class="cityName">贵阳</span><span class="planeNameNew">贵阳龙洞堡国际机场</span><span class="airportCode">KWE</span></li><li><span class="cityName">桂林</span><span class="planeNameNew">桂林两江国际机场 </span><span class="airportCode">KWL</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">H</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">惠阳</span><span class="planeNameNew">惠阳</span><span class="airportCode">AHE</span></li><li><span class="cityName">黄果树</span><span class="planeNameNew">黄果树</span><span class="airportCode">AVA</span></li><li><span class="cityName">海口</span><span class="planeNameNew">海口美兰国际机场</span><span class="airportCode">HAK</span></li><li><span class="cityName">河池市</span><span class="planeNameNew">河池金城江机场</span><span class="airportCode">HCJ</span></li><li><span class="cityName">邯郸</span><span class="planeNameNew">邯郸机场</span><span class="airportCode">HDG</span></li><li><span class="cityName">黑河</span><span class="planeNameNew">黑河国际机场</span><span class="airportCode">HEK</span></li><li><span class="cityName">呼和浩特</span><span class="planeNameNew">呼和浩特白塔国际机场</span><span class="airportCode">HET</span></li><li><span class="cityName">合肥</span><span class="planeNameNew">合肥骆岗机场</span><span class="airportCode">HFE</span></li><li><span class="cityName">杭州</span><span class="planeNameNew">杭州萧山国际机场</span><span class="airportCode">HGH</span></li><li><span class="cityName">淮安</span><span class="planeNameNew">淮安涟水机场</span><span class="airportCode">HIA</span></li><li><span class="cityName">怀化</span><span class="planeNameNew">怀化芷江机场</span><span class="airportCode">HJJ</span></li><li><span class="cityName">海拉尔</span><span class="planeNameNew">海拉尔东山机场</span><span class="airportCode">HLD</span></li><li><span class="cityName">哈密</span><span class="planeNameNew">哈密机场 </span><span class="airportCode">HMI</span></li><li><span class="cityName">衡阳</span><span class="planeNameNew">衡阳机场</span><span class="airportCode">HNY</span></li><li><span class="cityName">哈尔滨</span><span class="planeNameNew">哈尔滨太平国际机场</span><span class="airportCode">HRB</span></li><li><span class="cityName">和田</span><span class="planeNameNew">和田机场</span><span class="airportCode">HTN</span></li><li><span class="cityName">惠州市</span><span class="planeNameNew">惠州平潭机场</span><span class="airportCode">HUZ</span></li><li><span class="cityName">黄岩</span><span class="planeNameNew">黄岩路桥机场</span><span class="airportCode">HYN</span></li><li><span class="cityName">汉中</span><span class="planeNameNew">汉中西关机场</span><span class="airportCode">HZG</span></li><li><span class="cityName">黄山</span><span class="planeNameNew">黄山屯溪跃桥机场</span><span class="airportCode">TXN</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">I</div>
					<div class="nameBoxDiv">
						<ul></ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">J</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">江门</span><span class="planeNameNew">江门</span><span class="airportCode">JBD</span></li><li><span class="cityName">景德镇</span><span class="planeNameNew">景德镇罗家机场</span><span class="airportCode">JDZ</span></li><li><span class="cityName">嘉峪关</span><span class="planeNameNew">嘉峪关机场</span><span class="airportCode">JGN</span></li><li><span class="cityName">井冈山</span><span class="planeNameNew">井冈山机场</span><span class="airportCode">JGS</span></li><li><span class="cityName">金昌市</span><span class="planeNameNew">金昌金川机场</span><span class="airportCode">JIC</span></li><li><span class="cityName">吉林</span><span class="planeNameNew">吉林二台子机场</span><span class="airportCode">JIL</span></li><li><span class="cityName">九江</span><span class="planeNameNew">九江庐山机场</span><span class="airportCode">JIU</span></li><li><span class="cityName">晋江</span><span class="planeNameNew">泉州晋江机场</span><span class="airportCode">JJN</span></li><li><span class="cityName">佳木斯</span><span class="planeNameNew">佳木斯东郊机场</span><span class="airportCode">JMU</span></li><li><span class="cityName">济宁</span><span class="planeNameNew">济宁机场</span><span class="airportCode">JNG</span></li><li><span class="cityName">锦州</span><span class="planeNameNew">锦州小岭子机场</span><span class="airportCode">JNZ</span></li><li><span class="cityName">鸡西</span><span class="planeNameNew">鸡西兴凯湖机场</span><span class="airportCode">JXA</span></li><li><span class="cityName">九寨沟</span><span class="planeNameNew">九寨沟黄龙机场</span><span class="airportCode">JZH</span></li><li><span class="cityName">吉安</span><span class="planeNameNew">吉安机场</span><span class="airportCode">KNC</span></li><li><span class="cityName">荆州、沙市</span><span class="planeNameNew">荆州沙市机场  </span><span class="airportCode">SHS</span></li><li><span class="cityName">揭阳</span><span class="planeNameNew">揭阳潮汕机场</span><span class="airportCode">SWA</span></li><li><span class="cityName">济南</span><span class="planeNameNew">济南遥墙国际机场</span><span class="airportCode">TNA</span></li>
						</ul>
					</div>
				</div>
			</div>
			<div id="con_one_4" style="display:none;">
				<div class="zimuBox">
					<div class="shouzimu">K</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">库车</span><span class="planeNameNew">库车机场</span><span class="airportCode">KCA</span></li><li><span class="cityName">喀什</span><span class="planeNameNew">喀什机场</span><span class="airportCode">KHG</span></li><li><span class="cityName">喀纳斯</span><span class="planeNameNew">喀纳斯</span><span class="airportCode">KJI</span></li><li><span class="cityName">昆明</span><span class="planeNameNew">昆明长水国际机场</span><span class="airportCode">KMG</span></li><li><span class="cityName">库尔勒</span><span class="planeNameNew">库尔勒机场</span><span class="airportCode">KRL</span></li><li><span class="cityName">克拉玛依</span><span class="planeNameNew">克拉玛依机场</span><span class="airportCode">KRY</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">L</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">黎平</span><span class="planeNameNew">黎平机场</span><span class="airportCode">HZH</span></li><li><span class="cityName">连城</span><span class="planeNameNew">福建龙岩冠豸山机场</span><span class="airportCode">LCX</span></li><li><span class="cityName">兰州</span><span class="planeNameNew">兰州中川机场</span><span class="airportCode">LHW</span></li><li><span class="cityName">梁平</span><span class="planeNameNew">梁平万州梁平机场</span><span class="airportCode">LIA</span></li><li><span class="cityName">丽江</span><span class="planeNameNew">丽江三义机场</span><span class="airportCode">LJG</span></li><li><span class="cityName">荔波</span><span class="planeNameNew">荔波机场</span><span class="airportCode">LLB</span></li><li><span class="cityName">吕梁市</span><span class="planeNameNew">吕梁机场</span><span class="airportCode">LLV</span></li><li><span class="cityName">临沧</span><span class="planeNameNew">临沧机场</span><span class="airportCode">LNJ</span></li><li><span class="cityName">六盘水市</span><span class="planeNameNew">六盘水月照机场</span><span class="airportCode">LPF</span></li><li><span class="cityName">拉萨</span><span class="planeNameNew">拉萨贡嘎机场</span><span class="airportCode">LXA</span></li><li><span class="cityName">洛阳</span><span class="planeNameNew">洛阳北郊机场</span><span class="airportCode">LYA</span></li><li><span class="cityName">连云港</span><span class="planeNameNew">连云港白塔埠机场</span><span class="airportCode">LYG</span></li><li><span class="cityName">临沂</span><span class="planeNameNew">临沂机场</span><span class="airportCode">LYI</span></li><li><span class="cityName">柳州</span><span class="planeNameNew">柳州白莲机场</span><span class="airportCode">LZH</span></li><li><span class="cityName">泸州</span><span class="planeNameNew">泸州蓝田机场</span><span class="airportCode">LZO</span></li><li><span class="cityName">林芝</span><span class="planeNameNew">林芝米林机场</span><span class="airportCode">LZY</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">M</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">牡丹江</span><span class="planeNameNew">牡丹江海浪机场</span><span class="airportCode">MDG</span></li><li><span class="cityName">绵阳</span><span class="planeNameNew">绵阳南郊机场</span><span class="airportCode">MIG</span></li><li><span class="cityName">梅县</span><span class="planeNameNew">梅县机场</span><span class="airportCode">MXZ</span></li><li><span class="cityName">满洲里</span><span class="planeNameNew">满洲里西郊机场</span><span class="airportCode">NZH</span></li><li><span class="cityName">漠河</span><span class="planeNameNew">漠河古莲机场</span><span class="airportCode">OHE</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">N</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">南昌</span><span class="planeNameNew">南昌昌北国际机场</span><span class="airportCode">KHN</span></li><li><span class="cityName">南充</span><span class="planeNameNew">南充都尉坝机场</span><span class="airportCode">NAO</span></li><li><span class="cityName">南海</span><span class="planeNameNew">南海</span><span class="airportCode">NFF</span></li><li><span class="cityName">宁波</span><span class="planeNameNew">宁波栎社国际机场</span><span class="airportCode">NGB</span></li><li><span class="cityName">南京</span><span class="planeNameNew">南京禄口国际机场</span><span class="airportCode">NKG</span></li><li><span class="cityName">那拉提</span><span class="planeNameNew">那拉提</span><span class="airportCode">NLT</span></li><li><span class="cityName">南宁</span><span class="planeNameNew">南宁吴圩国际机场</span><span class="airportCode">NNG</span></li><li><span class="cityName">南阳</span><span class="planeNameNew">南阳姜营机场</span><span class="airportCode">NNY</span></li><li><span class="cityName">南通</span><span class="planeNameNew">南通兴东机场</span><span class="airportCode">NTG</span></li>
						</ul>
					</div>
				</div>
			</div>
			<div id="con_one_5" style="display:none;">
				<div class="zimuBox">
					<div class="shouzimu">P</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">攀枝花</span><span class="planeNameNew">攀枝花保安营机场</span><span class="airportCode">PZI</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">Q</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">且末</span><span class="planeNameNew">且末机场</span><span class="airportCode">IQM</span></li><li><span class="cityName">庆阳</span><span class="planeNameNew">庆阳西峰镇机场</span><span class="airportCode">IQN</span></li><li><span class="cityName">黔江机场</span><span class="planeNameNew">黔江机场</span><span class="airportCode">JIQ</span></li><li><span class="cityName">衢州</span><span class="planeNameNew">衢州机场</span><span class="airportCode">JUZ</span></li><li><span class="cityName">黔东南苗族侗族自治州</span><span class="planeNameNew">凯里黄平机场</span><span class="airportCode">KJH</span></li><li><span class="cityName">齐齐哈尔</span><span class="planeNameNew">齐齐哈尔三家子机场</span><span class="airportCode">NDG</span></li><li><span class="cityName">秦皇岛</span><span class="planeNameNew">秦皇岛山海关机场</span><span class="airportCode">SHP</span></li><li><span class="cityName">青岛</span><span class="planeNameNew">青岛流亭国际机场</span><span class="airportCode">TAO</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">R</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">日喀则市</span><span class="planeNameNew">日喀则和平机场</span><span class="airportCode">RKZ</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">S</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">神农架林区</span><span class="planeNameNew">神农架红坪机场</span><span class="airportCode">HPG</span></li><li><span class="cityName">顺德</span><span class="planeNameNew">顺德</span><span class="airportCode">NDH</span></li><li><span class="cityName">上海</span><span class="planeNameNew">上海浦东机场</span><span class="airportCode">PVG</span></li><li><span class="cityName">上海</span><span class="planeNameNew">上海虹桥机场</span><span class="airportCode">SHA</span></li><li><span class="cityName">沈阳</span><span class="planeNameNew">沈阳桃仙国际机场</span><span class="airportCode">SHE</span></li><li><span class="cityName">韶关</span><span class="planeNameNew">韶关</span><span class="airportCode">SHG</span></li><li><span class="cityName">石家庄</span><span class="planeNameNew">石家庄正定国际机场</span><span class="airportCode">SJW</span></li><li><span class="cityName">泗水</span><span class="planeNameNew">泗水</span><span class="airportCode">SUB</span></li><li><span class="cityName">鄯善</span><span class="planeNameNew">鄯善</span><span class="airportCode">SXJ</span></li><li><span class="cityName">思茅</span><span class="planeNameNew">普洱(思茅)机场</span><span class="airportCode">SYM</span></li><li><span class="cityName">三亚</span><span class="planeNameNew">三亚凤凰国际机场</span><span class="airportCode">SYX</span></li><li><span class="cityName">深圳</span><span class="planeNameNew">深圳宝安国际机场</span><span class="airportCode">SZX</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">T</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">塔城</span><span class="planeNameNew">塔城机场</span><span class="airportCode">TCG</span></li><li><span class="cityName">腾冲</span><span class="planeNameNew">腾冲</span><span class="airportCode">TCZ</span></li><li><span class="cityName">铜仁</span><span class="planeNameNew">铜仁大兴机场</span><span class="airportCode">TEN</span></li><li><span class="cityName">通辽</span><span class="planeNameNew">通辽机场</span><span class="airportCode">TGO</span></li><li><span class="cityName">台山</span><span class="planeNameNew">台山</span><span class="airportCode">THJ</span></li><li><span class="cityName">天水</span><span class="planeNameNew">天水麦积山机场</span><span class="airportCode">THQ</span></li><li><span class="cityName">吐鲁番</span><span class="planeNameNew">吐鲁番</span><span class="airportCode">TLQ</span></li><li><span class="cityName">通化市</span><span class="planeNameNew">通化三源浦机场</span><span class="airportCode">TNH</span></li><li><span class="cityName">天津</span><span class="planeNameNew">天津滨海国际机场</span><span class="airportCode">TSN</span></li><li><span class="cityName">唐山</span><span class="planeNameNew">唐山三女河机场</span><span class="airportCode">TVS</span></li><li><span class="cityName">太原</span><span class="planeNameNew">太原武宿国际机场</span><span class="airportCode">TYN</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">U</div>
					<div class="nameBoxDiv">
						<ul></ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">V</div>
					<div class="nameBoxDiv">
						<ul></ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">W</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">乌兰浩特</span><span class="planeNameNew">乌兰浩特依勒力特机场</span><span class="airportCode">HLH</span></li><li><span class="cityName">乌鲁木齐</span><span class="planeNameNew">乌鲁木齐地窝堡国际机场</span><span class="airportCode">URC</span></li><li><span class="cityName">潍坊</span><span class="planeNameNew">潍坊文登机场</span><span class="airportCode">WEF</span></li><li><span class="cityName">威海</span><span class="planeNameNew">威海大水泊国际机场</span><span class="airportCode">WEH</span></li><li><span class="cityName">文山</span><span class="planeNameNew">文山普者黑机场</span><span class="airportCode">WNH</span></li><li><span class="cityName">温州</span><span class="planeNameNew">温州永强机场</span><span class="airportCode">WNZ</span></li><li><span class="cityName">乌海</span><span class="planeNameNew">乌海机场</span><span class="airportCode">WUA</span></li><li><span class="cityName">武汉</span><span class="planeNameNew">武汉天河国际机场</span><span class="airportCode">WUH</span></li><li><span class="cityName">武夷山</span><span class="planeNameNew">武夷山机场</span><span class="airportCode">WUS</span></li><li><span class="cityName">无锡</span><span class="planeNameNew">无锡硕放机场</span><span class="airportCode">WUX</span></li><li><span class="cityName">梧州</span><span class="planeNameNew">梧州长洲岛机场</span><span class="airportCode">WUZ</span></li><li><span class="cityName">万州</span><span class="planeNameNew">重庆万州五桥机场</span><span class="airportCode">WXN</span></li>
						</ul>
					</div>
				</div>
			</div>
			<div id="con_one_6" style="display:none;">
				<div class="zimuBox">
					<div class="shouzimu">X</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">兴义</span><span class="planeNameNew">兴义机场</span><span class="airportCode">ACX</span></li><li><span class="cityName">西双版纳</span><span class="planeNameNew">西双版纳嘎洒机场</span><span class="airportCode">JHG</span></li><li><span class="cityName">襄阳</span><span class="planeNameNew">襄樊刘集机场</span><span class="airportCode">XFN</span></li><li><span class="cityName">西昌</span><span class="planeNameNew">西昌青山机场</span><span class="airportCode">XIC</span></li><li><span class="cityName">锡林浩特</span><span class="planeNameNew">锡林浩特机场</span><span class="airportCode">XIL</span></li><li><span class="cityName">西安</span><span class="planeNameNew">西安</span><span class="airportCode">XIY</span></li><li><span class="cityName">厦门</span><span class="planeNameNew">厦门高崎国际机场 </span><span class="airportCode">XMN</span></li><li><span class="cityName">西宁</span><span class="planeNameNew">西宁曹家堡机场</span><span class="airportCode">XNN</span></li><li><span class="cityName">徐州</span><span class="planeNameNew">徐州观音机场</span><span class="airportCode">XUZ</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">Y</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">延安</span><span class="planeNameNew">延安二十里堡机场</span><span class="airportCode">ENY</span></li><li><span class="cityName">银川</span><span class="planeNameNew">银川河东机场</span><span class="airportCode">INC</span></li><li><span class="cityName">伊春</span><span class="planeNameNew">伊春林都机场</span><span class="airportCode">LDS</span></li><li><span class="cityName">永州</span><span class="planeNameNew">湖南永州零陵机场</span><span class="airportCode">LLF</span></li><li><span class="cityName">榆林</span><span class="planeNameNew">榆林西沙机场</span><span class="airportCode">UYN</span></li><li><span class="cityName">宜宾</span><span class="planeNameNew">宜宾菜坝机场</span><span class="airportCode">YBP</span></li><li><span class="cityName">运城</span><span class="planeNameNew">运城关公机场</span><span class="airportCode">YCU</span></li><li><span class="cityName">宜春市</span><span class="planeNameNew">宜春明月山机场</span><span class="airportCode">YIC</span></li><li><span class="cityName">宜昌</span><span class="planeNameNew">宜昌三峡机场</span><span class="airportCode">YIH</span></li><li><span class="cityName">伊宁</span><span class="planeNameNew">伊宁机场</span><span class="airportCode">YIN</span></li><li><span class="cityName">义乌</span><span class="planeNameNew">义乌机场</span><span class="airportCode">YIW</span></li><li><span class="cityName">延吉</span><span class="planeNameNew">延吉朝阳川国际机场</span><span class="airportCode">YNJ</span></li><li><span class="cityName">烟台</span><span class="planeNameNew">烟台莱山机场</span><span class="airportCode">YNT</span></li><li><span class="cityName">盐城</span><span class="planeNameNew">盐城机场 </span><span class="airportCode">YNZ</span></li><li><span class="cityName">扬州</span><span class="planeNameNew">扬州泰州机场</span><span class="airportCode">YTY</span></li><li><span class="cityName">玉树</span><span class="planeNameNew">玉树巴塘机场</span><span class="airportCode">YUS</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">Z</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">郑州</span><span class="planeNameNew">郑州新郑国际机场</span><span class="airportCode">CGO</span></li><li><span class="cityName">长春</span><span class="planeNameNew">长春龙嘉国际机场</span><span class="airportCode">CGQ</span></li><li><span class="cityName">朝阳</span><span class="planeNameNew">朝阳机场</span><span class="airportCode">CHG</span></li><li><span class="cityName">长治</span><span class="planeNameNew">长治王村机场</span><span class="airportCode">CIH</span></li><li><span class="cityName">重庆</span><span class="planeNameNew">重庆江北国际机场</span><span class="airportCode">CKG</span></li><li><span class="cityName">长海</span><span class="planeNameNew">长海大长山岛机场</span><span class="airportCode">CNI</span></li><li><span class="cityName">长沙</span><span class="planeNameNew">长沙黄花国际机场</span><span class="airportCode">CSX</span></li><li><span class="cityName">张家界</span><span class="planeNameNew">张家界荷花大庸机场</span><span class="airportCode">DYG</span></li><li><span class="cityName">中山</span><span class="planeNameNew">中山</span><span class="airportCode">HHS</span></li><li><span class="cityName">舟山</span><span class="planeNameNew">舟山普陀山机场机场</span><span class="airportCode">HSN</span></li><li><span class="cityName">张掖市</span><span class="planeNameNew">张掖甘州机场</span><span class="airportCode">YZY</span></li><li><span class="cityName">昭通</span><span class="planeNameNew">昭通机场</span><span class="airportCode">ZAT</span></li><li><span class="cityName">湛江</span><span class="planeNameNew">湛江机场</span><span class="airportCode">ZHA</span></li><li><span class="cityName">中卫</span><span class="planeNameNew">中卫沙坡头机场</span><span class="airportCode">ZHY</span></li><li><span class="cityName">张家口市</span><span class="planeNameNew">张家口宁远机场</span><span class="airportCode">ZQZ</span></li><li><span class="cityName">珠海</span><span class="planeNameNew">珠海三灶国际机场</span><span class="airportCode">ZUH</span></li><li><span class="cityName">遵义</span><span class="planeNameNew">遵义新舟机场</span><span class="airportCode">ZYI</span></li>
						</ul>
					</div>
				</div>
			
			</div>
		</div>
	</div>
	<!--城市查找（国际）-->
	<div class="tab1" id="tab2">
		<div style="overflow:hidden;"><span>国际城市</span><span id="colseImgCity" class="colseImgCity">X</span><span style="clear:both;"></span></div>
		<div class="citymenu">
			<ul>
				<li id="two1" onclick="setTab('two',1)" class="off">热门</li>
				<li id="two2" onclick="setTab('two',2)">ABCDEF</li>
				<li id="two3" onclick="setTab('two',3)">GHIJ</li>
				<li id="two4" onclick="setTab('two',4)">KLMN</li>
				<li id="two5" onclick="setTab('two',5)">PQRSTUVW</li>
				<li id="two6" onclick="setTab('two',6)">XYZ</li>
			</ul>
		</div>
		<div class="menudiv">
			<!--热门推荐-->
			<div id="con_two_1">
				<ul><li><span class="cityName">安纳巴</span><span class="planeNameNew">安纳巴机场</span><span class="airportCode">AAE</span></li><li><span class="cityName">阿帕拉契科拉</span><span class="planeNameNew">阿帕拉契科拉地区机场</span><span class="airportCode">AAF</span></li><li><span class="cityName">奥尔堡</span><span class="planeNameNew">奥尔堡机场</span><span class="airportCode">AAL</span></li><li><span class="cityName">奥胡斯</span><span class="planeNameNew">奥胡斯机场</span><span class="airportCode">AAR</span></li><li><span class="cityName">阿伦敦</span><span class="planeNameNew">阿伦敦机场</span><span class="airportCode">ABE</span></li><li><span class="cityName">阿比林</span><span class="planeNameNew">阿比林地区机场</span><span class="airportCode">ABI</span></li><li><span class="cityName">承德</span><span class="planeNameNew">承德机场</span><span class="airportCode">CEH</span></li><li><span class="cityName">查塔努加都会</span><span class="planeNameNew">查塔努加机场</span><span class="airportCode">CHA</span></li></ul>
			</div>
			<div id="con_two_2" style="display:none;">
				<div class="zimuBox">
					<div class="shouzimu">A</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">安纳巴</span><span class="planeNameNew">安纳巴机场</span><span class="airportCode">AAE</span></li><li><span class="cityName">阿帕拉契科拉</span><span class="planeNameNew">阿帕拉契科拉地区机场</span><span class="airportCode">AAF</span></li><li><span class="cityName">奥尔堡</span><span class="planeNameNew">奥尔堡机场</span><span class="airportCode">AAL</span></li><li><span class="cityName">奥胡斯</span><span class="planeNameNew">奥胡斯机场</span><span class="airportCode">AAR</span></li><li><span class="cityName">阿伦敦</span><span class="planeNameNew">阿伦敦机场</span><span class="airportCode">ABE</span></li><li><span class="cityName">阿比林</span><span class="planeNameNew">阿比林地区机场</span><span class="airportCode">ABI</span></li><li><span class="cityName">阿比让</span><span class="planeNameNew">阿比让</span><span class="airportCode">ABJ</span></li><li><span class="cityName">阿布贾</span><span class="planeNameNew">阿布贾</span><span class="airportCode">ABV</span></li><li><span class="cityName">阿伯丁</span><span class="planeNameNew">阿伯丁</span><span class="airportCode">ABZ</span></li><li><span class="cityName">阿卡普尔科</span><span class="planeNameNew">阿卡普尔科国际机场</span><span class="airportCode">ACA</span></li><li><span class="cityName">阿克拉</span><span class="planeNameNew">阿克拉</span><span class="airportCode">ACC</span></li><li><span class="cityName">奥尔德尼</span><span class="planeNameNew">奥尔德尼机场</span><span class="airportCode">ACI</span></li><li><span class="cityName">阿达纳</span><span class="planeNameNew">阿达纳机场</span><span class="airportCode">ADA</span></li><li><span class="cityName">阿德莱德</span><span class="planeNameNew">阿德莱德</span><span class="airportCode">ADL</span></li><li><span class="cityName">奥尔代斯</span><span class="planeNameNew">奥尔代斯机场</span><span class="airportCode">ADY</span></li><li><span class="cityName">奥勒松</span><span class="planeNameNew">奥勒松机场</span><span class="airportCode">AES</span></li><li><span class="cityName">阿格拉</span><span class="planeNameNew">阿格拉机场</span><span class="airportCode">AGR</span></li><li><span class="cityName">奥古斯塔</span><span class="planeNameNew">奥古斯塔地区机场</span><span class="airportCode">AGS</span></li><li><span class="cityName">阿瓜斯卡连特斯</span><span class="planeNameNew">阿瓜斯卡连特斯国际机场</span><span class="airportCode">AGU</span></li><li><span class="cityName">阿拉卡茹</span><span class="planeNameNew">阿拉卡茹圣玛利亚机场</span><span class="airportCode">AJU</span></li><li><span class="cityName">阿加德兹</span><span class="planeNameNew">阿加德兹国际机场</span><span class="airportCode">AJY</span></li><li><span class="cityName">奥克兰</span><span class="planeNameNew">奥克兰</span><span class="airportCode">AKL</span></li><li><span class="cityName">阿克托别</span><span class="planeNameNew">阿克托别机场</span><span class="airportCode">AKX</span></li><li><span class="cityName">阿拉木图</span><span class="planeNameNew">阿拉木图</span><span class="airportCode">ALA</span></li><li><span class="cityName">阿尔及尔</span><span class="planeNameNew">阿尔及尔</span><span class="airportCode">ALG</span></li><li><span class="cityName">奥尔顿</span><span class="planeNameNew">奥尔顿圣路易斯地区机场</span><span class="airportCode">ALN</span></li><li><span class="cityName">阿马里洛</span><span class="planeNameNew">阿马里洛国际机场</span><span class="airportCode">AMA</span></li><li><span class="cityName">安曼</span><span class="planeNameNew">安曼</span><span class="airportCode">AMM</span></li><li><span class="cityName">阿姆斯特丹</span><span class="planeNameNew">阿姆斯特丹</span><span class="airportCode">AMS</span></li><li><span class="cityName">阿德马</span><span class="planeNameNew">阿德马机场</span><span class="airportCode">AMV</span></li><li><span class="cityName">安妮斯顿</span><span class="planeNameNew">安妮斯顿地区机场</span><span class="airportCode">ANB</span></li><li><span class="cityName">安克雷奇</span><span class="planeNameNew">泰德·史蒂文斯安克雷奇国际机场</span><span class="airportCode">ANC</span></li><li><span class="cityName">安德森</span><span class="planeNameNew">安德森地区机场</span><span class="airportCode">AND</span></li><li><span class="cityName">安托法加斯塔</span><span class="planeNameNew">安托法加斯塔塞罗莫雷诺机场</span><span class="airportCode">ANF</span></li><li><span class="cityName">安特卫普</span><span class="planeNameNew">安特卫普国际机场</span><span class="airportCode">ANR</span></li><li><span class="cityName">安科纳</span><span class="planeNameNew">安科纳-法尔科纳拉机场</span><span class="airportCode">AOI</span></li><li><span class="cityName">阿尔皮纳</span><span class="planeNameNew">阿尔皮纳机场</span><span class="airportCode">APN</span></li><li><span class="cityName">阿皮亚</span><span class="planeNameNew">阿皮亚</span><span class="airportCode">APW</span></li><li><span class="cityName">阿雷基帕</span><span class="planeNameNew">阿雷基帕机场</span><span class="airportCode">AQP</span></li><li><span class="cityName">阿尔汉格尔斯克</span><span class="planeNameNew">阿尔汉格尔斯克机场</span><span class="airportCode">ARH</span></li><li><span class="cityName">阿什哈巴德</span><span class="planeNameNew">阿什哈巴德</span><span class="airportCode">ASB</span></li><li><span class="cityName">阿斯彭</span><span class="planeNameNew">阿斯彭机场</span><span class="airportCode">ASE</span></li><li><span class="cityName">阿斯特拉罕</span><span class="planeNameNew">阿斯特拉罕机场</span><span class="airportCode">ASF</span></li><li><span class="cityName">阿斯旺</span><span class="planeNameNew">阿斯旺国际机场</span><span class="airportCode">ASW</span></li><li><span class="cityName">阿姆利则</span><span class="planeNameNew">阿姆利则</span><span class="airportCode">ATQ</span></li><li><span class="cityName">奥斯汀</span><span class="planeNameNew">奥斯汀贝格斯特罗姆国际机场</span><span class="airportCode">AUS</span></li><li><span class="cityName">阿什维尔</span><span class="planeNameNew">阿什维尔地区机场</span><span class="airportCode">AVL</span></li><li><span class="cityName">安阳</span><span class="planeNameNew">安阳北郊机场</span><span class="airportCode">AYN</span></li><li><span class="cityName">安塔利亚</span><span class="planeNameNew">安塔利亚机场</span><span class="airportCode">AYT</span></li><li><span class="cityName">阿布扎比</span><span class="planeNameNew">阿布扎比阿尔拜汀执行机场</span><span class="airportCode">AZI</span></li><li><span class="cityName">安吉利斯港</span><span class="planeNameNew">William R. Fairchild机场</span><span class="airportCode">CLM</span></li><li><span class="cityName">埃斯比约</span><span class="planeNameNew">埃斯比约机场</span><span class="airportCode">EBJ</span></li><li><span class="cityName">阿尔贝拉</span><span class="planeNameNew">阿尔贝拉国际机场</span><span class="airportCode">EBL</span></li><li><span class="cityName">埃阿坎</span><span class="planeNameNew">埃阿坎国际机场</span><span class="airportCode">ECN</span></li><li><span class="cityName">爱丁堡</span><span class="planeNameNew">爱丁堡</span><span class="airportCode">EDI</span></li><li><span class="cityName">埃因霍温</span><span class="planeNameNew">埃因霍温机场</span><span class="airportCode">EIN</span></li><li><span class="cityName">埃尔果累阿</span><span class="planeNameNew">埃尔果累阿机场</span><span class="airportCode">ELG</span></li><li><span class="cityName">埃尔帕索</span><span class="planeNameNew">埃尔帕索国际机场</span><span class="airportCode">ELP</span></li><li><span class="cityName">埃默拉尔德</span><span class="planeNameNew">埃默拉尔德</span><span class="airportCode">EMD</span></li><li><span class="cityName">埃尔福特</span><span class="planeNameNew">埃尔福特-魏玛机场</span><span class="airportCode">ERF</span></li><li><span class="cityName">埃拉特</span><span class="planeNameNew">埃拉特机场</span><span class="airportCode">ETH</span></li><li><span class="cityName">埃尔卡拉法特</span><span class="planeNameNew">埃尔卡拉法特机场</span><span class="airportCode">FTE</span></li><li><span class="cityName">阿特劳</span><span class="planeNameNew">阿特劳机场</span><span class="airportCode">GUW</span></li><li><span class="cityName">奥兰加巴德</span><span class="planeNameNew">奥兰加巴德机场</span><span class="airportCode">IXU</span></li><li><span class="cityName">奥兰多</span><span class="planeNameNew">奥兰多</span><span class="airportCode">MCO</span></li><li><span class="cityName">澳门</span><span class="planeNameNew">澳门</span><span class="airportCode">MFM</span></li><li><span class="cityName">阿拉巴马</span><span class="planeNameNew">阿拉巴马州西北地区机场</span><span class="airportCode">MSL</span></li><li><span class="cityName">奥克兰</span><span class="planeNameNew">奥克兰国际机场</span><span class="airportCode">OAK</span></li><li><span class="cityName">敖德萨</span><span class="planeNameNew">敖德萨机场</span><span class="airportCode">ODS</span></li><li><span class="cityName">奥兰</span><span class="planeNameNew">艾塞尼亚机场</span><span class="airportCode">ORN</span></li><li><span class="cityName">奥斯陆</span><span class="planeNameNew">奥斯陆</span><span class="airportCode">OSL</span></li><li><span class="cityName">奥什</span><span class="planeNameNew">奥什</span><span class="airportCode">OSS</span></li><li><span class="cityName">奥斯坦德</span><span class="planeNameNew">奥斯坦德机场</span><span class="airportCode">OST</span></li><li><span class="cityName">埃弗里特</span><span class="planeNameNew">埃弗里特佩恩机场</span><span class="airportCode">PAE</span></li><li><span class="cityName">阿雷格里港</span><span class="planeNameNew">阿雷格里港机场</span><span class="airportCode">POA</span></li><li><span class="cityName">奥尔达斯港</span><span class="planeNameNew">奥尔达斯港机场</span><span class="airportCode">PZO</span></li><li><span class="cityName">埃格尔斯巴赫</span><span class="planeNameNew">法兰克福-埃格尔斯巴赫机场</span><span class="airportCode">QEF</span></li><li><span class="cityName">奥伦堡</span><span class="planeNameNew">奥伦堡机场</span><span class="airportCode">REN</span></li><li><span class="cityName">阿克套</span><span class="planeNameNew">阿克套国际机场</span><span class="airportCode">SCO</span></li><li><span class="cityName">奥兰多</span><span class="planeNameNew">奥兰多桑福德国际机场</span><span class="airportCode">SFB</span></li><li><span class="cityName">阿萨洛</span><span class="planeNameNew">阿萨洛机场</span><span class="airportCode">SOR</span></li><li><span class="cityName">阿斯塔纳</span><span class="planeNameNew">阿斯塔纳</span><span class="airportCode">TSE</span></li><li><span class="cityName">爱德蒙顿</span><span class="planeNameNew">爱德蒙顿</span><span class="airportCode">YEG</span></li><li><span class="cityName">埃德森</span><span class="planeNameNew">埃德森机场</span><span class="airportCode">YET</span></li><li><span class="cityName">安大略</span><span class="planeNameNew">安大略红湖机场</span><span class="airportCode">YRL</span></li><li><span class="cityName">埃德蒙顿</span><span class="planeNameNew">埃德蒙顿城市机场</span><span class="airportCode">YXD</span></li><li><span class="cityName">安大略</span><span class="planeNameNew">加拿大伦敦机场</span><span class="airportCode">YXU</span></li><li><span class="cityName">阿伯兹福德</span><span class="planeNameNew">阿伯兹福德国际机场</span><span class="airportCode">YXX</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">B</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">伯纳利欧</span><span class="planeNameNew">阿尔伯克基国际机场</span><span class="airportCode">ABQ</span></li><li><span class="cityName">布朗</span><span class="planeNameNew">阿伯丁地区机场</span><span class="airportCode">ABR</span></li><li><span class="cityName">布宜诺斯艾利斯</span><span class="planeNameNew">布宜诺斯艾利斯霍尔赫纽贝里机场</span><span class="airportCode">AEP</span></li><li><span class="cityName">巴林</span><span class="planeNameNew">巴林</span><span class="airportCode">BAH</span></li><li><span class="cityName">巴库</span><span class="planeNameNew">巴库</span><span class="airportCode">BAK</span></li><li><span class="cityName">巴兰基亚</span><span class="planeNameNew">巴兰基亚机场</span><span class="airportCode">BAQ</span></li><li><span class="cityName">布巴内斯瓦尔</span><span class="planeNameNew">布巴内斯瓦尔机场</span><span class="airportCode">BBI</span></li><li><span class="cityName">布莱克布斯</span><span class="planeNameNew">布莱克布斯机场</span><span class="airportCode">BBS</span></li><li><span class="cityName">巴塞罗那</span><span class="planeNameNew">巴塞罗那</span><span class="airportCode">BCN</span></li><li><span class="cityName">班达伯格</span><span class="planeNameNew">班达伯格</span><span class="airportCode">BDB</span></li><li><span class="cityName">巴罗达</span><span class="planeNameNew">巴罗达机场</span><span class="airportCode">BDQ</span></li><li><span class="cityName">布里奇波特</span><span class="planeNameNew">布里奇波特西科斯基纪念机场</span><span class="airportCode">BDR</span></li><li><span class="cityName">布林迪西</span><span class="planeNameNew">布林迪西-萨兰托机场</span><span class="airportCode">BDS</span></li><li><span class="cityName">贝尔格莱德</span><span class="planeNameNew">贝尔格莱德</span><span class="airportCode">BEG</span></li><li><span class="cityName">班加西</span><span class="planeNameNew">班加西贝尼纳国际机场</span><span class="airportCode">BEN</span></li><li><span class="cityName">柏林</span><span class="planeNameNew">柏林</span><span class="airportCode">BER</span></li><li><span class="cityName">贝拉</span><span class="planeNameNew">贝拉机场</span><span class="airportCode">BEW</span></li><li><span class="cityName">贝鲁特</span><span class="planeNameNew">贝鲁特</span><span class="airportCode">BEY</span></li><li><span class="cityName">布拉德福德</span><span class="planeNameNew">布拉德福德地区机场</span><span class="airportCode">BFD</span></li><li><span class="cityName">贝克斯菲尔德</span><span class="planeNameNew">贝克斯菲尔德-米多斯菲尔德机场</span><span class="airportCode">BFL</span></li><li><span class="cityName">布隆方丹</span><span class="planeNameNew">布隆方丹布拉姆-费舍尔国际机场</span><span class="airportCode">BFN</span></li><li><span class="cityName">贝尔法斯特</span><span class="planeNameNew">贝尔法斯特</span><span class="airportCode">BFS</span></li><li><span class="cityName">卑尔根</span><span class="planeNameNew">卑尔根弗雷斯兰德机场</span><span class="airportCode">BGO</span></li><li><span class="cityName">班戈</span><span class="planeNameNew">班戈国际机场</span><span class="airportCode">BGR</span></li><li><span class="cityName">巴格达</span><span class="planeNameNew">巴格达国际机场</span><span class="airportCode">BGW</span></li><li><span class="cityName">贝加莫</span><span class="planeNameNew">贝加莫机场</span><span class="airportCode">BGY</span></li><li><span class="cityName">贝尔法斯特</span><span class="planeNameNew">乔治·贝斯特贝尔法斯特市机场</span><span class="airportCode">BHD</span></li><li><span class="cityName">布哈拉</span><span class="planeNameNew">布哈拉机场</span><span class="airportCode">BHK</span></li><li><span class="cityName">伯明翰</span><span class="planeNameNew">伯明翰舒特尔斯沃思国际机场</span><span class="airportCode">BHM</span></li><li><span class="cityName">博帕尔</span><span class="planeNameNew">博帕尔机场</span><span class="airportCode">BHO</span></li><li><span class="cityName">巴瑟斯特</span><span class="planeNameNew">巴瑟斯特拉格兰机场</span><span class="airportCode">BHS</span></li><li><span class="cityName">伯明翰</span><span class="planeNameNew">伯明翰</span><span class="airportCode">BHX</span></li><li><span class="cityName">比林斯</span><span class="planeNameNew">比林斯洛根国际机场</span><span class="airportCode">BIL</span></li><li><span class="cityName">毕尔巴鄂</span><span class="planeNameNew">毕尔巴鄂机场</span><span class="airportCode">BIO</span></li><li><span class="cityName">比亚里茨</span><span class="planeNameNew">比亚里茨-昂格莱-巴约讷机场</span><span class="airportCode">BIQ</span></li><li><span class="cityName">俾斯麦</span><span class="planeNameNew">俾斯麦机场</span><span class="airportCode">BIS</span></li><li><span class="cityName">布琼布拉</span><span class="planeNameNew">布琼布拉国际机场</span><span class="airportCode">BJM</span></li><li><span class="cityName">贝克</span><span class="planeNameNew">贝克机场</span><span class="airportCode">BKE</span></li><li><span class="cityName">巴马科</span><span class="planeNameNew">巴马科机场</span><span class="airportCode">BKO</span></li><li><span class="cityName">巴塞罗那</span><span class="planeNameNew">巴塞罗那何塞·安东尼奥·安索阿特吉国际机场</span><span class="airportCode">BLA</span></li><li><span class="cityName">布莱斯</span><span class="planeNameNew">布莱斯机场</span><span class="airportCode">BLH</span></li><li><span class="cityName">贝灵汉</span><span class="planeNameNew">贝灵汉国际机场</span><span class="airportCode">BLI</span></li><li><span class="cityName">比隆德</span><span class="planeNameNew">比隆德机场</span><span class="airportCode">BLL</span></li><li><span class="cityName">博洛尼亚</span><span class="planeNameNew">博洛尼亚</span><span class="airportCode">BLQ</span></li><li><span class="cityName">班加罗尔</span><span class="planeNameNew">班加罗尔</span><span class="airportCode">BLR</span></li><li><span class="cityName">布鲁姆</span><span class="planeNameNew">布鲁姆国际机场</span><span class="airportCode">BME</span></li><li><span class="cityName">布里斯班</span><span class="planeNameNew">布里斯班</span><span class="airportCode">BNE</span></li><li><span class="cityName">波尔多</span><span class="planeNameNew">波尔多-梅里尼亚克机场</span><span class="airportCode">BOD</span></li><li><span class="cityName">波哥大</span><span class="planeNameNew">波哥大埃尔多拉多国际机场</span><span class="airportCode">BOG</span></li><li><span class="cityName">博伊西</span><span class="planeNameNew">博伊西机场</span><span class="airportCode">BOI</span></li><li><span class="cityName">布尔加斯</span><span class="planeNameNew">布尔加斯机场</span><span class="airportCode">BOJ</span></li><li><span class="cityName">波士顿</span><span class="planeNameNew">波士顿</span><span class="airportCode">BOS</span></li><li><span class="cityName">博博迪乌拉索</span><span class="planeNameNew">博博迪乌拉索博尔戈机场</span><span class="airportCode">BOY</span></li><li><span class="cityName">巴厘巴板</span><span class="planeNameNew">巴厘巴板苏丹穆罕默德·阿吉·苏莱曼机场</span><span class="airportCode">BPN</span></li><li><span class="cityName">布拉戈维申斯克</span><span class="planeNameNew">布拉戈维申斯克机场</span><span class="airportCode">BQS</span></li><li><span class="cityName">布雷斯特</span><span class="planeNameNew">布雷斯特机场</span><span class="airportCode">BQT</span></li><li><span class="cityName">不来梅</span><span class="planeNameNew">不来梅机场</span><span class="airportCode">BRE</span></li><li><span class="cityName">巴里</span><span class="planeNameNew">巴里机场</span><span class="airportCode">BRI</span></li><li><span class="cityName">伯灵顿</span><span class="planeNameNew">伯灵顿爱荷华州东南部地区机场</span><span class="airportCode">BRL</span></li><li><span class="cityName">布朗斯维尔</span><span class="planeNameNew">布朗斯维尔南帕德里岛国际机场</span><span class="airportCode">BRO</span></li><li><span class="cityName">布里斯托尔</span><span class="planeNameNew">布里斯托尔机场</span><span class="airportCode">BRS</span></li><li><span class="cityName">布鲁塞尔</span><span class="planeNameNew">布鲁塞尔</span><span class="airportCode">BRU</span></li><li><span class="cityName">巴拉奥纳</span><span class="planeNameNew">巴拉奥纳玛丽亚·蒙特兹国际机场</span><span class="airportCode">BRX</span></li><li><span class="cityName">巴西利亚</span><span class="planeNameNew">巴西利亚国际机场</span><span class="airportCode">BSB</span></li><li><span class="cityName">巴塞尔</span><span class="planeNameNew">巴塞尔-米卢斯-弗赖堡欧洲机场</span><span class="airportCode">BSL</span></li><li><span class="cityName">巴士拉</span><span class="planeNameNew">巴士拉国际机场</span><span class="airportCode">BSR</span></li><li><span class="cityName">巴淡岛</span><span class="planeNameNew">巴淡岛杭纳迪姆机场</span><span class="airportCode">BTH</span></li><li><span class="cityName">班达亚齐</span><span class="planeNameNew">班达亚齐国际机场</span><span class="airportCode">BTJ</span></li><li><span class="cityName">布拉茨克</span><span class="planeNameNew">布拉茨克机场</span><span class="airportCode">BTK</span></li><li><span class="cityName">比尤特</span><span class="planeNameNew">比尤特伯特穆尼机场</span><span class="airportCode">BTM</span></li><li><span class="cityName">巴吞鲁日</span><span class="planeNameNew">巴吞鲁日机场</span><span class="airportCode">BTR</span></li><li><span class="cityName">布拉迪斯拉发</span><span class="planeNameNew">布拉迪斯拉发机场</span><span class="airportCode">BTS</span></li><li><span class="cityName">柏林顿</span><span class="planeNameNew">柏林顿国际机场</span><span class="airportCode">BTV</span></li><li><span class="cityName">布达佩斯</span><span class="planeNameNew">布达佩斯李斯特·费伦茨国际机场</span><span class="airportCode">BUD</span></li><li><span class="cityName">博阿维斯塔</span><span class="planeNameNew">博阿维斯塔阿里斯蒂德·佩雷拉国际机场</span><span class="airportCode">BVC</span></li><li><span class="cityName">贝弗利</span><span class="planeNameNew">贝弗利机场</span><span class="airportCode">BVY</span></li><li><span class="cityName">巴尔的摩</span><span class="planeNameNew">巴尔的摩-华盛顿国际机场</span><span class="airportCode">BWI</span></li><li><span class="cityName">博兹曼</span><span class="planeNameNew">博兹曼黄石国际机场</span><span class="airportCode">BZN</span></li><li><span class="cityName">布拉柴维尔</span><span class="planeNameNew">布拉柴维尔马亚机场</span><span class="airportCode">BZV</span></li><li><span class="cityName">巴黎</span><span class="planeNameNew">戴高乐机场</span><span class="airportCode">CDG</span></li><li><span class="cityName">布里奇波特</span><span class="planeNameNew">克拉克斯堡机场</span><span class="airportCode">CKB</span></li><li><span class="cityName">布拉索斯</span><span class="planeNameNew">伊斯特伍德机场</span><span class="airportCode">CLL</span></li><li><span class="cityName">贝洛奥里藏特</span><span class="planeNameNew">坦克雷多·内维斯国际机场</span><span class="airportCode">CNF</span></li><li><span class="cityName">巴厘岛</span><span class="planeNameNew">巴厘岛</span><span class="airportCode">DPS</span></li><li><span class="cityName">巴拿马城</span><span class="planeNameNew">巴拿马城西北佛罗里达海滩国际机场</span><span class="airportCode">ECP</span></li><li><span class="cityName">别尔哥罗德</span><span class="planeNameNew">别尔哥罗德国际机场</span><span class="airportCode">EGO</span></li><li><span class="cityName">布宜诺斯艾利斯</span><span class="planeNameNew">布宜诺斯艾利斯埃塞萨国际机场</span><span class="airportCode">EZE</span></li><li><span class="cityName">班顿杜</span><span class="planeNameNew">班顿杜机场</span><span class="airportCode">FDU</span></li><li><span class="cityName">比什凯克</span><span class="planeNameNew">比什凯克</span><span class="airportCode">FRU</span></li><li><span class="cityName">巴库</span><span class="planeNameNew">巴库盖达尔·阿利耶夫国际机场</span><span class="airportCode">GYD</span></li><li><span class="cityName">博格埃尔阿拉伯</span><span class="planeNameNew">亚历山大博格埃尔阿拉伯机场</span><span class="airportCode">HBE</span></li><li><span class="cityName">北九州</span><span class="planeNameNew">北九州</span><span class="airportCode">KKJ</span></li><li><span class="cityName">布尔歇</span><span class="planeNameNew">布尔歇机场</span><span class="airportCode">LBG</span></li><li><span class="cityName">布雷加港</span><span class="planeNameNew">布雷加港机场</span><span class="airportCode">LMQ</span></li><li><span class="cityName">北竿</span><span class="planeNameNew">马祖北竿机场</span><span class="airportCode">MFK</span></li><li><span class="cityName">波尔图</span><span class="planeNameNew">波尔图</span><span class="airportCode">OPO</span></li><li><span class="cityName">巴黎</span><span class="planeNameNew">巴黎－奥利机场</span><span class="airportCode">ORY</span></li><li><span class="cityName">布加勒斯特</span><span class="planeNameNew">布加勒斯特奥托佩尼国际机场</span><span class="airportCode">OTP</span></li><li><span class="cityName">巴黎</span><span class="planeNameNew">巴黎</span><span class="airportCode">PAR</span></li><li><span class="cityName">巴特那</span><span class="planeNameNew">巴特那</span><span class="airportCode">PAT</span></li><li><span class="cityName">巴东</span><span class="planeNameNew">达滨机场</span><span class="airportCode">PDG</span></li><li><span class="cityName">波特兰</span><span class="planeNameNew">波特兰</span><span class="airportCode">PDX</span></li><li><span class="cityName">槟城</span><span class="planeNameNew">槟城</span><span class="airportCode">PEN</span></li><li><span class="cityName">白沙瓦</span><span class="planeNameNew">白沙瓦机场</span><span class="airportCode">PEW</span></li><li><span class="cityName">彼得罗巴甫洛夫斯克</span><span class="planeNameNew">彼得罗巴甫洛夫斯克机场</span><span class="airportCode">PKC</span></li><li><span class="cityName">博卡拉</span><span class="planeNameNew">博卡拉机场</span><span class="airportCode">PKR</span></li><li><span class="cityName">北干巴鲁</span><span class="planeNameNew">北干巴鲁机场</span><span class="airportCode">PKU</span></li><li><span class="cityName">巴色</span><span class="planeNameNew">巴色机场</span><span class="airportCode">PKZ</span></li><li><span class="cityName">巴邻旁</span><span class="planeNameNew">巴邻旁</span><span class="airportCode">PLM</span></li><li><span class="cityName">贝洛奥里藏特</span><span class="planeNameNew">贝洛奥里藏特潘普利亚机场</span><span class="airportCode">PLU</span></li><li><span class="cityName">巴勒莫</span><span class="planeNameNew">巴勒莫机场</span><span class="airportCode">PMO</span></li><li><span class="cityName">波纳佩</span><span class="planeNameNew">波纳佩机场</span><span class="airportCode">PNI</span></li><li><span class="cityName">布拉格</span><span class="planeNameNew">布拉格</span><span class="airportCode">PRG</span></li><li><span class="cityName">比萨</span><span class="planeNameNew">比萨</span><span class="airportCode">PSA</span></li><li><span class="cityName">巴拿马城</span><span class="planeNameNew">巴拿马城托库门国际机场</span><span class="airportCode">PTY</span></li><li><span class="cityName">波城</span><span class="planeNameNew">波城机场</span><span class="airportCode">PUF</span></li><li><span class="cityName">波来古</span><span class="planeNameNew">波来古机场</span><span class="airportCode">PXU</span></li><li><span class="cityName">布尔巴赫</span><span class="planeNameNew">希根机场</span><span class="airportCode">SGE</span></li><li><span class="cityName">巴斯特尔</span><span class="planeNameNew">巴斯特尔罗伯特伯纳德肖机场</span><span class="airportCode">SKB</span></li><li><span class="cityName">柏林</span><span class="planeNameNew">柏林舍讷费尔德机场</span><span class="airportCode">SXF</span></li><li><span class="cityName">柏林</span><span class="planeNameNew">柏林滕珀尔霍夫机场</span><span class="airportCode">THF</span></li><li><span class="cityName">柏林</span><span class="planeNameNew">柏林泰格尔机场</span><span class="airportCode">TXL</span></li><li><span class="cityName">伯利兹</span><span class="planeNameNew">伯利兹城机场</span><span class="airportCode">TZA</span></li><li><span class="cityName">布桑加</span><span class="planeNameNew">布桑加机场</span><span class="airportCode">USU</span></li><li><span class="cityName">芭堤雅</span><span class="planeNameNew">乌打抛机场</span><span class="airportCode">UTP</span></li><li><span class="cityName">布雷西亚</span><span class="planeNameNew">布雷西亚机场</span><span class="airportCode">VBS</span></li><li><span class="cityName">巴伦西亚</span><span class="planeNameNew">巴伦西亚</span><span class="airportCode">VLC</span></li><li><span class="cityName">比亚埃尔莫萨</span><span class="planeNameNew">比亚埃尔莫萨机场</span><span class="airportCode">VSA</span></li><li><span class="cityName">贝科莫</span><span class="planeNameNew">贝科莫机场</span><span class="airportCode">YBC</span></li><li><span class="cityName">邦尼维尔</span><span class="planeNameNew">邦尼维尔机场</span><span class="airportCode">YBF</span></li><li><span class="cityName">贝克湖</span><span class="planeNameNew">贝克湖机场</span><span class="airportCode">YBK</span></li><li><span class="cityName">布兰登</span><span class="planeNameNew">布兰登机场</span><span class="airportCode">YBR</span></li><li><span class="cityName">贝伦斯里弗</span><span class="planeNameNew">贝伦斯里弗机场</span><span class="airportCode">YBV</span></li><li><span class="cityName">布朗萨布隆</span><span class="planeNameNew">布朗萨布隆机场</span><span class="airportCode">YBX</span></li><li><span class="cityName">波拉图克</span><span class="planeNameNew">波拉图克机场</span><span class="airportCode">YPC</span></li><li><span class="cityName">波蒂奇拉普大草原</span><span class="planeNameNew">波蒂奇拉普大草原机场</span><span class="airportCode">YPG</span></li><li><span class="cityName">彼得博勒</span><span class="planeNameNew">彼得博勒机场</span><span class="airportCode">YPQ</span></li><li><span class="cityName">鲍威尔河</span><span class="planeNameNew">鲍威尔河机场</span><span class="airportCode">YPW</span></li><li><span class="cityName">北湾</span><span class="planeNameNew">北湾机场</span><span class="airportCode">YYB</span></li><li><span class="cityName">巴瑟斯特</span><span class="planeNameNew">巴瑟斯特机场</span><span class="airportCode">ZBF</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">C</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">承德</span><span class="planeNameNew">承德机场</span><span class="airportCode">CEH</span></li><li><span class="cityName">查塔努加都会</span><span class="planeNameNew">查塔努加机场</span><span class="airportCode">CHA</span></li><li><span class="cityName">查尔斯顿</span><span class="planeNameNew">查尔斯顿国际机场</span><span class="airportCode">CHS</span></li><li><span class="cityName">春蓬</span><span class="planeNameNew">春蓬机场</span><span class="airportCode">CJM</span></li><li><span class="cityName">查亚普拉</span><span class="planeNameNew">查亚普拉仙谷机场</span><span class="airportCode">DJJ</span></li><li><span class="cityName">赤塔</span><span class="planeNameNew">赤塔卡达拉机场</span><span class="airportCode">HTA</span></li><li><span class="cityName">茨城</span><span class="planeNameNew">茨城机场</span><span class="airportCode">IBR</span></li><li><span class="cityName">冲绳</span><span class="planeNameNew">石垣机场</span><span class="airportCode">ISG</span></li><li><span class="cityName">昌迪加尔</span><span class="planeNameNew">昌迪加尔</span><span class="airportCode">IXC</span></li><li><span class="cityName">钏路</span><span class="planeNameNew">钏路机场</span><span class="airportCode">KUH</span></li><li><span class="cityName">冲绳</span><span class="planeNameNew">冲绳</span><span class="airportCode">OKA</span></li><li><span class="cityName">茨林</span><span class="planeNameNew">茨林机场</span><span class="airportCode">YZW</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">D</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">大西洋城</span><span class="planeNameNew">大西洋城国际机场</span><span class="airportCode">ACY</span></li><li><span class="cityName">达卡</span><span class="planeNameNew">达卡</span><span class="airportCode">DAC</span></li><li><span class="cityName">达拉斯</span><span class="planeNameNew">达拉斯拉夫菲尔德机场</span><span class="airportCode">DAL</span></li><li><span class="cityName">大马士革</span><span class="planeNameNew">大马士革国际机场</span><span class="airportCode">DAM</span></li><li><span class="cityName">达累斯萨拉姆</span><span class="planeNameNew">达累斯萨拉姆</span><span class="airportCode">DAR</span></li><li><span class="cityName">代顿</span><span class="planeNameNew">代顿国际机场</span><span class="airportCode">DAY</span></li><li><span class="cityName">达博</span><span class="planeNameNew">达博城市地区机场</span><span class="airportCode">DBO</span></li><li><span class="cityName">迪比克</span><span class="planeNameNew">迪比克地区机场</span><span class="airportCode">DBQ</span></li><li><span class="cityName">杜布罗夫尼克</span><span class="planeNameNew">杜布罗夫尼克机场</span><span class="airportCode">DBV</span></li><li><span class="cityName">德里</span><span class="planeNameNew">德里</span><span class="airportCode">DEL</span></li><li><span class="cityName">丹佛</span><span class="planeNameNew">丹佛</span><span class="airportCode">DEN</span></li><li><span class="cityName">达拉斯--奥斯堡</span><span class="planeNameNew">达拉斯--奥斯堡</span><span class="airportCode">DFW</span></li><li><span class="cityName">杜马格特</span><span class="planeNameNew">杜马格特机场</span><span class="airportCode">DGT</span></li><li><span class="cityName">多森</span><span class="planeNameNew">多森地区机场</span><span class="airportCode">DHN</span></li><li><span class="cityName">得雷达瓦</span><span class="planeNameNew">得雷达瓦国际机场</span><span class="airportCode">DIR</span></li><li><span class="cityName">达喀尔</span><span class="planeNameNew">达喀尔</span><span class="airportCode">DKR</span></li><li><span class="cityName">杜阿拉</span><span class="planeNameNew">杜阿拉</span><span class="airportCode">DLA</span></li><li><span class="cityName">大叻</span><span class="planeNameNew">大叻莲姜机场</span><span class="airportCode">DLI</span></li><li><span class="cityName">达拉曼</span><span class="planeNameNew">达拉曼机场</span><span class="airportCode">DLM</span></li><li><span class="cityName">达曼</span><span class="planeNameNew">达曼</span><span class="airportCode">DMM</span></li><li><span class="cityName">德尼兹利</span><span class="planeNameNew">德尼兹利机场</span><span class="airportCode">DNZ</span></li><li><span class="cityName">多哈</span><span class="planeNameNew">多哈</span><span class="airportCode">DOH</span></li><li><span class="cityName">顿涅茨克</span><span class="planeNameNew">顿涅茨克谢尔盖·普罗科菲耶夫国际机场</span><span class="airportCode">DOK</span></li><li><span class="cityName">德累斯顿</span><span class="planeNameNew">德累斯顿国际机场</span><span class="airportCode">DRS</span></li><li><span class="cityName">底特律</span><span class="planeNameNew">底特律</span><span class="airportCode">DTT</span></li><li><span class="cityName">底特律</span><span class="planeNameNew">底特律都会韦恩郡机场</span><span class="airportCode">DTW</span></li><li><span class="cityName">都柏林</span><span class="planeNameNew">都柏林</span><span class="airportCode">DUB</span></li><li><span class="cityName">旦尼丁</span><span class="planeNameNew">旦尼丁</span><span class="airportCode">DUD</span></li><li><span class="cityName">德班</span><span class="planeNameNew">德班</span><span class="airportCode">DUR</span></li><li><span class="cityName">杜塞尔多夫</span><span class="planeNameNew">杜塞尔多夫</span><span class="airportCode">DUS</span></li><li><span class="cityName">达沃</span><span class="planeNameNew">达沃国际机场</span><span class="airportCode">DVO</span></li><li><span class="cityName">迪拜</span><span class="planeNameNew">迪拜阿勒马克图姆国际机场</span><span class="airportCode">DWC</span></li><li><span class="cityName">迪拜</span><span class="planeNameNew">迪拜</span><span class="airportCode">DXB</span></li><li><span class="cityName">杜尚别</span><span class="planeNameNew">杜尚别</span><span class="airportCode">DYU</span></li><li><span class="cityName">大本德</span><span class="planeNameNew">大本德市政机场</span><span class="airportCode">GBD</span></li><li><span class="cityName">大章克申</span><span class="planeNameNew">大章克申地区机场</span><span class="airportCode">GJT</span></li><li><span class="cityName">大急流城</span><span class="planeNameNew">大急流城杰拉尔德·福特国际机场</span><span class="airportCode">GRR</span></li><li><span class="cityName">德黑兰</span><span class="planeNameNew">德黑兰</span><span class="airportCode">IKA</span></li><li><span class="cityName">大阪伊丹</span><span class="planeNameNew">伊丹机场</span><span class="airportCode">ITM</span></li><li><span class="cityName">大阪</span><span class="planeNameNew">大阪</span><span class="airportCode">KIX</span></li><li><span class="cityName">大加那利岛</span><span class="planeNameNew">大加那利机场</span><span class="airportCode">LPA</span></li><li><span class="cityName">东京</span><span class="planeNameNew">东京</span><span class="airportCode">NRT</span></li><li><span class="cityName">带广</span><span class="planeNameNew">带广机场</span><span class="airportCode">OBO</span></li><li><span class="cityName">大分</span><span class="planeNameNew">大分机场</span><span class="airportCode">OIT</span></li><li><span class="cityName">多巴哥岛</span><span class="planeNameNew">多巴哥岛机场</span><span class="airportCode">TAB</span></li><li><span class="cityName">大邱</span><span class="planeNameNew">大邱</span><span class="airportCode">TAE</span></li><li><span class="cityName">第比利斯</span><span class="planeNameNew">第比利斯</span><span class="airportCode">TBS</span></li><li><span class="cityName">东加大埔</span><span class="planeNameNew">东加大埔</span><span class="airportCode">TBU</span></li><li><span class="cityName">达叻</span><span class="planeNameNew">达叻机场</span><span class="airportCode">TDX</span></li><li><span class="cityName">德黑兰</span><span class="planeNameNew">德黑兰机场</span><span class="airportCode">THR</span></li><li><span class="cityName">蒂华纳</span><span class="planeNameNew">蒂华纳-罗德里格斯机场</span><span class="airportCode">TIJ</span></li><li><span class="cityName">的黎波里</span><span class="planeNameNew">的黎波里机场</span><span class="airportCode">TIP</span></li><li><span class="cityName">德岛</span><span class="planeNameNew">德岛机场</span><span class="airportCode">TKS</span></li><li><span class="cityName">刁曼岛</span><span class="planeNameNew">刁曼岛机场</span><span class="airportCode">TOD</span></li><li><span class="cityName">的里雅斯特</span><span class="planeNameNew">的里雅斯特机场</span><span class="airportCode">TRS</span></li><li><span class="cityName">蒂鲁吉拉帕利</span><span class="planeNameNew">蒂鲁吉拉帕利机场</span><span class="airportCode">TRZ</span></li><li><span class="cityName">董里</span><span class="planeNameNew">董里机场</span><span class="airportCode">TST</span></li><li><span class="cityName">斗湖</span><span class="planeNameNew">斗湖机场</span><span class="airportCode">TWU</span></li><li><span class="cityName">道森</span><span class="planeNameNew">道森机场</span><span class="airportCode">YDA</span></li><li><span class="cityName">多芬</span><span class="planeNameNew">多芬机场</span><span class="airportCode">YDN</span></li><li><span class="cityName">德赖登</span><span class="planeNameNew">德赖登地区机场</span><span class="airportCode">YHD</span></li><li><span class="cityName">大特劳特湖</span><span class="planeNameNew">大特劳特湖机场</span><span class="airportCode">YTL</span></li><li><span class="cityName">多伦多</span><span class="planeNameNew">多伦多</span><span class="airportCode">YTO</span></li><li><span class="cityName">蒂明斯</span><span class="planeNameNew">蒂明斯机场</span><span class="airportCode">YTS</span></li><li><span class="cityName">多伦多</span><span class="planeNameNew">多伦多市中心机场</span><span class="airportCode">YTZ</span></li><li><span class="cityName">德瑞司</span><span class="planeNameNew">德瑞司机场</span><span class="airportCode">YXT</span></li><li><span class="cityName">多伦多</span><span class="planeNameNew">多伦多皮尔逊机场</span><span class="airportCode">YYZ</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">E</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">恩德培</span><span class="planeNameNew">恩德培</span><span class="airportCode">EBB</span></li><li><span class="cityName">恩贾梅纳</span><span class="planeNameNew">恩贾梅纳机场</span><span class="airportCode">NDJ</span></li><li><span class="cityName">恩多拉</span><span class="planeNameNew">恩多拉机场</span><span class="airportCode">NLA</span></li><li><span class="cityName">鄂木斯克</span><span class="planeNameNew">鄂木斯克机场</span><span class="airportCode">OMS</span></li><li><span class="cityName">厄尔顿</span><span class="planeNameNew">厄尔顿机场</span><span class="airportCode">YXR</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">F</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">菲尼克斯</span><span class="planeNameNew">凤凰城鹿谷机场</span><span class="airportCode">DVT</span></li><li><span class="cityName">法鲁</span><span class="planeNameNew">法鲁机场</span><span class="airportCode">FAO</span></li><li><span class="cityName">法戈</span><span class="planeNameNew">法戈赫克托国际机场</span><span class="airportCode">FAR</span></li><li><span class="cityName">弗雷斯诺</span><span class="planeNameNew">弗雷斯诺约塞米蒂国际机场</span><span class="airportCode">FAT</span></li><li><span class="cityName">福岛</span><span class="planeNameNew">福岛</span><span class="airportCode">FKS</span></li><li><span class="cityName">弗卢里亚诺波利斯</span><span class="planeNameNew">弗卢里亚诺波利斯-埃尔西利·乌鲁兹国际机场</span><span class="airportCode">FLN</span></li><li><span class="cityName">弗里敦</span><span class="planeNameNew">弗里敦隆吉国际机场</span><span class="airportCode">FNA</span></li><li><span class="cityName">法兰克福</span><span class="planeNameNew">法兰克福</span><span class="airportCode">FRA</span></li><li><span class="cityName">福冈</span><span class="planeNameNew">福冈</span><span class="airportCode">FUK</span></li><li><span class="cityName">富蕴</span><span class="planeNameNew">富蕴可可托海机场</span><span class="airportCode">FYN</span></li><li><span class="cityName">费耶特维尔</span><span class="planeNameNew">费耶特维尔执行机场</span><span class="airportCode">FYV</span></li><li><span class="cityName">法兰克福</span><span class="planeNameNew">法兰克福-哈恩机场</span><span class="airportCode">HHN</span></li><li><span class="cityName">复活节岛</span><span class="planeNameNew">复活节岛马塔维里机场</span><span class="airportCode">IPC</span></li><li><span class="cityName">费城</span><span class="planeNameNew">费城</span><span class="airportCode">PHL</span></li><li><span class="cityName">菲尼克斯</span><span class="planeNameNew">菲尼克斯天港国际机场</span><span class="airportCode">PHX</span></li><li><span class="cityName">富国岛</span><span class="planeNameNew">富国国际机场</span><span class="airportCode">PQC</span></li><li><span class="cityName">釜山</span><span class="planeNameNew">釜山</span><span class="airportCode">PUS</span></li><li><span class="cityName">富山</span><span class="planeNameNew">富山</span><span class="airportCode">TOY</span></li><li><span class="cityName">符拉迪沃斯托克</span><span class="planeNameNew">符拉迪沃斯托克</span><span class="airportCode">VVO</span></li><li><span class="cityName">弗罗莰瓦夫</span><span class="planeNameNew">弗罗莰瓦夫机场</span><span class="airportCode">WRO</span></li><li><span class="cityName">费耶特维尔西北</span><span class="planeNameNew">费耶特维尔-阿肯色州西北地区机场</span><span class="airportCode">XNA</span></li><li><span class="cityName">弗朗西斯堡</span><span class="planeNameNew">弗朗西斯堡机场</span><span class="airportCode">YAG</span></li><li><span class="cityName">弗雷德里克顿</span><span class="planeNameNew">弗雷德里克顿国际机场</span><span class="airportCode">YFC</span></li><li><span class="cityName">福特雷索卢申</span><span class="planeNameNew">福特雷索卢申机场</span><span class="airportCode">YFR</span></li><li><span class="cityName">福特奇佩恩</span><span class="planeNameNew">福特奇佩恩机场</span><span class="airportCode">YPY</span></li><li><span class="cityName">福特圣约翰</span><span class="planeNameNew">福特圣约翰机场</span><span class="airportCode">YXJ</span></li>
						</ul>
					</div>
				</div>
			</div>
			<div id="con_two_3" style="display:none;">
				<div class="zimuBox">
					<div class="shouzimu">G</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">哥打基纳巴卢</span><span class="planeNameNew">哥打基纳巴卢</span><span class="airportCode">BKI</span></li><li><span class="cityName">哥伦比亚</span><span class="planeNameNew">哥伦比亚国际机场</span><span class="airportCode">CAE</span></li><li><span class="cityName">哥伦布</span><span class="planeNameNew">哥伦布</span><span class="airportCode">CMH</span></li><li><span class="cityName">哥本哈根</span><span class="planeNameNew">哥本哈根</span><span class="airportCode">CPH</span></li><li><span class="cityName">哥伦布</span><span class="planeNameNew">哥伦布机场</span><span class="airportCode">CSG</span></li><li><span class="cityName">甘岛</span><span class="planeNameNew">甘岛国际机场</span><span class="airportCode">GAN</span></li><li><span class="cityName">根西岛</span><span class="planeNameNew">根西岛机场</span><span class="airportCode">GCI</span></li><li><span class="cityName">瓜达拉哈拉</span><span class="planeNameNew">瓜达拉哈拉国际机场</span><span class="airportCode">GDL</span></li><li><span class="cityName">格连吉克</span><span class="planeNameNew">格连吉克机场</span><span class="airportCode">GDZ</span></li><li><span class="cityName">盖尔达耶</span><span class="planeNameNew">盖尔达耶努迈拉特国际机场</span><span class="airportCode">GHA</span></li><li><span class="cityName">格拉斯哥</span><span class="planeNameNew">格拉斯哥</span><span class="airportCode">GLA</span></li><li><span class="cityName">格洛斯特</span><span class="planeNameNew">格洛斯特郡机场</span><span class="airportCode">GLO</span></li><li><span class="cityName">格拉德斯通</span><span class="planeNameNew">格拉德斯通</span><span class="airportCode">GLT</span></li><li><span class="cityName">戈梅尔</span><span class="planeNameNew">戈梅尔机场</span><span class="airportCode">GME</span></li><li><span class="cityName">格罗德诺</span><span class="planeNameNew">格罗德诺机场</span><span class="airportCode">GNA</span></li><li><span class="cityName">盖恩斯维尔</span><span class="planeNameNew">盖恩斯维尔地区机场</span><span class="airportCode">GNV</span></li><li><span class="cityName">果阿</span><span class="planeNameNew">果阿国际机场</span><span class="airportCode">GOI</span></li><li><span class="cityName">歌德堡</span><span class="planeNameNew">歌德堡</span><span class="airportCode">GOT</span></li><li><span class="cityName">戈夫</span><span class="planeNameNew">戈夫机场</span><span class="airportCode">GOV</span></li><li><span class="cityName">格尔夫波特</span><span class="planeNameNew">格尔夫波特-比洛克西国际机场</span><span class="airportCode">GPT</span></li><li><span class="cityName">格拉纳达</span><span class="planeNameNew">格拉纳达机场</span><span class="airportCode">GRX</span></li><li><span class="cityName">格拉茨</span><span class="planeNameNew">格拉茨机场</span><span class="airportCode">GRZ</span></li><li><span class="cityName">格林斯伯勒</span><span class="planeNameNew">格林斯伯勒机场</span><span class="airportCode">GSO</span></li><li><span class="cityName">格林维尔</span><span class="planeNameNew">格林维尔-斯帕坦堡国际机场</span><span class="airportCode">GSP</span></li><li><span class="cityName">关岛</span><span class="planeNameNew">关岛</span><span class="airportCode">GUM</span></li><li><span class="cityName">广岛</span><span class="planeNameNew">广岛</span><span class="airportCode">HIJ</span></li><li><span class="cityName">哥打巴鲁</span><span class="planeNameNew">哥打巴鲁</span><span class="airportCode">KBR</span></li><li><span class="cityName">古晋</span><span class="planeNameNew">古晋</span><span class="airportCode">KCH</span></li><li><span class="cityName">高知</span><span class="planeNameNew">高知机场</span><span class="airportCode">KCZ</span></li><li><span class="cityName">高雄</span><span class="planeNameNew">高雄国际机场</span><span class="airportCode">KHH</span></li><li><span class="cityName">宫崎</span><span class="planeNameNew">宫崎机场</span><span class="airportCode">KMI</span></li><li><span class="cityName">古邦</span><span class="planeNameNew">古邦机场</span><span class="airportCode">KOE</span></li><li><span class="cityName">关丹</span><span class="planeNameNew">关丹</span><span class="airportCode">KUA</span></li><li><span class="cityName">光州</span><span class="planeNameNew">光州</span><span class="airportCode">KWJ</span></li><li><span class="cityName">光州</span><span class="planeNameNew">光州务安机场</span><span class="airportCode">MWX</span></li><li><span class="cityName">冈山</span><span class="planeNameNew">冈山机场</span><span class="airportCode">OKJ</span></li><li><span class="cityName">格拉斯哥</span><span class="planeNameNew">格拉斯哥普雷斯蒂克机场</span><span class="airportCode">PIK</span></li><li><span class="cityName">高松</span><span class="planeNameNew">高松机场</span><span class="airportCode">TAK</span></li><li><span class="cityName">瓜拉丁加奴</span><span class="planeNameNew">瓜拉丁加奴</span><span class="airportCode">TGG</span></li><li><span class="cityName">归仁</span><span class="planeNameNew">归仁富吉机场</span><span class="airportCode">UIH</span></li><li><span class="cityName">古斯贝</span><span class="planeNameNew">古斯贝机场</span><span class="airportCode">YYR</span></li><li><span class="cityName">格林伍德</span><span class="planeNameNew">格林伍德机场</span><span class="airportCode">YZX</span></li><li><span class="cityName">戈兹里弗</span><span class="planeNameNew">戈兹里弗机场</span><span class="airportCode">ZGI</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">H</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">滑铁卢</span><span class="planeNameNew">滑铁卢地区机场</span><span class="airportCode">ALO</span></li><li><span class="cityName">哈特福德</span><span class="planeNameNew">哈特福德</span><span class="airportCode">BDL</span></li><li><span class="cityName">华雷斯</span><span class="planeNameNew">华雷斯亚伯拉罕·冈萨雷斯国际机场</span><span class="airportCode">CJS</span></li><li><span class="cityName">汉考克</span><span class="planeNameNew">汉考克霍顿郡纪念机场</span><span class="airportCode">CMX</span></li><li><span class="cityName">华盛顿</span><span class="planeNameNew">罗纳德·里根机场</span><span class="airportCode">DCA</span></li><li><span class="cityName">哈博罗内</span><span class="planeNameNew">哈博罗内机场</span><span class="airportCode">GBE</span></li><li><span class="cityName">汉诺威</span><span class="planeNameNew">汉诺威-朗根哈根机场</span><span class="airportCode">HAJ</span></li><li><span class="cityName">汉堡</span><span class="planeNameNew">汉堡</span><span class="airportCode">HAM</span></li><li><span class="cityName">河内</span><span class="planeNameNew">河内</span><span class="airportCode">HAN</span></li><li><span class="cityName">海于格松</span><span class="planeNameNew">海于格松机场</span><span class="airportCode">HAU</span></li><li><span class="cityName">哈瓦那</span><span class="planeNameNew">哈瓦那何塞·马蒂国际机场</span><span class="airportCode">HAV</span></li><li><span class="cityName">霍巴特</span><span class="planeNameNew">霍巴特</span><span class="airportCode">HBA</span></li><li><span class="cityName">赫林斯多夫</span><span class="planeNameNew">赫林斯多夫机场</span><span class="airportCode">HDF</span></li><li><span class="cityName">合艾</span><span class="planeNameNew">合艾国际机场</span><span class="airportCode">HDY</span></li><li><span class="cityName">海霍</span><span class="planeNameNew">海霍机场</span><span class="airportCode">HEH</span></li><li><span class="cityName">赫尔辛基</span><span class="planeNameNew">赫尔辛基</span><span class="airportCode">HEL</span></li><li><span class="cityName">华欣</span><span class="planeNameNew">华欣机场</span><span class="airportCode">HHQ</span></li><li><span class="cityName">霍恩岛</span><span class="planeNameNew">霍恩岛机场</span><span class="airportCode">HID</span></li><li><span class="cityName">函馆</span><span class="planeNameNew">函馆机场</span><span class="airportCode">HKD</span></li><li><span class="cityName">哈密尔顿</span><span class="planeNameNew">哈密尔顿</span><span class="airportCode">HLZ</span></li><li><span class="cityName">哈西迈萨乌德</span><span class="planeNameNew">哈西迈萨乌德瓦迪伊拉拉机场</span><span class="airportCode">HME</span></li><li><span class="cityName">火奴鲁鲁</span><span class="planeNameNew">火奴鲁鲁</span><span class="airportCode">HNL</span></li><li><span class="cityName">亨德森</span><span class="planeNameNew">亨德森-牛津机场</span><span class="airportCode">HNZ</span></li><li><span class="cityName">海防</span><span class="planeNameNew">海防吉碑国际机场</span><span class="airportCode">HPH</span></li><li><span class="cityName">哈拉雷</span><span class="planeNameNew">哈拉雷</span><span class="airportCode">HRE</span></li><li><span class="cityName">赫尔格达</span><span class="planeNameNew">赫尔格达国际机场</span><span class="airportCode">HRG</span></li><li><span class="cityName">汉班托塔</span><span class="planeNameNew">汉班托塔机场</span><span class="airportCode">HRI</span></li><li><span class="cityName">哈尔科夫</span><span class="planeNameNew">哈尔科夫国际机场</span><span class="airportCode">HRK</span></li><li><span class="cityName">亨茨维尔</span><span class="planeNameNew">亨茨维尔国际机场</span><span class="airportCode">HSV</span></li><li><span class="cityName">汉密尔顿岛</span><span class="planeNameNew">汉密尔顿岛</span><span class="airportCode">HTI</span></li><li><span class="cityName">花莲</span><span class="planeNameNew">花莲机场</span><span class="airportCode">HUN</span></li><li><span class="cityName">海得拉巴</span><span class="planeNameNew">海得拉巴</span><span class="airportCode">HYD</span></li><li><span class="cityName">海斯</span><span class="planeNameNew">海斯地区机场</span><span class="airportCode">HYS</span></li><li><span class="cityName">华盛顿</span><span class="planeNameNew">华盛顿杜勒斯机场</span><span class="airportCode">IAD</span></li><li><span class="cityName">胡利亚卡</span><span class="planeNameNew">胡利亚卡机场</span><span class="airportCode">JUL</span></li><li><span class="cityName">哈巴罗夫斯克市</span><span class="planeNameNew">哈巴罗夫斯克市</span><span class="airportCode">KHV</span></li><li><span class="cityName">胡占德</span><span class="planeNameNew">胡占德</span><span class="airportCode">LBD</span></li><li><span class="cityName">黄金海岸</span><span class="planeNameNew">黄金海岸</span><span class="airportCode">OOL</span></li><li><span class="cityName">哈科特港</span><span class="planeNameNew">哈科特港</span><span class="airportCode">PHC</span></li><li><span class="cityName">黑德兰港</span><span class="planeNameNew">黑德兰港机场</span><span class="airportCode">PHE</span></li><li><span class="cityName">胡志明市</span><span class="planeNameNew">胡志明市</span><span class="airportCode">SGN</span></li><li><span class="cityName">华盛顿</span><span class="planeNameNew">华盛顿</span><span class="airportCode">WAS</span></li><li><span class="cityName">华沙</span><span class="planeNameNew">华沙</span><span class="airportCode">WAW</span></li><li><span class="cityName">惠灵顿</span><span class="planeNameNew">惠灵顿</span><span class="airportCode">WLG</span></li><li><span class="cityName">汉堡</span><span class="planeNameNew">汉堡温肯维德机场</span><span class="airportCode">XFW</span></li><li><span class="cityName">哈佛圣皮埃尔</span><span class="planeNameNew">哈佛圣皮埃尔机场</span><span class="airportCode">YGV</span></li><li><span class="cityName">霍普</span><span class="planeNameNew">霍普机场</span><span class="airportCode">YHE</span></li><li><span class="cityName">哈密尔顿</span><span class="planeNameNew">约翰·卡尔·芒罗哈密尔顿国际机场</span><span class="airportCode">YHM</span></li><li><span class="cityName">哈利法克斯</span><span class="planeNameNew">哈利法克斯罗伯特·洛恩·斯坦菲尔德国际机场</span><span class="airportCode">YHZ</span></li><li><span class="cityName">滑铁卢</span><span class="planeNameNew">滑铁卢区域国际机场</span><span class="airportCode">YKF</span></li><li><span class="cityName">韩国襄阳</span><span class="planeNameNew">韩国襄阳机场</span><span class="airportCode">YNY</span></li><li><span class="cityName">和平河</span><span class="planeNameNew">和平河机场</span><span class="airportCode">YPE</span></li><li><span class="cityName">霍尔海滩</span><span class="planeNameNew">霍尔海滩机场</span><span class="airportCode">YUX</span></li><li><span class="cityName">惠尔科夫</span><span class="planeNameNew">惠尔科夫机场</span><span class="airportCode">YXN</span></li><li><span class="cityName">怀特霍斯</span><span class="planeNameNew">埃里克·尼尔森怀特霍斯机场</span><span class="airportCode">YXY</span></li><li><span class="cityName">哈迪港</span><span class="planeNameNew">哈迪港机场</span><span class="airportCode">YZT</span></li><li><span class="cityName">怀特科特</span><span class="planeNameNew">怀特科特机场</span><span class="airportCode">YZU</span></li><li><span class="cityName">皇后镇</span><span class="planeNameNew">皇后镇机场</span><span class="airportCode">ZQN</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">I</div>
					<div class="nameBoxDiv">
						<ul></ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">J</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">加利福尼亚州</span><span class="planeNameNew">阿克塔机场</span><span class="airportCode">ACV</span></li><li><span class="cityName">加拉加斯</span><span class="planeNameNew">加拉加斯西蒙·玻利瓦尔国际机场</span><span class="airportCode">CCS</span></li><li><span class="cityName">加尔各答</span><span class="planeNameNew">加尔各答</span><span class="airportCode">CCU</span></li><li><span class="cityName">车里雅宾斯克</span><span class="planeNameNew">车里雅宾斯克机场</span><span class="airportCode">CEK</span></li><li><span class="cityName">吉大港</span><span class="planeNameNew">吉大港机场</span><span class="airportCode">CGP</span></li><li><span class="cityName">基督城</span><span class="planeNameNew">基督城</span><span class="airportCode">CHC</span></li><li><span class="cityName">酒泉</span><span class="planeNameNew">酒泉机场</span><span class="airportCode">CHW</span></li><li><span class="cityName">济州</span><span class="planeNameNew">济州</span><span class="airportCode">CJU</span></li><li><span class="cityName">加的夫</span><span class="planeNameNew">加的夫机场</span><span class="airportCode">CWL</span></li><li><span class="cityName">嘉义</span><span class="planeNameNew">嘉义机场</span><span class="airportCode">CYI</span></li><li><span class="cityName">杰尔巴</span><span class="planeNameNew">杰尔巴-杰尔吉斯国际机场</span><span class="airportCode">DJE</span></li><li><span class="cityName">基韦斯特</span><span class="planeNameNew">基韦斯特国际机场</span><span class="airportCode">EYW</span></li><li><span class="cityName">金沙萨</span><span class="planeNameNew">金沙萨</span><span class="airportCode">FIH</span></li><li><span class="cityName">加贝斯</span><span class="planeNameNew">加贝斯-马特马他国际机场</span><span class="airportCode">GAE</span></li><li><span class="cityName">加夫萨</span><span class="planeNameNew">加夫萨国际机场</span><span class="airportCode">GAF</span></li><li><span class="cityName">杰拉尔顿</span><span class="planeNameNew">杰拉尔顿机场</span><span class="airportCode">GET</span></li><li><span class="cityName">捷克逊维尔</span><span class="planeNameNew">捷克逊维尔</span><span class="airportCode">JAX</span></li><li><span class="cityName">焦达普尔</span><span class="planeNameNew">焦达普尔机场</span><span class="airportCode">JDH</span></li><li><span class="cityName">吉达</span><span class="planeNameNew">吉达</span><span class="airportCode">JED</span></li><li><span class="cityName">吉布提</span><span class="planeNameNew">吉布提</span><span class="airportCode">JIB</span></li><li><span class="cityName">贾巴尔普尔</span><span class="planeNameNew">贾巴尔普尔</span><span class="airportCode">JLR</span></li><li><span class="cityName">基辅</span><span class="planeNameNew">基辅</span><span class="airportCode">KBP</span></li><li><span class="cityName">甲米</span><span class="planeNameNew">甲米机场</span><span class="airportCode">KBV</span></li><li><span class="cityName">佳特土</span><span class="planeNameNew">佳特土机场</span><span class="airportCode">KDM</span></li><li><span class="cityName">加途</span><span class="planeNameNew">加途机场</span><span class="airportCode">KDO</span></li><li><span class="cityName">基尔</span><span class="planeNameNew">基尔机场</span><span class="airportCode">KEL</span></li><li><span class="cityName">加里宁格勒</span><span class="planeNameNew">加里宁格勒机场</span><span class="airportCode">KGD</span></li><li><span class="cityName">基加利</span><span class="planeNameNew">基加利</span><span class="airportCode">KGL</span></li><li><span class="cityName">金斯敦</span><span class="planeNameNew">金斯敦诺曼·曼利国际机场</span><span class="airportCode">KIN</span></li><li><span class="cityName">金门</span><span class="planeNameNew">金门</span><span class="airportCode">KNH</span></li><li><span class="cityName">加德满都</span><span class="planeNameNew">加德满都</span><span class="airportCode">KTM</span></li><li><span class="cityName">吉隆坡</span><span class="planeNameNew">吉隆坡</span><span class="airportCode">KUL</span></li><li><span class="cityName">金奈</span><span class="planeNameNew">金奈</span><span class="airportCode">MAA</span></li><li><span class="cityName">金边</span><span class="planeNameNew">金边</span><span class="airportCode">PNH</span></li><li><span class="cityName">旧金山</span><span class="planeNameNew">旧金山</span><span class="airportCode">SFO</span></li><li><span class="cityName">吉隆坡</span><span class="planeNameNew">吉隆坡苏丹阿卜杜勒·阿齐兹·沙阿机场</span><span class="airportCode">SZB</span></li><li><span class="cityName">基多</span><span class="planeNameNew">基多机场</span><span class="airportCode">UIO</span></li><li><span class="cityName">基永加</span><span class="planeNameNew">基永加机场</span><span class="airportCode">UNG</span></li><li><span class="cityName">剑桥湾</span><span class="planeNameNew">剑桥湾机场</span><span class="airportCode">YCB</span></li><li><span class="cityName">加斯佩</span><span class="planeNameNew">加斯佩机场</span><span class="airportCode">YGP</span></li><li><span class="cityName">杰拉尔顿</span><span class="planeNameNew">杰拉尔顿机场</span><span class="airportCode">YGQ</span></li><li><span class="cityName">吉拉木</span><span class="planeNameNew">吉拉木机场</span><span class="airportCode">YGX</span></li><li><span class="cityName">今米鲁特</span><span class="planeNameNew">今米鲁特机场</span><span class="airportCode">YLC</span></li><li><span class="cityName">基隆拿</span><span class="planeNameNew">基隆拿</span><span class="airportCode">YLW</span></li><li><span class="cityName">加蒂诺</span><span class="planeNameNew">加蒂诺-渥太华行政机场</span><span class="airportCode">YND</span></li><li><span class="cityName">津德尔</span><span class="planeNameNew">津德尔机场</span><span class="airportCode">ZND</span></li>
						</ul>
					</div>
				</div>
			</div>
			<div id="con_two_4" style="display:none;">
				<div class="zimuBox">
					<div class="shouzimu">K</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">开塞利</span><span class="planeNameNew">开塞利机场</span><span class="airportCode">ASR</span></li><li><span class="cityName">克利夫兰</span><span class="planeNameNew">克利夫兰伯克湖滨机场</span><span class="airportCode">BKL</span></li><li><span class="cityName">开罗</span><span class="planeNameNew">开罗</span><span class="airportCode">CAI</span></li><li><span class="cityName">坎贝尔镇</span><span class="planeNameNew">坎贝尔镇机场</span><span class="airportCode">CAL</span></li><li><span class="cityName">科恰班巴</span><span class="planeNameNew">科恰班巴乔治·维尔斯特曼国际机场</span><span class="airportCode">CBB</span></li><li><span class="cityName">堪培拉</span><span class="planeNameNew">堪培拉</span><span class="airportCode">CBR</span></li><li><span class="cityName">科科斯岛</span><span class="planeNameNew">科科斯岛机场</span><span class="airportCode">CCK</span></li><li><span class="cityName">克雷斯特维</span><span class="planeNameNew">克雷斯特维鲍勃赛克斯机场</span><span class="airportCode">CEW</span></li><li><span class="cityName">克莱蒙费朗</span><span class="planeNameNew">克莱蒙费朗奥弗涅机场</span><span class="airportCode">CFE</span></li><li><span class="cityName">克基拉岛</span><span class="planeNameNew">克基拉岛国际机场</span><span class="airportCode">CFU</span></li><li><span class="cityName">库亚巴</span><span class="planeNameNew">库亚巴马歇尔·龙东国际机场</span><span class="airportCode">CGB</span></li><li><span class="cityName">开普吉拉多</span><span class="planeNameNew">开普吉拉多地区机场</span><span class="airportCode">CGI</span></li><li><span class="cityName">科隆</span><span class="planeNameNew">科隆</span><span class="airportCode">CGN</span></li><li><span class="cityName">科纳克里</span><span class="planeNameNew">科纳克里国际机场</span><span class="airportCode">CKY</span></li><li><span class="cityName">克利夫兰</span><span class="planeNameNew">克利夫兰</span><span class="airportCode">CLE</span></li><li><span class="cityName">科利马</span><span class="planeNameNew">科利马机场</span><span class="airportCode">CLQ</span></li><li><span class="cityName">科伦坡</span><span class="planeNameNew">科伦坡</span><span class="airportCode">CMB</span></li><li><span class="cityName">凯恩斯</span><span class="planeNameNew">凯恩斯</span><span class="airportCode">CNS</span></li><li><span class="cityName">科钦</span><span class="planeNameNew">科钦国际机场</span><span class="airportCode">COK</span></li><li><span class="cityName">科托努</span><span class="planeNameNew">科托努</span><span class="airportCode">COO</span></li><li><span class="cityName">科罗拉多斯普林斯</span><span class="planeNameNew">科罗拉多斯普林斯机场</span><span class="airportCode">COS</span></li><li><span class="cityName">坎佩切</span><span class="planeNameNew">坎佩切国际机场</span><span class="airportCode">CPE</span></li><li><span class="cityName">科比亚波</span><span class="planeNameNew">科比亚波机场</span><span class="airportCode">CPO</span></li><li><span class="cityName">开普敦</span><span class="planeNameNew">开普敦</span><span class="airportCode">CPT</span></li><li><span class="cityName">克拉克</span><span class="planeNameNew">克拉克</span><span class="airportCode">CRK</span></li><li><span class="cityName">科珀斯克里斯蒂</span><span class="planeNameNew">科珀斯克里斯蒂国际机场</span><span class="airportCode">CRP</span></li><li><span class="cityName">坎昆</span><span class="planeNameNew">坎昆国际机场</span><span class="airportCode">CUN</span></li><li><span class="cityName">库斯科</span><span class="planeNameNew">库斯科机场</span><span class="airportCode">CUZ</span></li><li><span class="cityName">魁那伐克</span><span class="planeNameNew">魁那伐克国际机场</span><span class="airportCode">CVJ</span></li><li><span class="cityName">库里蒂巴</span><span class="planeNameNew">库里蒂巴国际机场</span><span class="airportCode">CWB</span></li><li><span class="cityName">克林顿</span><span class="planeNameNew">爱荷华州克林顿市政机场</span><span class="airportCode">CWI</span></li><li><span class="cityName">康斯坦丁</span><span class="planeNameNew">康斯坦丁穆罕默德·布迪亚夫国际机场</span><span class="airportCode">CZL</span></li><li><span class="cityName">科苏梅尔</span><span class="planeNameNew">科苏梅尔国际机场</span><span class="airportCode">CZM</span></li><li><span class="cityName">Kooddoo</span><span class="planeNameNew">Kooddoo机场</span><span class="airportCode">GKK</span></li><li><span class="cityName">克久拉霍</span><span class="planeNameNew">克久拉霍机场</span><span class="airportCode">HJR</span></li><li><span class="cityName">喀布尔</span><span class="planeNameNew">喀布尔</span><span class="airportCode">KBL</span></li><li><span class="cityName">坎大哈</span><span class="planeNameNew">坎大哈机场</span><span class="airportCode">KDH</span></li><li><span class="cityName">肯达里</span><span class="planeNameNew">肯达里机场</span><span class="airportCode">KDI</span></li><li><span class="cityName">凯夫拉维克</span><span class="planeNameNew">凯夫拉维克国际机场</span><span class="airportCode">KEF</span></li><li><span class="cityName">克尔曼</span><span class="planeNameNew">克尔曼机场</span><span class="airportCode">KER</span></li><li><span class="cityName">克拉斯诺亚尔斯克</span><span class="planeNameNew">克拉斯诺亚尔斯克-叶米里亚诺瓦国际机场</span><span class="airportCode">KJA</span></li><li><span class="cityName">孔敬</span><span class="planeNameNew">孔敬机场</span><span class="airportCode">KKC</span></li><li><span class="cityName">库马西</span><span class="planeNameNew">库马西机场</span><span class="airportCode">KMS</span></li><li><span class="cityName">库努纳拉</span><span class="planeNameNew">库努纳拉机场</span><span class="airportCode">KNX</span></li><li><span class="cityName">科纳</span><span class="planeNameNew">科纳国际机场</span><span class="airportCode">KOA</span></li><li><span class="cityName">克拉科夫</span><span class="planeNameNew">克拉科夫</span><span class="airportCode">KRK</span></li><li><span class="cityName">克拉斯诺达</span><span class="planeNameNew">克拉斯诺达国际机场</span><span class="airportCode">KRR</span></li><li><span class="cityName">克里斯蒂安桑</span><span class="planeNameNew">克里斯蒂安桑机场</span><span class="airportCode">KRS</span></li><li><span class="cityName">喀土穆</span><span class="planeNameNew">喀土穆</span><span class="airportCode">KRT</span></li><li><span class="cityName">科希策</span><span class="planeNameNew">科希策国际机场</span><span class="airportCode">KSC</span></li><li><span class="cityName">凯瑟琳</span><span class="planeNameNew">凯瑟琳·廷德尔民用机场</span><span class="airportCode">KTR</span></li><li><span class="cityName">科威特</span><span class="planeNameNew">科威特</span><span class="airportCode">KWI</span></li><li><span class="cityName">喀山</span><span class="planeNameNew">喀山国际机场</span><span class="airportCode">KZN</span></li><li><span class="cityName">克孜勒奥尔达</span><span class="planeNameNew">克孜勒奥尔达机场</span><span class="airportCode">KZO</span></li><li><span class="cityName">克雷塔罗</span><span class="planeNameNew">克雷塔罗机场</span><span class="airportCode">QRO</span></li><li><span class="cityName">科罗尔</span><span class="planeNameNew">科罗尔罗曼·莫图国际机场</span><span class="airportCode">ROR</span></li><li><span class="cityName">昆岛</span><span class="planeNameNew">昆岛机场</span><span class="airportCode">VCS</span></li><li><span class="cityName">坎吉克斯瓦尔</span><span class="planeNameNew">坎吉克斯瓦尔机场</span><span class="airportCode">XGR</span></li><li><span class="cityName">坎贝尔</span><span class="planeNameNew">坎贝尔河机场</span><span class="airportCode">YBL</span></li><li><span class="cityName">库格卢克图克</span><span class="planeNameNew">库格卢克图克机场</span><span class="airportCode">YCO</span></li><li><span class="cityName">克莱德</span><span class="planeNameNew">克莱德河机场</span><span class="airportCode">YCY</span></li><li><span class="cityName">库朱阿拉普</span><span class="planeNameNew">库朱阿拉普机场</span><span class="airportCode">YGW</span></li><li><span class="cityName">凯恩岛</span><span class="planeNameNew">鲁珀特王子港机场</span><span class="airportCode">YPR</span></li><li><span class="cityName">凯诺拉</span><span class="planeNameNew">凯诺拉机场</span><span class="airportCode">YQK</span></li><li><span class="cityName">克内尔</span><span class="planeNameNew">克内尔机场</span><span class="airportCode">YQZ</span></li><li><span class="cityName">克兰布鲁克</span><span class="planeNameNew">克兰布鲁克加拿大落基山国际机场</span><span class="airportCode">YXC</span></li><li><span class="cityName">科勒尔港</span><span class="planeNameNew">科勒尔港机场</span><span class="airportCode">YZS</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">L</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">莱比锡</span><span class="planeNameNew">莱比锡阿尔滕堡机场</span><span class="airportCode">AOC</span></li><li><span class="cityName">罗马</span><span class="planeNameNew">罗马钱皮诺机场</span><span class="airportCode">CIA</span></li><li><span class="cityName">卢本巴希</span><span class="planeNameNew">卢本巴希机场</span><span class="airportCode">FBM</span></li><li><span class="cityName">罗马</span><span class="planeNameNew">菲乌米奇诺机场</span><span class="airportCode">FCO</span></li><li><span class="cityName">罗德岱堡</span><span class="planeNameNew">罗德岱堡</span><span class="airportCode">FLL</span></li><li><span class="cityName">里约热内卢</span><span class="planeNameNew">里约热内卢 加利昂机场</span><span class="airportCode">GIG</span></li><li><span class="cityName">列城</span><span class="planeNameNew">列城</span><span class="airportCode">IXL</span></li><li><span class="cityName">兰契</span><span class="planeNameNew">兰契</span><span class="airportCode">IXR</span></li><li><span class="cityName">鹿儿岛</span><span class="planeNameNew">鹿儿岛</span><span class="airportCode">KOJ</span></li><li><span class="cityName">罗安达</span><span class="planeNameNew">罗安达</span><span class="airportCode">LAD</span></li><li><span class="cityName">莱城</span><span class="planeNameNew">莱城机场</span><span class="airportCode">LAE</span></li><li><span class="cityName">拉瓦格</span><span class="planeNameNew">拉瓦格机场</span><span class="airportCode">LAO</span></li><li><span class="cityName">拉斯韦加斯</span><span class="planeNameNew">拉斯韦加斯</span><span class="airportCode">LAS</span></li><li><span class="cityName">洛杉矶</span><span class="planeNameNew">洛杉矶</span><span class="airportCode">LAX</span></li><li><span class="cityName">利伯维尔</span><span class="planeNameNew">利伯维尔</span><span class="airportCode">LBV</span></li><li><span class="cityName">拉纳卡</span><span class="planeNameNew">拉纳卡</span><span class="airportCode">LCA</span></li><li><span class="cityName">伦敦</span><span class="planeNameNew">伦敦城市机场</span><span class="airportCode">LCY</span></li><li><span class="cityName">隆德里纳</span><span class="planeNameNew">隆德里纳机场</span><span class="airportCode">LDB</span></li><li><span class="cityName">罗定</span><span class="planeNameNew">罗定机场</span><span class="airportCode">LDG</span></li><li><span class="cityName">利尔蒙斯</span><span class="planeNameNew">利尔蒙斯机场</span><span class="airportCode">LEA</span></li><li><span class="cityName">列宁格勒</span><span class="planeNameNew">列宁格勒</span><span class="airportCode">LED</span></li><li><span class="cityName">莱比锡</span><span class="planeNameNew">莱比锡哈雷机场</span><span class="airportCode">LEJ</span></li><li><span class="cityName">拉菲特</span><span class="planeNameNew">拉菲特机场</span><span class="airportCode">LFT</span></li><li><span class="cityName">洛美</span><span class="planeNameNew">纳辛贝·埃亚德马机场</span><span class="airportCode">LFW</span></li><li><span class="cityName">列日</span><span class="planeNameNew">列日机场</span><span class="airportCode">LGG</span></li><li><span class="cityName">兰卡威</span><span class="planeNameNew">兰卡威</span><span class="airportCode">LGK</span></li><li><span class="cityName">黎牙实比</span><span class="planeNameNew">黎牙实比机场</span><span class="airportCode">LGP</span></li><li><span class="cityName">伦敦</span><span class="planeNameNew">盖特威克机场</span><span class="airportCode">LGW</span></li><li><span class="cityName">拉合尔</span><span class="planeNameNew">拉合尔机场</span><span class="airportCode">LHE</span></li><li><span class="cityName">伦敦</span><span class="planeNameNew">伦敦</span><span class="airportCode">LHR</span></li><li><span class="cityName">里尔</span><span class="planeNameNew">里尔机场</span><span class="airportCode">LIL</span></li><li><span class="cityName">利马</span><span class="planeNameNew">利马</span><span class="airportCode">LIM</span></li><li><span class="cityName">里斯本</span><span class="planeNameNew">里斯本</span><span class="airportCode">LIS</span></li><li><span class="cityName">卢布尔亚那</span><span class="planeNameNew">卢布尔亚那</span><span class="airportCode">LJU</span></li><li><span class="cityName">勒克瑙</span><span class="planeNameNew">勒克瑙机场</span><span class="airportCode">LKO</span></li><li><span class="cityName">林肯</span><span class="planeNameNew">林肯机场</span><span class="airportCode">LNK</span></li><li><span class="cityName">拉奈</span><span class="planeNameNew">拉奈机场</span><span class="airportCode">LNY</span></li><li><span class="cityName">龙目岛</span><span class="planeNameNew">龙目岛机场</span><span class="airportCode">LOP</span></li><li><span class="cityName">拉各斯</span><span class="planeNameNew">拉各斯</span><span class="airportCode">LOS</span></li><li><span class="cityName">拉巴斯</span><span class="planeNameNew">EL ALTO机场</span><span class="airportCode">LPB</span></li><li><span class="cityName">林雪平</span><span class="planeNameNew">林雪平机场</span><span class="airportCode">LPI</span></li><li><span class="cityName">朗勃拉邦</span><span class="planeNameNew">朗勃拉邦机场</span><span class="airportCode">LPQ</span></li><li><span class="cityName">洛佩兹岛</span><span class="planeNameNew">洛佩兹岛机场</span><span class="airportCode">LPS</span></li><li><span class="cityName">洛斯安赫莱斯</span><span class="planeNameNew">洛斯安赫莱斯机场</span><span class="airportCode">LSQ</span></li><li><span class="cityName">朗塞斯顿</span><span class="planeNameNew">朗塞斯顿机场</span><span class="airportCode">LST</span></li><li><span class="cityName">利斯莫尔</span><span class="planeNameNew">利斯莫尔机场</span><span class="airportCode">LSY</span></li><li><span class="cityName">伦敦</span><span class="planeNameNew">伦敦卢顿机场</span><span class="airportCode">LTN</span></li><li><span class="cityName">卢卡拉</span><span class="planeNameNew">卢卡拉机场</span><span class="airportCode">LUA</span></li><li><span class="cityName">卢萨卡</span><span class="planeNameNew">卢萨卡</span><span class="airportCode">LUN</span></li><li><span class="cityName">卢武克</span><span class="planeNameNew">卢武克机场</span><span class="airportCode">LUW</span></li><li><span class="cityName">卢森堡</span><span class="planeNameNew">卢森堡</span><span class="airportCode">LUX</span></li><li><span class="cityName">利文斯通</span><span class="planeNameNew">利文斯通机场</span><span class="airportCode">LVI</span></li><li><span class="cityName">卢克索</span><span class="planeNameNew">卢克索机场</span><span class="airportCode">LXR</span></li><li><span class="cityName">里昂</span><span class="planeNameNew">里昂</span><span class="airportCode">LYS</span></li><li><span class="cityName">连江</span><span class="planeNameNew">南竿机场</span><span class="airportCode">LZN</span></li><li><span class="cityName">洛坤府</span><span class="planeNameNew">洛坤府机场</span><span class="airportCode">NST</span></li><li><span class="cityName">良乌</span><span class="planeNameNew">良乌机场</span><span class="airportCode">NYU</span></li><li><span class="cityName">洛杉矶</span><span class="planeNameNew">洛杉矶安大略机场</span><span class="airportCode">ONT</span></li><li><span class="cityName">拉夫哈</span><span class="planeNameNew">拉夫哈机场</span><span class="airportCode">RAH</span></li><li><span class="cityName">里贝朗普雷图</span><span class="planeNameNew">里贝朗普雷图机场</span><span class="airportCode">RAO</span></li><li><span class="cityName">拉皮德城</span><span class="planeNameNew">拉皮德城机场</span><span class="airportCode">RAP</span></li><li><span class="cityName">拉罗汤加</span><span class="planeNameNew">拉罗汤加</span><span class="airportCode">RAR</span></li><li><span class="cityName">拉巴特</span><span class="planeNameNew">拉巴特机场</span><span class="airportCode">RBA</span></li><li><span class="cityName">雷德蒙德</span><span class="planeNameNew">雷德蒙德机场</span><span class="airportCode">RDM</span></li><li><span class="cityName">罗利</span><span class="planeNameNew">罗利</span><span class="airportCode">RDU</span></li><li><span class="cityName">累西腓</span><span class="planeNameNew">累西腓瓜拉拉皮斯吉尔贝托·弗雷雷机场</span><span class="airportCode">REC</span></li><li><span class="cityName">雷焦卡拉布里亚</span><span class="planeNameNew">雷焦卡拉布里亚机场</span><span class="airportCode">REG</span></li><li><span class="cityName">里奥格兰德</span><span class="planeNameNew">里奥格兰德机场</span><span class="airportCode">RGA</span></li><li><span class="cityName">罗得岛</span><span class="planeNameNew">罗得岛迪亚戈拉斯机场</span><span class="airportCode">RHO</span></li><li><span class="cityName">里加</span><span class="planeNameNew">里加</span><span class="airportCode">RIX</span></li><li><span class="cityName">里雅恩姆卡拉</span><span class="planeNameNew">里雅恩姆卡拉</span><span class="airportCode">RIY</span></li><li><span class="cityName">雷克亚未克</span><span class="planeNameNew">雷克亚未克机场</span><span class="airportCode">RKV</span></li><li><span class="cityName">龙讷比</span><span class="planeNameNew">龙讷比机场</span><span class="airportCode">RNB</span></li><li><span class="cityName">雷诺</span><span class="planeNameNew">雷诺机场</span><span class="airportCode">RNO</span></li><li><span class="cityName">罗阿诺克</span><span class="planeNameNew">罗阿诺克机场</span><span class="airportCode">ROA</span></li><li><span class="cityName">罗切斯特</span><span class="planeNameNew">罗切斯特国际机场</span><span class="airportCode">ROC</span></li><li><span class="cityName">罗克汉普顿</span><span class="planeNameNew">罗克汉普顿</span><span class="airportCode">ROK</span></li><li><span class="cityName">罗马</span><span class="planeNameNew">罗马</span><span class="airportCode">ROM</span></li><li><span class="cityName">罗萨里奥</span><span class="planeNameNew">罗萨里奥机场</span><span class="airportCode">ROS</span></li><li><span class="cityName">罗斯托夫</span><span class="planeNameNew">罗斯托夫机场</span><span class="airportCode">ROV</span></li><li><span class="cityName">赖布尔</span><span class="planeNameNew">赖布尔</span><span class="airportCode">RPR</span></li><li><span class="cityName">勒罗斯</span><span class="planeNameNew">Roeros机场</span><span class="airportCode">RRS</span></li><li><span class="cityName">丽水</span><span class="planeNameNew">丽水机场</span><span class="airportCode">RSU</span></li><li><span class="cityName">鹿特丹</span><span class="planeNameNew">鹿特丹机场</span><span class="airportCode">RTM</span></li><li><span class="cityName">利雅得</span><span class="planeNameNew">利雅得</span><span class="airportCode">RUH</span></li><li><span class="cityName">路易斯维尔</span><span class="planeNameNew">路易斯维尔机场</span><span class="airportCode">SDF</span></li><li><span class="cityName">里约热内卢</span><span class="planeNameNew">圣杜蒙特机场</span><span class="airportCode">SDU</span></li><li><span class="cityName">伦敦</span><span class="planeNameNew">伦敦斯坦斯特德机场</span><span class="airportCode">STN</span></li><li><span class="cityName">拉默齐亚</span><span class="planeNameNew">拉默齐亚机场</span><span class="airportCode">SUF</span></li><li><span class="cityName">拉格兰德</span><span class="planeNameNew">拉格兰德机场</span><span class="airportCode">YGL</span></li><li><span class="cityName">利亚德堡</span><span class="planeNameNew">利亚德堡机场</span><span class="airportCode">YJF</span></li><li><span class="cityName">劳埃德明斯特</span><span class="planeNameNew">劳埃德明斯特机场</span><span class="airportCode">YLL</span></li><li><span class="cityName">莱斯布里奇</span><span class="planeNameNew">莱斯布里奇郡立机场</span><span class="airportCode">YQL</span></li><li><span class="cityName">里贾纳</span><span class="planeNameNew">里贾纳</span><span class="airportCode">YQR</span></li><li><span class="cityName">雷普尔斯湾</span><span class="planeNameNew">雷普尔斯湾机场</span><span class="airportCode">YUT</span></li><li><span class="cityName">鲁安</span><span class="planeNameNew">鲁安诺兰达机场</span><span class="airportCode">YUY</span></li><li><span class="cityName">里格利</span><span class="planeNameNew">里格利机场</span><span class="airportCode">YWY</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">M</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">马拉加</span><span class="planeNameNew">马拉加</span><span class="airportCode">AGP</span></li><li><span class="cityName">马塔兰</span><span class="planeNameNew">Selaparang机场</span><span class="airportCode">AMI</span></li><li><span class="cityName">马辰</span><span class="planeNameNew">马辰沙姆斯丁努尔机场</span><span class="airportCode">BDJ</span></li><li><span class="cityName">莫比尔</span><span class="planeNameNew">Mobile Downtown机场</span><span class="airportCode">BFM</span></li><li><span class="cityName">缅因</span><span class="planeNameNew">Greater Binghamton机场</span><span class="airportCode">BGM</span></li><li><span class="cityName">莫斯科</span><span class="planeNameNew">莫斯科比科沃机场</span><span class="airportCode">BKA</span></li><li><span class="cityName">曼谷</span><span class="planeNameNew">曼谷</span><span class="airportCode">BKK</span></li><li><span class="cityName">明古鲁</span><span class="planeNameNew">明古鲁机场</span><span class="airportCode">BKS</span></li><li><span class="cityName">孟买</span><span class="planeNameNew">孟买</span><span class="airportCode">BOM</span></li><li><span class="cityName">民都鲁</span><span class="planeNameNew">民都鲁机场</span><span class="airportCode">BTU</span></li><li><span class="cityName">曼巴豪</span><span class="planeNameNew">曼巴豪机场</span><span class="airportCode">CGM</span></li><li><span class="cityName">密歇根</span><span class="planeNameNew">奇普瓦郡立机场</span><span class="airportCode">CIU</span></li><li><span class="cityName">马德堡</span><span class="planeNameNew">马德堡科赫施泰特机场</span><span class="airportCode">CSO</span></li><li><span class="cityName">莫斯科</span><span class="planeNameNew">多莫杰多沃机场</span><span class="airportCode">DME</span></li><li><span class="cityName">曼谷</span><span class="planeNameNew">曼谷廊曼国际机场</span><span class="airportCode">DMK</span></li><li><span class="cityName">蒙斯特</span><span class="planeNameNew">蒙斯特机场</span><span class="airportCode">FMO</span></li><li><span class="cityName">马德拉</span><span class="planeNameNew">马德拉机场</span><span class="airportCode">FNC</span></li><li><span class="cityName">牧之原</span><span class="planeNameNew">静冈机场</span><span class="airportCode">FSZ</span></li><li><span class="cityName">马加丹</span><span class="planeNameNew">马加丹机场</span><span class="airportCode">GDX</span></li><li><span class="cityName">莫罗尼</span><span class="planeNameNew">莫罗尼机场</span><span class="airportCode">HAH</span></li><li><span class="cityName">米克诺斯岛</span><span class="planeNameNew">米克诺斯岛机场</span><span class="airportCode">JMK</span></li><li><span class="cityName">棉兰</span><span class="planeNameNew">棉兰瓜拉纳穆国际机场</span><span class="airportCode">KNO</span></li><li><span class="cityName">米兰</span><span class="planeNameNew">米兰利纳特机场</span><span class="airportCode">LIN</span></li><li><span class="cityName">马德里</span><span class="planeNameNew">马德里</span><span class="airportCode">MAD</span></li><li><span class="cityName">米德兰</span><span class="planeNameNew">米德兰机场</span><span class="airportCode">MAF</span></li><li><span class="cityName">曼彻斯特</span><span class="planeNameNew">曼彻斯特</span><span class="airportCode">MAN</span></li><li><span class="cityName">马瑙斯</span><span class="planeNameNew">马瑙斯爱德华多·戈梅斯机场</span><span class="airportCode">MAO</span></li><li><span class="cityName">蒙巴萨</span><span class="planeNameNew">蒙巴萨机场</span><span class="airportCode">MBA</span></li><li><span class="cityName">姆马巴托</span><span class="planeNameNew">姆马巴托机场</span><span class="airportCode">MBD</span></li><li><span class="cityName">蒙特哥贝</span><span class="planeNameNew">SANGSTER机场</span><span class="airportCode">MBJ</span></li><li><span class="cityName">梅肯</span><span class="planeNameNew">梅肯机场</span><span class="airportCode">MCN</span></li><li><span class="cityName">马斯喀特</span><span class="planeNameNew">马斯喀特</span><span class="airportCode">MCT</span></li><li><span class="cityName">麦德林</span><span class="planeNameNew">麦德林何塞·玛丽亚·科尔多瓦机场</span><span class="airportCode">MDE</span></li><li><span class="cityName">麦地那</span><span class="planeNameNew">穆罕默德·本·阿卜杜勒-阿齐兹亲王机场</span><span class="airportCode">MED</span></li><li><span class="cityName">墨尔本</span><span class="planeNameNew">墨尔本</span><span class="airportCode">MEL</span></li><li><span class="cityName">孟菲斯</span><span class="planeNameNew">孟菲斯</span><span class="airportCode">MEM</span></li><li><span class="cityName">棉兰</span><span class="planeNameNew">棉兰</span><span class="airportCode">MES</span></li><li><span class="cityName">墨西哥</span><span class="planeNameNew">墨西哥城机场</span><span class="airportCode">MEX</span></li><li><span class="cityName">麦卡伦</span><span class="planeNameNew">麦卡伦机场</span><span class="airportCode">MFE</span></li><li><span class="cityName">马拉迪</span><span class="planeNameNew">马拉迪机场</span><span class="airportCode">MFQ</span></li><li><span class="cityName">蒙哥马利</span><span class="planeNameNew">蒙哥马利机场</span><span class="airportCode">MGM</span></li><li><span class="cityName">马什哈德</span><span class="planeNameNew">马什哈德机场</span><span class="airportCode">MHD</span></li><li><span class="cityName">曼海姆</span><span class="planeNameNew">曼海姆市机场</span><span class="airportCode">MHG</span></li><li><span class="cityName">曼哈顿</span><span class="planeNameNew">曼哈顿机场</span><span class="airportCode">MHK</span></li><li><span class="cityName">曼彻斯特</span><span class="planeNameNew">曼彻斯特-波士顿地区机场</span><span class="airportCode">MHT</span></li><li><span class="cityName">迈阿密</span><span class="planeNameNew">迈阿密</span><span class="airportCode">MIA</span></li><li><span class="cityName">梅里达</span><span class="planeNameNew">梅里达机场</span><span class="airportCode">MID</span></li><li><span class="cityName">米兰</span><span class="planeNameNew">米兰</span><span class="airportCode">MIL</span></li><li><span class="cityName">莫纳斯提尔</span><span class="planeNameNew">莫纳斯提尔机场</span><span class="airportCode">MIR</span></li><li><span class="cityName">密尔沃基</span><span class="planeNameNew">密尔沃基</span><span class="airportCode">MKE</span></li><li><span class="cityName">穆卡</span><span class="planeNameNew">穆卡机场</span><span class="airportCode">MKM</span></li><li><span class="cityName">麦凯</span><span class="planeNameNew">麦凯</span><span class="airportCode">MKY</span></li><li><span class="cityName">马耳他</span><span class="planeNameNew">马耳他机场</span><span class="airportCode">MLA</span></li><li><span class="cityName">马累</span><span class="planeNameNew">马累</span><span class="airportCode">MLE</span></li><li><span class="cityName">玛琅</span><span class="planeNameNew">玛琅阿卜杜勒·拉赫曼·萨利赫机场</span><span class="airportCode">MLG</span></li><li><span class="cityName">莫雷利亚</span><span class="planeNameNew">莫雷利亚机场</span><span class="airportCode">MLM</span></li><li><span class="cityName">蒙罗维亚</span><span class="planeNameNew">蒙罗维亚机场</span><span class="airportCode">MLW</span></li><li><span class="cityName">马拉蒂亚</span><span class="planeNameNew">马拉蒂亚机场</span><span class="airportCode">MLX</span></li><li><span class="cityName">摩尔曼斯科</span><span class="planeNameNew">摩尔曼斯科机场</span><span class="airportCode">MMK</span></li><li><span class="cityName">马尼拉</span><span class="planeNameNew">马尼拉</span><span class="airportCode">MNL</span></li><li><span class="cityName">莫比尔</span><span class="planeNameNew">莫比尔机场</span><span class="airportCode">MOB</span></li><li><span class="cityName">穆龙达瓦</span><span class="planeNameNew">穆龙达瓦机场</span><span class="airportCode">MOQ</span></li><li><span class="cityName">莫斯科</span><span class="planeNameNew">莫斯科</span><span class="airportCode">MOW</span></li><li><span class="cityName">莫雷阿</span><span class="planeNameNew">莫雷阿机场</span><span class="airportCode">MOZ</span></li><li><span class="cityName">蒙彼利埃</span><span class="planeNameNew">蒙彼利埃地中海机场</span><span class="airportCode">MPL</span></li><li><span class="cityName">马普托</span><span class="planeNameNew">马普托机场</span><span class="airportCode">MPM</span></li><li><span class="cityName">米尔迪拉</span><span class="planeNameNew">米尔迪拉</span><span class="airportCode">MQL</span></li><li><span class="cityName">马丁</span><span class="planeNameNew">马丁机场</span><span class="airportCode">MQM</span></li><li><span class="cityName">默克莱</span><span class="planeNameNew">默克莱机场</span><span class="airportCode">MQX</span></li><li><span class="cityName">马赛</span><span class="planeNameNew">马赛</span><span class="airportCode">MRS</span></li><li><span class="cityName">毛里求斯</span><span class="planeNameNew">毛里求斯机场</span><span class="airportCode">MRU</span></li><li><span class="cityName">蒙特雷</span><span class="planeNameNew">蒙特雷地区机场</span><span class="airportCode">MRY</span></li><li><span class="cityName">麦迪逊</span><span class="planeNameNew">麦迪逊机场</span><span class="airportCode">MSN</span></li><li><span class="cityName">米苏拉</span><span class="planeNameNew">米苏拉机场</span><span class="airportCode">MSO</span></li><li><span class="cityName">明尼阿波利斯</span><span class="planeNameNew">明尼阿波利斯</span><span class="airportCode">MSP</span></li><li><span class="cityName">明斯克</span><span class="planeNameNew">明斯克</span><span class="airportCode">MSQ</span></li><li><span class="cityName">马塞纳</span><span class="planeNameNew">马塞纳机场</span><span class="airportCode">MSS</span></li><li><span class="cityName">马塞卢</span><span class="planeNameNew">马塞卢机场</span><span class="airportCode">MSU</span></li><li><span class="cityName">莫什泰鲁什</span><span class="planeNameNew">莫什泰鲁什机场</span><span class="airportCode">MTI</span></li><li><span class="cityName">马里兰</span><span class="planeNameNew">马丁州立机场</span><span class="airportCode">MTN</span></li><li><span class="cityName">蒙特雷</span><span class="planeNameNew">蒙特雷国际机场</span><span class="airportCode">MTY</span></li><li><span class="cityName">慕尼黑</span><span class="planeNameNew">慕尼黑</span><span class="airportCode">MUC</span></li><li><span class="cityName">马鲁迪</span><span class="planeNameNew">马鲁迪机场</span><span class="airportCode">MUR</span></li><li><span class="cityName">蒙得维的亚</span><span class="planeNameNew">蒙得维的亚机场</span><span class="airportCode">MVD</span></li><li><span class="cityName">Moses Lake</span><span class="planeNameNew">格兰特郡立机场</span><span class="airportCode">MWH</span></li><li><span class="cityName">姆万扎</span><span class="planeNameNew">姆万扎机场</span><span class="airportCode">MWZ</span></li><li><span class="cityName">米兰</span><span class="planeNameNew">米兰马尔本萨机场</span><span class="airportCode">MXP</span></li><li><span class="cityName">默特尔比奇</span><span class="planeNameNew">默特尔比奇机场</span><span class="airportCode">MYR</span></li><li><span class="cityName">美里</span><span class="planeNameNew">美里机场</span><span class="airportCode">MYY</span></li><li><span class="cityName">名古屋</span><span class="planeNameNew">名古屋</span><span class="airportCode">NGO</span></li><li><span class="cityName">莫斯科</span><span class="planeNameNew">奥斯塔夫耶沃机场</span><span class="airportCode">OSF</span></li><li><span class="cityName">马略卡岛帕尔马</span><span class="planeNameNew">马略卡岛帕尔马机场</span><span class="airportCode">PMI</span></li><li><span class="cityName">莫尔斯比港</span><span class="planeNameNew">莫尔斯比港</span><span class="airportCode">POM</span></li><li><span class="cityName">缅因波特兰</span><span class="planeNameNew">Portland机场</span><span class="airportCode">PWM</span></li><li><span class="cityName">马拉喀什</span><span class="planeNameNew">马拉喀什机场</span><span class="airportCode">RAK</span></li><li><span class="cityName">蒙罗维亚</span><span class="planeNameNew">蒙罗维亚罗伯茨机场</span><span class="airportCode">ROB</span></li><li><span class="cityName">迈尔斯堡</span><span class="planeNameNew">迈尔斯堡西南佛罗里达国际机场</span><span class="airportCode">RSW</span></li><li><span class="cityName">莫斯科</span><span class="planeNameNew">谢诺梅杰沃机场</span><span class="airportCode">SVO</span></li><li><span class="cityName">莫斯科</span><span class="planeNameNew">伏努科沃机场</span><span class="airportCode">VKO</span></li><li><span class="cityName">马恩河畔沙隆</span><span class="planeNameNew">巴黎瓦特里机场</span><span class="airportCode">XCR</span></li><li><span class="cityName">麋鹿湖</span><span class="planeNameNew">麋鹿湖机场</span><span class="airportCode">YAD</span></li><li><span class="cityName">米子</span><span class="planeNameNew">米子机场</span><span class="airportCode">YGJ</span></li><li><span class="cityName">麦迪兰群岛</span><span class="planeNameNew">麦迪兰群岛机场</span><span class="airportCode">YGR</span></li><li><span class="cityName">梅多莱克</span><span class="planeNameNew">梅多莱克机场</span><span class="airportCode">YLJ</span></li><li><span class="cityName">穆斯乔</span><span class="planeNameNew">穆斯乔机场</span><span class="airportCode">YMJ</span></li><li><span class="cityName">麦克默里堡</span><span class="planeNameNew">麦克默里堡</span><span class="airportCode">YMM</span></li><li><span class="cityName">马库维克</span><span class="planeNameNew">马库维克机场</span><span class="airportCode">YMN</span></li><li><span class="cityName">穆瑟尼</span><span class="planeNameNew">穆瑟尼机场</span><span class="airportCode">YMO</span></li><li><span class="cityName">蒙特利尔</span><span class="planeNameNew">蒙特利尔</span><span class="airportCode">YMQ</span></li><li><span class="cityName">蒙特利尔</span><span class="planeNameNew">米拉贝尔机场</span><span class="airportCode">YMX</span></li><li><span class="cityName">蒙特利尔</span><span class="planeNameNew">蒙特利尔特鲁多机场</span><span class="airportCode">YUL</span></li><li><span class="cityName">梅迪辛哈特</span><span class="planeNameNew">梅迪辛哈特机场</span><span class="airportCode">YXH</span></li><li><span class="cityName">蒙若利</span><span class="planeNameNew">蒙若利机场</span><span class="airportCode">YYY</span></li><li><span class="cityName">马塞特</span><span class="planeNameNew">马塞特机场</span><span class="airportCode">ZMT</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">N</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">楠塔基特</span><span class="planeNameNew">楠塔基特机场</span><span class="airportCode">ACK</span></li><li><span class="cityName">纽约</span><span class="planeNameNew">奥尔巴尼机场</span><span class="airportCode">ALB</span></li><li><span class="cityName">楠普拉</span><span class="planeNameNew">楠普拉机场</span><span class="airportCode">APL</span></li><li><span class="cityName">纳什维尔</span><span class="planeNameNew">纳什维尔机场</span><span class="airportCode">BNA</span></li><li><span class="cityName">纽瓦克</span><span class="planeNameNew">纽瓦克</span><span class="airportCode">EWR</span></li><li><span class="cityName">努克</span><span class="planeNameNew">努克机场</span><span class="airportCode">GOH</span></li><li><span class="cityName">南非乔治</span><span class="planeNameNew">南非乔治机场</span><span class="airportCode">GRJ</span></li><li><span class="cityName">纽约</span><span class="planeNameNew">长岛机场</span><span class="airportCode">ISP</span></li><li><span class="cityName">纽约</span><span class="planeNameNew">纽约约翰·菲茨杰拉德·肯尼迪国际机场</span><span class="airportCode">JFK</span></li><li><span class="cityName">纽约</span><span class="planeNameNew">拉瓜迪亚机场</span><span class="airportCode">LGA</span></li><li><span class="cityName">女满别</span><span class="planeNameNew">女满别机场</span><span class="airportCode">MMB</span></li><li><span class="cityName">内尔斯普雷特</span><span class="planeNameNew">克鲁格姆普马兰加国际机场机场</span><span class="airportCode">MQP</span></li><li><span class="cityName">那格浦尔</span><span class="planeNameNew">那格浦尔</span><span class="airportCode">NAG</span></li><li><span class="cityName">纳迪</span><span class="planeNameNew">纳迪</span><span class="airportCode">NAN</span></li><li><span class="cityName">那不勒斯</span><span class="planeNameNew">那不勒斯机场</span><span class="airportCode">NAP</span></li><li><span class="cityName">拿骚</span><span class="planeNameNew">拿骚机场</span><span class="airportCode">NAS</span></li><li><span class="cityName">内夫谢希尔</span><span class="planeNameNew">内夫谢希尔机场</span><span class="airportCode">NAV</span></li><li><span class="cityName">内罗毕</span><span class="planeNameNew">内罗毕</span><span class="airportCode">NBO</span></li><li><span class="cityName">尼斯</span><span class="planeNameNew">尼斯</span><span class="airportCode">NCE</span></li><li><span class="cityName">纽卡斯尔</span><span class="planeNameNew">纽卡斯尔</span><span class="airportCode">NCL</span></li><li><span class="cityName">尼亚美</span><span class="planeNameNew">尼亚美机场</span><span class="airportCode">NIM</span></li><li><span class="cityName">努瓦克肖特</span><span class="planeNameNew">努瓦克肖特机场</span><span class="airportCode">NKC</span></li><li><span class="cityName">诺福克岛</span><span class="planeNameNew">诺福克岛国际机场</span><span class="airportCode">NLK</span></li><li><span class="cityName">嫩江</span><span class="planeNameNew">嫩江机场</span><span class="airportCode">NNN</span></li><li><span class="cityName">纳皮尔</span><span class="planeNameNew">纳皮尔机场</span><span class="airportCode">NPE</span></li><li><span class="cityName">纽卡斯尔</span><span class="planeNameNew">纽卡斯尔</span><span class="airportCode">NTL</span></li><li><span class="cityName">内瓦</span><span class="planeNameNew">内瓦机场</span><span class="airportCode">NVA</span></li><li><span class="cityName">纳沃伊</span><span class="planeNameNew">纳沃伊机场</span><span class="airportCode">NVI</span></li><li><span class="cityName">纳韦甘蒂斯</span><span class="planeNameNew">纳韦甘蒂斯机场</span><span class="airportCode">NVT</span></li><li><span class="cityName">诺维奇</span><span class="planeNameNew">诺维奇机场</span><span class="airportCode">NWI</span></li><li><span class="cityName">纽约</span><span class="planeNameNew">纽约</span><span class="airportCode">NYC</span></li><li><span class="cityName">内比都</span><span class="planeNameNew">内比都机场</span><span class="airportCode">NYT</span></li><li><span class="cityName">诺福克</span><span class="planeNameNew">诺福克地区机场</span><span class="airportCode">OFK</span></li><li><span class="cityName">诺福克</span><span class="planeNameNew">诺福克国际机场</span><span class="airportCode">ORF</span></li><li><span class="cityName">南安普敦</span><span class="planeNameNew">南安普敦机场</span><span class="airportCode">SOU</span></li><li><span class="cityName">诺克斯维尔</span><span class="planeNameNew">诺克斯维尔麦吉·泰森机场</span><span class="airportCode">TYS</span></li><li><span class="cityName">纳沙斯雅克</span><span class="planeNameNew">纳沙斯雅克机场</span><span class="airportCode">UAK</span></li><li><span class="cityName">南萨哈林斯克</span><span class="planeNameNew">南萨哈林斯克机场</span><span class="airportCode">UUS</span></li><li><span class="cityName">纳奈莫</span><span class="planeNameNew">纳奈莫机场</span><span class="airportCode">YCD</span></li><li><span class="cityName">奈恩</span><span class="planeNameNew">奈恩机场</span><span class="airportCode">YDP</span></li><li><span class="cityName">纳塔什昆</span><span class="planeNameNew">纳塔什昆机场</span><span class="airportCode">YNA</span></li><li><span class="cityName">挪威豪斯</span><span class="planeNameNew">挪威豪斯机场</span><span class="airportCode">YNE</span></li><li><span class="cityName">纳尔逊堡</span><span class="planeNameNew">纳尔逊堡机场</span><span class="airportCode">YYE</span></li>
						</ul>
					</div>
				</div>
			</div>
			<div id="con_two_5" style="display:none;">
				<div class="zimuBox">
					<div class="shouzimu">P</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">Pittston Township</span><span class="planeNameNew">威尔克斯-巴里机场</span><span class="airportCode">AVP</span></li><li><span class="cityName">平壤</span><span class="planeNameNew">平壤机场</span><span class="airportCode">FNJ</span></li><li><span class="cityName">屏东</span><span class="planeNameNew">恒春机场</span><span class="airportCode">HCN</span></li><li><span class="cityName">普吉</span><span class="planeNameNew">普吉</span><span class="airportCode">HKT</span></li><li><span class="cityName">浦项</span><span class="planeNameNew">浦项</span><span class="airportCode">KPO</span></li><li><span class="cityName">帕德博恩</span><span class="planeNameNew">帕德博恩机场</span><span class="airportCode">PAD</span></li><li><span class="cityName">帕罗</span><span class="planeNameNew">帕罗机场</span><span class="airportCode">PBH</span></li><li><span class="cityName">帕拉马里博</span><span class="planeNameNew">帕拉马里博约翰·阿道夫·彭格尔国际机场</span><span class="airportCode">PBM</span></li><li><span class="cityName">珀斯</span><span class="planeNameNew">珀斯</span><span class="airportCode">PER</span></li><li><span class="cityName">帕苏丰杜</span><span class="planeNameNew">帕苏丰杜机场</span><span class="airportCode">PFB</span></li><li><span class="cityName">彭世洛</span><span class="planeNameNew">彭世洛机场</span><span class="airportCode">PHS</span></li><li><span class="cityName">屏东</span><span class="planeNameNew">屏东机场</span><span class="airportCode">PIF</span></li><li><span class="cityName">皮乌拉</span><span class="planeNameNew">皮乌拉机场</span><span class="airportCode">PIU</span></li><li><span class="cityName">帕克斯</span><span class="planeNameNew">帕克斯机场</span><span class="airportCode">PKE</span></li><li><span class="cityName">普斯科夫</span><span class="planeNameNew">普斯科夫机场</span><span class="airportCode">PKV</span></li><li><span class="cityName">普拉森西亚</span><span class="planeNameNew">普拉森西亚机场</span><span class="airportCode">PLJ</span></li><li><span class="cityName">帕尔马</span><span class="planeNameNew">帕尔马机场</span><span class="airportCode">PMF</span></li><li><span class="cityName">浦那</span><span class="planeNameNew">浦那</span><span class="airportCode">PNQ</span></li><li><span class="cityName">彭萨科拉</span><span class="planeNameNew">彭萨科拉机场</span><span class="airportCode">PNS</span></li><li><span class="cityName">普拉塔港</span><span class="planeNameNew">Puerto PLata Gregorio Luperon机场</span><span class="airportCode">POP</span></li><li><span class="cityName">普罗瑟派恩</span><span class="planeNameNew">普罗瑟派恩</span><span class="airportCode">PPP</span></li><li><span class="cityName">普林塞萨港</span><span class="planeNameNew">普林塞萨港机场</span><span class="airportCode">PPS</span></li><li><span class="cityName">帕皮提</span><span class="planeNameNew">帕皮提机场</span><span class="airportCode">PPT</span></li><li><span class="cityName">普拉兰岛</span><span class="planeNameNew">普拉兰岛机场</span><span class="airportCode">PRI</span></li><li><span class="cityName">普尔曼</span><span class="planeNameNew">普尔曼机场</span><span class="airportCode">PUW</span></li><li><span class="cityName">普拉</span><span class="planeNameNew">普拉机场</span><span class="airportCode">PUY</span></li><li><span class="cityName">普罗维登斯</span><span class="planeNameNew">普罗维登斯机场</span><span class="airportCode">PVD</span></li><li><span class="cityName">佩韦克</span><span class="planeNameNew">佩韦克机场</span><span class="airportCode">PWE</span></li><li><span class="cityName">普拉亚</span><span class="planeNameNew">普拉亚弗朗西斯科·门德斯国际机场</span><span class="airportCode">RAI</span></li><li><span class="cityName">平彻克里克</span><span class="planeNameNew">平彻克里克机场</span><span class="airportCode">WPC</span></li><li><span class="cityName">佩利湾</span><span class="planeNameNew">佩利湾机场</span><span class="airportCode">YBB</span></li><li><span class="cityName">派内贝</span><span class="planeNameNew">派内贝机场</span><span class="airportCode">YKG</span></li><li><span class="cityName">皮克尔</span><span class="planeNameNew">皮克尔机场</span><span class="airportCode">YPL</span></li><li><span class="cityName">Povungnituk</span><span class="planeNameNew">Povungnituk机场</span><span class="airportCode">YPX</span></li><li><span class="cityName">彭蒂科顿</span><span class="planeNameNew">彭蒂科顿机场</span><span class="airportCode">YYF</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">Q</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">青森</span><span class="planeNameNew">青森机场</span><span class="airportCode">AOJ</span></li><li><span class="cityName">秋田</span><span class="planeNameNew">秋田机场</span><span class="airportCode">AXT</span></li><li><span class="cityName">卡拉马祖</span><span class="planeNameNew">卡拉马祖-巴特尔克里克国际机场</span><span class="airportCode">AZO</span></li><li><span class="cityName">卡尔霍恩</span><span class="planeNameNew">W.K.凯洛格地区机场</span><span class="airportCode">BTL</span></li><li><span class="cityName">卡利亚里</span><span class="planeNameNew">卡利亚里埃尔马斯机场</span><span class="airportCode">CAG</span></li><li><span class="cityName">卡萨布兰卡</span><span class="planeNameNew">卡萨布兰卡</span><span class="airportCode">CAS</span></li><li><span class="cityName">清莱</span><span class="planeNameNew">清莱国际机场</span><span class="airportCode">CEI</span></li><li><span class="cityName">奇姆肯特</span><span class="planeNameNew">奇姆肯特机场</span><span class="airportCode">CIT</span></li><li><span class="cityName">卡拉马</span><span class="planeNameNew">卡拉马洛阿省机场</span><span class="airportCode">CJC</span></li><li><span class="cityName">清州</span><span class="planeNameNew">清州</span><span class="airportCode">CJJ</span></li><li><span class="cityName">卡尔维</span><span class="planeNameNew">卡尔维圣凯瑟琳机场</span><span class="airportCode">CLY</span></li><li><span class="cityName">卡门城</span><span class="planeNameNew">卡门城国际机场</span><span class="airportCode">CME</span></li><li><span class="cityName">七美</span><span class="planeNameNew">七美机场</span><span class="airportCode">CMJ</span></li><li><span class="cityName">卡萨布兰卡</span><span class="planeNameNew">卡萨布兰卡穆罕默德五世国际机场</span><span class="airportCode">CMN</span></li><li><span class="cityName">卡尔斯巴德</span><span class="planeNameNew">卡尔斯巴德机场</span><span class="airportCode">CNM</span></li><li><span class="cityName">清迈</span><span class="planeNameNew">清迈</span><span class="airportCode">CNX</span></li><li><span class="cityName">卡塔尼亚</span><span class="planeNameNew">卡塔尼亚丰塔纳罗萨机场</span><span class="airportCode">CTA</span></li><li><span class="cityName">卡塔赫纳</span><span class="planeNameNew">卡塔赫纳拉斐尔·努涅斯国际机场</span><span class="airportCode">CTG</span></li><li><span class="cityName">切图马尔</span><span class="planeNameNew">切图马尔国际机场</span><span class="airportCode">CTM</span></li><li><span class="cityName">千岁</span><span class="planeNameNew">新千岁机场</span><span class="airportCode">CTS</span></li><li><span class="cityName">奇瓦瓦</span><span class="planeNameNew">奇瓦瓦罗伯托·菲耶罗·比利亚洛沃斯将军国际机场</span><span class="airportCode">CUU</span></li><li><span class="cityName">奇琴伊查</span><span class="planeNameNew">奇琴伊查国际机场</span><span class="airportCode">CZA</span></li><li><span class="cityName">乔治敦</span><span class="planeNameNew">乔治敦切迪贾根国际机场</span><span class="airportCode">GEO</span></li><li><span class="cityName">乞力马扎罗</span><span class="planeNameNew">乞力马扎罗国际机场</span><span class="airportCode">JRO</span></li><li><span class="cityName">卡诺</span><span class="planeNameNew">卡诺</span><span class="airportCode">KAN</span></li><li><span class="cityName">卡拉干达</span><span class="planeNameNew">卡拉干达萨里-阿尔卡国际机场</span><span class="airportCode">KGF</span></li><li><span class="cityName">卡尔古利</span><span class="planeNameNew">卡尔古利-博尔德机场</span><span class="airportCode">KGI</span></li><li><span class="cityName">卡拉奇</span><span class="planeNameNew">卡拉奇真纳国际机场</span><span class="airportCode">KHI</span></li><li><span class="cityName">卡利博</span><span class="planeNameNew">卡利博国际机场</span><span class="airportCode">KLO</span></li><li><span class="cityName">卡拉特哈</span><span class="planeNameNew">卡拉特哈机场</span><span class="airportCode">KTA</span></li><li><span class="cityName">卡地克兰</span><span class="planeNameNew">卡地克兰机场</span><span class="airportCode">MPH</span></li><li><span class="cityName">卡胡卢伊</span><span class="planeNameNew">卡胡卢伊机场</span><span class="airportCode">OGG</span></li><li><span class="cityName">芹苴</span><span class="planeNameNew">芹苴国际机场</span><span class="airportCode">VCA</span></li><li><span class="cityName">切特温德</span><span class="planeNameNew">切特温德机场</span><span class="airportCode">YCQ</span></li><li><span class="cityName">切斯特菲尔德因莱特</span><span class="planeNameNew">切斯特菲尔德因莱特机场</span><span class="airportCode">YCS</span></li><li><span class="cityName">卡蒂</span><span class="planeNameNew">卡蒂机场</span><span class="airportCode">YOA</span></li><li><span class="cityName">乔治王子城</span><span class="planeNameNew">乔治王子城</span><span class="airportCode">YXS</span></li><li><span class="cityName">卡尔加里</span><span class="planeNameNew">卡尔加里</span><span class="airportCode">YYC</span></li><li><span class="cityName">丘吉尔</span><span class="planeNameNew">丘吉尔机场</span><span class="airportCode">YYQ</span></li><li><span class="cityName">卡普斯卡辛</span><span class="planeNameNew">卡普斯卡辛机场</span><span class="airportCode">YYU</span></li><li><span class="cityName">七岛港</span><span class="planeNameNew">七岛港机场</span><span class="airportCode">YZV</span></li><li><span class="cityName">丘吉尔</span><span class="planeNameNew">丘吉尔瀑布机场</span><span class="airportCode">ZUM</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">R</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">热那亚</span><span class="planeNameNew">热那亚—西塞斯特里克里斯托弗·哥伦布国际机场</span><span class="airportCode">GOA</span></li><li><span class="cityName">日内瓦</span><span class="planeNameNew">日内瓦</span><span class="airportCode">GVA</span></li><li><span class="cityName">柔佛州</span><span class="planeNameNew">柔佛州新山士乃国际机场</span><span class="airportCode">JHB</span></li><li><span class="cityName">日惹</span><span class="planeNameNew">日惹机场</span><span class="airportCode">JOG</span></li><li><span class="cityName">若因维利</span><span class="planeNameNew">若因维利·库巴唐机场</span><span class="airportCode">JOI</span></li><li><span class="cityName">热浪岛</span><span class="planeNameNew">热浪岛机场</span><span class="airportCode">RDN</span></li><li><span class="cityName">Rygge</span><span class="planeNameNew">Rygge机场</span><span class="airportCode">RYG</span></li><li><span class="cityName">荣市</span><span class="planeNameNew">荣市机场</span><span class="airportCode">VII</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">S</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">索契</span><span class="planeNameNew">索契机场</span><span class="airportCode">AER</span></li><li><span class="cityName">斯德哥尔摩</span><span class="planeNameNew">斯德哥尔摩机场</span><span class="airportCode">ARN</span></li><li><span class="cityName">斯里巴加湾</span><span class="planeNameNew">斯里巴加湾文莱国际机场</span><span class="airportCode">BWN</span></li><li><span class="cityName">斯塔克</span><span class="planeNameNew">阿克伦坎顿机场</span><span class="airportCode">CAK</span></li><li><span class="cityName">斯普林菲尔德</span><span class="planeNameNew">韦斯托弗机场</span><span class="airportCode">CEF</span></li><li><span class="cityName">圣保罗</span><span class="planeNameNew">圣保罗孔戈尼亚斯机场</span><span class="airportCode">CGH</span></li><li><span class="cityName">尚佩恩</span><span class="planeNameNew">尚佩恩机场</span><span class="airportCode">CMI</span></li><li><span class="cityName">沙勒罗瓦</span><span class="planeNameNew">布鲁塞尔南部-沙勒罗瓦机场</span><span class="airportCode">CRL</span></li><li><span class="cityName">圣塞瓦斯蒂安</span><span class="planeNameNew">圣塞瓦斯蒂安机场</span><span class="airportCode">EAS</span></li><li><span class="cityName">萨尔瓦多</span><span class="planeNameNew">萨尔瓦多里卡多·加西亚·波萨达机场</span><span class="airportCode">ESR</span></li><li><span class="cityName">苏福尔斯</span><span class="planeNameNew">苏福尔斯地区机场</span><span class="airportCode">FSD</span></li><li><span class="cityName">绥芬河</span><span class="planeNameNew">绥芬河机场</span><span class="airportCode">FUD</span></li><li><span class="cityName">尚勒乌尔法</span><span class="planeNameNew">尚勒乌尔法机场</span><span class="airportCode">GNY</span></li><li><span class="cityName">圣保罗</span><span class="planeNameNew">圣保罗机场</span><span class="airportCode">GRU</span></li><li><span class="cityName">顺化</span><span class="planeNameNew">顺化富牌机场</span><span class="airportCode">HUI</span></li><li><span class="cityName">首尔</span><span class="planeNameNew">首尔仁川机场</span><span class="airportCode">ICN</span></li><li><span class="cityName">圣托里尼</span><span class="planeNameNew">圣托里尼机场</span><span class="airportCode">JTR</span></li><li><span class="cityName">萨马拉</span><span class="planeNameNew">萨马拉机场</span><span class="airportCode">KUF</span></li><li><span class="cityName">斯瓦尔巴群岛</span><span class="planeNameNew">斯瓦尔巴朗伊尔机场</span><span class="airportCode">LYR</span></li><li><span class="cityName">萨吉诺</span><span class="planeNameNew">萨吉诺机场</span><span class="airportCode">MBS</span></li><li><span class="cityName">松山</span><span class="planeNameNew">松山</span><span class="airportCode">MYJ</span></li><li><span class="cityName">圣安唐</span><span class="planeNameNew">圣安唐机场</span><span class="airportCode">NTO</span></li><li><span class="cityName">斯德哥尔摩</span><span class="planeNameNew">斯德哥尔摩史卡夫斯塔机场</span><span class="airportCode">NYO</span></li><li><span class="cityName">圣丹尼斯</span><span class="planeNameNew">留尼旺岛罗兰·加洛斯机场</span><span class="airportCode">RUN</span></li><li><span class="cityName">萨那</span><span class="planeNameNew">萨那</span><span class="airportCode">SAH</span></li><li><span class="cityName">圣萨尔瓦多</span><span class="planeNameNew">圣萨尔瓦多 科马拉帕机场</span><span class="airportCode">SAL</span></li><li><span class="cityName">圣地亚哥</span><span class="planeNameNew">圣地亚哥</span><span class="airportCode">SAN</span></li><li><span class="cityName">萨凡纳</span><span class="planeNameNew">萨凡纳机场</span><span class="airportCode">SAV</span></li><li><span class="cityName">圣芭芭拉</span><span class="planeNameNew">圣芭芭拉机场</span><span class="airportCode">SBA</span></li><li><span class="cityName">诗巫</span><span class="planeNameNew">诗巫机场</span><span class="airportCode">SBW</span></li><li><span class="cityName">斯塔特大学</span><span class="planeNameNew">斯塔特大学机场</span><span class="airportCode">SCE</span></li><li><span class="cityName">圣地亚哥</span><span class="planeNameNew">圣地亚哥机场</span><span class="airportCode">SCL</span></li><li><span class="cityName">萨尔布鲁根</span><span class="planeNameNew">萨尔布吕肯机场</span><span class="airportCode">SCN</span></li><li><span class="cityName">圣地亚哥</span><span class="planeNameNew">圣地亚哥德孔波斯特拉机场</span><span class="airportCode">SCQ</span></li><li><span class="cityName">圣克鲁斯岛</span><span class="planeNameNew">圣克鲁斯岛机场</span><span class="airportCode">SCZ</span></li><li><span class="cityName">山打根</span><span class="planeNameNew">山打根机场</span><span class="airportCode">SDK</span></li><li><span class="cityName">圣多明各</span><span class="planeNameNew">LAS AMERICAS机场</span><span class="airportCode">SDQ</span></li><li><span class="cityName">首尔</span><span class="planeNameNew">首尔</span><span class="airportCode">SEL</span></li><li><span class="cityName">斯法克斯</span><span class="planeNameNew">斯法克斯Thyna机场</span><span class="airportCode">SFA</span></li><li><span class="cityName">森讷堡</span><span class="planeNameNew">森讷堡机场</span><span class="airportCode">SGD</span></li><li><span class="cityName">斯普林菲尔德</span><span class="planeNameNew">斯普林菲尔德机场</span><span class="airportCode">SGF</span></li><li><span class="cityName">沙迦</span><span class="planeNameNew">沙迦</span><span class="airportCode">SHJ</span></li><li><span class="cityName">什里夫波特</span><span class="planeNameNew">什里夫波特机场</span><span class="airportCode">SHV</span></li><li><span class="cityName">圣何塞</span><span class="planeNameNew">圣何塞</span><span class="airportCode">SJC</span></li><li><span class="cityName">圣何塞</span><span class="planeNameNew">胡安圣玛利亚机场</span><span class="airportCode">SJO</span></li><li><span class="cityName">圣胡安</span><span class="planeNameNew">圣胡安国际机场</span><span class="airportCode">SJU</span></li><li><span class="cityName">塞萨洛尼基</span><span class="planeNameNew">塞萨洛尼基机场</span><span class="airportCode">SKG</span></li><li><span class="cityName">斯科普里</span><span class="planeNameNew">斯科普里机场</span><span class="airportCode">SKP</span></li><li><span class="cityName">塞拉莱</span><span class="planeNameNew">塞拉莱机场</span><span class="airportCode">SLL</span></li><li><span class="cityName">萨克拉门托</span><span class="planeNameNew">萨克拉门托机场</span><span class="airportCode">SMF</span></li><li><span class="cityName">圣马丽亚</span><span class="planeNameNew">圣马丽亚机场</span><span class="airportCode">SMX</span></li><li><span class="cityName">圣塔安那</span><span class="planeNameNew">圣塔安那橙郡县机场</span><span class="airportCode">SNA</span></li><li><span class="cityName">圣尼古拉</span><span class="planeNameNew">圣尼古拉普雷吉萨机场</span><span class="airportCode">SNE</span></li><li><span class="cityName">梭罗</span><span class="planeNameNew">梭罗阿迪苏曼莫国际机场</span><span class="airportCode">SOC</span></li><li><span class="cityName">索非亚</span><span class="planeNameNew">索非亚</span><span class="airportCode">SOF</span></li><li><span class="cityName">苏朗</span><span class="planeNameNew">苏朗机场</span><span class="airportCode">SOQ</span></li><li><span class="cityName">塞班</span><span class="planeNameNew">塞班</span><span class="airportCode">SPN</span></li><li><span class="cityName">斯普利特</span><span class="planeNameNew">斯普利特机场机场</span><span class="airportCode">SPU</span></li><li><span class="cityName">三宝垄</span><span class="planeNameNew">三宝垄艾哈迈德亚尼国际机场</span><span class="airportCode">SRG</span></li><li><span class="cityName">萨尔瓦多</span><span class="planeNameNew">萨尔瓦多路易斯·爱德华多·马加良斯议员机场</span><span class="airportCode">SSA</span></li><li><span class="cityName">沙姆沙伊赫</span><span class="planeNameNew">沙姆沙伊赫机场</span><span class="airportCode">SSH</span></li><li><span class="cityName">圣地亚哥</span><span class="planeNameNew">SANTIAGO MUNICIPAL机场</span><span class="airportCode">STI</span></li><li><span class="cityName">斯德哥尔摩</span><span class="planeNameNew">斯德哥尔摩</span><span class="airportCode">STO</span></li><li><span class="cityName">斯图加特</span><span class="planeNameNew">斯图加特</span><span class="airportCode">STR</span></li><li><span class="cityName">遂宁</span><span class="planeNameNew">遂宁机场</span><span class="airportCode">SUN</span></li><li><span class="cityName">苏瓦</span><span class="planeNameNew">苏瓦那机场</span><span class="airportCode">SUV</span></li><li><span class="cityName">斯塔万格</span><span class="planeNameNew">斯塔万格机场</span><span class="airportCode">SVG</span></li><li><span class="cityName">塞维利亚</span><span class="planeNameNew">塞维利亚机场</span><span class="airportCode">SVQ</span></li><li><span class="cityName">斯特拉斯堡</span><span class="planeNameNew">斯特拉斯堡</span><span class="airportCode">SXB</span></li><li><span class="cityName">斯利那加</span><span class="planeNameNew">斯利那加机场</span><span class="airportCode">SXR</span></li><li><span class="cityName">设拉子</span><span class="planeNameNew">设拉子机场</span><span class="airportCode">SYZ</span></li><li><span class="cityName">萨尔茨堡</span><span class="planeNameNew">萨尔茨堡机场</span><span class="airportCode">SZG</span></li><li><span class="cityName">苏州</span><span class="planeNameNew">苏州机场</span><span class="airportCode">SZV</span></li><li><span class="cityName">山口</span><span class="planeNameNew">山口机场</span><span class="airportCode">UBJ</span></li><li><span class="cityName">神户</span><span class="planeNameNew">神户机场</span><span class="airportCode">UKB</span></li><li><span class="cityName">苏梅岛</span><span class="planeNameNew">苏梅岛</span><span class="airportCode">USM</span></li><li><span class="cityName">圣保罗</span><span class="planeNameNew">坎皮纳斯机场</span><span class="airportCode">VCP</span></li><li><span class="cityName">沙佩科</span><span class="planeNameNew">沙佩科机场</span><span class="airportCode">XAP</span></li><li><span class="cityName">圣诞岛</span><span class="planeNameNew">圣诞岛机场</span><span class="airportCode">XCH</span></li><li><span class="cityName">实里达</span><span class="planeNameNew">实里达机场</span><span class="airportCode">XSP</span></li><li><span class="cityName">苏圣玛丽</span><span class="planeNameNew">苏圣玛丽机场</span><span class="airportCode">YAM</span></li><li><span class="cityName">沙普洛</span><span class="planeNameNew">沙普洛机场</span><span class="airportCode">YLD</span></li><li><span class="cityName">桑德贝</span><span class="planeNameNew">桑德贝机场</span><span class="airportCode">YQT</span></li><li><span class="cityName">萨德伯里</span><span class="planeNameNew">萨德伯里机场</span><span class="airportCode">YSB</span></li><li><span class="cityName">萨菲尔德</span><span class="planeNameNew">萨菲尔德机场</span><span class="airportCode">YSD</span></li><li><span class="cityName">圣约翰</span><span class="planeNameNew">圣约翰机场</span><span class="airportCode">YSJ</span></li><li><span class="cityName">瑟佛罗里达基斯</span><span class="planeNameNew">瑟佛罗里达基斯马拉松机场</span><span class="airportCode">YSP</span></li><li><span class="cityName">萨斯卡通</span><span class="planeNameNew">萨斯卡通</span><span class="airportCode">YXE</span></li><li><span class="cityName">苏卢考特</span><span class="planeNameNew">苏卢考特机场</span><span class="airportCode">YXL</span></li><li><span class="cityName">史密瑟斯</span><span class="planeNameNew">史密瑟斯机场</span><span class="airportCode">YYD</span></li><li><span class="cityName">斯威夫特卡伦特</span><span class="planeNameNew">斯威夫特卡伦特机场</span><span class="airportCode">YYN</span></li><li><span class="cityName">圣约翰斯</span><span class="planeNameNew">圣约翰斯机场</span><span class="airportCode">YYT</span></li><li><span class="cityName">桑德斯皮特</span><span class="planeNameNew">桑德斯皮特机场</span><span class="airportCode">YZP</span></li><li><span class="cityName">萨格勒布</span><span class="planeNameNew">萨格勒布</span><span class="airportCode">ZAG</span></li><li><span class="cityName">桑给巴尔</span><span class="planeNameNew">桑给巴尔机场</span><span class="airportCode">ZNZ</span></li><li><span class="cityName">苏黎世</span><span class="planeNameNew">苏黎世</span><span class="airportCode">ZRH</span></li><li><span class="cityName">斯图尔特</span><span class="planeNameNew">斯图尔特机场</span><span class="airportCode">ZST</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">T</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">塔兰特</span><span class="planeNameNew">Fort Worth Alliance机场</span><span class="airportCode">AFW</span></li><li><span class="cityName">太子港国际</span><span class="planeNameNew">太子港国际机场</span><span class="airportCode">PAP</span></li><li><span class="cityName">台中</span><span class="planeNameNew">台中</span><span class="airportCode">RMQ</span></li><li><span class="cityName">塔克洛班</span><span class="planeNameNew">塔克洛班机场</span><span class="airportCode">TAC</span></li><li><span class="cityName">塔比拉兰</span><span class="planeNameNew">塔比拉兰机场</span><span class="airportCode">TAG</span></li><li><span class="cityName">塔什干</span><span class="planeNameNew">塔什干</span><span class="airportCode">TAS</span></li><li><span class="cityName">塔巴卡</span><span class="planeNameNew">塔巴卡机场</span><span class="airportCode">TBJ</span></li><li><span class="cityName">塔巴</span><span class="planeNameNew">塔巴机场</span><span class="airportCode">TCP</span></li><li><span class="cityName">塔迪库尔干</span><span class="planeNameNew">塔迪库尔干机场</span><span class="airportCode">TDK</span></li><li><span class="cityName">泰贝萨</span><span class="planeNameNew">泰贝萨机场</span><span class="airportCode">TEE</span></li><li><span class="cityName">特内里费</span><span class="planeNameNew">北特内里费机场</span><span class="airportCode">TFN</span></li><li><span class="cityName">图古尔特</span><span class="planeNameNew">图古尔特机场</span><span class="airportCode">TGR</span></li><li><span class="cityName">提亚雷特</span><span class="planeNameNew">提亚雷特机场</span><span class="airportCode">TID</span></li><li><span class="cityName">廷杜夫</span><span class="planeNameNew">廷杜夫机场</span><span class="airportCode">TIN</span></li><li><span class="cityName">特鲁克</span><span class="planeNameNew">特鲁克机场</span><span class="airportCode">TKK</span></li><li><span class="cityName">图尔库</span><span class="planeNameNew">图尔库机场</span><span class="airportCode">TKU</span></li><li><span class="cityName">塔拉哈西</span><span class="planeNameNew">塔拉哈西机场</span><span class="airportCode">TLH</span></li><li><span class="cityName">塔林</span><span class="planeNameNew">塔林</span><span class="airportCode">TLL</span></li><li><span class="cityName">特莱姆森</span><span class="planeNameNew">特莱姆森机场</span><span class="airportCode">TLM</span></li><li><span class="cityName">图卢兹</span><span class="planeNameNew">图卢兹布拉尼亚克机场</span><span class="airportCode">TLS</span></li><li><span class="cityName">托卢</span><span class="planeNameNew">托卢机场</span><span class="airportCode">TLU</span></li><li><span class="cityName">特拉维夫</span><span class="planeNameNew">特拉维夫机场</span><span class="airportCode">TLV</span></li><li><span class="cityName">提米蒙</span><span class="planeNameNew">提米蒙机场</span><span class="airportCode">TMX</span></li><li><span class="cityName">台南</span><span class="planeNameNew">台南机场</span><span class="airportCode">TNN</span></li><li><span class="cityName">塔那那利佛</span><span class="planeNameNew">塔那那利佛</span><span class="airportCode">TNR</span></li><li><span class="cityName">托泽尔</span><span class="planeNameNew">托泽尔机场</span><span class="airportCode">TOE</span></li><li><span class="cityName">特罗姆瑟</span><span class="planeNameNew">特罗姆瑟机场</span><span class="airportCode">TOS</span></li><li><span class="cityName">坦帕</span><span class="planeNameNew">坦帕</span><span class="airportCode">TPA</span></li><li><span class="cityName">台北</span><span class="planeNameNew">台北</span><span class="airportCode">TPE</span></li><li><span class="cityName">托雷翁</span><span class="planeNameNew">托雷翁机场</span><span class="airportCode">TRC</span></li><li><span class="cityName">特隆赫姆</span><span class="planeNameNew">特隆赫姆机场</span><span class="airportCode">TRD</span></li><li><span class="cityName">特罗纳</span><span class="planeNameNew">特罗纳机场</span><span class="airportCode">TRH</span></li><li><span class="cityName">特里凡得琅</span><span class="planeNameNew">特里凡得琅机场</span><span class="airportCode">TRV</span></li><li><span class="cityName">台北</span><span class="planeNameNew">台北松山国际机场</span><span class="airportCode">TSA</span></li><li><span class="cityName">汤斯维尔</span><span class="planeNameNew">汤斯维尔</span><span class="airportCode">TSV</span></li><li><span class="cityName">台东</span><span class="planeNameNew">台东丰年机场</span><span class="airportCode">TTT</span></li><li><span class="cityName">塔尔萨</span><span class="planeNameNew">塔尔萨机场</span><span class="airportCode">TUL</span></li><li><span class="cityName">突尼斯城</span><span class="planeNameNew">突尼斯城</span><span class="airportCode">TUN</span></li><li><span class="cityName">图森</span><span class="planeNameNew">图森机场</span><span class="airportCode">TUS</span></li><li><span class="cityName">特拉弗斯城</span><span class="planeNameNew">特拉弗斯城机场</span><span class="airportCode">TVC</span></li><li><span class="cityName">塔韦乌尼岛</span><span class="planeNameNew">塔韦乌尼岛机场</span><span class="airportCode">TVU</span></li><li><span class="cityName">同海</span><span class="planeNameNew">同海机场</span><span class="airportCode">VDH</span></li><li><span class="cityName">图芬奴</span><span class="planeNameNew">图芬奴机场</span><span class="airportCode">YAZ</span></li><li><span class="cityName">汤普森</span><span class="planeNameNew">汤普森机场</span><span class="airportCode">YTH</span></li><li><span class="cityName">Tasiujaq</span><span class="planeNameNew">Tasiujaq机场</span><span class="airportCode">YTQ</span></li><li><span class="cityName">塔克托亚图克</span><span class="planeNameNew">塔克托亚图克机场</span><span class="airportCode">YUB</span></li><li><span class="cityName">TALOYOAK</span><span class="planeNameNew">TALOYOAK机场</span><span class="airportCode">YYH</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">U</div>
					<div class="nameBoxDiv">
						<ul></ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">V</div>
					<div class="nameBoxDiv">
						<ul></ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">W</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">瓦科</span><span class="planeNameNew">瓦科地区机场</span><span class="airportCode">ACT</span></li><li><span class="cityName">瓦拉瓦拉</span><span class="planeNameNew">瓦拉瓦拉机场</span><span class="airportCode">ALW</span></li><li><span class="cityName">沃特敦</span><span class="planeNameNew">沃特敦机场</span><span class="airportCode">ART</span></li><li><span class="cityName">沃特敦</span><span class="planeNameNew">沃特敦地区机场</span><span class="airportCode">ATY</span></li><li><span class="cityName">伍兹湖县</span><span class="planeNameNew">巴德特BAUDETTE机场</span><span class="airportCode">BDE</span></li><li><span class="cityName">万隆</span><span class="planeNameNew">万隆国际机场</span><span class="airportCode">BDO</span></li><li><span class="cityName">武端</span><span class="planeNameNew">武端机场</span><span class="airportCode">BXU</span></li><li><span class="cityName">万科昆戈</span><span class="planeNameNew">万科昆戈机场</span><span class="airportCode">CEO</span></li><li><span class="cityName">维多利亚城</span><span class="planeNameNew">维多利亚城机场</span><span class="airportCode">CVM</span></li><li><span class="cityName">瓦德</span><span class="planeNameNew">盖马尔机场</span><span class="airportCode">ELU</span></li><li><span class="cityName">韦恩堡</span><span class="planeNameNew">韦恩堡国际机场</span><span class="airportCode">FWA</span></li><li><span class="cityName">危地马拉城</span><span class="planeNameNew">危地马拉城拉奥罗拉国际机场</span><span class="airportCode">GUA</span></li><li><span class="cityName">瓦图尔科</span><span class="planeNameNew">瓦图尔科国际机场</span><span class="airportCode">HUX</span></li><li><span class="cityName">威奇托</span><span class="planeNameNew">威奇托机场</span><span class="airportCode">ICT</span></li><li><span class="cityName">威尔明顿</span><span class="planeNameNew">威尔明顿机场</span><span class="airportCode">ILM</span></li><li><span class="cityName">芒特艾萨</span><span class="planeNameNew">芒特艾萨</span><span class="airportCode">ISA</span></li><li><span class="cityName">芒格洛尔</span><span class="planeNameNew">芒格洛尔机场</span><span class="airportCode">IXE</span></li><li><span class="cityName">万鸦老</span><span class="planeNameNew">万鸦老</span><span class="airportCode">MDC</span></li><li><span class="cityName">瓦加杜古</span><span class="planeNameNew">瓦加杜古机场</span><span class="airportCode">OUA</span></li><li><span class="cityName">吴哥窟</span><span class="planeNameNew">吴哥窟</span><span class="airportCode">REP</span></li><li><span class="cityName">维多利亚</span><span class="planeNameNew">塞舌尔机场</span><span class="airportCode">SEZ</span></li><li><span class="cityName">乌汶</span><span class="planeNameNew">乌汶机场</span><span class="airportCode">UBP</span></li><li><span class="cityName">乌赫塔</span><span class="planeNameNew">乌赫塔机场</span><span class="airportCode">UCT</span></li><li><span class="cityName">乌贝兰迪亚</span><span class="planeNameNew">乌贝兰迪亚机场</span><span class="airportCode">UDI</span></li><li><span class="cityName">乌代浦尔</span><span class="planeNameNew">乌代浦尔机场</span><span class="airportCode">UDR</span></li><li><span class="cityName">乌法</span><span class="planeNameNew">乌法机场</span><span class="airportCode">UFA</span></li><li><span class="cityName">乌兰巴托</span><span class="planeNameNew">乌兰巴托机场</span><span class="airportCode">ULN</span></li><li><span class="cityName">伍默拉</span><span class="planeNameNew">伍默拉机场</span><span class="airportCode">UMR</span></li><li><span class="cityName">乌戎潘当</span><span class="planeNameNew">乌戎潘当机场</span><span class="airportCode">UPG</span></li><li><span class="cityName">万纶</span><span class="planeNameNew">万纶机场</span><span class="airportCode">URT</span></li><li><span class="cityName">乌斯怀亚</span><span class="planeNameNew">乌斯怀亚 马尔维纳斯机场</span><span class="airportCode">USH</span></li><li><span class="cityName">乌辛斯克</span><span class="planeNameNew">乌辛斯克机场</span><span class="airportCode">USK</span></li><li><span class="cityName">乌隆他尼</span><span class="planeNameNew">乌隆他尼机场</span><span class="airportCode">UTH</span></li><li><span class="cityName">乌兰乌德</span><span class="planeNameNew">乌兰乌德机场</span><span class="airportCode">UUD</span></li><li><span class="cityName">瓦萨</span><span class="planeNameNew">瓦萨机场</span><span class="airportCode">VAA</span></li><li><span class="cityName">威尼斯</span><span class="planeNameNew">威尼斯</span><span class="airportCode">VCE</span></li><li><span class="cityName">沃洛格达</span><span class="planeNameNew">沃洛格达机场</span><span class="airportCode">VGD</span></li><li><span class="cityName">维哥</span><span class="planeNameNew">维哥机场</span><span class="airportCode">VGO</span></li><li><span class="cityName">维也纳</span><span class="planeNameNew">维也纳</span><span class="airportCode">VIE</span></li><li><span class="cityName">沃尔库塔</span><span class="planeNameNew">沃尔库塔机场</span><span class="airportCode">VKT</span></li><li><span class="cityName">维拉港</span><span class="planeNameNew">维拉港国际机场</span><span class="airportCode">VLI</span></li><li><span class="cityName">维尔纽斯</span><span class="planeNameNew">维尔纽斯机场</span><span class="airportCode">VNO</span></li><li><span class="cityName">瓦拉纳西</span><span class="planeNameNew">瓦拉纳西机场</span><span class="airportCode">VNS</span></li><li><span class="cityName">沃罗涅什</span><span class="planeNameNew">沃罗涅什机场</span><span class="airportCode">VOZ</span></li><li><span class="cityName">瓦拉德</span><span class="planeNameNew">瓦拉德机场</span><span class="airportCode">VRA</span></li><li><span class="cityName">维罗纳</span><span class="planeNameNew">维罗纳国际机场</span><span class="airportCode">VRN</span></li><li><span class="cityName">维捷布斯克</span><span class="planeNameNew">维捷布斯克机场</span><span class="airportCode">VTB</span></li><li><span class="cityName">万象</span><span class="planeNameNew">万象</span><span class="airportCode">VTE</span></li><li><span class="cityName">维萨卡帕特南</span><span class="planeNameNew">维萨卡帕特南机场</span><span class="airportCode">VTZ</span></li><li><span class="cityName">温得和克</span><span class="planeNameNew">温得和克卢格哈威机场</span><span class="airportCode">WDH</span></li><li><span class="cityName">万锦</span><span class="planeNameNew">巴顿维尔机场</span><span class="airportCode">YKZ</span></li><li><span class="cityName">韦明吉</span><span class="planeNameNew">韦明吉机场</span><span class="airportCode">YNC</span></li><li><span class="cityName">渥太华</span><span class="planeNameNew">渥太华</span><span class="airportCode">YOW</span></li><li><span class="cityName">温莎</span><span class="planeNameNew">温莎机场</span><span class="airportCode">YQG</span></li><li><span class="cityName">乌苗奥</span><span class="planeNameNew">乌苗奥机场</span><span class="airportCode">YUD</span></li><li><span class="cityName">瓦勒多</span><span class="planeNameNew">瓦勒多机场</span><span class="airportCode">YVO</span></li><li><span class="cityName">温哥华</span><span class="planeNameNew">温哥华</span><span class="airportCode">YVR</span></li><li><span class="cityName">温尼伯</span><span class="planeNameNew">温尼伯</span><span class="airportCode">YWG</span></li><li><span class="cityName">威廉斯湖</span><span class="planeNameNew">威廉斯湖机场</span><span class="airportCode">YWL</span></li><li><span class="cityName">沃瓦</span><span class="planeNameNew">沃瓦机场</span><span class="airportCode">YXZ</span></li>
						</ul>
					</div>
				</div>
			</div>
			<div id="con_two_6" style="display:none;">
				<div class="zimuBox">
					<div class="shouzimu">X</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">旭川</span><span class="planeNameNew">旭川机场</span><span class="airportCode">AKJ</span></li><li><span class="cityName">希拉本德</span><span class="planeNameNew">希拉本德市政机场</span><span class="airportCode">BDN</span></li><li><span class="cityName">西雅图</span><span class="planeNameNew">波音场国王郡立机场</span><span class="airportCode">BFI</span></li><li><span class="cityName">锡达城</span><span class="planeNameNew">锡达城机场</span><span class="airportCode">CDC</span></li><li><span class="cityName">夏洛茨维尔</span><span class="planeNameNew">夏洛茨维尔阿尔伯马尔机场</span><span class="airportCode">CHO</span></li><li><span class="cityName">锡达拉皮兹</span><span class="planeNameNew">锡达拉皮兹机场</span><span class="airportCode">CID</span></li><li><span class="cityName">夏洛特</span><span class="planeNameNew">夏洛特</span><span class="airportCode">CLT</span></li><li><span class="cityName">辛代尔</span><span class="planeNameNew">辛代尔机场</span><span class="airportCode">CNL</span></li><li><span class="cityName">辛辛那提</span><span class="planeNameNew">辛辛那提</span><span class="airportCode">CVG</span></li><li><span class="cityName">岘港</span><span class="planeNameNew">岘港</span><span class="airportCode">DAD</span></li><li><span class="cityName">肖勒姆</span><span class="planeNameNew">肖勒姆由海机场</span><span class="airportCode">ESH</span></li><li><span class="cityName">下诺夫哥罗德</span><span class="planeNameNew">下诺夫哥罗德机场</span><span class="airportCode">GOJ</span></li><li><span class="cityName">叙尔特岛</span><span class="planeNameNew">叙尔特岛机场</span><span class="airportCode">GWT</span></li><li><span class="cityName">香港</span><span class="planeNameNew">香港</span><span class="airportCode">HKG</span></li><li><span class="cityName">休斯顿</span><span class="planeNameNew">休斯顿威廉·佩特斯·霍比机场</span><span class="airportCode">HOU</span></li><li><span class="cityName">休斯顿</span><span class="planeNameNew">休斯顿</span><span class="airportCode">IAH</span></li><li><span class="cityName">锡亚高</span><span class="planeNameNew">锡亚高机场</span><span class="airportCode">IAO</span></li><li><span class="cityName">希洛</span><span class="planeNameNew">希洛国际机场</span><span class="airportCode">ITO</span></li><li><span class="cityName">新泻</span><span class="planeNameNew">新泻</span><span class="airportCode">KIJ</span></li><li><span class="cityName">熊本</span><span class="planeNameNew">熊本机场</span><span class="airportCode">KMJ</span></li><li><span class="cityName">小松</span><span class="planeNameNew">小松</span><span class="airportCode">KMQ</span></li><li><span class="cityName">西哈努克</span><span class="planeNameNew">西哈努克机场</span><span class="airportCode">KOS</span></li><li><span class="cityName">小石城</span><span class="planeNameNew">小石城机场</span><span class="airportCode">LIT</span></li><li><span class="cityName">新奥尔良</span><span class="planeNameNew">新奥尔良</span><span class="airportCode">MSY</span></li><li><span class="cityName">下瓦尔托夫斯克</span><span class="planeNameNew">下瓦尔托夫斯克机场</span><span class="airportCode">NJC</span></li><li><span class="cityName">新库兹涅茨克</span><span class="planeNameNew">新库兹涅茨克机场</span><span class="airportCode">NOZ</span></li><li><span class="cityName">新西伯利亚</span><span class="planeNameNew">新西伯利亚</span><span class="airportCode">OVB</span></li><li><span class="cityName">西棕榈滩</span><span class="planeNameNew">西棕榈滩机场</span><span class="airportCode">PBI</span></li><li><span class="cityName">西班牙港</span><span class="planeNameNew">西班牙港机场</span><span class="airportCode">POS</span></li><li><span class="cityName">仙台</span><span class="planeNameNew">仙台</span><span class="airportCode">SDJ</span></li><li><span class="cityName">西雅图</span><span class="planeNameNew">西雅图</span><span class="airportCode">SEA</span></li><li><span class="cityName">新加坡</span><span class="planeNameNew">新加坡</span><span class="airportCode">SIN</span></li><li><span class="cityName">辛菲罗波尔</span><span class="planeNameNew">辛菲罗波尔机场</span><span class="airportCode">SIP</span></li><li><span class="cityName">悉尼</span><span class="planeNameNew">悉尼</span><span class="airportCode">SYD</span></li><li><span class="cityName">雪城</span><span class="planeNameNew">雪城汉考克机场</span><span class="airportCode">SYR</span></li><li><span class="cityName">兴城</span><span class="planeNameNew">兴城机场</span><span class="airportCode">XEN</span></li><li><span class="cityName">邢台</span><span class="planeNameNew">邢台褡裢机场</span><span class="airportCode">XNT</span></li><li><span class="cityName">新威斯敏斯特</span><span class="planeNameNew">新威斯敏斯特机场</span><span class="airportCode">YBD</span></li><li><span class="cityName">谢弗维尔</span><span class="planeNameNew">谢弗维尔机场</span><span class="airportCode">YKL</span></li><li><span class="cityName">希布加莫</span><span class="planeNameNew">希布加莫机场</span><span class="airportCode">YMT</span></li><li><span class="cityName">夏洛特城</span><span class="planeNameNew">夏洛特城机场</span><span class="airportCode">YYG</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">Y</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">艾因</span><span class="planeNameNew">艾因国际机场</span><span class="airportCode">AAN</span></li><li><span class="cityName">伊兹密尔</span><span class="planeNameNew">伊兹密尔阿德南·曼德列斯机场</span><span class="airportCode">ADB</span></li><li><span class="cityName">亚的斯亚贝巴</span><span class="planeNameNew">亚的斯亚贝巴</span><span class="airportCode">ADD</span></li><li><span class="cityName">匹兹堡</span><span class="planeNameNew">Allegheny County机场</span><span class="airportCode">AGC</span></li><li><span class="cityName">艾丽斯</span><span class="planeNameNew">艾丽斯国际机场</span><span class="airportCode">ALI</span></li><li><span class="cityName">艾哈迈达巴德</span><span class="planeNameNew">艾哈迈达巴德机场</span><span class="airportCode">AMD</span></li><li><span class="cityName">亚罗士打</span><span class="planeNameNew">AOR机场</span><span class="airportCode">AOR</span></li><li><span class="cityName">艾丽斯斯普林斯</span><span class="planeNameNew">艾丽斯斯普林斯机场</span><span class="airportCode">ASP</span></li><li><span class="cityName">亚松森</span><span class="planeNameNew">亚松森机场</span><span class="airportCode">ASU</span></li><li><span class="cityName">雅典</span><span class="planeNameNew">雅典</span><span class="airportCode">ATH</span></li><li><span class="cityName">亚特兰大</span><span class="planeNameNew">亚特兰大</span><span class="airportCode">ATL</span></li><li><span class="cityName">艾斯尤特</span><span class="planeNameNew">艾斯尤特国际机场</span><span class="airportCode">ATZ</span></li><li><span class="cityName">亚历山德里亚</span><span class="planeNameNew">亚历山德里亚国际机场</span><span class="airportCode">AXN</span></li><li><span class="cityName">艾尔斯岩</span><span class="planeNameNew">艾尔斯岩机场</span><span class="airportCode">AYQ</span></li><li><span class="cityName">亚兹德</span><span class="planeNameNew">亚兹德机场</span><span class="airportCode">AZD</span></li><li><span class="cityName">雅加达</span><span class="planeNameNew">雅加达苏加诺-哈达国际机场</span><span class="airportCode">CGK</span></li><li><span class="cityName">芽庄</span><span class="planeNameNew">芽庄卡姆拉恩机场</span><span class="airportCode">CXR</span></li><li><span class="cityName">尤金</span><span class="planeNameNew">尤金机场</span><span class="airportCode">EUG</span></li><li><span class="cityName">伊拉克利翁</span><span class="planeNameNew">伊拉克利翁国际机场</span><span class="airportCode">HER</span></li><li><span class="cityName">因阿迈纳斯</span><span class="planeNameNew">因阿迈纳斯机场</span><span class="airportCode">IAM</span></li><li><span class="cityName">伊瓜苏</span><span class="planeNameNew">伊瓜苏卡塔拉塔斯国际机场</span><span class="airportCode">IGR</span></li><li><span class="cityName">伊瓜苏</span><span class="planeNameNew">伊瓜苏国际机场</span><span class="airportCode">IGU</span></li><li><span class="cityName">依尔库茨克</span><span class="planeNameNew">依尔库茨克</span><span class="airportCode">IKT</span></li><li><span class="cityName">伊洛伊洛</span><span class="planeNameNew">伊洛伊洛国际机场</span><span class="airportCode">ILO</span></li><li><span class="cityName">印第安纳波利斯</span><span class="planeNameNew">印第安纳波利斯</span><span class="airportCode">IND</span></li><li><span class="cityName">因盖扎姆</span><span class="planeNameNew">因盖扎姆机场</span><span class="airportCode">INF</span></li><li><span class="cityName">因斯布鲁克</span><span class="planeNameNew">因斯布鲁克机场</span><span class="airportCode">INN</span></li><li><span class="cityName">因萨拉赫</span><span class="planeNameNew">因萨拉赫机场</span><span class="airportCode">INZ</span></li><li><span class="cityName">伊斯兰堡</span><span class="planeNameNew">伊斯兰堡</span><span class="airportCode">ISB</span></li><li><span class="cityName">伊斯坦布尔</span><span class="planeNameNew">伊斯坦布尔</span><span class="airportCode">IST</span></li><li><span class="cityName">伊萨卡</span><span class="planeNameNew">伊萨卡汤普金斯地区机场</span><span class="airportCode">ITH</span></li><li><span class="cityName">伊瓦洛</span><span class="planeNameNew">伊瓦洛机场</span><span class="airportCode">IVL</span></li><li><span class="cityName">雅加达</span><span class="planeNameNew">雅加达</span><span class="airportCode">JKT</span></li><li><span class="cityName">约翰内斯堡</span><span class="planeNameNew">约翰内斯堡</span><span class="airportCode">JNB</span></li><li><span class="cityName">艾格瓦特</span><span class="planeNameNew">艾格瓦特机场</span><span class="airportCode">LOO</span></li><li><span class="cityName">匹兹堡</span><span class="planeNameNew">匹兹堡机场</span><span class="airportCode">PIT</span></li><li><span class="cityName">仰光</span><span class="planeNameNew">仰光</span><span class="airportCode">RGN</span></li><li><span class="cityName">伊斯坦布尔</span><span class="planeNameNew">伊斯坦布尔萨比哈·格克琴国际机场</span><span class="airportCode">SAW</span></li><li><span class="cityName">盐湖城</span><span class="planeNameNew">盐湖城</span><span class="airportCode">SLC</span></li><li><span class="cityName">叶卡捷琳堡</span><span class="planeNameNew">叶卡捷琳堡/科利佐沃机场机场</span><span class="airportCode">SVX</span></li><li><span class="cityName">蔚山</span><span class="planeNameNew">蔚山机场</span><span class="airportCode">USN</span></li><li><span class="cityName">雅温得</span><span class="planeNameNew">雅温得机场</span><span class="airportCode">YAO</span></li><li><span class="cityName">铀城</span><span class="planeNameNew">铀城机场</span><span class="airportCode">YBE</span></li><li><span class="cityName">伊格卢利克</span><span class="planeNameNew">伊格卢利克机场</span><span class="airportCode">YGT</span></li><li><span class="cityName">伊武吉维克</span><span class="planeNameNew">伊武吉维克机场</span><span class="airportCode">YIK</span></li><li><span class="cityName">雅库茨克</span><span class="planeNameNew">雅库茨克机场</span><span class="airportCode">YKS</span></li><li><span class="cityName">扬斯顿</span><span class="planeNameNew">扬斯顿机场</span><span class="airportCode">YNG</span></li><li><span class="cityName">艾伯特王子城</span><span class="planeNameNew">艾伯特王子城机场</span><span class="airportCode">YPA</span></li><li><span class="cityName">约克顿</span><span class="planeNameNew">约克顿机场</span><span class="airportCode">YQV</span></li><li><span class="cityName">耶洛奈夫</span><span class="planeNameNew">耶洛奈夫机场</span><span class="airportCode">YZF</span></li><li><span class="cityName">艾伯塔</span><span class="planeNameNew">艾伯塔奴湖机场</span><span class="airportCode">YZH</span></li>
						</ul>
					</div>
				</div>
				<div class="zimuBox">
					<div class="shouzimu">Z</div>
					<div class="nameBoxDiv">
						<ul>
							<li><span class="cityName">芝拉扎</span><span class="planeNameNew">芝拉扎东古裕龙机场</span><span class="airportCode">CXP</span></li><li><span class="cityName">佐贺</span><span class="planeNameNew">佐贺机场</span><span class="airportCode">HSG</span></li><li><span class="cityName">斋浦尔</span><span class="planeNameNew">斋浦尔</span><span class="airportCode">JAI</span></li><li><span class="cityName">泽西</span><span class="planeNameNew">泽西机场</span><span class="airportCode">JER</span></li><li><span class="cityName">朱巴</span><span class="planeNameNew">朱巴国际机场</span><span class="airportCode">JUB</span></li><li><span class="cityName">长滩</span><span class="planeNameNew">长滩机场</span><span class="airportCode">LGB</span></li><li><span class="cityName">芝加哥</span><span class="planeNameNew">芝加哥米德韦国际机场</span><span class="airportCode">MDW</span></li><li><span class="cityName">长崎</span><span class="planeNameNew">长崎</span><span class="airportCode">NGS</span></li><li><span class="cityName">芝加哥</span><span class="planeNameNew">芝加哥</span><span class="airportCode">ORD</span></li><li><span class="cityName">棕榈泉</span><span class="planeNameNew">Palm Springs机场</span><span class="airportCode">PSP</span></li><li><span class="cityName">札幌</span><span class="planeNameNew">札幌</span><span class="airportCode">SPK</span></li><li><span class="cityName">扎里亚</span><span class="planeNameNew">扎里亚机场</span><span class="airportCode">ZAR</span></li><li><span class="cityName">扎金索斯</span><span class="planeNameNew">扎金索斯机场</span><span class="airportCode">ZTH</span></li>
						</ul>
					</div>
				</div>
			
			</div>
		</div>
	</div>
	<!-- 索引结果 -->
	<div id="pipeiValue"></div>
	<!-- 加载等待界面 -->	
	<div id="loading" style="display:none; position:absolute; top:0px; left:0px; width:100%; height:100%; background:rgba(0,0,0,0.5);">
		<div style="color:#fff; text-align:center; margin-top:20%;">搜 索 中...</div> 
	</div>
	<script>
		$(function(){
			var planeName = ""; //机场的名字
			<%-- var liList='<li><div class="infoContent" style="margin-left:0px;"><div class="airPlane">南方航空</div><div class="filetNo">CZ2011</div></div><div class="infoContent planeName"><div class="timeClass">08:15</div><div class="planeNameText">三亚凤凰机场</div></div><div class="infoContent"><div style="line-height:50px;"><img src="<%=basePath%>console/images/bigtip1.png"/></div></div><div class="infoContent planeName"><div class="timeClass">11:30</div><div class="planeNameText">太原武宿机场</div></div><div class="infoContent"><span>￥</span><span style="line-height:50px; font-size:30px; color:#FF9900; font-weight:bold;">1025</span></div><div class="infoContent"><button class="btnclass">预定航班</button></div><div style="clear:both;"></div></li>';
			for(var i=0; i<15; i++){
				$("#ulBox").append(liList);
			} --%>
			
			$(".btnclass").click(function(){
				$(".InfoTure").css("display","block");
			});
			
			$("#errorBtn").click(function(){
				$(".InfoTure").css("display","none");
				$(".goWhere").css("display","block");
			});
			
			$(".colseImg").click(function(){
				$(".goWhere").css("display","none");
			});
			
			//单程和返程
			$("#danAndFan").combobox({
				onChange:function (n,o){
					if($("#danAndFan").combobox("getValue")=="2"){
						$("#fancDate").attr("disabled",false);
					}else{
						$("#fancDate").attr("disabled","disabled");
					}
				}
			});
			
			//出发城市选择输入框
			$(".cityIpnt").click(function(){
				$(this).val("");
				$(".cityIpnt1").removeClass("chooseIpnt");
				$(this).addClass("chooseIpnt");
				$(this).parent().next().children(".planeInpt").addClass("tempPlane");
				var top = $(this).offset().top;
				var left = $(this).offset().left;
				if($("#cityArea").combobox("getValue")=="2"){ //国际城市的选择框
					$("#tab2").css("top",top+20);
					$("#tab2").css("left",left);
					$("#tab2").css("display","block");
				}else{ //国内城市的选择框
					$("#tab1").css("top",top+20);
					$("#tab1").css("left",left);
					$("#tab1").css("display","block");
				}
			});
			//到达城市选择输入框
			$(".cityIpnt1").click(function(){
				$(this).val("");
				$(".cityIpnt").removeClass("chooseIpnt");
				$(this).addClass("chooseIpnt");
				$(this).parent().next().children(".planeInpt").addClass("tempPlane");
				var top = $(this).offset().top;
				var left = $(this).offset().left;
				if($("#cityArea").combobox("getValue")=="2"){ //国际城市的选择框
					$("#tab2").css("top",top+20);
					$("#tab2").css("left",left);
					$("#tab2").css("display","block");
				}else{ //国内城市的选择框
					$("#tab1").css("top",top+20);
					$("#tab1").css("left",left);
					$("#tab1").css("display","block");
				}
			});
			//交换城市的方法
			$("#changeBtn").click(function(){
				var foo=$("#gofaCity").val(), bar=$("#arrCity").val();
				var pln=$("#gofaPlane").val(), pnlboo = $("#arrPlane").val();
				bar = [foo,foo=bar][0];
				pnlboo = [pln,pln=pnlboo][0];
				$("#gofaCity").val(foo);
				$("#arrCity").val(bar);
				
				$("#gofaPlane").val(pln);
				$("#arrPlane").val(pnlboo);
			});
		});
	</script>
	
	
	<script>
		//城市选择切换的js
		var name_0='one';
		var cursel_0=1;
		var links_len,iIntervalId;
		onload=function(){
			var links = $("#tab1 li");
			links_len=links.length;
			setTab(name_0,cursel_0);
		}
		
		function setTab(name,cursel){
			for(var i=1; i<=links_len; i++){
				var menu = document.getElementById(name+i);
				if(i==cursel){
					$("#"+name+i).addClass("off");
					$("#con_"+name+"_"+i).css("display","block");
				}else{
					$("#"+name+i).removeClass("off");
					$("#con_"+name+"_"+i).css("display","none");
				}
			}
		}
		
		$(function(){
			$(".menudiv>div ul li").click(function(){
				var cityName = $(this).children(".cityName").text();
				var planeCode = $(this).children(".airportCode").text();
				planeName = $(this).children(".planeNameNew").text();
				//alert(cityName+","+planeCode+","+planeName);
				$(".chooseIpnt").val(cityName+"("+planeCode+")");
				$(".tempPlane").val(planeName);
				$(".cityIpnt").removeClass("chooseIpnt");
				$(".cityIpnt1").removeClass("chooseIpnt");
				$(".planeInpt").removeClass("tempPlane");
				$("#tab1").css("display","none");
				$("#tab2").css("display","none");
			});
			
			$(".colseImgCity").click(function(){
				$(".cityIpnt").removeClass("chooseIpnt");
				$(".planeInpt").removeClass("tempPlane");
				$("#tab1").css("display","none");
				$("#tab2").css("display","none");
			});
		});
		
	</script>
	
	<script>
	//机票搜索的js
	function ajaxjson(){
		$("#ulBox").html("");
		var chufCityCode = $("#gofaCity").val();
		var daodCityCode = $("#arrCity").val();
		var gody = $("#gofaTime").val();
		var fady = $("#fancDate").val();
		if(chufCityCode==""||chufCityCode==null){
			alert("出发城市不能为空");
			return false;
		}
		if(daodCityCode==""||daodCityCode==null){
			alert("到达城市不能为空");
			return false;
		}
		if(chufCityCode==daodCityCode){
			alert("起始城市和目的城市不能相同");
			return false;
		}
		if(gody==""||gody==null){
			alert("出发日期不能为空");
			return false;
		}
		var data = gody;
		var chknow = new Date(Date.parse(data));
		var now = new Date();
		now.setDate(now.getDate()-1);
		if (chknow < now) {
		         alert("出发日期不能在今天之前");
		         return false;
		}
		if($("#danAndFan").combobox("getValue")=="1"){  //单程
			//var cangW = $("#cangwei").val();
			var dateTime = $("#gofaTime").val();
			chufCityCode = getText(chufCityCode);
			daodCityCode = getText(daodCityCode);
			//console.log(chufCityCode+","+daodCityCode+","+cangW+","+dateTime); ,"cangW":cangW
			$.ajax({
					url:"<%=basePath%>wechatController/find/planTek.action",
					type:"POST",
					data:{"chufCity":chufCityCode,"daodCity":daodCityCode,"dateTime":dateTime},
					dataType:"json",
					beforeSend:function(){$("#loading").css("display","block");},
					complete:function(){$("#loading").css("display","none");},
					success:function(data){
						if(data.msg==1){
							var dataList = data.listDate;//直达的航班
							var zzDataList = data.zzListDate; //中转的航班
							console.log(dataList);
							//直达的航班
							for(var i=0;i<dataList.length;i++){
								var teickNum = (dataList[i].seatList)[(dataList[i].seatList.length)-1].cangwei_data; //舱位剩余的票数
								var arrTime = changeType(dataList[i].arrTime); //到达时间
								var depTime = changeType(dataList[i].depTime); //出发时间
								var costPay=0;
								for(var j=0; j<dataList[i].seatList.length; j++){ //没有对应的舱位
									//if((dataList[i].seatList)[j].basicCabin==cnCang($("#cangwei").val())){
										var b=new Array(dataList[i].seatList.length);
										for(var n=0,t=0;n<dataList[i].seatList.length;n++){
											b[t++]=(dataList[i].seatList)[n].onewayPrice;
										}
										costPay=Math.min.apply( Math, b);
										console.log(costPay);
										//var cangweiType = (dataList[i].seatList)[j].cangwei; //舱位
										//var gofaPlane = $("#gofaPlane").val();
										//var arrPlane = $("#arrPlane").val();
									//}
								}
								
								var liList='<li class="resultListBox"><div class="infoContent" style="margin-left:0px;"><div class="airPlane">'+findByCode(dataList[i].airCode)+'</div><div class="filetNo">'+dataList[i].flightNo+'</div></div><div class="infoContent planeName"><div class="timeClass newttime">'+depTime+'</div><div class="planeNameText deplaneName">'+findByplaneName(dataList[i].orgCity)+'</div></div><div class="infoContent"><div style="line-height:50px;"><img src="<%=basePath%>console/images/bigtip1.png"/></div></div><div class="infoContent planeName"><div class="timeClass arrTimenews">'+arrTime+'</div><div class="planeNameText arrPlaneName">'+findByplaneName(dataList[i].dstCity)+'</div></div><div class="infoContent"><span>￥</span><span class="costPayMoney" style="line-height:50px; font-size:30px; color:#FF9900; font-weight:bold;">'+costPay+'</span></div><div class="infoContent"><button class="btnclass" onclick="pointBtn(this)">预定航班▼</button></div><div style="clear:both;"></div><div class="otherCang"></div></li>';
								$("#ulBox").append(liList);	
								
								//动态加载针对该航班的其他舱位的信息
								for(var j=0;j<dataList[i].seatList.length;j++){
										// var cangweiName = $("#cangwei").val();
										var basicCabin = dataList[i].seatList[j].basicCabin;
										if(basicCabin=="C"){
											basicCabin="公务舱";
										}else if(basicCabin=="F"){
											basicCabin="头等舱";
										}else if(basicCabin=="Y"){
											basicCabin="经济舱";
										}
										//if(basicCabin==cangweiName){
											var cangwei_type = dataList[i].seatList[j].cangwei; //舱位的类型如(L、U、E...等)，类型不同价钱也不一样
											onewayPrice = dataList[i].seatList[j].onewayPrice;//价钱
											var listDiv='<div class="childBoxClass"><div class="kongBox"></div><div class="otherCangweiClass"><span>'+basicCabin+'：</span><span class="cangweiNum">'+cangwei_type+'</span><span> 舱位</span></div><div class="jiagePay"><span style="color:#666666;">￥</span><span class="payMoneyBox">'+onewayPrice+'</span></div><div class="yudingBtn"><button class="trueYuBtn" onclick="yudingTicket(this)">预　定</button><a class="orgCity" style="display:none;">'+dataList[i].orgCity+'</a><a class="dstCity" style="display:none;">'+dataList[i].dstCity+'</a></div><div style="clear:both;"></div></div>';
											$(".resultListBox:eq("+i+") .otherCang").append(listDiv);
										//}
								}
								$(".otherCang").slideUp("fast");
							}
							
							//中转的航班
							var countDivNum = 0; //计数器
							for(var i=0; i<zzDataList.length; i++){
								var liList;
								for(var j=zzDataList.length-1; j>i; j--){
									if(zzDataList[i].dstCity==zzDataList[j].orgCity&&MathTime(zzDataList[i].arrTime,zzDataList[j].depTime)>3600&&(zzDataList[i].airCode==zzDataList[j].airCode)){
										var rowstr1 = JSON.stringify(zzDataList[i]); //第一段航班(字符串)
										var rowstr2 = JSON.stringify(zzDataList[j]); //第二段航班(字符串)
										var rowseatInfo1 = zzDataList[i].seatList; //第一航段的座位
										var rowseatInfo2 = zzDataList[j].seatList; //第一航段的座位
										var chufDate = $("#gofaTime").val(); //出发日期
										var arrTime = changeType(zzDataList[j].arrTime); //到达时间
										var depTime = changeType(zzDataList[i].depTime); //出发时间
										var onePay,twoPay;
										for(var k=0; k<rowseatInfo1.length; k++){  //第一段航班的对应舱位的价格
											//if(rowseatInfo1[k].basicCabin == cnCang($("#cangwei").val())){
												var b=new Array(rowseatInfo1.length);
												for(var n=0,t=0;n<rowseatInfo1.length;n++){
													b[t++]=rowseatInfo1[n].onewayPrice;
												}
												var onePay=Math.min.apply( Math, b);
											//}
										}
										
										for(var k=0; k<rowseatInfo2.length; k++){	//第二段航班的对应舱位的价格
											//if(rowseatInfo1[k].basicCabin == cnCang($("#cangwei").val())){
												var c=new Array(rowseatInfo2.length);
												for(var n=0,t=0;n<rowseatInfo2.length;n++){
													c[t++]=rowseatInfo2[n].onewayPrice;
												}
												var twoPay=Math.min.apply( Math, c);
											//}
										}
										var costpayzhuang=(parseFloat(onePay)+parseFloat(twoPay)).toFixed(2);
										liList='<li class="zzresultListBox"><div class="infoContent" style="margin-left:0px;"><div class="airPlane">'+findByCode(zzDataList[i].airCode)+'</div><div class="filetNo">'+zzDataList[i].flightNo+'/'+zzDataList[j].flightNo+'</div></div><div class="infoContent planeName"><div class="timeClass newttime">'+depTime+'</div><div class="planeNameText deplaneName">'+findByplaneName(zzDataList[i].orgCity)+'</div></div><div class="infoContent"><div><div>'+findByCity(zzDataList[i].dstCity)+'(转)</div><div>停留：'+stos(MathTime(zzDataList[i].arrTime,zzDataList[j].depTime))+'</div></div></div><div class="infoContent planeName"><div class="timeClass arrTimenews">'+arrTime+'</div><div class="planeNameText arrPlaneName">'+findByplaneName(zzDataList[j].dstCity)+'</div></div><div class="infoContent"><span>￥</span><span class="costPayMoney" style="line-height:50px; font-size:30px; color:#FF9900; font-weight:bold;">'+costpayzhuang+'</span></div><div class="infoContent"><button class="zaClass" onclick="pointBtnzhz(this)">预定航班▼</button></div><div style="clear:both;"></div><div class="zhzfildBox"></div></li>';
										$("#ulBox").append(liList);	
										
										for(var k=0; k<rowseatInfo1.length; k++){
											for(var h=0; h<rowseatInfo2.length; h++){
												if(rowseatInfo1[k].cangwei == rowseatInfo2[h].cangwei){
													var fildNumOnePaice = rowseatInfo1[k].onewayPrice;
													var fildNumTwoPaice = rowseatInfo2[h].onewayPrice;
													var basicCabinzhz = rowseatInfo1[k].basicCabin;
													if(basicCabinzhz=="C"){
														basicCabinzhz="公务舱";
													}else if(basicCabinzhz=="F"){
														basicCabinzhz="头等舱";
													}else if(basicCabinzhz=="Y"){
														basicCabinzhz="经济舱";
													}
													var listDiv='<div class="childBoxClass"><div class="kongBox"></div><div class="otherCangweiClass"><span>'+basicCabinzhz+'：</span><span class="cangweiNum">'+rowseatInfo1[k].cangwei+'</span><span> 舱位</span></div><div class="jiagePay"><span style="color:#666666;">￥</span><span class="payMoneyBox">'+(parseFloat(fildNumOnePaice)+parseFloat(fildNumTwoPaice)).toFixed(2)+'</span></div><div class="yudingBtn"><a class="trueYuBtn" href=\'<%=basePath%>console/framework/jporder/zz_writeInfo.jsp?chufDate='+chufDate+'&cang='+rowseatInfo1[k].cangwei+'&rowstr1='+rowstr1+'&rowstr2='+rowstr2+'\' >预　定</a></div><div style="clear:both;"></div></div>';
													$(".zzresultListBox:eq("+countDivNum+") .zhzfildBox").append(listDiv);
												}
											}
										}
										countDivNum++;
									}
								}
							}
							$(".zhzfildBox").slideUp("fast");
						}else{
							$("#ulBox").html("<li style='color:#999;font-size:20px; font-weight:bold; text-align:center;'>没有找到符合条件的航班</li>");
						}
					},error:function(){
						
					}
			});
		}else if($("#danAndFan").combobox("getValue")=="2"){ //往返
			if(fady==""||fady==null){
				alert("返回日期不能为空");
				return false;
			}
			var chufCityCode = getText($("#gofaCity").val());
			var daodCityCode = getText($("#arrCity").val());
			var dateTime = $("#gofaTime").val();
			var returnTime = $("#fancDate").val();
			if(dateTime==""||dateTime==null){
				alert("出发日期不能为空");
				return false;
			}
			if(returnTime==""||returnTime==null){
				alert("返回日期不能为空");
				return false;
			}
		    if(dateTime == returnTime){
		    	alert("同一天请分开预定");
		    	return false;
		    }
		    var data = dateTime;
			var reData = returnTime;
		    data = data.replace("-","/");
		    reData = reData.replace("-","/");
		    var chknow = new Date(Date.parse(data));
		    var rechknow = new Date(Date.parse(reData));
		    if(rechknow < chknow){
		    	alert("返回日期不能在出发日期之前");
		    	return false;
		    }
		    var now = new Date();
		    now.setDate(now.getDate()-1);
		    if (chknow < now) {
		           alert("出发日期不能在今天之前");
		           return false;
		    }
		    if (rechknow < now) {
		           alert("返回日期不能在今天之前");
		           return false;
		    }
			var airline = "";
			var page = "";
			$.ajax({
					url:"<%=basePath%>wechatController/find/planTekTo.action",
					type:"POST",
					data:{"org":chufCityCode,"dst":daodCityCode,"date":dateTime,"returnDate":returnTime,"airline":airline,"page":page},
					dataType:"json",
					beforeSend:function(){$("#loading").css("display","block");},
					complete:function(){$("#loading").css("display","none");},
					success:function(data){
						if(data.msg==0){
							return;
						}else{
							var depart = data.departAv; //去程的航班
							var returnf = data.returnAv; //回程的航班
							//console.log(data.AVDouble);
							//console.log(departRows);
							//console.log(returnRows);
							var c=new Array();
							
							var z=new Array();
							
						
							
							var countwf = 0; //计数参数
							for(var i=0; i<depart.length; i++){
								//console.log("depart.length:"+depart.length);
								var airName = findByCode(depart[i].airCode);
								//console.log(depart[i].seatList);
								for(var j=0; j<returnf.length; j++){
									//console.log("returnf.length:"+returnf.length);
									var d=new Array();
									var airName2 = findByCode(returnf[j].airCode); 
									//console.log(returnf[j].seatList);
									var liList='<li class="wfresListBox"><div class="zuheFildClass"><div class="hangbanInfo"><div class="childBox"><span class="spanClass airName">'+airName+'</span><span class="spanClass filgNo">'+depart[i].flightNo+'</span></div><div class="childBox"><span class="spanClass depTime">'+changeType(depart[i].depTime)+'</span><span class="spanClass depPlane">'+findByplaneName(depart[i].orgCity)+'</span></div><div class="childBox"><span class="spanClass" style="line-height:36px;float:left;"><img src="<%=basePath%>console/images/bigtip1.png" style="height:35px;"/></span><span class="spanClass depDateClass">'+$("#gofaTime").val()+'</span></div><div class="childBox"><span class="spanClass arrTime">'+changeType(depart[i].arrTime)+'</span><span class="spanClass arrPlane">'+findByplaneName(depart[i].dstCity)+'</span></div><div style="clear:both;"></div></div><div class="hangbanInfo"><div class="childBox"><span class="spanClass airName">'+airName2+'</span><span class="spanClass filgNo">'+returnf[j].flightNo+'</span></div><div class="childBox"><span class="spanClass depTime">'+changeType(returnf[j].depTime)+'</span><span class="spanClass depPlane">'+findByplaneName(returnf[j].orgCity)+'</span></div><div class="childBox"><span class="spanClass" style="line-height:36px;float:left;"><img src="<%=basePath%>console/images/bigtip1.png" style="height:35px;"/></span><span class="spanClass depDateClass">'+$("#fancDate").val()+'</span></div><div class="childBox"><span class="spanClass arrTime">'+changeType(returnf[j].arrTime)+'</span><span class="spanClass arrPlane">'+findByplaneName(returnf[j].dstCity)+'</span></div><div style="clear:both;"></div></div></div><div class="countMoney"><span class="countNumPay">往返总价</span><span class="spanClass deoole">￥</span><span class="spanClass payMoey"></span><span class="spanClass qiClass">起</span></div><div class="hangbanbtn"><button onclick="pointBtnwf(this)">预定该组合▼</button></div><div style="clear:both;"></div><div class="childBoxCang"></div></li>';
									$("#ulBox").append(liList);
									var p=0;
									var min=666666;
									for(var k=0; k<depart[i].seatList.length; k++){
										//console.log("depart[i].seatList.length:"+depart[i].seatList.length);
										var GcangType = (depart[i].seatList)[k].basicCabin;
										if(GcangType=="C"){
											GcangType="公务舱"
										}else if(GcangType=="F"){
											GcangType="头等舱";
										}else if(GcangType=="Y"){
											GcangType="经济舱";
										}
										var GcangPont = (depart[i].seatList)[k].cangwei;
										 var depart_moneyCost = (depart[i].seatList)[k].onewayPrice;
										//alert(depart_moneyCost);
										//console.log(depart_moneyCost);
										 var c=new Array(depart[i].seatList.length);
										for(var n=0,t=0;n<depart[i].seatList.length;n++){
											
											c[t++]=(depart[i].seatList)[n].onewayPrice;
										}
										
										var depart1_moneyCost=Math.min.apply( Math, c); 
										var n=0;
										var l=0;
										//alert("vvgfg:"+j);
										for(var h=0; h<returnf[j].seatList.length; h++){
											//console.log("returnf[j].seatList.length:"+returnf[j].seatList.length);
											var RcangType = (returnf[j].seatList)[h].basicCabin;
											if(RcangType=="C"){
												RcangType="公务舱"
											}else if(RcangType=="F"){
												RcangType="头等舱";
											}else if(RcangType=="Y"){
												RcangType="经济舱";
											}
											
											var RcangPont = (returnf[j].seatList)[h].cangwei;
											
											var return_moneyCost = (returnf[j].seatList)[h].onewayPrice;
											var dr_countPay = (parseFloat(depart_moneyCost)+parseFloat(return_moneyCost)).toFixed(2);
											
											if(GcangType == RcangType && GcangPont == RcangPont){
												var departRows = JSON.stringify(depart[i]); //第一段航班(字符串)
												var returnRows = JSON.stringify(returnf[j]); //第二段航班(字符串)
												d[h++]=parseInt(dr_countPay);
												if(min>parseInt(dr_countPay)){
													min=dr_countPay;
												}
												var dr_countPay1 = d.sort(function(x,y){
													if(x>y){
														return -1;
													}else{
														return 1;
													}
												});
												dr_countPay1=Math.min.apply(Math,dr_countPay1);
												console.log(dr_countPay1);
												var listDiv='<div class="wfchildBoxClass"><div class="kongBox"></div><div class="otherCangweiClass"><span>'+GcangType+'：</span><span class="cangweiNum">'+GcangPont+'</span><span> 舱位</span></div><div class="jiagePay"><span style="color:#666666;">￥</span><span class="payMoneyBox">'+dr_countPay+'</span></div><div class="yudingBtn"><a class="trueYuBtn" href=\'<%=basePath%>console/framework/jporder/zz_writeInfo.jsp?chufDate=2016-11-19,2016-11-21&cang='+GcangPont+'&rowstr1='+departRows+'&rowstr2='+returnRows+'\'>预　定</a></div><div style="clear:both;"></div></div>';
												$(".wfresListBox:eq("+countwf+") .childBoxCang").append(listDiv);
												$(".wfresListBox:eq("+countwf+")>.countMoney>.payMoey").text(min);
											}
											
										}
										
									}
									countwf++;
								}
								
							}
							
							$(".childBoxCang").slideUp("fast");
						}
					},error:function(){
						
					}
			});
		}else{
			alert("请选择单返类型");
			return false;
		}
	}
		
		//输入关键字的时候自动索引
		function myFunction(inc) {
				$("#tab1").css("display","none");
				$("#tab2").css("display","none");
				var top = $(".chooseIpnt").offset().top;
				var left = $(".chooseIpnt").offset().left;
				$("#pipeiValue").css("top",top+20);
				$("#pipeiValue").css("left",left);
				$("#pipeiValue").css("display","block");
				var keyVal = $(inc).val();
				if($("#cityArea").combobox("getValue")=="1"){
					$("#tab2 .zimuBox .nameBoxDiv li>.cityName").removeClass("chCity");
					$("#tab1 .zimuBox .nameBoxDiv li>.cityName").removeClass("chCity").filter(":contains(" + keyVal + ")").addClass("chCity");
				}else{
					$("#tab1 .zimuBox .nameBoxDiv li>.cityName").removeClass("chCity");
					$("#tab2 .zimuBox .nameBoxDiv li>.cityName").removeClass("chCity").filter(":contains(" + keyVal + ")").addClass("chCity");
				}
				$("#pipeiValue").text("");
				for(var i=0; i<$(".chCity").length&&i!=6; i++){
					var cityname = $(".chCity:eq("+i+")").text();
					var palnename = $(".chCity:eq("+i+")").next().text();
					var airCodeName = $.trim($(".chCity:eq("+i+")").next().next().text());
					var dateList = '<div class="pipeiChildren" onclick="javascript:chaRes(this)"><span class="cityName01">'+cityname+'</span>(<span class="palneName01">'+palnename+'</span>)<span style="display:none;" class="airCode01">'+airCodeName+'</span></div>';
					$("#pipeiValue").append(dateList);
				}
			
		}
		
		//索引出来的结果的点击事件
		function chaRes(inc){
			var cityName = $(inc).children(".cityName01").text();
			planeName = $(inc).children(".palneName01").text();
			var planeCode = $(inc).children(".airCode01").text();
			//alert(cityName+","+planeCode+","+planeName);
			$(".chooseIpnt").val(cityName+"("+planeCode+")");
			$(".tempPlane").val(planeName);
			$(".cityIpnt").removeClass("chooseIpnt");
			$(".planeInpt").removeClass("tempPlane");
			$("#pipeiValue").css("display","none");
		}
		
		//预定航班的按钮（含有箭头的那个）直达
		function pointBtn(inc){
				$(inc).parent().siblings(".otherCang").slideToggle("fast");
		}
		
		//预定航班的按钮（含有箭头的那个）往返
		function pointBtnwf(inc){
				$(inc).parent().siblings(".childBoxCang").slideToggle("fast");
		}	
		
		//预定航班的按钮（含有箭头的那个）中转
		function pointBtnzhz(inc){
				$(inc).parent().siblings(".zhzfildBox").slideToggle("fast");
		}	
		
		//获取（）括号里面内容的方法
		function getText(str){
			var str2=str;
			var userName = str2.substring((str.indexOf("(")+1),str.indexOf(")"));
			return userName;
		}
		
		//格式化舱位
		function cnCang(basicCabin){
			if(basicCabin=="公务舱"){
				basicCabin="C";
			}else if(basicCabin=="头等舱"){
				basicCabin="F";
			}else if(basicCabin=="经济舱"){
				basicCabin="Y";
			}
			return basicCabin;
		}
		
		//改变出发时间和到达时间的类型
		function changeType(GoTime){	
			if(4<GoTime.length){
				var firstTime=GoTime.substring(0,2);
				var conterTime=GoTime.substring(2,4);
				var lastTime=GoTime.substring(4,GoTime.length);
				return firstTime+":"+conterTime+"<span style='color:#ff0000; font-size:10px;'>"+lastTime+"</span>";
			}else{			
				var firstTime=GoTime.substring(0,2);
				var lastTime=GoTime.substring(2,GoTime.length);
				return firstTime+":"+lastTime;
			}
		}
		
		function yudingTicket(inc){
			var chufaTime = $(inc).parents(".resultListBox").children(".planeName").children(".newttime").text(); //出发时间
			var arrTimes = $(inc).parents(".resultListBox").children(".planeName").children(".arrTimenews").text(); //到达时间
			var deplaneName = $(inc).parents(".resultListBox").children(".planeName").children(".deplaneName").text();
			var arrPlaneName = $(inc).parents(".resultListBox").children(".planeName").children(".arrPlaneName").text();
			var planAndFildNo = deplaneName+" "+$(inc).parents(".resultListBox").children(".infoContent").children(".filetNo").text(); //出发机场和航班号
			var mudiPlaneAndtime = arrPlaneName+" "+cuntTime(chufaTime.replace(":",""),arrTimes.replace(":","")); //到达机场个历时多长时间
			var payMoney = $(inc).parents(".childBoxClass").children(".jiagePay").children(".payMoneyBox").text(); //价格
			var zhekou = "85折" //折扣
			var cangwei = $(inc).parents(".childBoxClass").children(".otherCangweiClass").children(".cangweiNum").text() //舱位
			var chufCity = getoutText($("#gofaCity").val());//出发城市
			var arryCity = getoutText($("#arrCity").val()); //到达城市
			var chufaDate = $("#gofaTime").val(); //出发日期
			var chufCode =  $(inc).next().text();
			var daodCode = $(inc).next().next().text();
			//alert(chufaTime+"/"+arrTimes+"/"+planAndFildNo+"/"+mudiPlaneAndtime+"/"+payMoney+"/"+zhekou+"/"+cangwei+"/"+chufCity+"/"+arryCity+"/"+chufaDate);
			window.location.href="<%=basePath%>console/framework/jporder/writeInfo.jsp?chufTime="+chufaTime+"&arrDTime="+arrTimes+"&shiPlace="+planAndFildNo+"&zhongPlace="+mudiPlaneAndtime+"&cost="+payMoney+"&zhekou="+zhekou+"&cangweiType="+cangwei+"&chufCityID="+chufCity+"&daodCityID="+arryCity+"&chufDate="+chufaDate+"&chufCode="+chufCode+"&daodCode="+daodCode;
		}
		
		//计算历经多长时间到达
		function cuntTime(depTime,arrTime){
			var sTime = changesTime(depTime); //出发时间的秒
			var oTime = changesTime(arrTime); //到达时间的秒
			var chaTime = oTime-sTime; //两个时间相差的秒
			var liTime = parseInt(chaTime/3600)+"时"+parseInt((chaTime%3600)/60)+"分";
			//alert(depTime+"->"+changesTime(depTime)+"/"+arrTime+"->"+changesTime(arrTime)+"/"+liTime);
			return liTime;
		}
		
		//根据时间参数进行大小比较
		function MathTime(starTime,overTime){
			//将时间转换成秒来比较
			var shh = starTime.substring(0,2);
			var smm = starTime.substring(2,starTime.length);
			var scount,ocount; //定义总时间的两个变量
			scount = shh*3600+smm*60; //开始的总秒数
			var ohh,omm,odd;
			if(overTime.indexOf("+")>0){
				ohh = overTime.substring(0,2);
				omm = overTime.substring(2,4);
				odd = overTime.substring(4,overTime.length);
				ocount = ohh*3600+omm*60+24*3600;
			}else{
				ohh = overTime.substring(0,2);
				omm = overTime.substring(2,overTime.length);
				odd = "0";
				ocount = ohh*3600+omm*60;
			}
			return ocount-scount;
		}
		
		//根据时间参数化成秒
		function changesTime(time){
			var ohh,omm,ocount;
			if(time.indexOf("+")>0){
				ohh = time.substring(0,2);
				omm = time.substring(2,4);
				ocount = ohh*3600+omm*60+24*3600;
			}else{
				ohh = time.substring(0,2);
				omm = time.substring(2,time.length);
				ocount = ohh*3600+omm*60;
			}
			return ocount;
		}
		
		//获取括号外面的城市名的方法
		function getoutText(str){
			var userName = str.substring(0,str.indexOf("("));
			return userName;
		}
		
		//将秒化成    天/时/分
		function stos(s){
			var ss;
			if(24>parseInt(s/3600)>0){
				ss = parseInt(s/3600)+"小时"+parseInt((s%3600)/60)+"分";
			}else if(parseInt(s/3600)>=24){
				if(parseInt(s/3600)-24>1){
					ss = parseInt(parseInt(s/3600)/24)+"天"+(parseInt(s/3600)-24)+"小时";
				}else{
					ss = parseInt(parseInt(s/3600)/24)+"天"+((s/3600)-24)*60+"分";
				}
			}
			return ss;
		}
	</script>
</body>
</html>