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
		$(".panel").css("display","none");
	});
	
	//点击列表的方法(中转)
	$(".zhzChildBox").click(function(){ 
		$("body .banner").css("display","none");
		$("body .wfbanner").css("display","none");
		$("body .cangweiClass").css("display","none");
		$(this).siblings(".wfbanner").css("display","block");
		$(".panel").css("display","none");
	});
	
	//点击“对应舱位其他票价”时
	$(".piaojia").click(function(){
		$(".cangweiClass").css("display","none");
		$(this).parents(".banner").next(".cangweiClass").css("display","block");
		$(".panel").css("display","none");
	});
	
	//点击“对应舱位其他票价”时(中转)
	$(".wfpiaojia").click(function(){
		$(".cangweiClass").css("display","none");
		$(this).parents(".wfbanner").next(".cangweiClass").css("display","block");
		$(".panel").css("display","none");
	});
	
	//预定的方法
	/*$(".aYuding").click(function(){	
		var basePath=$("#basePath").text();
		var cangweiType = $(this).parent().next().next().children(".Eimg").text(); //舱位类型
		//var TekNum = obj.children(".notTjTicketDiv").children(".moneyAndTicket").children(".zuowei").text();//剩余的票数
		var chufDate = $("#dateTimeID").text();//出发时间
		var jsd = $(this).next(".choDate").text();
		window.location.href = basePath+"wechatController/page/YDticket.action?cangweiType="+cangweiType+"&chufDate="+chufDate+"&jsd="+jsd;         
	});*/
	
	//其他舱位中的预定
	/*$(".anotherCW").click(function(){	
		var basePath=$("#basePath").text();
		var cangweiType = $(this).parent().next().next().children(".Eimg").text(); //舱位类型
		var chufDate = $("#dateTimeID").text();//出发时间
		var jsd = $(this).next(".choDate").text();
		//var TekNum = obj.children(".notTjTicketDiv").children(".moneyAndTicket").children(".zuowei").text();//剩余的票数
		window.location.href = basePath+"wechatController/page/YDticket.action?cangweiType="+cangweiType+"&chufDate="+chufDate+"&jsd="+jsd;
	});*/
});

//直达的航班点击“预定”的时候
function otherYdBtn(uuid,canbin,dateTime){
	var basePath=$("#basePath").text();
	window.location.href = basePath+"wechatController/page/YDticket.action?uuid="+uuid+"&canbin="+canbin+"&dateTime="+dateTime;
}

function another(uuid1,uuid2,canbin,dateTime){
	var basePath=$("#basePath").text();
	window.location.href = basePath+"console/wechat/zhzconfirmInfo.jsp?uuid1="+uuid1+"&uuid2="+uuid2+"&canbin="+canbin+"&dateTime="+dateTime;
}




