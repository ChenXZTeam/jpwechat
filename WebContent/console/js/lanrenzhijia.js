$(function(){	
	
	//设计案例切换
	$('.title-list li').click(function(){
		var liindex = $('.title-list li').index(this);
		$(this).addClass('on').siblings().removeClass('on');
		$('.product-wrap div.product').eq(liindex).fadeIn(150).siblings('div.product').hide();
		var liWidth = $('.title-list li').width();
		$('.lanrenzhijia .title-list p').stop(false,true).animate({'left' : liindex * liWidth + 'px'},0);
	});

	
	//获取系统时间 显示当前是星期几并选择
	var dayNames = new Array("周日","周一","周二","周三","周四","周五","周六");
	Stamp = new Date();
	var week = dayNames[Stamp.getDay()];
	for(var i=0;i<7;i++){
		var liText = $(".title-list").find("li").eq(i).text();
		if(week==liText){
			$(".title-list li").eq(i).text("今天");
			$('.title-list li').eq(i).addClass('on').siblings().removeClass('on');
			$('.product-wrap div.product').eq(i).fadeIn(150).siblings('div.product').hide();
			var liWidth = $('.title-list li').width();
			$('.lanrenzhijia .title-list p').stop(false,true).animate({'left' : i * liWidth + 'px'},0);
			return false;
		}
	
	}
	
	

});


