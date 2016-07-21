// ����ѡ����
$(function(){
	//����һ����ǩ�û���ʶ�����غ�Ŀ�ĵ�
	var num;	
	//���̵ĳ�����
	$("#shi001").click(function(e){
		var X = $('#shi001').offset().top; 
		var Y = $('#shi001').offset().left;
		$('.cityContent').css("top",(X+20)+"px");
		$('.cityContent').css("left",Y+"px");
		$(".cityContent").show();
		num=0;
	});
	//���̵�Ŀ�ĵ�
	$("#zhong001").click(function(e){
		var X = $('#zhong001').offset().top; 
		var Y = $('#zhong001').offset().left;
		$('.cityContent').css("top",(X+20)+"px");
		$('.cityContent').css("left",(Y-120)+"px");
		$(".cityContent").show();
		num=1;
	});
	
	//���̵ĳ�����
	$("#shif02").click(function(e){
		var X = $('#shif02').offset().top; 
		var Y = $('#shif02').offset().left;
		$('.cityContent').css("top",(X+20)+"px");
		$('.cityContent').css("left",Y+"px");
		$(".cityContent").show();
		num=2;
	});
	//���̵�Ŀ�ĵ�
	$("#zhongf02").click(function(e){
		var X = $('#zhongf02').offset().top; 
		var Y = $('#zhongf02').offset().left;
		$('.cityContent').css("top",(X+20)+"px");
		$('.cityContent').css("left",(Y-120)+"px");
		$(".cityContent").show();
		num=3;
	});
	
	//����ѡ�񱳾��ķ���
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
	
	//设计案例切换
	$('.titleTab-list li').click(function(){
		var liindex = $('.titleTab-list li').index(this);
		$(this).addClass('onCountry').siblings().removeClass('onCountry');
		$('.product-wrap1 div.product1').eq(liindex).fadeIn(10).siblings('div.product1').hide();
		var liWidth = $('.titleTab-list li').width();
		$('.CityTab .titleTab-list p').stop(false,true).animate({'left' : liindex * liWidth + 'px'},0);
	});
});
