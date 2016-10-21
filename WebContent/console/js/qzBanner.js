//全屏滚动
$(function(){
	var n=0;
	var imgLength=$(".b-img .runDiv").length;
	var ctWidth=imgLength*100;
	var itemWidth=1/imgLength*100;
	$(".b-img").width(ctWidth+"%");
	$(".b-img .runDiv").width(itemWidth+"%");
	$(".b-list").width(imgLength*20);
	if(imgLength>1)
	{	//根据图片的多少就增加多少个切换点
		for(var i=0;i<imgLength;i++)
		{
			var listSpan=$("<span></span>")
			$(".b-list").append(listSpan);
		}
	}
	
	$(".b-list span:eq(0)").addClass("spcss").siblings("span").removeClass("spcss");  //在显示的图片对应的切换点的地方增加spcss类，同时移除其他含有spcss的类
	
	
	//下面切换点的点击方法
	$(".b-list span").click(function(){
		var lsIndex=$(this).index();
		n=lsIndex;
		var ctPosit=n*100;
		$(".b-img").animate({"left":"-"+ctPosit+"%"},1000);
		$(this).addClass("spcss").siblings("span").removeClass("spcss");
	})
	//自动切换的方法
	function rollEnvent(){
		if(n==imgLength-1){
			var ctPosit=(n+1)*100;
			$(".banner").append($(".b-img").clone());
			$(".b-img:last").css("left","100%");
			$(".b-img:first").animate({"left":"-"+ctPosit+"%"},1000);
			$(".b-img:last").animate({"left":"0"},1000);
			var setTime0=setTimeout(function () {
            	$(".banner .b-img:first").remove();
            }, 1000);
			n=0;
			$(".b-list span:eq(0)").addClass("spcss").siblings("span").removeClass("spcss");
		}
		else{
			n++;
			var ctPosit=n*100;
			$(".b-img").animate({"left":"-"+ctPosit+"%"},1000);
			$(".b-list span:eq("+n+")").addClass("spcss").siblings("span").removeClass("spcss");
		}
	}
	
	var slidesetInterval=setInterval(rollEnvent,3000);
	
	
})
