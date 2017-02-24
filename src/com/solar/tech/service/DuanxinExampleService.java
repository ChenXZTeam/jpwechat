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

import com.solar.tech.bean.DuanxinExample;
import com.solar.tech.bean.PhoneNum;
import com.solar.tech.bean.entity.Info;
import com.solar.tech.dao.GenericDao;
import com.solar.tech.util.Current;
import com.solar.tech.utils.PassSend;
@Service
@Transactional
public class DuanxinExampleService {
	
	@Resource
	private GenericDao gDao;
	
	/**
	 * 保存短信模板
	 * @param info
	 * @return
	 */
	public int addExample(DuanxinExample duanxinExample) {
		try {
			gDao.save(duanxinExample);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	
	/**
	 * 获取短信列表
	 * @param pag
	 * @param row
	 * @return
	 */
	public Map<String, Object> getExampleList(int pag, int row) {
		Map<String, Object> map = new HashMap<String, Object>();
		String hql = "FROM DuanxinExample ";
		if(row==10000){
			List<DuanxinExample> iList = this.gDao.find(hql);
			map.put("iList", iList);
		}else{
			List<DuanxinExample> cList = this.gDao.findByPage(hql, Integer.valueOf(pag), Integer.valueOf(row));
			Long total = this.gDao.count(DuanxinExample.class,hql); //获取影响的行数，用于前台分页
			map.put("rows", cList);
			map.put("total", total);
		}
		return map;
	}
	
	/**
	 * 删除短信模板
	 * @param phoneID
	 * @return
	 */
	public int deleteExample(String ExampleID) {
		gDao.deleteByIds(DuanxinExample.class, ExampleID);
		return 1;
	}
	
	/**
	 * 功能描述：更新指定的短信模板
	 *
	 * @param visa
	 *
	 * @return void
	 */
	public void updateExample(DuanxinExample duanxinExample) {
		gDao.update(duanxinExample);
	}
	
	/**
	 * 功能描述：通过绑定人查找模板
	 * @param row 
	 * @param pag 
	 *
	 * @param id
	 *
	 * @return Info
	 */
	public Map<String, Object> findExample(String banPeople, int pag, int row) {
		Map<String, Object> map = new HashMap<String, Object>();
		String hql = "FROM DuanxinExample i where i.banPeople like '%"+banPeople+"%' ";
		List<DuanxinExample> cList = this.gDao.findByPage(hql, Integer.valueOf(pag), Integer.valueOf(row));
		Long total = this.gDao.count(PhoneNum.class,hql); //获取影响的行数，用于前台分页
		map.put("rows", cList);
		map.put("total", total);
		return map;
	}


	

	
	
	

}
