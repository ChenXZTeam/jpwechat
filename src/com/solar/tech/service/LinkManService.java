package com.solar.tech.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;



import com.solar.tech.bean.PhoneNum;
import com.solar.tech.bean.entity.LinkMan;
import com.solar.tech.bean.entity.RD_wechatUser;
import com.solar.tech.dao.GenericDao;
import com.solar.tech.util.ExportUtil;

@Service
@Transactional
public class LinkManService {
	private SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	private final static String excel2003L =".xls";    //2003- 版本的excel
	private final static String excel2007U =".xlsx";   //2007+ 版本的excel

	
	@Resource
	private GenericDao gDao;
	
	
	public Map<String,Object> manlist(int page, int rows){
		Map<String,Object> map = new HashMap<String,Object>();
		List<LinkMan> cList = this.gDao.findByPage("FROM LinkMan ORDER BY createTime DESC", Integer.valueOf(page), Integer.valueOf(rows));
		Long total = this.gDao.count(LinkMan.class,"FROM LinkMan ORDER BY createTime DESC"); //获取影响的行数，用于前台分页
		map.put("rows",cList);
		map.put("total", total);
		return map;
	}
	
	public void addInfo(LinkMan lman){
		gDao.save(lman);
	}
	
	public void delInfo(List<LinkMan> lman){
		gDao.delete(lman);
	}
	
	public void upInfo(LinkMan lman){
		gDao.update(lman);
	}
	
	public List<RD_wechatUser> getuserList(){
		List<RD_wechatUser> ulist = this.gDao.find("FROM RD_wechatUser");
		List<RD_wechatUser> formDate = new ArrayList<RD_wechatUser>();
		for(RD_wechatUser sd : ulist){
			RD_wechatUser forsd = new RD_wechatUser();
			forsd.setUserName(sd.getUserName());
			formDate.add(forsd);
		}
		return formDate;
	}
	
	public List<RD_wechatUser> getuserList(String userName){
		List<RD_wechatUser> ulist = this.gDao.find("FROM RD_wechatUser WHERE UserName = '"+userName+"'");
		return ulist;
	}
	
	public List<LinkMan> isRepeat(String idCase,String userName){
		List<LinkMan> ulist = this.gDao.find("FROM LinkMan WHERE caseNum = '"+idCase+"' AND UserName = '"+userName+"'");
		return ulist;
	}
	
	public Map<String,Object> findPage(int page,int rows,String cusAdmin,String custor,String chinaName,String phoneNum){
		Map<String,Object> map = new HashMap<String,Object>();
		String sql="FROM LinkMan WHERE 1=1 ";
		if(cusAdmin!=null&&cusAdmin!=""){
			sql+="and UserName LIKE '%"+cusAdmin+"%'";
		}
		if(custor!=null&&custor!=""){
			sql+="and linkman LIKE '%"+custor+"%'";
		}
		if(chinaName!=null&&chinaName!=""){
			sql+="and chinaName LIKE '%"+chinaName+"%'";
		}
		if(phoneNum!=null&&phoneNum!=""){
			sql+="and linkNumber LIKE '%"+phoneNum+"%'";
		}
		sql += " ORDER BY LinkMan, createTime DESC";
		List<LinkMan> cList = this.gDao.findByPage(sql, Integer.valueOf(page), Integer.valueOf(rows));
		Long total = this.gDao.count(LinkMan.class,sql); //获取影响的行数，用于前台分页
		map.put("rows",cList);
		map.put("total", total);
		return map;
	}
	
