package com.solar.tech.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExportUtil {
	
	private final static String excel2003L =".xls";    //2003- 版本的excel
	private final static String excel2007U =".xlsx";   //2007+ 版本的excel
	
	/** 
	 * 描述：根据文件路径获取项目中的文件 
	 * @param fileDir 文件路径
	 * @return
	 * @throws Exception
	 */
	public  File getExcelDemoFile(String fileDir) throws Exception{
		String classDir = null;
		String fileBaseDir = null;
		File file = null;
		classDir = Thread.currentThread().getContextClassLoader().getResource("/").getPath();
		fileBaseDir = classDir.substring(0, classDir.lastIndexOf("classes"));
		System.out.println(fileBaseDir+fileDir);
		file = new File(fileBaseDir+fileDir);
		if(!file.exists()){
			throw new Exception("模板文件不存在！");
		}
		
		return file;
		
	}
	
	public  CellStyle setSimpleCellStyle(Workbook wb){
		CellStyle cs = wb.createCellStyle();
		/*
		cs.setBorderBottom(CellStyle.BORDER_THIN); //下边框
		cs.setBorderLeft(CellStyle.BORDER_THIN);//左边框
		cs.setBorderTop(CellStyle.BORDER_THIN);//上边框
		cs.setBorderRight(CellStyle.BORDER_THIN);//右边框
*/
		cs.setAlignment(CellStyle.ALIGN_CENTER); // 居中
		cs.setVerticalAlignment(CellStyle.VERTICAL_CENTER);//垂直居中
		return cs;
	}
	
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

	
	public Workbook writelinkManExcel(File file, String sheetName,
			List<Map<String, String>> lis) throws Exception {
		Workbook wb = null;
		Row row = null; 
		Cell cell = null;
		FileInputStream fis = new FileInputStream(file);
		wb = new ExportUtil().getWorkbook(fis, file.getName());
		Sheet sheet = wb.getSheet(sheetName);
		
		//循环插入数据
		int first = sheet.getFirstRowNum()+1;
		CellStyle cs = setSimpleCellStyle(wb);
		if("旅客信息表".equals(sheetName)){
			for (int i = 0; i < lis.size(); i++) {
				row = sheet.createRow(first+i); //创建新的ROW，用于数据插入
				Short s = 23*23;
				row.setRowStyle(cs);
				row.setHeight(s);
				
				//按项目实际需求，在该处将对象数据插入到Excel中
				Map<String, String> vo  = lis.get(i);
				if(null==vo){
					break;
				}
				//Cell赋值开始				
				cell = row.createCell(0);
				cell.setCellValue(vo.get("username"));
				cell.setCellStyle(cs);
				
				cell = row.createCell(1);
				cell.setCellValue(vo.get("phone"));
				cell.setCellStyle(cs);
				
				cell = row.createCell(2);
				cell.setCellValue(vo.get("passage"));
				cell.setCellStyle(cs);
				
				cell = row.createCell(3);
				cell.setCellValue(vo.get("phonenumber"));
				cell.setCellStyle(cs);
				
				cell = row.createCell(4);
				cell.setCellValue(vo.get("birth"));
				cell.setCellStyle(cs);
				
				cell = row.createCell(5);
				cell.setCellValue(vo.get("zjtype"));
				cell.setCellStyle(cs);
				
				cell = row.createCell(6);
				cell.setCellValue(vo.get("zjnumber"));
				cell.setCellStyle(cs);
				
				cell = row.createCell(7);
				cell.setCellValue(vo.get("lktype"));
				cell.setCellStyle(cs);
				
				cell = row.createCell(8);
				cell.setCellValue(vo.get("sex"));
				cell.setCellStyle(cs);
				
				cell = row.createCell(9);
				cell.setCellValue(vo.get("guoji"));
				cell.setCellStyle(cs);
				
				cell = row.createCell(10);
				cell.setCellValue(vo.get("wxID"));
				cell.setCellStyle(cs);
			}
		}
		return wb;
		
	}
	
	

}
