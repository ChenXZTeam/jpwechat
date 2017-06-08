package com.solar.tech.service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.entity.TravItinerary;
import com.solar.tech.bean.entity.userOrderInfo;
import com.solar.tech.dao.GenericDao;

@Service
@Transactional
public class TravItineraryService {
	@Resource
	private GenericDao gDao;

	public Map<String,Object> getList(int page,int rows){
		Map<String,Object> map = new HashMap<String,Object>();
		List<TravItinerary> cList = this.gDao.findByPage("FROM TravItinerary ORDER BY filghtDate DESC", Integer.valueOf(page), Integer.valueOf(rows));
		Long total = this.gDao.count(TravItinerary.class,"FROM TravItinerary ORDER BY filghtDate DESC"); //获取影响的行数，用于前台分页
		map.put("rows",cList);
		map.put("total", total);
		return map;
	}
	
	public Map<String,Object> findByCondition(int page,int rows,String pingtai,String flyDate,String conStutas,String kdNum,String ordNum,String phoneNum){
		Map<String,Object> map = new HashMap<String,Object>();
		StringBuffer hql =  new StringBuffer("FROM TravItinerary WHERE 1=1");
		if(!flyDate.isEmpty()){
			hql.append(" AND filghtDate LIKE '%"+flyDate+"%'");
		}
		if(!conStutas.isEmpty()){
			hql.append(" AND consoleStutas = '"+conStutas+"'");
		}
		if(!kdNum.isEmpty()){
			hql.append(" AND kdOrderNum LIKE '%"+kdNum+"%'");
		}
		if(!ordNum.isEmpty()){
			hql.append(" AND orderNum LIKE '%"+ordNum+"%'");
		}
		if(!phoneNum.isEmpty()){
			hql.append(" AND linkPhone LIKE '%"+phoneNum+"%'");
		}
		hql.append(" ORDER BY createTime DESC");
		List<TravItinerary> cList = this.gDao.findByPage(hql.toString(), Integer.valueOf(page), Integer.valueOf(rows));
		Long total = this.gDao.count(TravItinerary.class,hql.toString()); //获取影响的行数，用于前台分页
		map.put("rows",cList);
		map.put("total", total);
		return map;
	}
	
	public void getOrderDate(){
		List<userOrderInfo> consoleOrderDate = this.gDao.find("FROM userOrderInfo WHERE isConsole = '1' AND consoleStatus = '0'"); //拿订单表中的数据
		List<TravItinerary> soleDate = this.gDao.find("FROM TravItinerary"); //拿原来存在打印表中的数据（这样做是为了防止：插入重复的数据）
		List<TravItinerary> tempList = new ArrayList<TravItinerary>();
		if(consoleOrderDate.size()>0){
			for(userOrderInfo uInfo : consoleOrderDate){
				boolean isAdd = true;
				for(TravItinerary tt : soleDate){
					if(uInfo.getOrderNum().equals(tt.getOrderNum())){
						isAdd = false;
						break;
					}
				}
				if(isAdd==true){
					TravItinerary ttin = new TravItinerary();
					ttin.setConsoleStutas("0");
					ttin.setCreateTime(new Timestamp(new Date().getTime()));
					ttin.setFilghtDate(uInfo.getChufDate());
					ttin.setFilghtMan(uInfo.getLinkName());
					ttin.setLinkPhone(uInfo.getLinkPhoneNum());
					ttin.setOrderNum(uInfo.getOrderNum());
					ttin.setSandAdd(uInfo.getSendAdd());
					ttin.setTicketNum(uInfo.getTelNum());
					tempList.add(ttin);
				}
				
			}
			saveDate(tempList); //保存到需要打印的数据表中
		}
		
	}
	
	public void upConStutas(String uuid,String stutas){
		this.gDao.executeJDBCSql("UPDATE userorderinfo SET consoleStatus = '"+stutas+"' WHERE orderNum = '"+uuid+"'");
	}
	
	public void saveDate(List<TravItinerary> titra){
		this.gDao.save(titra);
	}

	public void upInfo(TravItinerary ttay){
		this.gDao.update(ttay);
	}
	
	public void delInfo(List<TravItinerary> ttay){
		this.gDao.delete(ttay);
	}
	
	public void disBution(String uuid,String kdOrderNum,String kdCompany,String consoleStutas){
		this.gDao.executeJDBCSql("UPDATE fw_travitinerary SET kdOrderNum = '"+kdOrderNum+"',kdCompany = '"+kdCompany+"',consoleStutas = '"+consoleStutas+"' WHERE uuid = '"+uuid+"'");
	}
	
	public TravItinerary findOld(String uuid){
		List<TravItinerary> ty = this.gDao.find("FROM TravItinerary WHERE uuid = '"+uuid+"'");
		return ty.get(0);
	}

}
