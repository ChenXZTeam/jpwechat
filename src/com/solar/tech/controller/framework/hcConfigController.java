package com.solar.tech.controller.framework;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.entity.SeatInfoData;
import com.solar.tech.bean.entity.hcConfig;
import com.solar.tech.service.PlanTekService;
import com.solar.tech.service.hcConfigService;

@Controller
@RequestMapping("/framework/hcConfig")
public class hcConfigController {
	@Resource
	private hcConfigService hcService;
	@Autowired
	private PlanTekService PlanTekServ;
	
	
	@RequestMapping("/numList.action")
	@ResponseBody
	public Map<String,Object> numList(int page, int rows){
		Map<String,Object> insura = hcService.getInfoList(page, rows); 
		return insura;
	}
	
	//缓存重新加载到管理表中
	@RequestMapping("/reloadHc.action")
	@ResponseBody
	public Map<String,Object> reloadHc(int page, int rows){
		try {
			hcService.reload();
		} catch (Exception e) {}
		
		Map<String,Object> insura = hcService.getInfoList(page, rows); 
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
					hcConfig hcf = hcService.findByuuid(chsign);
					String date = hcService.formDate(hcf.getHcType()); //获取默认的查找日期
					try {
						hcService.delHcOldDate(hcf.getOrgCity(),hcf.getDstCity(),hcf.getHcType()); //删除原先的缓存航班
						List<SeatInfoData> upSeat = PlanTekServ.upHcDate(hcf.getOrgCity(), hcf.getDstCity(), date, 0); //更新缓存
						//更新管理员管理缓存表中的数据
						hcService.upHcTable(chsign,upSeat.get(0));//更新已经更新缓存的
					} catch (Exception e) {
						System.out.println("手动更新功能删除原先缓存出错");
					}
				}
				return 1;
			} catch (Exception e) {
				return 0;
			}
		}
	}
	
}
