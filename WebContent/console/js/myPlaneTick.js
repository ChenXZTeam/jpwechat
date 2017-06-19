/**
 *  
 */
$(function(){	
	//修改乘机人资料
	$(".upUserMsg").click(function(){		
		var basePathJava = $("#basePathJava").text();
		var pnr = $(this).parent().siblings(".hiddenClass").children(".pnrNoDel").text();
		var orderNum = $(this).parent().siblings(".hiddenClass").children(".IDDel").text();
		window.location.href = basePathJava+"console/wechat/upUserMsg.jsp?orderNum="+orderNum+"&pnrNo="+pnr;
	});
	
	//同舱改期
	$(".sameCanbin").click(function(){	
		var basePathJava = $("#basePathJava").text();
		var pnr = $(this).parent().siblings(".hiddenClass").children(".pnrNoDel").text();
		var orderNum = $(this).parent().siblings(".hiddenClass").children(".orderNumDel").text();
		window.location.href = basePathJava+"console/wechat/upCanbin.jsp?orderNum="+orderNum+"&pnrNo="+pnr;
	});
	
});