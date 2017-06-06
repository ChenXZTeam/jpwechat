package com.solar.tech.controller.framework;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.entity.Freight;
import com.solar.tech.bean.entity.SeatPriceData;
import com.solar.tech.service.FreightService;

@Controller
@RequestMapping("/framework/freight")
public class FreightController{
	@Autowired
	private FreightService freService;
	
	@RequestMapping("/numList.action")
	@ResponseBody
	public Map<String,Object> numList(int page, int rows){
		Map<String,Object> insura = freService.getInfoList(page, rows); 
		return insura;
	}
	
	@RequestMapping("/reloadHc.action")
	@ResponseBody
	public Map<String,Object> reloadHc(int page, int rows){
		freService.reloadDate();
		Map<String,Object> insura = freService.getInfoList(page, rows); 
		return insura;
	}
	
	//管理员手动更新缓存表中的航班数据
	@RequestMapping(value = "/relUpHc.action", method = RequestMethod.POST)
	@ResponseBody
	public int relUpHc(String sign){
		if(sign.equals("all")){
			System.out.println("更新全部缓存");
			try {
				return 1;
			} catch (Exception e) {
				return 0;
			}
		}else{
			System.out.println("更新部分缓存");
			try {
				String[] signStr = sign.split(",");
				for(String chsign : signStr){
					Freight hcf = freService.findByuuid(chsign);
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					String pastTime = sdf.format(new Timestamp(new Date().getTime()));
					try {
						freService.delHcOldDate(hcf.getOrgCity(),hcf.getDstCity()); //删除原先的缓存运价
						List<SeatPriceData> upSeat = freService.upPrice(hcf.getOrgCity(), hcf.getDstCity(), pastTime); //更新缓存
						//更新管理员管理缓存表中的数据
						freService.upHcTable(chsign,upSeat.get(0));//更新已经更新缓存的
					} catch (Exception e) {
						System.out.println("手动更新运价功能删除原先缓存出错");
					}
				}
				return 1;
			} catch (Exception e) {
				return 0;
			}
		}
	}
	
	@RequestMapping("/findBySel.action")
	@ResponseBody
	public Map<String,Object> findBySel(int page, int rows, String orgCity, String dstCity, String isOverSel){
		Map<String,Object> insura = freService.findBySel(page, rows, orgCity, dstCity, isOverSel); 
		return insura;
	}
	
	@RequestMapping("/addHc.action")
	@ResponseBody
	public int addHc(String orgCity, String dstCity, String dateBox){
		try {
			freService.upPrice(orgCity,dstCity,dateBox.substring(0,10));
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	
}