	public String readReport(InputStream inp, String fileName) throws Exception {
		String resultMsg = ""; //提示结果
		 //创建Excel工作薄
		Workbook work = this.getWorkbooks(inp,fileName);
		
		if(null == work){
			throw new Exception("创建Excel工作簿为空！");
		}
		
		Sheet sheet = null;
	    Row row = null;
	    Cell cell = null;
	    
	  //遍历Excel中所有的sheet
	    for (int i = 0; i < work.getNumberOfSheets(); i++) {
	    	sheet = work.getSheetAt(i);
	    	System.out.print(sheet);
	    	String sheetName = sheet.getSheetName();
	    	System.out.print(sheetName);
	    	if("aaa".equals(sheetName)||"aaa".equals(sheetName)){
	    		//循环当前sheet的所有行
	    		for (int j = sheet.getFirstRowNum(); j < sheet.getLastRowNum(); j++) {
	    			row = sheet.getRow(j+1);
	    			if(row==null){break;}
	    			int y = row.getFirstCellNum();
	    			LinkMan linkMan=new LinkMan();
	    			String username = "";
	    			
	    			try{
	    				username = (String)this.getCellValue(row.getCell(y));
	    			}catch(Exception e){
	    				System.out.println("联系用户为空："+e);
	    			}
	    			linkMan.setUserName(username);
	    			String phone = "";
	    			try{
	    				phone = (String)this.getCellValue(row.getCell(y+1));
	    			}catch(Exception e){
	    				System.out.println("绑定手机为空："+e);
	    			}
	    			linkMan.setLinkNumber(phone);
	    			String passage="";
	    			try{
	    				passage = (String)this.getCellValue(row.getCell(y+2));
	    			}catch(Exception e){
	    				System.out.println("乘机人为空："+e);
	    			}
	    			linkMan.setLinkman(passage);
	                String phonenumber="";
	                try{
	                	phonenumber = (String)this.getCellValue(row.getCell(y+3));
	    			}catch(Exception e){
	    				System.out.println("电话号码为空："+e);
	    			}
	                linkMan.setUserNamePhone(phonenumber);
	                String birth="";
	                try{
	                	birth = (String)this.getCellValue(row.getCell(y+4));
	    			}catch(Exception e){
	    				System.out.println("生日为空："+e);
	    			}
	                linkMan.setBirthday(birth);
	                String zjtype="";
	                try{
	                	zjtype = (String)this.getCellValue(row.getCell(y+5));
	    			}catch(Exception e){
	    				System.out.println("证件类型为空："+e);
	    			}
	                linkMan.setCaseType(zjtype);
	                String zjnumber="";
	                try{
	                	zjnumber = (String)this.getCellValue(row.getCell(y+6));
	    			}catch(Exception e){
	    				System.out.println("证件号码为空："+e);
	    			}
	                linkMan.setCaseNum(zjnumber);
	                String lktype="";
	                try{
	                	lktype = (String)this.getCellValue(row.getCell(y+7));
	    			}catch(Exception e){
	    				System.out.println("旅客类型为空："+e);
	    			}
	                linkMan.setPeopleType(lktype);
	                String sex="";
	                try{
	                	sex = (String)this.getCellValue(row.getCell(y+8));
	    			}catch(Exception e){
	    				System.out.println("性别类型为空："+e);
	    			}
	                linkMan.setSex(sex);
	                String guoji="";
	                try{
	                	guoji = (String)this.getCellValue(row.getCell(y+9));
	    			}catch(Exception e){
	    				System.out.println("国籍为空："+e);
	    			}
	                linkMan.setBelongCtry(guoji);
	                String wxID="";
	                try{
	                	wxID = (String)this.getCellValue(row.getCell(y+10));
	    			}catch(Exception e){
	    				System.out.println("微信ID号为空："+e);
	    			}
	                linkMan.setOpenID(wxID);
	                linkMan.setCreateTime(new Timestamp(new Date().getTime()));
	    		    addNu(linkMan);
	    			resultMsg="导入成功！";
	    			
	    			
	    			
	    		}
	    	}
	    }
	    return resultMsg;
	}
	
	   public int addNu(LinkMan linkMan) {
		    try {
			   gDao.save(linkMan);
			   return 1;
		    } catch (Exception e) {
			   return 0;
		    }
	   }
	   
	   public  Object getCellValue(Cell cell){
		   Object value = null;
		   DecimalFormat df = new DecimalFormat("0"); //格式化number String字符
		   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); //日期格式化
		   DecimalFormat df2 = new DecimalFormat("0.00");  //格式化数字
		   
