$(function(){
	//多选的单击按钮（订购航空意外险）直达
	$(".flindYw").click(function(){	
		var ywaicod = $("#ywaicoid").text().trim();
		if($(this).attr("checked")=="checked"){
			$(this).prev().css("display","block");
			var li = '<li id="yiwLi"><div style="margin-left:15px;">x1</div><div style="width:80px;">￥<span id="yiwaiBxPay" class="kl">'+ywaicod+'</span>/人</div><div style="width:100px; margin-right:50px;">意外险</div></li>';
			$("#costXq").append(li);
			$("#cost").text(parseInt($("#cost").text())+parseInt(ywaicod));
		}else{
			$(this).prev().css("display","none");	
			$("#yiwLi").remove();
			$("#cost").text(parseInt($("#cost").text())-parseInt(ywaicod));
		}
	});
	
	//多选的单击按钮（订购延误取消险）直达
	$(".delayBx").click(function(){	
		var ywcostid = $("#ywcostid").text().trim(); 
		if($(this).attr("checked")=="checked"){
			$(this).prev().css("display","block");
			var li = '<li id="yawLi"><div style="margin-left:15px;">x1</div><div style="width:80px;">￥<span id="yiwaiBxPay" class="kl">'+ywcostid+'</span>/人</div><div style="width:100px; margin-right:50px;">延误险</div></li>';
			$("#costXq").append(li);
			$("#cost").text(parseInt($("#cost").text())+parseInt(ywcostid));
		}else{
			$(this).prev().css("display","none");	
			$("#yawLi").remove();
			$("#cost").text(parseInt($("#cost").text())-parseInt(ywcostid));
		}
	});
	
	//多选的单击按钮（优惠选择）
	/*$(".youhuiBx").click(function(){			
		var payMoney = $("#moneyPay").text();
		var youhuiType = $("#zhekouType").text();
		var youhuiMoney = $(this).val();
		var cp = 0;
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
	});*/
	
	//多选的单击按钮（订购航空意外险）中转和往返
	$(".flindYwzhz").click(function(){	
		var ywaicod = $("#ywaicoid").text().trim();
		if($(this).attr("checked")=="checked"){
			$(this).prev().css("display","block");
			var li = '<li id="yiwLi"><div style="margin-left:15px;">x2</div><div style="width:80px;">￥<span id="yiwaiBxPay" class="kl">'+parseInt(ywaicod)+'</span>/人</div><div style="width:100px; margin-right:50px;">意外险</div></li>';
			$("#costXq").append(li);
			$("#countPay").text(parseInt($("#countPay").text())+(parseInt(ywaicod)*2));
		}else{
			$(this).prev().css("display","none");	
			$("#yiwLi").remove();
			$("#countPay").text(parseInt($("#countPay").text())-(parseInt(ywaicod)*2));
		}
	});
	
	//多选的单击按钮（订购延误取消险）中转和往返
	$(".delayBxzhz").click(function(){		
		var ywcostid = $("#ywcostid").text().trim(); 
		if($(this).attr("checked")=="checked"){
			$(this).prev().css("display","block");
			var li = '<li id="yawLi"><div style="margin-left:15px;">x2</div><div style="width:80px;">￥<span id="yiwaiBxPay" class="kl">'+parseInt(ywcostid)+'</span>/人</div><div style="width:100px; margin-right:50px;">延误险</div></li>';
			$("#costXq").append(li);
			$("#countPay").text(parseInt($("#countPay").text())+(parseInt(ywcostid)*2));
		}else{
			$(this).prev().css("display","none");	
			$("#yawLi").remove();
			$("#countPay").text(parseInt($("#countPay").text())-(parseInt(ywcostid)*2));
		}
	});
	
	//多选的单击按钮（报销单）直达航班
	$(".baoxiao").click(function(){	
		var kdcostid = $("#kdcostid").text().trim(); 
		if($(this).attr("checked")=="checked"){
			$(this).prev().css("display","block");
			var li = '<li id="baoxiaoLi"><div style="margin-left:15px;">x1</div><div style="width:80px;">￥<span id="yiwaiBxPay" class="kl">'+kdcostid+'</span>/人</div><div style="width:100px; margin-right:50px;">快递费</div></li>';
			$("#costXq").append(li);
			$("#cost").text(parseInt($("#cost").text())+parseInt(kdcostid));
			$("#sendAddBox").css("display","block");
		}else{
			$(this).prev().css("display","none");	
			$("#baoxiaoLi").remove();
			$("#cost").text(parseInt($("#cost").text())-parseInt(kdcostid));
			$("#sendAddBox").css("display","none");
		}
	});
	
	//多选的单击按钮（报销单）中转和往返
	$(".baoxiaoDc").click(function(){		
		var kdcostid = $("#kdcostid").text().trim(); 
		if($(this).attr("checked")=="checked"){
			$(this).prev().css("display","block");
			var li = '<li id="baoxiaoLi"><div style="margin-left:15px;">x2</div><div style="width:80px;">￥<span id="yiwaiBxPay" class="kl">'+(parseInt(kdcostid)/2)+'</span>/人</div><div style="width:100px; margin-right:50px;">快递费</div></li>';
			$("#costXq").append(li);
			$("#countPay").text(parseInt($("#countPay").text())+parseInt(kdcostid));
			$("#sendAddBox").css("display","block");
		}else{
			$(this).prev().css("display","none");	
			$("#baoxiaoLi").remove();
			$("#countPay").text(parseInt($("#countPay").text())-parseInt(kdcostid));
			$("#sendAddBox").css("display","none");
		}
	});
});