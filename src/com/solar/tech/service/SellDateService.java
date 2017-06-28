package com.solar.tech.service;

import java.util.Date;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.airCompanyDade;
import com.solar.tech.bean.airCompayMoney;
import com.solar.tech.bean.entity.FlightInfo;
import com.solar.tech.bean.entity.userOrderInfo;
import com.solar.tech.dao.GenericDao;
import com.solar.tech.util.ExportSellDate;
import com.solar.tech.util.ExportUtil;


@Service
@Transactional
public class SellDateService {
	
	private SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	private final static String excel2003L =".xls";    //2003- 版本的excel
	private final static String excel2007U =".xlsx";   //2007+ 版本的excel
	
	@Resource
	private GenericDao gDao;
	
	public List<userOrderInfo> find(String ltime,String TTime){
		String hql="";
		String ctime=ltime+" "+"00:00:00";
		String dtime=TTime+" "+"23:59:59";
		
		if(("".equals(TTime)||TTime==null)&&("".equals(ltime)||ltime==null)){
			hql="FROM userOrderInfo";
		}else if("".equals(ltime)||ltime==null){
			hql="FROM userOrderInfo WHERE createTime <='"+dtime+"'";
		}else if("".equals(TTime)||TTime==null){
			hql="FROM userOrderInfo WHERE createTime >='"+ctime+"'";
		}else{
			hql="FROM userOrderInfo WHERE createTime <='"+dtime+"' AND createTime >='"+ctime+"'";
		}
		
		List<userOrderInfo> Orders=this.gDao.find(hql);
		return Orders;
	}
	
	public List<userOrderInfo> chazhao(){
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat ss=new SimpleDateFormat("yyyy-MM");
		String ptime=df.format(new Date());
		String pmonth=ss.format(new Date());
		String ppmonth=pmonth+"-"+"01"+" "+"00:00:00";
		String pptime=ptime+" "+"24:59:59";
		String hql="FROM userOrderInfo WHERE createTime >='"+ppmonth+"' and createTime<='"+pptime+"'";
		
		
		//System.out.println(hql);
		List<userOrderInfo> Orders=this.gDao.find(hql);
		return Orders;
		
		
	}
	
	public void exportSellDate(HttpServletRequest request,HttpServletResponse response){
		OutputStream os = null;  //输出流
		Workbook wb = null;  //工作薄
		try{
			String lTime=request.getParameter("lTime");
			String TTime=request.getParameter("TTime");
			String airCode=request.getParameter("airCode");
			List<Map<String,String>> lo=new ArrayList<Map<String,String>>();
			List<userOrderInfo> list = find(lTime,TTime);
			int countMoney = 0;
			for(userOrderInfo uo : list){
				countMoney = Integer.parseInt(uo.getCostMoney())+countMoney;
			}
			if("".equals(airCode)||airCode==null){}else{ //然后在判断用户是否查找针对航空公司的数据
				List<userOrderInfo> listTemp = new ArrayList<userOrderInfo>();
				for(userOrderInfo userSx : list){
					if(airCode.equals(userSx.getHangbanNum().substring(0,2))){
						listTemp.add(userSx);
					}
				}
				list = listTemp;
			}
			
			if(null !=list&&list.size()>0){ //先判断是否查找到数据
				lo = getAlls(list,lTime,TTime,countMoney);
			}
		
			ExportSellDate util=new ExportSellDate();  //这个是new一个导出工具
			File file=util.getExcelDemoFile("template/航司销售数据详情表.xlsx");
			String sheetName="航司销售数据详情表";
			
			wb=util.writeAIRName(file,sheetName,lo);
			System.out.println("wb是:"+wb);
			String fileName="航司销售数据详情表_"+sdf.format(new Date()) +".xlsx";
			
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-disposition", "attachment;filename="+ URLEncoder.encode(fileName, "utf-8"));
			os=response.getOutputStream();
			wb.write(os);
			
		}catch (UnsupportedEncodingException e) {
	        e.printStackTrace();
        }catch (IOException e) {
	        e.printStackTrace();
        }catch (Exception e) {
	        e.printStackTrace();
        }  finally{
	       try {
		       os.flush();
		       os.close();
	       } catch (IOException e) {
		       e.printStackTrace();
	       }
        } 
         
	}  
	
	public List<Map<String,String>> getAlls(List<userOrderInfo> userOrderInfo, String starTime, String overTime,int countMoney){
		List<Map<String,String>> listMap = new ArrayList<Map<String,String>>();
		List<airCompanyDade> listAir = new ArrayList<airCompanyDade>();
		List<String> airStr = new ArrayList<String>();
		List<airCompayMoney> listAc = new ArrayList<airCompayMoney>();
		for(userOrderInfo uinfo : userOrderInfo){
			airCompanyDade airBean = new airCompanyDade();
			airBean.setAirCompay(uinfo.getHangbanNum().substring(0,2));
			airBean.setOrderStatus(uinfo.getOrderStatus());
			airBean.setMoney(Integer.parseInt(uinfo.getCostMoney()));
			listAir.add(airBean);
			airStr.add(uinfo.getHangbanNum().substring(0,2));
		}
		airStr = repleace(airStr); //去掉航空公司重复的数据
		for(String str : airStr){
			airCompayMoney ac = new airCompayMoney();
			ac.setAirCompay(str);
			listAc.add(ac);
		}
		
		for(airCompanyDade airDate : listAir){
			for(int i=0; i<listAc.size(); i++){
				if(listAc.get(i).getAirCompay().equals(airDate.getAirCompay())&&"0".equals(airDate.getOrderStatus())){
					listAc.get(i).setDownMoney(listAc.get(i).getDownMoney()+airDate.getMoney());
					listAc.get(i).setDownTekNum(listAc.get(i).getDownTekNum()+1);
					break;
				}
				if(listAc.get(i).getAirCompay().equals(airDate.getAirCompay())&&"1".equals(airDate.getOrderStatus())){
					listAc.get(i).setUpMoney(listAc.get(i).getUpMoney()+airDate.getMoney());
					listAc.get(i).setUpTekNum(listAc.get(i).getUpTekNum()+1);
					break;
				}
				
			}
		}
		
		//计算总的销售额
		NumberFormat numberFormat = NumberFormat.getInstance();
		numberFormat.setMaximumFractionDigits(2);
		for(airCompayMoney airc : listAc){
			String result = numberFormat.format((float) (airc.getDownMoney()+airc.getUpMoney()) / (float) countMoney * 100);
			Map<String,String> obj=new HashMap<String,String>();
			obj.put("hangs", airc.getAirCompay());
			obj.put("orderStatus", "线上/线下");
			obj.put("sjTekMoney", airc.getUpMoney()+"/"+airc.getDownMoney());
			obj.put("countMoney",(airc.getUpMoney()+airc.getDownMoney())+"");
			obj.put("sjTekNum", airc.getUpTekNum()+"/"+airc.getDownTekNum());
			obj.put("biliCount", result+"%");
			obj.put("tekFw", starTime+"~"+overTime);
			listMap.add(obj);
		}
		return listMap;
		
	}  
	
	public List<String> repleace(List<String> airStr){
		List<String> resStr = new ArrayList<String>();
		if(airStr != null && airStr.size() > 0){
			for(String info : airStr){
				boolean flag = true;
				for(String rInfo : resStr){
					if(info.equals(rInfo)){
						flag = false;
						break;
					}
				}
				if(flag){
					resStr.add(info);
				}
			}
		}
		return resStr;
	}
  
}
