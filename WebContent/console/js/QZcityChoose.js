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
		$(this).addClass("CityC");
		$("#CityCH").fadeIn();
	});
	
	//城市子类信息选择(热门)
	$("#CityCH>#remenCity>ul>li>.remenLi").click(function(){
		var country = $(this).text();
		var basePathID = $("#basePathID").text();
		window.location.href=basePathID+"console/wechat/qzOneCoInfo.jsp?countryName="+country+"&countryId=213543";
	});
	
	//城市子类信息选择(城市链表)
	$("#CityCH #CityList>.zimuResult>.cityUL>li").click(function(){
		var country = $(this).text();
		var basePathID = $("#basePathID").text();
		window.location.href=basePathID+"console/wechat/qzOneCoInfo.jsp?countryName="+country+"&countryId=213543";
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
	
	//点下锚点字母的时候
	$(".zimuOne a").click(function(){
		$(".zimuTishi").css("display","block");
		$(".zimuTishi").text($(this).text());		
	});
	
});

//输入关键字的时候自动索引
function myFunction() {
	var keyVal = document.getElementById("citySearch").value;
	$(".zimuResult>.cityUL>li").removeClass("chCity").filter(":contains(" + keyVal + ")").addClass("chCity");
	$("#pipeiValue").text("");
	for(var i=0; i<$(".chCity").length&&i!=6; i++){
		var cityname = $(".chCity:eq("+i+")").text();
		var palnename = $(".chCity:eq("+i+")").next().text();
		var airCodeName = $.trim($(".chCity:eq("+i+")").next().next().text());
		var dateList = '<div class="pipeiChildren" onclick="javascript:chaRes(this)"><span class="cityName01">'+cityname+'</span></div>';
		$("#pipeiValue").append(dateList);
	}
}

//索引出来的结果的点击事件
function chaRes(inc){
	var country = $(inc).children(".cityName01").text();//选择的城市名字
	var basePathID = $("#basePathID").text();
	window.location.href=basePathID+"console/wechat/qzOneCoInfo.jsp?countryName="+country+"&countryId=213543";
}