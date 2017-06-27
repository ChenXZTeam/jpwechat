package com.solar.tech.service;

import java.util.Date;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
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
	
	public List<userOrderInfo> find(String ltime,String TTime) throws ParseException{
		String ctime=ltime+" "+"00:00:00";
		String dtime=TTime+" "+"24:59:59";
		String hql="FROM userOrderInfo WHERE createTime >='"+ctime+"' and createTime <='"+dtime+"'";
		//System.out.println(hql);
		List<userOrderInfo> Orders=this.gDao.find(hql);
		//System.out.println(Orders);
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
	
	public Map<String,String> getAlls(userOrderInfo userOrderInfo){
		Map<String,String> obj=new HashMap<String,String>();
	   
			
		obj.put("hangs", userOrderInfo.getHangbanNum());
		obj.put("time",userOrderInfo.getChufDate());
		obj.put("orderStatus", userOrderInfo.getOrderStatus());
		obj.put("money", userOrderInfo.getCostMoney());
		return obj;
	}
	
	public void exportSellDate(HttpServletRequest request,HttpServletResponse response){
		OutputStream os = null;  //输出流
		Workbook wb = null;  //工作薄
		try{
			String numID=request.getParameter("numID");
			String[] array1=numID.split(",");
			List<Map<String,String>> lo=new ArrayList<Map<String,String>>();
			for(int i=0;i<array1.length;i++){
				List<userOrderInfo> list=gDao.find("FROM userOrderInfo WHERE orderNum='"+array1[i]+"'");
				
				if(null !=list&&list.size()>0){
					userOrderInfo userOrderInfo=list.get(0);
					
					Map<String,String> obj=getAlls(userOrderInfo);
					lo.add(obj);
					System.out.println("obj:"+obj);
					System.out.println("lo:"+lo);
				}
				
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
  
}
