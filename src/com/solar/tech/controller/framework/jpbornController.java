package com.solar.tech.controller.framework;

import java.io.IOException;
import java.net.MalformedURLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;























import com.solar.tech.bean.DuanxinExample;
import com.solar.tech.bean.entity.PhoneAndText;
import com.solar.tech.bean.PhoneNum;
import com.solar.tech.bean.entity.jpmesBorn;
import com.solar.tech.bean.entity.phoneMess;
import com.solar.tech.bean.entity.userOrderInfo;
import com.solar.tech.service.jpbornService;
import com.solar.tech.utils.Send106msg;


@Controller
@RequestMapping("/framework/jpborn")
public class jpbornController {
    
	@Autowired
	private jpbornService bornService;
	
	
	@RequestMapping(value = "/query.action", method = RequestMethod.POST)
	@ResponseBody
    public Map<String ,Object> query(String linkName,String chufCity,String chufTime,String hangbanNum,String daodCity,String model,String Pnumber,String iDcase){
		Map<String ,Object> map=new HashMap<String,Object>();
		List<jpmesBorn> mesBorn = new ArrayList<jpmesBorn>();
		List<userOrderInfo> orderList=bornService.queryOrder(linkName, chufCity, chufTime, hangbanNum, daodCity,iDcase,Pnumber); //查询订单，匹配条件
		System.out.println(orderList.size());
		if(orderList.size()<=0){
			jpmesBorn chMesBorn=new jpmesBorn();
			chMesBorn.setBornStatus("失败：没有符合条件的订单信息");
			mesBorn.add(chMesBorn);
			map.put("rows", mesBorn);
			return map;
		}
		List<DuanxinExample> mesmodeList=bornService.queryModelMes(model); //获取模板内容
		if(mesmodeList.size()<=0){
			jpmesBorn chMesBorn=new jpmesBorn();
			chMesBorn.setBornStatus("失败:没有符合的短信模板");
			mesBorn.add(chMesBorn);
			map.put("rows", mesBorn);
			return map;
		}


		for(userOrderInfo chOrder :orderList){
			        
					jpmesBorn chMesBorn=new jpmesBorn();
					chMesBorn.setChufCity(chOrder.getChufCity()); //出发城市从订单中拿
					chMesBorn.setDaodCity(chOrder.getDaodCity()); //到达城市从订单中拿
					chMesBorn.setChufTime(chOrder.getChufDate()); //出发时间从订单中拿
					chMesBorn.setDaodTime(chOrder.getDaodDate()); //到达时间从订单中拿
					chMesBorn.setHanbanNum(chOrder.getHangbanNum()); //航班号从订单中去拿
					chMesBorn.setLinkName(chOrder.getLinkName());  //乘机人姓名从订单中去拿
					chMesBorn.setIDcase(chOrder.getIDcase());       //身份证号码从订单里面拿
					chMesBorn.setPnumber(chOrder.getLinkPhoneNum()); //拿到联系人的电话号码
					
					
					for(DuanxinExample chMesmode:mesmodeList){
						if(model.equals(chMesmode.getModel())){
							String sendMesText=sendMesText(chMesmode.getText(),chOrder);
							switch(sendMesText){
							    case "0":
							    	System.out.println("乘机人姓名为空");
							    	chMesBorn.setBornStatus("失败:订单中的乘机人姓名为空");break;
							    case "1":
							    	System.out.println("航空号为空");
							    	chMesBorn.setBornStatus("失败:订单中的航空好为空");
							    case "2":
							    	System.out.println("出发城市为空");
							    	chMesBorn.setBornStatus("失败:订单中的出发城市为空");
							    case "3":
							    	System.out.println("到达城市为空");
							    	chMesBorn.setBornStatus("失败:订单中的到达城市为空");
							    case "4":
							    	System.out.println("出发日期为空");
							    	chMesBorn.setBornStatus("失败:订单中的出发日期为空");
							    case "5":
							    	System.out.println("到达日期为空");
							    	chMesBorn.setBornStatus("失败:订单中的到达日期为空");
							    case "6":
							    	System.out.println("总金额数为空");
							    	chMesBorn.setBornStatus("失败:订单中的总金额数为空");
							    default:
							    	chMesBorn.setMesText(sendMesText);
							    	chMesBorn.setBornStatus("成功");
							}
							chMesBorn.setModel(chMesmode.getModel());
							
						}
					}
		mesBorn.add(chMesBorn);
				    
		}
		map.put("rows",mesBorn );
		System.out.println(mesBorn.size());
		map.put("total", mesBorn.size());
		return map;
		
	}


public static String sendMesText(String text,userOrderInfo rows){
	if(text.indexOf("#NAME#")>=0){
		try{
			text=text.replaceAll("#NAME#", rows.getLinkName());
		}catch(Exception e){
			return "0";
		}
	}
	if(text.indexOf("#NumberPlane#")>=0){
		try{
			text=text.replaceAll("#NumberPlane#",rows.getHangbanNum());
		}catch(Exception e){
			return "1";
		}
	}
	if(text.indexOf("#Lcity#")>=0){
		try{
			text=text.replaceAll("#Lcity#", rows.getChufCity());
			
		}catch(Exception e){
			return "2";
		}
	}
	if(text.indexOf("#Tcity#")>=0){
		try{
			text=text.replaceAll("#Tcity#", rows.getDaodCity());
		}catch(Exception e){
			return "3";
		}
	}
	if(text.indexOf("#LTime#")>=0){
		try{
			text=text.replaceAll("#LTime#", rows.getChufDate());
		}catch(Exception e){
			return "4";
		}
	}
	if(text.indexOf("#TTime#")>=0){
		try{
			text=text.replaceAll("#TTime#", rows.getDaodDate());
		}catch(Exception e){
			return "5";
		}
	}
	if(text.indexOf("#SumMoney#")>=0){
		try{
			text=text.replaceAll("#SumMoney#",rows.getCostMoney());
		}catch(Exception e){
			return "6";
		}
	}
	return text;
 }

/**
 * 发送短信的方法
 * @param phoneNum
 * @param textMes
 * @param session
 * @return
 */
@RequestMapping(value="/sandMes.action",method = RequestMethod.POST)
@ResponseBody
public Map<String,Object> sandMes(String rowsJson,HttpSession session){
	String userTureName = (String)session.getAttribute("userTureName");
	Send106msg sender = new Send106msg();
	Map<String, Object> map = new HashMap<String, Object>();
	JSONArray jsonArray = JSONArray.fromObject(rowsJson);
	List<Map<String,Object>> mapListJson = (List)jsonArray; 
	List<PhoneAndText> PhTextList = new ArrayList<PhoneAndText>();
	for (int i = 0; i < mapListJson.size(); i++){
		 Map<String,Object> obj = mapListJson.get(i);
		 PhoneAndText PAT = new PhoneAndText();
		 for(Entry<String,Object> entry : obj.entrySet()){
			 if("label".equals(entry.getKey())){
         		PAT.setPhone((String)entry.getValue());
         	 }
			 if("value".equals(entry.getKey())){
         		PAT.setTextMes((String)entry.getValue());
         	 }
		 }
		 PhTextList.add(PAT); 
	}
	PhTextList = removeRepeat(PhTextList);
	String errorMes = "";
	String seccus = "";
	for(PhoneAndText chPTL:PhTextList){
		phoneMess ph=new phoneMess();
		String a=chPTL.getTextMes();
		ph.setCreateTime(new Timestamp(new Date().getTime()));
		ph.setUserName(userTureName);
		ph.setPhoneNumber(chPTL.getPhone());
		ph.setText(a);
		String sendMes = "";
		try{
			sendMes=sender.SendMSGtoPhone("【广州仁德】"+a,chPTL.getPhone());
			
		}catch(MalformedURLException e){
			e.printStackTrace();
		}catch (IOException e) {
			e.printStackTrace();
		}
		if(sendMes.equals("1")||"1".equals(sendMes)){
			ph.setSendType(1);
			seccus += chPTL.getPhone()+",";
		}else{
			ph.setSendType(0);
			errorMes += chPTL.getPhone()+"(短信接口错误代码："+sendMes+"),";
		}
		bornService.savaPhoneMess(ph);
	}
	if("".equals(errorMes)||null==errorMes){
		map.put("errorMes", "发送成功");
	}else{
		map.put("errorMes", errorMes.substring(0, errorMes.length()-1));
		map.put("seccus", seccus.substring(0,seccus.length()-1));
	}
	return map;
}

public List<PhoneAndText> removeRepeat(List<PhoneAndText> list){
	List<PhoneAndText> resultList = new ArrayList<PhoneAndText>();
	if(list != null && list.size() > 0){
		for(PhoneAndText info : list){
			boolean flag = true;
			for(PhoneAndText rInfo : resultList){
				if(info.getPhone().equals(rInfo.getPhone())){
					flag = false;
					break;
				}
			}
			if(flag){
					resultList.add(info);
			}
		}
	}
	return resultList;
}
}
	


