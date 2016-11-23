/**
 * 
 */
$(function(){
	//点击列表的方法
	$(".notTjTicketDiv").click(function(){ 
		$("body .banner").css("display","none");
		$("body .wfbanner").css("display","none");
		$("body .cangweiClass").css("display","none");
		$(this).siblings(".banner").css("display","block");
	});
	
	//点击列表的方法(中转)
	$(".zhzChildBox").click(function(){ 
		$("body .banner").css("display","none");
		$("body .wfbanner").css("display","none");
		$("body .cangweiClass").css("display","none");
		$(this).siblings(".wfbanner").css("display","block");
	});
	
	//点击“对应舱位其他票价”时
	$(".piaojia").click(function(){
		$(".cangweiClass").css("display","none");
		$(this).parents(".banner").next(".cangweiClass").css("display","block");
	});
	
	//点击“对应舱位其他票价”时(中转)
	$(".wfpiaojia").click(function(){
		$(".cangweiClass").css("display","none");
		$(this).parents(".wfbanner").next(".cangweiClass").css("display","block");
	});
	
	//预定的方法
	$(".aYuding").click(function(){	
		var basePath=$("#basePath").text();
		var obj = $(this).parent().parent().parent().parent().parent().parent().parent();//这个方法会定位到最大的父标签 class="notTjTicket"中
		var chufTime = obj.children(".notTjTicketDiv").children(".StartTimeEnd").children(".StartTime").text();//出发时间
		var arrDTime = obj.children(".notTjTicketDiv").children(".StartTimeEnd").children(".EndTime").text();//到达时间
		var shiPlace = obj.children(".notTjTicketDiv").children(".StartAndEnd").children(".StartJC").children("span").text();//起始机场名和航班
		var zhongPlace = obj.children(".notTjTicketDiv").children(".StartAndEnd").children(".EndTJC").children("span").text();//终点机场名和历经时间
		var cost = obj.children(".notTjTicketDiv").children(".moneyAndTicket").children(".money").text();//获取价格
		var zhekou = $(this).parent().next().children(".zhe").text();//折扣
		var cangweiType = $(this).parent().next().next().children(".Eimg").text(); //舱位类型
		var TekNum = obj.children(".notTjTicketDiv").children(".moneyAndTicket").children(".zuowei").text();//剩余的票数
		var chufDate = $("#dateTimeID").text();//出发时间
		var chufCityID = $("#chufCityID").text();//出发城市
		var daodCityID = $("#daodCityID").text();//到达城市
		var jsd = $(this).next(".choDate").text();
		alert(jsd);
		return false;
		//alert(chufDate+"/"+chufCityID+"/"+daodCityID);
		window.location.href = basePath+"wechatController/page/YDticket.action?chufTime="+chufTime+"&arrDTime="+arrDTime+"&shiPlace="+shiPlace+"&zhongPlace="+zhongPlace+"&cost="+cost+"&cangweiType="+cangweiType+"&zhekou="+zhekou+"&chufDate="+chufDate+"&chufCityID="+chufCityID+"&daodCityID="+daodCityID;         
	});
	
	//其他舱位中的预定
	$(".anotherCW").click(function(){	
		var basePath=$("#basePath").text();
		var obj = $(this).parent().parent().parent().parent().parent().parent().parent().parent();//这个方法会定位到最大的父标签 class="notTjTicket"中
		var chufTime = obj.children(".notTjTicketDiv").children(".StartTimeEnd").children(".StartTime").text();//出发时间
		var arrDTime = obj.children(".notTjTicketDiv").children(".StartTimeEnd").children(".EndTime").text();//到达时间
		var shiPlace = obj.children(".notTjTicketDiv").children(".StartAndEnd").children(".StartJC").children("span").text();//起始机场名和航班
		var zhongPlace = obj.children(".notTjTicketDiv").children(".StartAndEnd").children(".EndTJC").children("span").text();//终点机场名和历经时间
		var cost = $(this).parent().next().children(".money").text();//获取价格
		var zhekou = $(this).parent().next().children(".zhe").text();//折扣
		var cangweiType = $(this).parent().next().next().children(".Eimg").text(); //舱位类型
		var chufDate = $("#dateTimeID").text();//出发时间
		var chufCityID = $("#chufCityID").text();//出发城市
		var daodCityID = $("#daodCityID").text();//到达城市
		var TekNum = obj.children(".notTjTicketDiv").children(".moneyAndTicket").children(".zuowei").text();//剩余的票数
		window.location.href = basePath+"wechatController/page/YDticket.action?chufTime="+chufTime+"&arrDTime="+arrDTime+"&shiPlace="+shiPlace+"&zhongPlace="+zhongPlace+"&cost="+cost+"&zhekou="+zhekou+"&cangweiType="+cangweiType+"&chufDate="+chufDate+"&chufCityID="+chufCityID+"&daodCityID="+daodCityID;
	});
});




