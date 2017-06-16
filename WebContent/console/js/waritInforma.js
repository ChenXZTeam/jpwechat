$(function(){
	//多选的单击按钮（订购航空意外险）
	$(".flindYw").click(function(){	
		if($(this).attr("checked")=="checked"){
			$(this).prev().css("display","block");
			var li = '<li id="yiwLi"><div style="margin-left:15px;">x1</div><div style="width:80px;">￥<span id="yiwaiBxPay" class="kl">30</span>/人</div><div style="width:100px; margin-right:50px;">意外险</div></li>';
			$("#costXq").append(li);
			$("#cost").text(parseInt($("#cost").text())+30);
		}else{
			$(this).prev().css("display","none");	
			$("#yiwLi").remove();
			$("#cost").text(parseInt($("#cost").text())-30);
		}
	});
	
	//多选的单击按钮（订购延误取消险）
	$(".delayBx").click(function(){			
		if($(this).attr("checked")=="checked"){
			$(this).prev().css("display","block");
			var li = '<li id="yawLi"><div style="margin-left:15px;">x1</div><div style="width:80px;">￥<span id="yiwaiBxPay" class="kl">20</span>/人</div><div style="width:100px; margin-right:50px;">延误险</div></li>';
			$("#costXq").append(li);
			$("#cost").text(parseInt($("#cost").text())+20);
		}else{
			$(this).prev().css("display","none");	
			$("#yawLi").remove();
			$("#cost").text(parseInt($("#cost").text())-20);
		}
	});
	
	//多选的单击按钮（优惠选择）
	$(".youhuiBx").click(function(){			
		var payMoney = $("#moneyPay").text();
		var youhuiType = $("#zhekouType").text();
		var youhuiMoney = $(this).val();
		var cp = 0;
		//alert("机票价："+payMoney+", 邀请码类型："+youhuiType+", 优惠或者折扣数："+youhuiMoney);
		if($(this).attr("checked")=="checked"){
			$(this).prev().css("display","block");
			if(youhuiType == "preferential"){
				$("#crTelkBox").remove();
				var liList = '<li id="crTelkBox"><div style="margin-left:15px;">x1</div><div style="width:80px;">￥<span id="moneyPay" class="kl">'+(parseInt(payMoney)-parseInt(youhuiMoney))+'</span>/人</div><div style="width:100px; margin-right:50px;">成人票(优惠'+youhuiMoney+')</div></li>';
				$("#sign").after(liList);
			}else if(youhuiType == "discount"){
				$("#crTelkBox").remove();
				var zhekou = youhuiMoney/10;
				var liList = '<li id="crTelkBox"><div style="margin-left:15px;">x1</div><div style="width:80px;">￥<span id="moneyPay" class="kl">'+(parseInt(payMoney)*zhekou)+'</span>/人</div><div style="width:100px; margin-right:50px;">成人票(折扣'+zhekou+')</div></li>';
				$("#sign").after(liList);
			}
			for(var i = 0;i<$(".kl").length;i++){
				cp+= parseInt($(".kl:eq("+i+")").text());
			}
			$("#cost").text(cp);
		}else{
			if(youhuiType == "preferential"){
				$("#crTelkBox").remove();
				var liList = '<li id="crTelkBox"><div style="margin-left:15px;">x1</div><div style="width:80px;">￥<span id="moneyPay" class="kl">'+(parseInt(payMoney)+parseInt(youhuiMoney))+'</span>/人</div><div style="width:100px; margin-right:50px;">成人票</div></li>';
				$("#sign").after(liList);
			}else if(youhuiType == "discount"){
				$("#crTelkBox").remove();
				var zhekou = youhuiMoney/10;
				var liList = '<li id="crTelkBox"><div style="margin-left:15px;">x1</div><div style="width:80px;">￥<span id="moneyPay" class="kl">'+(parseInt(payMoney)/zhekou)+'</span>/人</div><div id="pstTypeName" style="width:100px; margin-right:50px;">成人票</div></li>';
				$("#sign").after(liList);
			}
			$(this).prev().css("display","none");
			for(var i = 0;i<$(".kl").length;i++){
				cp+= parseInt($(".kl:eq("+i+")").text());
			}
			$("#cost").text(cp);
		}
	});
	
	//多选的单击按钮（订购航空意外险）
	$(".flindYwzhz").click(function(){	
		if($(this).attr("checked")=="checked"){
			$(this).prev().css("display","block");
			var li = '<li id="yiwLi"><div style="margin-left:15px;">x2</div><div style="width:80px;">￥<span id="yiwaiBxPay" class="kl">30</span>/人</div><div style="width:100px; margin-right:50px;">意外险</div></li>';
			$("#costXq").append(li);
			$("#countPay").text(parseInt($("#countPay").text())+60);
		}else{
			$(this).prev().css("display","none");	
			$("#yiwLi").remove();
			$("#countPay").text(parseInt($("#countPay").text())-60);
		}
	});
	
	//多选的单击按钮（订购延误取消险）
	$(".delayBxzhz").click(function(){			
		if($(this).attr("checked")=="checked"){
			$(this).prev().css("display","block");
			var li = '<li id="yawLi"><div style="margin-left:15px;">x2</div><div style="width:80px;">￥<span id="yiwaiBxPay" class="kl">20</span>/人</div><div style="width:100px; margin-right:50px;">延误险</div></li>';
			$("#costXq").append(li);
			$("#countPay").text(parseInt($("#countPay").text())+40);
		}else{
			$(this).prev().css("display","none");	
			$("#yawLi").remove();
			$("#countPay").text(parseInt($("#countPay").text())-40);
		}
	});
	
	//多选的单击按钮（优惠选择）
	$(".baoxiao").click(function(){			
		if($(this).attr("checked")=="checked"){
			$(this).prev().css("display","block");
		}else{
			$(this).prev().css("display","none");	
		}
	});
});