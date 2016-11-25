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
		//(parseFloat(onePay)+parseFloat(twoPay)).toFixed(2)
		var payMoney = $(".payMoney").text();
		var SubPayMoney = payMoney.substring(1,payMoney.length);
		var newPayMoney = 0;
		if($(this).attr("checked")=="checked"){
			$(this).prev().css("display","block");
			newPayMoney = (parseFloat(SubPayMoney)+parseFloat(30)).toFixed(2);
			$(".payMoney").text("￥"+newPayMoney);
		}else{
			if(newPayMoney!=SubPayMoney){
				newPayMoney = (parseFloat(SubPayMoney)-parseFloat(30)).toFixed(2);
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
			newPayMoney = (parseFloat(SubPayMoney)+parseFloat(20)).toFixed(2);
			$(".payMoney").text("￥"+newPayMoney);
		}else{
			if(newPayMoney!=SubPayMoney){
				newPayMoney = (parseFloat(SubPayMoney)-parseFloat(20)).toFixed(2);
			}
			$(".payMoney").text("￥"+newPayMoney);
			$(this).prev().css("display","none");	
		}
	});
	
	//多选的单击按钮（优惠选择）
	$(".youhuiBx").click(function(){			
		var payMoney = $(".payMoney").text();
		var SubPayMoney = payMoney.substring(1,payMoney.length);
		var newPayMoney = 0;
		var youhuiType = $("#zhekouType").text();
		var youhuiMoney = $(this).val();
		var sd = $("#m").val();
		sd = sd - (sd * (youhuiMoney/10));
		if($(this).attr("checked")=="checked"){
			$(this).prev().css("display","block");
			if(youhuiType == "preferential"){
				newPayMoney = (parseFloat(SubPayMoney)-parseFloat(youhuiMoney)).toFixed(2);
				$(".payMoney").text("￥"+newPayMoney);
			}else if(youhuiType == "discount"){
				newPayMoney = (parseFloat(SubPayMoney)-parseFloat(sd)).toFixed(2);
				$(".payMoney").text("￥"+newPayMoney);
			}
		}else{
			if(newPayMoney!=SubPayMoney){
				if(youhuiType == "preferential"){
					newPayMoney = (parseFloat(SubPayMoney)+parseFloat(youhuiMoney)).toFixed(2);
				}else if(youhuiType == "discount"){
					newPayMoney = (parseFloat(SubPayMoney)+parseFloat(sd)).toFixed(2);
				}
			}
			$(".payMoney").text("￥"+newPayMoney);
			$(this).prev().css("display","none");	
		}
	});
	
	//多选的单击按钮（订购航空意外险）
	$(".flindYwzhz").click(function(){	
		//(parseFloat(onePay)+parseFloat(twoPay)).toFixed(2)
		var payMoney = $("#timess_m").val();
		var oneMoney = $("#oneMoney").val();
		var twoMoney = $("#twoMoney").val();
		var SubPayMoney = payMoney;
		var newPayMoney = 0;
		var newoneMoney = 0;
		var newtwoMoney = 0;
		if($(this).attr("checked")=="checked"){
			$(this).prev().css("display","block");
			newPayMoney = (parseFloat(SubPayMoney)+parseFloat(60)).toFixed(2);
			$("#timess_m").val(newPayMoney);
			$("#moneyPay").text(newPayMoney);
			$("#CostPay").text(newPayMoney);
			newoneMoney = (parseFloat(oneMoney)+parseFloat(30)).toFixed(2);
			newtwoMoney = (parseFloat(twoMoney)+parseFloat(30)).toFixed(2);
			$("#oneMoney").val(newoneMoney);
			$("#twoMoney").val(newtwoMoney);
		}else{
			if(newPayMoney!=SubPayMoney){
				newPayMoney = (parseFloat(SubPayMoney)-parseFloat(60)).toFixed(2);
				newoneMoney = (parseFloat(oneMoney)-parseFloat(30)).toFixed(2);
				newtwoMoney = (parseFloat(twoMoney)-parseFloat(30)).toFixed(2);
			}
			$("#timess_m").val(newPayMoney);
			$("#moneyPay").text(newPayMoney);
			$("#CostPay").text(newPayMoney);
			$("#oneMoney").val(newoneMoney);
			$("#twoMoney").val(newtwoMoney);
			$(this).prev().css("display","none");	
		}
	});
	
	//多选的单击按钮（订购延误取消险）
	$(".delayBxzhz").click(function(){			
		var payMoney = $("#timess_m").val();
		var oneMoney = $("#oneMoney").val();
		var twoMoney = $("#twoMoney").val();
		var SubPayMoney = payMoney;
		var newPayMoney = 0;
		var newoneMoney = 0;
		var newtwoMoney = 0;
		if($(this).attr("checked")=="checked"){
			$(this).prev().css("display","block");
			newPayMoney = (parseFloat(SubPayMoney)+parseFloat(40)).toFixed(2);
			$("#timess_m").val(newPayMoney);
			$("#moneyPay").text(newPayMoney);
			$("#CostPay").text(newPayMoney);
			newoneMoney = (parseFloat(oneMoney)+parseFloat(20)).toFixed(2);
			newtwoMoney = (parseFloat(twoMoney)+parseFloat(20)).toFixed(2);
			$("#oneMoney").val(newoneMoney);
			$("#twoMoney").val(newtwoMoney);
		}else{
			if(newPayMoney!=SubPayMoney){
				newPayMoney = (parseFloat(SubPayMoney)-parseFloat(40)).toFixed(2);
				newoneMoney = (parseFloat(oneMoney)-parseFloat(20)).toFixed(2);
				newtwoMoney = (parseFloat(twoMoney)-parseFloat(20)).toFixed(2);
			}
			$("#timess_m").val(newPayMoney);
			$("#moneyPay").text(newPayMoney);
			$("#CostPay").text(newPayMoney);
			$("#oneMoney").val(newoneMoney);
			$("#twoMoney").val(newtwoMoney);
			$(this).prev().css("display","none");	
		}
	});
	
	//多选的单击按钮（优惠选择）
	$(".youhuiBxzhz").click(function(){			
		var payMoney = $("#timess_m").val();
		var payMoneyTrue = $("#truess_m").val();
		var oneMoney = $("#oneMoney").val();
		var twoMoney = $("#twoMoney").val();
		var newPayMoney = 0;
		var youhuiType = $("#zhekouType").text();
		var youhuiMoney = $(this).val();
		payMoneyTrue = payMoneyTrue-(payMoneyTrue*(youhuiMoney/10));
		if($(this).attr("checked")=="checked"){
			$(this).prev().css("display","block");
			if(youhuiType == "preferential"){
				newPayMoney = (parseFloat(payMoney)-parseFloat(youhuiMoney)).toFixed(2);
				$("#timess_m").val(newPayMoney);
				$("#moneyPay").text(newPayMoney);
				$("#CostPay").text(newPayMoney);
				newoneMoney = (parseFloat(oneMoney)-parseFloat(youhuiMoney/2)).toFixed(2);
				newtwoMoney = (parseFloat(twoMoney)-parseFloat(youhuiMoney/2)).toFixed(2);
				$("#oneMoney").val(newoneMoney);
				$("#twoMoney").val(newtwoMoney);
			}else if(youhuiType == "discount"){
				newPayMoney = (parseFloat(payMoney)-parseFloat(payMoneyTrue)).toFixed(2);
				$("#timess_m").val(newPayMoney);
				$("#moneyPay").text(newPayMoney);
				$("#CostPay").text(newPayMoney);
				newoneMoney = (parseFloat(oneMoney)-parseFloat((payMoneyTrue/2))).toFixed(2);
				newtwoMoney = (parseFloat(twoMoney)-parseFloat((payMoneyTrue/2))).toFixed(2);
				$("#oneMoney").val(newoneMoney);
				$("#twoMoney").val(newtwoMoney);
			}
		}else{
			if(newPayMoney!=payMoney){
				if(youhuiType == "preferential"){
					newPayMoney = (parseFloat(payMoney)+parseFloat(youhuiMoney)).toFixed(2);
					$("#timess_m").val(newPayMoney);
					$("#moneyPay").text(newPayMoney);
					$("#CostPay").text(newPayMoney);
					newoneMoney = (parseFloat(oneMoney)+parseFloat(youhuiMoney/2)).toFixed(2);
					newtwoMoney = (parseFloat(twoMoney)+parseFloat(youhuiMoney/2)).toFixed(2);
					$("#oneMoney").val(newoneMoney);
					$("#twoMoney").val(newtwoMoney);
				}else if(youhuiType == "discount"){
					newPayMoney = (parseFloat(payMoney)+parseFloat(payMoneyTrue)).toFixed(2);
					$("#timess_m").val(newPayMoney);
					$("#moneyPay").text(newPayMoney);
					$("#CostPay").text(newPayMoney);
					newoneMoney = (parseFloat(oneMoney)+parseFloat((payMoneyTrue/2))).toFixed(2);
					newtwoMoney = (parseFloat(twoMoney)+parseFloat((payMoneyTrue/2))).toFixed(2);
					$("#oneMoney").val(newoneMoney);
					$("#twoMoney").val(newtwoMoney);
				}
			}
			$(".payMoney").text("￥"+newPayMoney);
			$(this).prev().css("display","none");	
		}
	});
});