		   switch (cell.getCellType()) {
		   case Cell.CELL_TYPE_STRING:
			   value = cell.getRichStringCellValue().getString();
			   break;
		   case Cell.CELL_TYPE_NUMERIC:
			   if("General".equals(cell.getCellStyle().getDataFormatString())){
					value = df.format(cell.getNumericCellValue());
				}else if("m/d/yy".equals(cell.getCellStyle().getDataFormatString())){
					value = sdf.format(cell.getDateCellValue());
				}else{
					value = df2.format(cell.getNumericCellValue());
				}
				break;
		   case Cell.CELL_TYPE_BOOLEAN:
				value = cell.getBooleanCellValue();
				break;
		   case Cell.CELL_TYPE_BLANK:
				value = "";
				break;
		   default:
				break;
			}
		   return value;
		   }
	   
	  /**
		 * 描述：根据文件后缀，自适应上传文件的版本 
		 * @param inStr,fileName
		 * @return
		 * @throws Exception
		 */
	 public  Workbook getWorkbooks(InputStream inStr,String fileName) throws Exception{
		   Workbook wb = null;
		   String fileType = fileName.substring(fileName.lastIndexOf("."));
		   if(excel2003L.equals(fileType)){
				wb = new HSSFWorkbook(inStr);  //2003-
			}else if(excel2007U.equals(fileType)){
				wb = new XSSFWorkbook(inStr);  //2007+
			}else{
				throw new Exception("解析的文件格式有误！");
			}
			return wb;
	   }
	 //导出任务工具
	 public Map<String,String> getAlls(LinkMan linkMan){
		 Map<String, String> obj = new HashMap<String, String>();
		 obj.put("username",linkMan.getUserName());  //客户名
		 obj.put("phone", linkMan.getLinkNumber()); //绑定号码
		 obj.put("passage", linkMan.getLinkman()); //乘机人
		 obj.put("phonenumber",linkMan.getUserNamePhone());
		 obj.put("birth", linkMan.getBirthday());
		 String bb=linkMan.getCaseType();
		 if(bb.equals("PP")){
			 obj.put("zjtype", "护照");
		 }
		 else if(bb.equals("ID")){
			 obj.put("zjtype", "其他");
			 
		 }else{
			 obj.put("zjtype", "身份证");
		 }
		 obj.put("zjnumber", linkMan.getBelongCtry());
		 String aa=linkMan.getPeopleType();
		 if(aa=="ADT"){
			 obj.put("lktype", "成人");
		 }else{
			 obj.put("lktype", "小孩");
		 }
		 obj.put("sex", linkMan.getSex());
		 obj.put("guoji", linkMan.getBelongCtry());
	     return obj;
		 
	 }
	 
	public void exportexcel(HttpServletRequest request,
			HttpServletResponse response){
		String hql="from LinkMan where ID=?";
		OutputStream os = null;  //输出流
		Workbook wb = null;  //工作薄
		
		try {
			String Nums = request.getParameter("Nums");
			String[] array1 = Nums.split(",");
			List<Map<String, String>> lo = new ArrayList<Map<String, String>>();
			for(int i=0; i<array1.length; i++){
				List<Object> parames=new ArrayList<Object>();
				parames.add(array1[i]);
				List<LinkMan> list = gDao.getListByHql(LinkMan.class, hql, parames);
				if(null != list && list.size()>0){
			    	LinkMan linkMan = list.get(0);
			    	Map<String,String> obj=getAlls(linkMan);
			    	lo.add(obj);
			    }
			    	
			  }
			  //导出Excel文件数据 
			    ExportUtil util = new ExportUtil();
			    File file =util.getExcelDemoFile("template/旅客信息表.xlsx");
			    String sheetName="旅客信息表";
			    
			    wb = util.writelinkManExcel(file, sheetName, lo);
			    String fileName="旅客信息表_"+sdf.format(new Date()) +".xlsx";
			    
			    response.setContentType("application/vnd.ms-excel");
			    response.setHeader("Content-disposition", "attachment;filename="+ URLEncoder.encode(fileName, "utf-8"));
			    os = response.getOutputStream();
			    wb.write(os);
		        } catch (UnsupportedEncodingException e) {
			        e.printStackTrace();
		        } catch (IOException e) {
			        e.printStackTrace();
		        } catch (Exception e) {
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

