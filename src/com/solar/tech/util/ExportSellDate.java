package com.solar.tech.util;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

public class ExportSellDate {
  
	
	private final static String excel2003L =".xls";    //2003- 版本的excel
	private final static String excel2007U =".xlsx";   //2007+ 版本的excel
	
	public  File getExcelDemoFile(String fileDir) throws Exception{
		String classDir = null;
		String fileBaseDir = null;
		File file = null;
		classDir = Thread.currentThread().getContextClassLoader().getResource("/").getPath();
		fileBaseDir = classDir.substring(0, classDir.lastIndexOf("classes"));
		
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
	
	public Workbook writeAIRName(File file,String sheetName,List<Map<String,String>> lis) throws Exception{
		Workbook wb = null;
		Row row = null;
		Cell cell = null;
		FileInputStream fis = new FileInputStream(file);
		wb = new ExportUtil().getWorkbook(fis, file.getName());
		Sheet sheet = wb.getSheet(sheetName);
		
		//循环插入数据
		int first = sheet.getFirstRowNum()+1;
		CellStyle cs = setSimpleCellStyle(wb);
		if("航司销售数据详情表".equals(sheetName)){
			for (int i = 0; i < lis.size(); i++) {
				row = sheet.createRow(first+i); //创建新的ROW，用于数据插入
				Short s = 23*23;
				row.setRowStyle(cs);
				row.setHeight(s);
				
				//按项目实际需求，在该处将对象数据插入到Excel中
				Map<String, String> vo  = lis.get(i);
			
				
				//Cell赋值开始	
				cell = row.createCell(0);
				cell.setCellValue(vo.get("hangs").substring(0,2));
				cell.setCellStyle(cs);
				
				cell = row.createCell(1);
				cell.setCellValue(vo.get("orderStatus"));
				cell.setCellStyle(cs);
				
				cell = row.createCell(2);
				cell.setCellValue(vo.get("money"));
				cell.setCellStyle(cs);
				
				cell=row.createCell(3);
				cell.setCellValue(vo.get("money"));
				cell.setCellStyle(cs);
				
				cell=row.createCell(4);
				cell.setCellValue("1");
				cell.setCellStyle(cs);
				
				cell=row.createCell(5);
				cell.setCellValue("0%");
				cell.setCellStyle(cs);
				
				cell=row.createCell(6);
				cell.setCellValue(vo.get("time"));
				cell.setCellStyle(cs);
				
			}
		}
		return wb;
		}
	}

