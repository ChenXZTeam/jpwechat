$(function(){
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