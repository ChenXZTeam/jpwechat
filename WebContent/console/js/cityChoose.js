// 城市选择器
$(function(){
	//定义一个标签用户标识出发地和目的地
	var num;	
	//单程的出发地
	$("#shi001").click(function(e){
		var X = $('#shi001').offset().top; 
		var Y = $('#shi001').offset().left;
		$('.cityContent').css("top",(X+20)+"px");
		$('.cityContent').css("left",Y+"px");
		$(".cityContent").show();
		num=0;
	});
	//单程的目的地
	$("#zhong001").click(function(e){
		var X = $('#zhong001').offset().top; 
		var Y = $('#zhong001').offset().left;
		$('.cityContent').css("top",(X+20)+"px");
		$('.cityContent').css("left",(Y-120)+"px");
		$(".cityContent").show();
		num=1;
	});
	
	//返程的出发地
	$("#shif02").click(function(e){
		var X = $('#shif02').offset().top; 
		var Y = $('#shif02').offset().left;
		$('.cityContent').css("top",(X+20)+"px");
		$('.cityContent').css("left",Y+"px");
		$(".cityContent").show();
		num=2;
	});
	//返程的目的地
	$("#zhongf02").click(function(e){
		var X = $('#zhongf02').offset().top; 
		var Y = $('#zhongf02').offset().left;
		$('.cityContent').css("top",(X+20)+"px");
		$('.cityContent').css("left",(Y-120)+"px");
		$(".cityContent").show();
		num=3;
	});
	
	//城市选择背景的方法
	$(".A_G ul>li").click(function(){
		$(".A_G").find("li").removeClass('onCity');	
		$(this).addClass('onCity').siblings().removeClass('onCity');
		if(num==0){
			$("#shi001").text($(this).text());				
		}
		if(num==1){
			$("#zhong001").text($(this).text());				
		}
		if(num==2){
			$("#shif02").text($(this).text());				
		}
		if(num==3){
			$("#zhongf02").text($(this).text());				
		}
		$(".cityContent").hide();
	});	

});
