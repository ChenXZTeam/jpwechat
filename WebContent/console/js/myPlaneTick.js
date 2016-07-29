/**
 *  
 */
$(function(){	
	var fals=true;
	$(".xialaImg").click(function(){
		if(fals==true){		
			$(this).children("img").css("transition","all 0.4s ease-in-out");
			$(this).children("img").css("transform","rotateZ(90deg)");
			$(this).siblings(".movement").animate({height:"50px"},400);
			fals=false;
		}else{
			$(this).children("img").css("transition","all 0.4s ease-in-out");
			$(this).children("img").css("transform","rotateZ(-0deg)");		
			$(this).siblings(".movement").animate({height:"0px"},400);
			fals=true;
		}
		//$(this).siblings(".hiddenClass")
	});
	
	$(".deleteThis").click(function(){
		var basePathJava = $("#basePathJava").text();
		var pnr = $(this).parent().siblings(".hiddenClass").children(".pnrNoDel").text();
		var orderNum = $(this).parent().siblings(".hiddenClass").children(".orderNumDel").text();
		var id = $(this).parent().siblings(".hiddenClass").children(".IDDel").text();
		if(pnr==""||pnr=="null"||pnr==null){
			alert("参数不匹配，删除失败1");
			return false;
		}else if(orderNum==""||orderNum=="null"||orderNum==null){
			alert("参数不匹配，删除失败2");
			return false;
		}else if(id==""||id=="null"||id==null){
			alert("参数不匹配，删除失败3");
			return false;
		}else{
			$.ajax({
				url:basePathJava+"userOrderController/delete/order.action",
				type:"POST",
				data:{"pnrNo":pnr, "orderNum":orderNum, "ID":id},
				dataType:"json",
				success:function(res){
					window.location.reload();
					alert("删除成功");
				},error:function(){
					
				}
			});
		}
	});
});