package com.solar.tech.service;

import java.io.InputStream;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.PhoneNum;
import com.solar.tech.bean.entity.Info;
import com.solar.tech.dao.GenericDao;
import com.solar.tech.util.Current;
import com.solar.tech.utils.PassSend;

@Service
@Transactional
public class PhoneNumService {
	private SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	private final static String excel2003L =".xls";    //2003- 版本的excel
	private final static String excel2007U =".xlsx";   //2007+ 版本的excel
	
	@Resource
	private GenericDao gDao;
	@Resource
	private PhoneNumService phoneNumService;
	/**
	 * 保存手机号
	 * @param info
	 * @return
	 */
	public int addPhoneNum(PhoneNum phoneNum) {
		try {
			gDao.save(phoneNum);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	
	/**
	 * 获取手机号列表
	 * @param pag
	 * @param row
	 * @return
	 */
	public Map<String, Object> getPhoneNumList(int pag, int row) {
		Map<String, Object> map = new HashMap<String, Object>();
		String hql = "FROM PhoneNum i  order by i.createTime desc";
		if(row==10000){
			List<PhoneNum> iList = this.gDao.find(hql);
			map.put("iList", iList);
		}else{
			List<PhoneNum> cList = this.gDao.findByPage(hql, Integer.valueOf(pag), Integer.valueOf(row));
			Long total = this.gDao.count(PhoneNum.class,hql); //获取影响的行数，用于前台分页
			map.put("rows", cList);
			map.put("total", total);
		}
		return map;
	}
	
	/**
	 * 删除手机号
	 * @param phoneID
	 * @return
	 */
	public int deletePhoneNum(String phoneID) {
		gDao.deleteByIds(PhoneNum.class, phoneID);
		return 1;
	}
	
	/**
	 * 功能描述：更新指定的PhoneNum
	 *
	 * @param visa
	 *
	 * @return void
	 */
	public void updatePhoneNum(PhoneNum phoneNum) {
		gDao.update(phoneNum);
	}
	
	/**
	 * 功能描述：通过ID查找手机号
	 * @param row 
	 * @param pag 
	 *
	 * @param id
	 *
	 * @return Info
	 */
	public Map<String, Object> findPhoneNumByID(String phoneNumber, int pag, int row) {
		Map<String, Object> map = new HashMap<String, Object>();
		String hql = "FROM PhoneNum i where i.phoneNumber like '%"+phoneNumber+"%' ";
		List<PhoneNum> cList = this.gDao.findByPage(hql, Integer.valueOf(pag), Integer.valueOf(row));
		Long total = this.gDao.count(PhoneNum.class,hql); //获取影响的行数，用于前台分页
		map.put("rows", cList);
		map.put("total", total);
		return map;
	}

	

	/**
	 * 通过id进行查找资讯 用于微信前端
	 * @param title
	 * @return
	 */
	public Map<String, Object> findPhoneByID(String ID) {
		Map<String, Object> map = new HashMap<String, Object>();
		String hql = "FROM PhoneNum i where i.phoneID = '"+ID+"' ";
		List<Info> cList = this.gDao.queryHQL(hql);
		map.put("rows", cList);
		return map;
	}

	/** 
     * 读取报表 
	 * @throws Exception 
     */  
    public String readReports(InputStream inp, String fileName) throws Exception { 
    	    String resultMsg = ""; //提示结果
            //创建Excel工作薄
    	    Workbook work = this.getWorkbook(inp,fileName);
    		
    	    if(null == work){
    	    	throw new Exception("创建Excel工作薄为空！");
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
    			if("zzz".equals(sheetName)||"zzz".equals(sheetName)){
    				//循环当前sheet的所有行
    				for (int j = sheet.getFirstRowNum(); j < sheet.getLastRowNum(); j++) {
    					row = sheet.getRow(j+1);
        				if(row==null){break;}
        				int y = row.getFirstCellNum();
        				PhoneNum phoneNum=new PhoneNum();
    					String user = ""; 
    					
    					try{
    						user = (String)this.getCellValue(row.getCell(y));
    					}catch(Exception e){
    						System.out.println("联系用户为空："+e);
    					} 
    					phoneNum.setLinkName(user);
    					String pnumber="";
    					
    					try{
    						pnumber=(String)this.getCellValue(row.getCell(y+1));
    					}catch(Exception e){
    						System.out.println("电话号码为空:"+e);
    					}
    					phoneNum.setPhoneNumber(pnumber);
    					String group="";
    					
    					try{
    						group=(String)this.getCellValue(row.getCell(y+2));
    					}catch(Exception e){
    						System.out.println("分组为空:"+e);
    					}
    					phoneNum.setFzName(group);
    					
    					phoneNum.setUserName(Current.user().getUserName());
    					
    					phoneNum.setCreateTime(new Timestamp(new Date().getTime()));
    					
    				    //创建时间赋值
    					phoneNumService.addPhoneNum(phoneNum);
    					resultMsg="导入成功！";
    				}
    			}
    		}
			return resultMsg;
	}

    /**
	 * 描述：对表格中数值进行格式化
	 * @param cell
	 * @return
	 */
	public  Object getCellValue(Cell cell){
		Object value = null;
		DecimalFormat df = new DecimalFormat("0");  //格式化number String字符
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  //日期格式化
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
	public  Workbook getWorkbook(InputStream inStr,String fileName) throws Exception{
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
	
	
	

}
