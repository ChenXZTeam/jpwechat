package com.solar.tech.controller.seeTheWorld;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.bean.RequiredMaterials;
import com.solar.tech.bean.Visa;
import com.solar.tech.bean.VisaFree;
import com.solar.tech.bean.VisaOrder;
import com.solar.tech.service.VisaService;

@Controller
@RequestMapping("/framework/visa")
public class VisaController {
	
	@Resource
	private VisaService visaService;
	
	@RequestMapping("/getVisaList.action")
	@ResponseBody
	public List<Visa> getVisaList(){
		return this.visaService.getVisaList();
	}

	@RequestMapping("/addVisa.action")
	@ResponseBody
	public Serializable addVisa(Visa visa){
		return this.visaService.addVisa(visa);
	}
	
	@RequestMapping("/deleteVisa.action")
	@ResponseBody
	public int deleteVisa(String ids){
		return this.visaService.deleteVisa(ids);
	}
	
	@RequestMapping("/updateVisa.action")
	@ResponseBody
	public void updateVisa(Visa visa){
		this.visaService.updateVisa(visa);
	}
	
	@RequestMapping("/findByCountry.action")
	public String findByCountry(Visa visa,Map map){
		List<Visa> list = this.visaService.findByCountry(visa);
		map.put("list", list);
		return "/SeeTheWorld/VisaList";
	}
	
	@RequestMapping("/findByID.action")
	public String findByID(String id,Map map){
		Visa visa = this.visaService.findByID(id);
		map.put("visa", visa);
		return "/SeeTheWorld/VisaContent";
	}

	@RequestMapping("/findByVisaFreeID.action")
	public String findByVisaFreeID(String id,Map map){
		VisaFree visaFree = this.visaService.findByVisaFreeID(id);
		map.put("visaFree", visaFree);
		return "/SeeTheWorld/VisaFreeContent";
	}
	
	@RequestMapping("/getVisaFreeList.action")
	@ResponseBody
	public List<VisaFree> getVisaFreeList(){
		return this.visaService.getVisaFreeList();
	}

	@RequestMapping("/addVisaFree.action")
	@ResponseBody
	public Serializable addVisaFree(VisaFree visaFree){
		return this.visaService.addVisaFree(visaFree);
	}

	@RequestMapping("/updateVisaFree.action")
	@ResponseBody
	public void updateVisaFree(VisaFree visaFree){
		this.visaService.updateVisaFree(visaFree);
	}

	@RequestMapping("/deleteVisaFree.action")
	@ResponseBody
	public int deleteVisaFree(String ids){
		return this.visaService.deleteVisaFree(ids);
	}
	
	
	
	@RequestMapping("/getVisaOrderList.action")
	@ResponseBody
	public List<VisaOrder> getVisaOrderList(){
		System.out.println("getVisaOrderList");
		return this.visaService.getVisaOrderList();
	}
	
	@RequestMapping("/addVisaOrder.action")
	@ResponseBody
	public Serializable addVisaOrder(VisaOrder visaOrder){
		System.out.println(visaOrder);
		return this.visaService.addVisaOrder(visaOrder);
	}
	
	@RequestMapping("/updateVisaOrder.action")
	@ResponseBody
	public void updateVisaOrder(VisaOrder visaOrder){
		System.out.println(visaOrder);
		this.visaService.updateVisaOrder(visaOrder);
	}
	
	@RequestMapping("/deleteVisaOrder.action")
	@ResponseBody
	public int deleteVisaOrder(String ids){
		System.out.println(ids);
		return this.visaService.deleteVisaOrder(ids);
	}

	
	@RequestMapping("/getRequiredMaterialsList.action")
	@ResponseBody
	public List<RequiredMaterials> getRequiredMaterialsList(){
		System.out.println("getRequiredMaterialsList");
		return this.visaService.getRequiredMaterialsList();
	}
	
	@RequestMapping("/addRequiredMaterials.action")
	@ResponseBody
	public Serializable addRequiredMaterials(RequiredMaterials requiredMaterials){
		System.out.println(requiredMaterials);
		return this.visaService.addRequiredMaterials(requiredMaterials);
	}
	
	@RequestMapping("/updateRequiredMaterials.action")
	@ResponseBody
	public void updateRequiredMaterials(RequiredMaterials requiredMaterials){
		System.out.println(requiredMaterials);
		this.visaService.updateRequiredMaterials(requiredMaterials);
	}
	
	@RequestMapping("/deleteRequiredMaterials.action")
	@ResponseBody
	public int deleteRequiredMaterials(String ids){
		System.out.println(ids);
		return this.visaService.deleteRequiredMaterials(ids);
	}
	
	@RequestMapping("/findByMaterialsID.action")
	public String findByMaterialsID(String id,Map map){
		System.out.println(id);
		RequiredMaterials materials = this.visaService.findByMaterialsID(id);
		map.put("materials", materials);
		return "/SeeTheWorld/MaterialsContent";
	}
	
}
