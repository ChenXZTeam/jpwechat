package com.solar.tech.controller.framework;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.entity.Insurance;
import com.solar.tech.bean.entity.bxOrder;
import com.solar.tech.bean.entity.userOrderInfo;
import com.solar.tech.service.bxOrderService;

@Controller
@RequestMapping("/framework/bxList")
public class bxOrderController {
	@Autowired
	private bxOrderService bxOrderSer;
	
	@RequestMapping("/numList.action")
	@ResponseBody
	public Map<String,Object> getOrderList(int page, int rows){
		Map<String,Object> map = bxOrderSer.manlist(page, rows);
		return map;
	}
	
	@RequestMapping("/seach.action")
	@ResponseBody
	public Map<String,Object> seach(int page, int rows, String on, String ct){
		Map<String,Object> map = bxOrderSer.manlist(page, rows, on, ct);
		return map;
	}
	
	@RequestMapping("/configNum.action")
	@ResponseBody
	public int configNum(String uuid, String bxNum){
		try {
			bxOrderSer.configNum(uuid,bxNum);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	
	@RequestMapping("/reload.action")
	@ResponseBody
	public int reload(){
		List<Insurance> insure = bxOrderSer.bxMoney(); //查找价格
		String yiwaiCost = "";
		String yanwuCost = "";
		for(Insurance isnch : insure){
			if("1".equals(isnch.getBxType())){
				yiwaiCost = isnch.getCost();
			}else if("2".equals(isnch.getBxType())){
				yanwuCost = isnch.getCost();
			}
		}
		List<userOrderInfo> usOr =  bxOrderSer.load();
		if(usOr.size()>0){
			List<bxOrder> bxord = new ArrayList<bxOrder>();
			for(userOrderInfo uinf : usOr){
				bxOrder bxo = new bxOrder();
				if("1".equals(uinf.getYiwaiBX())){ //如果购买了意外保险
					bxo.setYiwaiBX("1");
					bxo.setBxMoney(yiwaiCost);
				}
				if("1".equals(uinf.getYanwuBX())){ //如果购买了延误保险
					bxo.setYanwuBX("1");
					bxo.setBxMoney(yanwuCost);
				}
				if("1".equals(uinf.getYanwuBX())&&"1".equals(uinf.getYiwaiBX())){ //如果购买了两种保险
					bxo.setBxMoney(Integer.parseInt(yiwaiCost)+Integer.parseInt(yanwuCost)+""); //就设置两种价格的总和
				}
				bxo.setOrderNum(uinf.getOrderNum());
				bxo.setCustomer(uinf.getLinkName());
				bxo.setIdCard(uinf.getIDcase());
				bxord.add(bxo);
			}
			bxOrderSer.delDate();
			bxOrderSer.save(bxord);
		}else{
			return 0;
		}
		return 1;
	}
}
