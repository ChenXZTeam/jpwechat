// JavaScript Document
$(function(){
	//性别选择
	$("#sexIpnt").click(function(){
			var top = $(this).offset().top;
			var left = $(this).offset().left;
			$("#sexType").css("top",top+25);
			$("#sexType").css("left",left-45);
			$("#sexType").css("display","block");
			$("#sexType").animate({height:"53px"},250);
	});
	
	$(".sexBoxCH").click(function(){
			$(this).text();	
			$("#sexIpnt").val($(this).text());
			$("#sexType").animate({height:"0px"},250);
			var t  = setTimeout(function(){$("#sexType").css("display","none")},250);
	})
	
	//旅客选择
	$("#personIpnt").click(function(){
			var top = $(this).offset().top;
			var left = $(this).offset().left;
			$("#personType").css("top",top+25);
			$("#personType").css("left",left-70);
			$("#personType").css("display","block");
			$("#personType").animate({height:"80px"},250);
	});
	
	$(".persBoxCH").click(function(){
			$(this).text();	
			$("#personIpnt").val($(this).text());
			$("#personType").animate({height:"0px"},250);
			var t  = setTimeout(function(){$("#personType").css("display","none")},250);
	})
	
	
	//证件选择
	$("#caseIpnt").click(function(){
			var top = $(this).offset().top;
			var left = $(this).offset().left;
			$("#CaseType").css("top",top+25);
			$("#CaseType").css("left",left);
			$("#CaseType").css("display","block");
			$("#CaseType").animate({height:"80px"},250);
	});
	
	$(".caseBoxCH").click(function(){
			$(this).text();	
			$("#caseIpnt").text($(this).text());
			$("#CaseType").animate({height:"0px"},250);
			var t  = setTimeout(function(){$("#CaseType").css("display","none")},250);
	})
	
	//多选的单击按钮（订购航空意外险）
	$(".flindYw").click(function(){			
		var payMoney = $(".payMoney").text();
		var SubPayMoney = payMoney.substring(1,payMoney.length);
		var newPayMoney = 0;
		if($(this).attr("checked")=="checked"){
			$(this).prev().css("display","block");
			newPayMoney = parseInt(SubPayMoney)+30;
			$(".payMoney").text("￥"+newPayMoney);
		}else{
			if(newPayMoney!=SubPayMoney){
				newPayMoney = parseInt(SubPayMoney)-30;
			}
			$(".payMoney").text("￥"+newPayMoney);
			$(this).prev().css("display","none");	
		}
	});
	
	//多选的单击按钮（订购延误取消险）
	$(".delayBx").click(function(){			
		var payMoney = $(".payMoney").text();
		var SubPayMoney = payMoney.substring(1,payMoney.length);
		var newPayMoney = 0;
		if($(this).attr("checked")=="checked"){
			$(this).prev().css("display","block");
			newPayMoney = parseInt(SubPayMoney)+20;
			$(".payMoney").text("￥"+newPayMoney);
		}else{
			if(newPayMoney!=SubPayMoney){
				newPayMoney = parseInt(SubPayMoney)-20;
			}
			$(".payMoney").text("￥"+newPayMoney);
			$(this).prev().css("display","none");	
		}
	});
	
});