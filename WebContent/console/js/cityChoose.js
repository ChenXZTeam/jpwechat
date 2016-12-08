//城市选择js文件
$(function(){	
	//设计案例切换
	$('.titleTab-list li').click(function(){
		var liindex = $('.titleTab-list li').index(this);
		$(this).addClass('onCountry').siblings().removeClass('onCountry');
		$('.product-wrap1 div.product1').eq(liindex).fadeIn(10).siblings('div.product1').hide();
		var liWidth = $('.titleTab-list li').width();
		$('.CityTab .titleTab-list p').stop(false,true).animate({'left' : liindex * liWidth + 'px'},0);
	});
	
	//城市选择
	$(".CityChoose").click(function(){	
		$(document).attr("title","城市选择");
		$(this).addClass("CityC");
		$("#CityCH").css("display","block");
	});
	
	//城市子类信息选择(热门)
	$("#CityCH>#remenCity>ul>li>.remenLi").click(function(){
		$(".CityC").text($(this).children(".cityName").text());
		$(".CityC").next().text($(this).children(".planeName").text());
		$(".CityC").next().next().text($(this).children(".airportCode").text());
		$(".CityChoose").removeClass("CityC");
		$(document).attr("title","机票查询");
		$("#CityCH").css("display","none");
	});
	
	//城市子类信息选择(城市链表)
	$("#CityCH #CityList>.zimuResult>.cityUL>li").click(function(){
		$(".CityC").text($(this).children(".cityName").text());
		$(".CityC").next().text($(this).children(".planeName").text());
		$(".CityC").next().next().text($(this).children(".airportCode").text());//获取点击选择城市之后隐藏于其中的机场代码
		//alert($(this).children(".airportCode").text());
		$(".CityChoose").removeClass("CityC");
		$(document).attr("title","机票查询");
		$("#CityCH").css("display","none");
	});
	
	//城市查找中的搜索按钮点击事件
	$("#finBtn").click(function(){
		var keyVal = $(".citySearch").val();
		$(".zimuResult>.cityUL>li>.cityName").removeAttr("id").filter(":contains(" + keyVal + ")").attr("id","CityResult");
	});
	//城市搜索输入框获得焦点时
	$("#citySearch").focus(function(){
		$("#pipeiValue").css("display","block");		
	});
	//隐藏城市字母列表的按钮点击方法
	var fals = true;
	$(".zimuListImgDiv").click(function(){
		if(fals==true){
			$(this).animate({right:"-2px"},200);
			$(this).next().animate({right:"-22px"},200);	
			$(this).children("img").css("transition","all 0s ease-in-out");
			$(this).children("img").css("transform","rotateZ(180deg)");
			fals=false;
		}else{
			$(this).animate({right:"20px"},200);
			$(this).next().animate({right:"0px"},200);
			$(this).children("img").css("transition","all 0s ease-in-out");
			$(this).children("img").css("transform","rotateZ(0deg)");
			fals=true;
		}
	});
});

//输入关键字的时候自动索引
function myFunction() {
	var keyVal = document.getElementById("citySearch").value;
	$(".zimuResult>.cityUL>li>.cityName").removeClass("chCity").filter(":contains(" + keyVal + ")").addClass("chCity");
	$("#pipeiValue").text("");
	for(var i=0; i<$(".chCity").length&&i!=6; i++){
		var cityname = $(".chCity:eq("+i+")").text();
		var palnename = $(".chCity:eq("+i+")").next().text();
		var airCodeName = $.trim($(".chCity:eq("+i+")").next().next().text());
		var dateList = '<div class="pipeiChildren" onclick="javascript:chaRes(this)"><span class="cityName01">'+cityname+'</span><span style="font-size:12px;" class="palneName01">（'+palnename+'）</span><span style="display:none;" class="airCode01">'+airCodeName+'</span></div>';
		$("#pipeiValue").append(dateList);
	}
}

//索引出来的结果的点击事件
function chaRes(inc){
	$(".CityC").text($(inc).children(".cityName01").text());//选择的城市名字
	var plname = $(inc).children(".palneName01").text();
	plname = plname.substring(1,plname.length-1);
	$(".CityC").next().text(plname);//选择的城市机场名
	$(".CityC").next().next().text($(inc).children(".airCode01").text());//选择的城市名字
	$("#pipeiValue").css("display","none");
	$(".CityChoose").removeClass("CityC");
	$(document).attr("title","机票查询");
	$("#CityCH").css("display","none");
}