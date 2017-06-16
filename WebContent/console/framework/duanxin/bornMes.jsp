<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>短信生成与发送</title>
	<link rel="stylesheet" type="text/css"href="<%=basePath%>scripts/common/jquery-easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/demo.css">
    <link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/default/datagrid.css">
    <script src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
    <script src="<%=basePath%>console/js/jquery-1.8.3.min.js"></script>
    <script src="<%=basePath%>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
    <script src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
     <div id="contain">
          <form id="qfm" action="">
                <div id="jpHeader">
                     <div style="width:1200px;padding-top:20px;">
                          <span>
                               <lable class="font-style">乘机人姓名:</lable>
                               <input id="Name" class="easyui-textbox" data-options="prompt:'请输入乘机人姓名'" style="width:150px;height:25px"></input>
                          </span>
                          <span style="margin-left:30px;">
                               <lable class="font-style">出发城市:</lable>
                               <input id="LCity" class="easyui-textbox" data-options="prompt:'请输入出发城市'" style="width:150px;height:25px"></input>
                          </span>
                          
                          <span style="margin-left:30px" >
                               <label class="font-style">出发时间:</label>
                               <input id="Ltime" class="easyui-datebox" data-options="prompt:'请输入出发时间'"  style="width:150px;height:25px"></input>
                          </span>
                          <span style="margin-left:30px">
                               <label class="font-style">模板类型:</label>
                              <select id="Mode" class="easyui-combobox" data-options="panelHeight:'auto'"  style="width:150px;height:25px;">
						             <option value="有票价模板" selected>有票价模板</option>
						             <option value="无票价模板">无票价模板</option>
					         </select> 
                          </span>
                           <span style="width:200px; position:relative;margin-left:1100px;  text-align:center;margin-right:-800px; top:-27px; display:block;  overflow:hidden;">
			    	          <a href="javascript:void(0)" data-options="iconCls:'icon-search',plain:false" class="btnRes" onclick="reset()"  style="width: 100px;height: 35px;background-color: #01B5E6;border: none;cursor: pointer;outline: none;margin-left: 15px;color: #fff;display: block;float: left;line-height: 30px;text-decoration: none;">
                                 <img src="<%=basePath%>/console/images/res.png"/>
                                 <span class="img_class">重置</span>
                              </a>
                          </span>
                          
                         
                         
                     </div>
                     <div style="width:1200px;">
                        <span>
                              <lable class="font_style">航&nbsp;&nbsp;班&nbsp;&nbsp;号&nbsp;&nbsp;:</lable>
                              <input id="number" class="easyui-textbox" data-options="prompt:'请输入航班号'" style="width:150px;height:25px"></input>
                          </span>
                         <span style="margin-left:30px">
                               <lable class="font-style">到达城市:</lable>
                               <input id="TCity" class="easyui-textbox" data-options="prompt:'请输入到达城市'" style="width:150px;height:25px"></input>
                         </span>
                         
                         <span style="margin-left:30px">
                               <lable class="font-style">证件号码:</lable>
                               <input id="zjNumber" class="easyui-textbox" data-options="prompt:'请输入证件号码'" style="width:150px;height:25px"></input>
                               
                         </span>
                         <span style="margin-left:30px">
                               <lable class="font-style">电话号码:</lable>
                               <input id="pnumber" class="easyui-textbox" data-options="prompt:'请输入电话号码'" style="width:150px;height:25px"></input>
                         </span>
                         <span style="width:200px; position:relative;margin-left:1100px; text-align:center; top:-27px; display:block;  overflow:hidden;">
                               <a href="javascript:void(0)" data-options="iconCls:'icon-search',plain:false"  class="btn_find"  onclick="query()" style="width:100px;height:35px;background-color:#01B5E6;border:none;cursor:pointer;outline:none;margin-left:15px;color:#fff;display:block;float:left;line-height:30px;text-decoration:none;"">
                                  <img src="<%=basePath %>/console/images/find.png"  />
						          <span class="img_class">生成</span>
                               </a>
                         </span>
                     </div>
                     
                     
                </div>
          </form>
          
          <div id="grideBox" style="width:100%;">
               <div id="dg" style="width:100%;height:100%;"></div>
          </div>
          
          <div id="tb" style="height:auto;">
	           <a id="SMSBtn_qx" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="sendMess()">短信发送</a>
	           <a id="lookSeeThis" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="lookSee()">查看详情</a>
	     </div>
	     
	     <div id="lookSeeBox" class="easyui-dialog" style="height:400px; width:400px;" closed="true">
	          <form id="lookForm">
	              <table id="tableStyle">
	                 <tr>
	                     <td>乘机人姓名:</td>
	                     <td><input type="text" name="linkName" readonly></input></td>
	                 </tr>
	                 <tr>
	                    <td>电话号码:</td>
	                    <td><input type="text" name="pnumber" readonly></input></td>
	                 </tr>
	                 <tr>
	                    <td>模板类型:</td>
	                    <td><input type="text" name="model" readonly></input></td>
	                 </tr>
	                 <tr>
	                    <td>航班号:</td>
	                    <td><input type="text" name="hanbanNum" readonly></input></td>
	                 </tr>
	                 <tr>
	                    <td>证件号码:</td>
	                    <td><input type="text" name="idcase" readonly></input></td>
	                 </tr>
	                 <tr>
	                    <td>出发城市:</td>
	                    <td><input type="text" name="chufCity" readonly></input></td>
	                 </tr>
	                 <tr>
	                    <td>到达城市:</td>
	                    <td><input type="text" name="daodCity" readonly></input></td>
	                 </tr>
	                 <tr>
	                    <td>出发时间:</td>
	                    <td><input type="text" name="chufTime" readonly></input></td>
	                 </tr>
	                 <tr>
	                    <td>发送内容:</td>
	                    <td><input type="text" name="mesText" readonly></input></td>
	                 </tr>
	                 <tr>
	                    <td>生成状态:</td>
	                    <td><input type="text" name="bornStatus" readonly></input></td>
	                 </tr>
	              </table>
	          </form>
	     </div>
     </div>
     
     <script type="text/javascript">
        $(function(){
           $("#grideBox").css("height",$(window).height()-155);
           $("#dg").datagrid({
               height:'100%',
               fit:true,
               method:'POST',
               striped:true,
               nowrap:true,
               pageSize:20,
               pageNumber:1,
               pageList:[10,20,50,100,150,200],
               pagination:true,
               showFooter:true,
               loadMsg:'数据加载中请稍后......',
               toolbar:'#tb',
               singleSelect:false,
               rownumbers:true,
               columns:[[
                      { field:'ck',checkbox:true},
                      { field:'linkName',title:'乘机人姓名',width:'7%'},
                      { field:'PhoneNumber',title:'电话号码',width:'10%'},
                      { field:'model',title:'模板类型',width:'10%'},
                      { field:'hangbanNum',title:'航班号',width:'10%'},
                      { field:'iDcase',title:'证件号码',width:'10%'},
                      { field:'chufCity',title:'出发城市',width:'10%'},
                      { field:'daodCity',title:'到达城市',width:'10%'},
                      { field:'chufTime',title:'出发时间',width:'10%'},
                      { field:'content',title:'发送内容',width:'30%'},
                      { field:'BornStatus',title:'生成状态',width:'15%'}
               ]]
               
           })
          
        });
        
        function reset(){
        $("#Name").textbox('setValue',"");
        $("#LCity").textbox('setValue',"");
        $("#Ltime").datebox('setValue',"");
        $("#zjNumber").textbox('setValue',"");
        $("#number").textbox('setValue',"");
        $("#TCity").textbox('setValue',"");
        $("#Money").textbox('setValue',"");
        $("#Mode").combobox('select', "有票价模板")
                  
        };
        
        function query(){
          var linkName=$("#Name").textbox('getValue').trim(); //删除开始和结尾的空格
          var chufCity=$("#LCity").textbox('getValue').trim();
          var iDcase=$("#zjNumber").textbox('getValue').trim();
          var chufTime=$("#Ltime").val().trim();
          var hangbanNum=$("#number").textbox('getValue').trim();
          var daodCity=$("#TCity").textbox('getValue').trim();
          var PhoneNumber=$("#pnumber").textbox('getValue').trim();//获取手机号码
          var model=$("#Mode").combobox('getValue').trim();
          if(linkName==""){
           alert("乘机人姓名是必填项")
            return false;
          }
          if(iDcase==""){
           alert("证件号码是必填项")
            return false;
          }
          $('#dg').datagrid({
             height:'100%',
             fit:true,
             url:'<%=basePath%>framework/jpborn/query.action',
             queryParams:{
                 "linkName":linkName,
                 "chufCity":chufCity,
                 "chufTime":chufTime,
                 "iDcase":iDcase,
                 "hangbanNum":hangbanNum,
                 "daodCity":daodCity,
                 "model":model,
                 "Pnumber":PhoneNumber,
             },
             method:'POST',
             striped:true,
             nowrap:true,
             pageSize:20,
             pageNumber:1,
             pageList:[10,20,50,100,150,200],
             pagination: true,
             showFooter: true,
             loadMsg: '数据加载中请稍后……',
             toolbar:"#tb",
             singleSelect: false,
             rownumbers:true,
             columns:[[
                      { field:'ck',checkbox:true},
                      { field:'linkName',title:'乘机人姓名',width:'7%'},
                      { field:'pnumber',title:'电话号码',width:'10%'},
                      { field:'model',title:'模板类型',width:'10%'},
                      { field:'hanbanNum',title:'航班号',width:'10%'},
                      { field:'idcase',title:'证件号码',width:'10%'},
                      { field:'chufCity',title:'出发城市',width:'10%'},
                      { field:'daodCity',title:'到达城市',width:'10%'},
                      { field:'chufTime',title:'出发时间',width:'10%'},
                      { field:'mesText',title:'发送内容',width:'30%'},
                      { field:'bornStatus',title:'生成状态',width:'15%'}
                      
               ]]
           
               
          
          });
        }
        
        function sendMess(){
          var row=$('#dg').datagrid('getChecked');
          var rowsJson = [];
          var rowshuzu= new Array(row.length);
          if(row.length==0){
               $.messager.alert('Warning','请选择要发送的记录');
               return false;
          }
          for(var i=0;i<row.length;i++){
             if((row[i].bornStatus).indexOf("失败")>=0){
               $.messager.alert('Warning','不能选择生成"失败"的短信模板,请重新选择！');
               return false;
             }
          }
          for(var i=0;i<row.length;i++){
             rowshuzu[i]=row[i].pnumber;
             rowsJson.push(fusionjsonUser(row[i].pnumber,row[i].mesText));
          }
          var jsonString = JSON.stringify(rowsJson);
          if(arrRepeat(rowshuzu)){
             $.messager.confirm('确定','是否继续执行发送',function(r){
               if(r){
                 $.ajax({
                    type:"POST",
                    data:{"rowsJSON":jsonString},
                    dataType:'json',
                    url:"<%=basePath%>framework/jpborn/sandMes.action",
                    success:function(data){
                        console.log(data.errorMes);
                        if(data.errorMes=="发送成功"){
                            $.messager.alert('发送状态:',data.errorMes);
                            $("#dg").datagrid("loadData",{total:0,rows:[]});
                        }else{
                            $.messager.alert('发送状态:','短信发送不成功的手机有:'+data.errorMes+',短信发送成功的手机有:'+data.seccus);
                        }
                    }
                 });
               }
             });
       
          
        }else{
           $.ajax({
              type: "POST",
	          data:{"rowsJson":jsonString},
	          dataType: 'json',
	          url:"<%=basePath%>framework/jpborn/sandMes.action",
	          success:function(data){
	              console.log(data.errorMes);
	              if(data.errorMes=="发送成功"){
	                 $.messager.alert('发送状态：', data.errorMes);
	                 $('#dg').datagrid('loadData',{total:0,rows:[]});
	              }else{
            		$.messager.alert('发送状态：', '短信发送不成功的手机有：'+data.errorMes+',发送成功的手机：'+data.seccus); 
            	}
	          }
           });
        }
   }
   
   //fusioncharts格式化json数据	 
function fusionjsonUser(label, value){
	var jsonStr = {};
	jsonStr.label = label;
	jsonStr.value = value;
	return jsonStr;
}

function arrRepeat(arr){
	var arrStr = JSON.stringify(arr),str;
	for (var i = 0; i < arr.length; i++) {
		if (arrStr.indexOf(arr[i]) != arrStr.lastIndexOf(arr[i])){
			alert("短信号码"+arr[i]+"重复：将在发送的时候会自动删除重复发送到同一个手机号码的数据，请检查!"); 
			return true;
		}
	};
	return false;
}

function lookSee(){
    var row=$('#dg').datagrid('getChecked');
    if(row.length==0){
        $.messager.alert("操作提示",'没有选择被操作的记录！','warning');
        return false;
    }
    if(row.length>1){
       $.messager.alert("操作提示","只能选择一条操作记录",'warning');
    }
    $('#lookForm').form('load',row[0]);
	$('#lookSeeBox').dialog('open').dialog('setTitle','查看详情');
    
    
}
     </script>
    
</body>
</html>