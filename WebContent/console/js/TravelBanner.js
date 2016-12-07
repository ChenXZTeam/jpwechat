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
	
	
	$(".contentText").swipe({
		swipe:function(event, direction, distance, duration, fingerCount) {
            if(direction == "left"){//向左切换的方法
            	if(n==imgLength-1){
        			var ctPosit=(n+1)*100;
        			$(".banner").append($(".b-img").clone()); //$(".b-img").clone()是克隆或者复制.b-img里面的内容
        			$(".b-img:last").css("left","100%");
        			$(".b-img:first").animate({"left":"-"+ctPosit+"%"},500);
        			$(".b-img:last").animate({"left":"0"},500);
        			n=0;
        			$(".b-list span:eq("+n+")").addClass("spcss").siblings("span").removeClass("spcss");
        		}
        		else{
        			n++;
        			var ctPosit=n*100;
        			$(".b-img").animate({"left":"-"+ctPosit+"%"},500);
        			$(".b-list span:eq("+n+")").addClass("spcss").siblings("span").removeClass("spcss");
        		}
            }else if(direction == "right"){//向右切换的方法
            	if(n==0){
        			var stPosit=imgLength*100;
        			var etPosit=(imgLength-1)*100;
        			$(".banner").prepend($(".b-img").clone());
        			$(".b-img:first").css("left","-"+stPosit+"%");
        			$(".b-img:last").animate({"left":"100%"},500);
        			$(".b-img:first").animate({"left":"-"+etPosit+"%"},500);
        			n=imgLength-1;
        			$(".b-list span:eq("+n+")").addClass("spcss").siblings("span").removeClass("spcss");
        		}
        		else{
        			n--;
        			var ctPosit=n*100;
        			$(".b-img").animate({"left":"-"+ctPosit+"%"},500);
        			$(".b-list span:eq("+n+")").addClass("spcss").siblings("span").removeClass("spcss");
        		}
            }
       }
	});

	//下面切换点的点击方法
	$(".b-list span").click(function(){
		var lsIndex=$(this).index();
		n=lsIndex;
		var ctPosit=n*100;
		$(".b-img").animate({"left":"-"+ctPosit+"%"},1000);
		$(this).addClass("spcss").siblings("span").removeClass("spcss");
	})
	
})
