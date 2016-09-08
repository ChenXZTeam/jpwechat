/**
 * 这个js文件是被upCanbin.jsp页面调用的。用途请查看界面
 */
$(function(){
	var daodTime = null;
	//确认预订的按钮方法
	$(".upMSGbtn").click(function(){
		var $dome = $(this).parents(".infoFiletghtLi").children(".infoFiletght").children(".smalldivClass");
		var flightNo = $dome.children(".flightNo").text();
		var cangwei = $dome.children(".cangwei").text();
		var chufDate = $dome.children(".chufDate").text();
		var depTime = $dome.children(".depTime").text();
		daodTime = $dome.children(".daodTime").text();
		
		//给确认信息的界面赋予新的值
		$("#chufDateTime").text(chufDate+" "+depTime);
		$("#fildNum").text(flightNo);
		var height = $("#fildDataList").height();
		$(".MsgSureBox").css("height",height+5).css("display","block");
	});
	
	
	//信息确认中的提交按钮
	$("#submitBtn").click(function(){
		var basePathJava = $("#basePathJava").text();
		var pnrNo = $("#pnrNo").val();
		var orderNum = $("#orderNum").val();
		var chufDate = $("#chufDate").val(); //旧的出发日期
		var fildNO = $("#fildNO").val(); //旧的航班号
		var NoTime = $("#chufDateTime").text();
		var newChufDate = NoTime.split(" ")[0];//新的出发日期
		var newChufTime = NoTime.split(" ")[1];//新的出发时间
		var fildNum = $("#fildNum").text(); //新的航班号
			$.ajax({
			url:basePathJava+"userOrderController/update/changeDate.action",
			type:"POST",
			data:{"pnrNo":pnrNo,"orderNum":orderNum,"fltDateOld":chufDate,"fltNoOld":fildNO,"fltDateNew":newChufDate,"chufTime":newChufTime,"fltNoNew":fildNum,"daodTime":daodTime},
			dataType:"json",
			success:function(res){
				if(res.msg==1){
					alert("改签成功！");
				}else{
					alert("改签失败！");
				}
			},error:function(){
				
			}
		});
	});
	
	//信息确认中的取消按钮
	$("#colseThis").click(function(){
		$(".MsgSureBox").css("display","none");
	});
});
