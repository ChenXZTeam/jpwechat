<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>销售数据</title>
	<link rel="stylesheet" type="text/css"href="<%=basePath%>scripts/common/jquery-easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/default/datagrid.css">
    <script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
    <script src="<%=basePath%>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>console/js/echarts.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="<%=basePath %>console/js/airCodeVScity.js"></script>
</head>
<body>
     <div id="contain">
          <form id="qfm" action="">
                <div id="xsHeader" style="width:100%;padding-top:20px;">
                    
                     <span style="margin-left:30px">
                          <lable class="font-style">请输入时间:</lable>
                          <input type="text" id="lTime" class="easyui-datebox" data-options="prompt:'请输入时间'" style="width:150px;height:25px" >
                     </span>
                     <span style="margin-left:10px">
                          <lable class="font-style">至</lable>
                          <input type="text" id="TTime" class="easyui-datebox" data-options="prompt:'请输入时间'" style="width:150px;height:25px">
                     </span>
                     <span style="margin-left:50px">
                          <lable class="font-style">航空二字码</lable>
                          <input id="airCode" name="airCode" class="easyui-combobox" data-options="prompt:'航空公司二字码',panelHeight:'276',valueField:'value', textField:'text'"/>
                     </span>
                     <span style="position:relative;margin-left:800px; text-align:center; top:-27px; display:block;  overflow:hidden;">
			    	          <a href="javascript:void(0)" data-options="iconCls:'icon-search',plain:false" class="btnRes" onclick="find()"  style="width:80px;height: 28px;background-color: #01B5E6;border: none;cursor: pointer;outline: none;margin-left: 15px;color: #fff;display: block;float: left;line-height: 30px;text-decoration: none;border-radius:5px;">
                                 
                                 <span class="img_class">查询</span>
                              </a>
                     </span>
                </div>
          </form>
          <div id="grideBox" style="width:100%;">
               <a href="javascript:void(0)" data-options="iconCls:'icon-search',plain:false" class="btnRes" onclick="DCdate()"  style="width:80px;height: 28px;background-color: #01B5E6;border: none;cursor: pointer;outline: none;margin-left: 15px;color: #fff;display: block;float: left;line-height: 30px;text-decoration: none;border-radius:5px;">
                                 
                                 <span class="img_class">导出</span>
                    </a>
               <div  style="width:80%;height:600px;border:1px solid #C1C1C1;margin:0px auto">
                    
                    <div id="canvasDiv" style="width:100%;height:570px;"></div>
                   
               </div>
               
          </div>
      </div>
      <script type="text/javascript">
           var tempdate;
           function DCdate(){
             
              var numID=[];
              for(var i=0;i<tempdate.length;i++){
                 numID.push(tempdate[i].orderNum);
                 
              }
             
                 location.href="<%=basePath%>framework/SellDate/exportSellDate.action?numID="+numID+"";
                
           }
           $(function(){
               $.ajax({
                  type:'POST',
                  dataType:'JSON',
                  url:"<%=basePath%>framework/SellDate/showDate.action",
                  data:{},
                  success:function(data){
                      ss=data.state;
                      console.log(ss);
                      tempdate=ss;
                      canvas();
                  }
               })
               var data = [];
					var airCompany = JSON.stringify(getAircode());
					airCompany = airCompany.substring(1,airCompany.length-1);
					var chCompany = airCompany.split(",");
					for(var i=0; i<chCompany.length; i++){
						var codeAndName = chCompany[i].split(":");
						data.push({"value":codeAndName[0].substring(1,codeAndName[0].length-1),"text":codeAndName[0].substring(1,codeAndName[0].length-1)+"("+codeAndName[1].substring(1,codeAndName[1].length-1)+")"});
					}
					$("#airCode").combobox("loadData", data);	
           });
           
           function canvas(){
                var date=[];
                var dateLast=[];
                var hstype=[];
                inline=[];
                offline=[];
                for(var i=0; i<ss.length;i++){
                    var status=ss[i].orderStatus;
                    var a=ss[i].hangbanNum.substr(0, 2);
                    var b=findByCode(a)+"("+a+")";
                    //console.log("截取之后的b:"+b)
                    var Money=ss[i].costMoney;
                	date.push(formdate(b,status,Money));
                	
                }
                 
                 var norep=uniquePay(date);
                 for(var i=0;i<norep.length;i++){
                    dateLast.push(lastformdate(norep[i].aircode,0,0));
                    hstype.push(norep[i].aircode);
                 
               }
                 for(var i=0;i<date.length;i++){
                   for(var j=0;j<dateLast.length;j++){
		                 if(date[i].aircode==dateLast[j].aircode&&date[i].type==1){
						     dateLast[j].upmoney = parseInt(dateLast[j].upmoney)+parseInt(date[i].money);
					     }
					    else if(date[i].aircode==dateLast[j].aircode&&date[i].type==0){
							dateLast[j].dewomoney = parseInt(dateLast[j].dewomoney)+parseInt(date[i].money);
					    }
                  
                  }
                 }
                 
                 for(var a=0;a<dateLast.length;a++){
                    inline.push(dateLast[a].upmoney);
                    offline.push(dateLast[a].dewomoney);
                 }
                
                 
                 
                  
                 
             
            
       var myChart = echarts.init(document.getElementById('canvasDiv'));
              var option = {
                  tooltip:{
                      trigger:'axis',
                      axisPointer:{
                         type:'shadow'
                      }
                  },
                  legend:{
                      data:['线上','线下']
                  },
                  grid:{
                      left:'3%',
                      right:'4%',
                      bottom:'3%',
                      containLabel:true
                  },
                  xAxis:{
                      type:'value',
                  },
                  yAxis:{
                      type:'category',
                      data:hstype,
                  },
                  series:[
                  {
                      name:'线上',
                      type:'bar',
                      stack:'总价',
                      label:{
                           normal:{
                               show:true,
                               position:'insideRight'
                           }
                      },
                      data:inline 
                   },
                   {
                       name:'线下',
                       type:'bar',
                       stack:'总价',
                       label:{
                           normal:{
                               show:true,
                               position:'insideRight'
                           }
                       },
                       data:offline
                   },   
                      
                  ]
                  
                  
              };
              myChart.setOption(option);  
              
      }
     
       
  
         
        
        function uniquePay(paylist){
		    var payArr = [paylist[0]];
		    for(var i = 1; i < paylist.length; i++){
		        var payItem = paylist[i];
		        var repeat = false;
		        for (var j = 0; j < payArr.length; j++) {
		          if (payItem.aircode == payArr[j].aircode) {
		                 repeat = true;
		                 break;
		          }
		     	}
		        if (!repeat) {
		             payArr.push(payItem);
		        }
		    }
		    return payArr;
       }
           
           
           
          function formdate(aircode,type,money){
					 var chdate = {};
					 chdate.aircode = aircode;
					 chdate.type = type;
					 chdate.money = money;
					 return chdate;
          }
         function lastformdate(aircode,upmoney,dewomoney){
					 var chdate = {};
					 chdate.aircode = aircode;
					 chdate.upmoney = upmoney;
					 chdate.dewomoney = dewomoney;
					 return chdate;
         }
			 
			  function filterRepeatStr(str){
					var ar2 = str.split(",");
					var array = new Array();
					var j=0
					for(var i=0;i<ar2.length;i++){ 
						if((array == "" || array.toString().match(new RegExp(ar2[i],"g")) == null)&&ar2[i]!=""){ 
							array[j] =ar2[i]; 
							array.sort();
							j++;
						}
					}
					return array.toString();
				}
				
				//解析json数据中的重复数据
				function countJson(json){
					    var rdata = {};
						for(var i in json){
							var c = json[i].aircode;
							rdata[c] ? (rdata[c]++) : (rdata[c]= 1) ;
						}
						
						var strResult = "";
						for(var k in rdata){
							if(rdata[k] >= 1){
								for(var j=0;j<json.length;j++){
									if(json[j].aircode==k){
										strResult += "{'aircode':'"+k+"','value':"+rdata[k]+"},";
										break;
									}
								}
							}
						}
						return strResult;
				}
			 
           function find(){
             var ltime = $("#lTime").datebox("getValue");
            
             var TTime = $("#TTime").datebox("getValue");
            
             var a=ltime+TTime;
             
             if(a){
               $.ajax({
                   type:'POST',
                   dataType:'JSON',
                   url:"<%=basePath%>framework/SellDate/selldate.action",
                   data:{"ltime":ltime,"TTime":TTime},
                   success:function(data){
                       aa=data.state;
                       tempdate=aa;
                       ywtype();
                   }
                   
               })
             }
           }
          
           function ywtype(){
               var air = $("#airCode").combobox("getValue").trim();
               var List=[];
               var dateList=[];
               var gsType=[];
               var oninternet=[];
               var offinternet=[];
               if(air==""){
                  for(var i=0; i<aa.length;i++){
	                    
		                    var status=aa[i].orderStatus;
		                    var a=aa[i].hangbanNum.substr(0, 2);
		                    var b=findByCode(a)+"("+a+")";
		                    //console.log("截取之后的b:"+b);
		                    var Money=aa[i].costMoney;
		                	List.push(formdate(b,status,Money));
	                	
	                }
               }else{
               
	               for(var i=0; i<aa.length;i++){
	                    if(air==aa[i].hangbanNum.substr(0, 2)){
		                    var status=aa[i].orderStatus;
		                    var a=aa[i].hangbanNum.substr(0, 2);
		                    var b=findByCode(a)+"("+a+")";
		                    //console.log("截取之后的b:"+b);
		                    var Money=aa[i].costMoney;
		                	List.push(formdate(b,status,Money));
	                	}
	                }
               }
                 
                //console.log(List);
                
               var GS=uniquePay(List);
               for(var i=0;i<GS.length;i++){
                  dateList.push(lastformdate(GS[i].aircode,0,0));
                  gsType.push(GS[i].aircode);
               }
               //console.log(gsType);
               for(var i=0;i<List.length;i++){
                  for(var j=0;j<dateList.length;j++){
                     if(List[i].aircode==dateList[j].aircode&&List[i].type==1){
                       dateList[j].upmoney=parseInt(dateList[j].upmoney)+parseInt(List[i].money);
                     }else if(List[i].aircode==dateList[j].aircode&&List[i].type==0){
                       dateList[j].dewomoney = parseInt(dateList[j].dewomoney)+parseInt(List[i].money);
                     }
                  }
               }
               for(var c=0;c<dateList.length;c++){
                    oninternet.push(dateList[c].upmoney);
                    offinternet.push(dateList[c].dewomoney);
              }
              //console.log(oninternet);
              //console.log(offinternet);
              var myChart = echarts.init(document.getElementById('canvasDiv'));
              var option = {
	                    tooltip : {
                           trigger: 'axis',
                           axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                                type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                           }
                     },
                     legend: {
                           data: ['线上', '线下',]
                     },
                     grid: {
                         left: '3%',
                         right: '4%',
                         bottom: '3%',
                         containLabel: true
                     },
                     xAxis:  {
                         type: 'value'
                     },
                     yAxis: {
                         type: 'category',
                         data: gsType,
                     },
                     series: [
                      {
                          name: '线上',
                          type: 'bar',
                          stack: '总价',
                          label: {
                               normal: {
                                  show: true,
                                  position: 'insideRight' 
                               }
                          },
                          data:oninternet
                        },
                        {
                          name: '线下',
                          type: 'bar',
                          stack: '总价',
                          label: {
                              normal: {
                                 show: true,
                                 position: 'insideRight'
                              }
                          },
                          data:offinternet
                        },
                     ]
                    };
                    myChart.setOption(option);
                }
               
                
           
      
      </script>
</body>
</html>