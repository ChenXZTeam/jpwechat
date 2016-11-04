package com.solar.tech.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.swing.text.Segment;

import org.apache.commons.lang.StringUtils;

import com.solar.tech.bean.entity.FlightInfo;
import com.solar.tech.bean.entity.SeatInfo;
import com.travelsky.sbeclient.obe.response.AVDoubleResponse;
import com.travelsky.sbeclient.obe.response.AvSegment;
import com.travelsky.sbeclient.obe.response.FDItem;
import com.travelsky.sbeclient.obe.response.SkSegment;

public class OptimizeECUtils {

	// 复合查询，返回完整的航班信息
	public List<FlightInfo> query(String org, String dst, String date, String airCode ,String filgNo, String direct, String noStop){
		List<SkSegment> skList = new ECUtils().sk(org, dst, date, airCode, direct, noStop); // 查询飞行周期
		List<FDItem> fdList = new ECUtils().fd(org, dst, date, airCode, null, null, null); // 查询运价
		List<AvSegment> avList = new ECUtils().av(org, dst, date, null, airCode, direct, noStop, null, filgNo); // 查询座位可用
		
		List<FlightInfo> list = new ArrayList<FlightInfo>(); // 整合数据结果
		
		if(skList != null && skList.size() > 0){ 
			for(SkSegment s : skList){
				// 剔除掉补班的航班
				if(!"A".equals(s.getAirline().substring(s.getAirline().length() - 1, s.getAirline().length()))){
					FlightInfo bean = new FlightInfo(); // 航班信息
					bean.setAirCode(s.getAirline().substring(0, 2)); // 设置航空公司代码
					bean.setFlightNo(s.getAirline()); // 设置航班号
					bean.setPlaneStyle(s.getPlanestyle()); // 设置机型
					bean.setDepTime(s.getDeptime()); // 设置起飞时间
					bean.setOrgCity(s.getOrgcity()); // 设置起始城市
					bean.setArrTime(s.getArritime()); // 设置到达时间
					bean.setDstCity(s.getDstcity()); // 设置到达城市
					
					List<SeatInfo> seatList = new ArrayList<SeatInfo>(); // 航班座位信息
					
					String[] data = avList.get(0).getCangwei_data(); // 初始化座位数据
					char[] index = avList.get(0).getCangwei_index(); // 初始化座位信息
					
					AvSegment avSeg = null;
					for(AvSegment as : avList){
						// 根据当前航班号、起始城市及到达城市，得到对应的座位信息
						if(bean.getFlightNo().equals(as.getAirline()) && org.equals(as.getOrgcity()) && dst.equals(as.getDstcity())){
							avSeg = as;
						}
					}
					
					if(avSeg != null){
						data = avSeg.getCangwei_data(); // 得到对应的座位信息
						index = avSeg.getCangwei_index(); // 得到对应的座位信息
					}
					
					if(index != null && index.length > 0){
						for(int i=0;i<index.length;i++){
							SeatInfo seatInfo = new SeatInfo();
							
							seatInfo.setCangwei(index[i] + ""); // 设置舱位
							seatInfo.setCangwei_data(data[i]); // 设置舱位信息
							
							if(SeatUtils.getSeatNum(data[i]) != null){
								if(fdList != null && fdList.size() > 0){
									for(FDItem item : fdList){
										// 根据当前航司代码、及舱位获取对应的运价信息
										if(bean.getAirCode().equals(item.getAirline()) && (index[i] + "").equals(item.getCabin())){
											if(!StringUtils.isEmpty(item.getOnewayPrice())){
												seatInfo.setOnewayPrice(item.getOnewayPrice()); // 设置单程运价
											}
											if(!StringUtils.isEmpty(item.getRoundtripPrice())){
												seatInfo.setRoundtripPrice(item.getRoundtripPrice()); // 设置往返运价
											}
											if(!StringUtils.isEmpty(item.getBasicCabin())){
												seatInfo.setBasicCabin(item.getBasicCabin()); // 设置基础舱位信息
											}
										}
									}
								}
							}
							if(!StringUtils.isEmpty(seatInfo.getOnewayPrice()) && !StringUtils.isEmpty(seatInfo.getRoundtripPrice())){
								seatList.add(seatInfo); // 添加可用舱位信息
							}
						}
					}
					bean.setSeatList(seatList);
					list.add(bean);
				}
			}
		}
		return list;
	}	
	
	//返回往返的全部航班信息
	public Map<String, Object> roundtripAv(String org, String dst, String date, String returnDate, String airline, Integer page){
		Map<String, Object> map = new HashMap<String, Object>();
		AVDoubleResponse AVDouble  = new ECUtils().roundtripAv(org, dst, date, returnDate, airline, page);
		List<FDItem> fdList = new ECUtils().fd(org, dst, date, null, null, null, null); // 查询运价
		List<AvSegment> avList = new ECUtils().av(org, dst, date, null, null, null, null, null, null); // 查询座位可用
		
		List<FlightInfo> departAv = new ArrayList<FlightInfo>(); //去程航班的链表
		List<FlightInfo> returnAv = new ArrayList<FlightInfo>(); //回程航班的链表
		//处理去程的航班，重构去程航班链表
		System.out.println("==========================去程的航班==========================");
		for(int i=0; i<AVDouble.getDepartItemsCount(); i++){
			for(int j=0; j<AVDouble.getDepartAvItems().get(i).getSegments().size(); j++){
					FlightInfo bean = new FlightInfo(); // 航班信息
					bean.setFlightNo(AVDouble.getDepartAvItems().get(i).getSegments().get(j).getAirline());
					bean.setAirCode((bean.getFlightNo()).substring(0,2));
					bean.setDeplaneName(CityUtils.huoquPlane(CityUtils.getAirportNameByCode(AVDouble.getDepartAvItems().get(i).getSegments().get(j).getOrgcity())));
					bean.setArrPlaneName(CityUtils.huoquPlane(CityUtils.getAirportNameByCode(AVDouble.getDepartAvItems().get(i).getSegments().get(j).getDstcity())));
					bean.setPlaneStyle(AVDouble.getDepartAvItems().get(i).getSegments().get(j).getPlanestyle());
					bean.setDepTime(AVDouble.getDepartAvItems().get(i).getSegments().get(j).getDepTime());
					bean.setArrTime(AVDouble.getDepartAvItems().get(i).getSegments().get(j).getArriTime());
					bean.setOrgCity(AVDouble.getDepartAvItems().get(i).getSegments().get(j).getOrgcity()); 
					bean.setDstCity(AVDouble.getDepartAvItems().get(i).getSegments().get(j).getDstcity()); 

					List<SeatInfo> seatList = new ArrayList<SeatInfo>(); // 航班座位信息
					String[] data = avList.get(0).getCangwei_data(); // 初始化座位数据
					char[] index = avList.get(0).getCangwei_index(); // 初始化座位信息
					
					AvSegment avSeg = null;
					for(AvSegment as : avList){
						// 根据当前航班号、起始城市及到达城市，得到对应的座位信息
						if(bean.getFlightNo().equals(as.getAirline()) && org.equals(as.getOrgcity()) && dst.equals(as.getDstcity())){
							avSeg = as;
						}
					}
					
					if(avSeg != null){
						data = avSeg.getCangwei_data(); // 得到对应的座位信息
						index = avSeg.getCangwei_index(); // 得到对应的座位信息
					}
					
					if(index != null && index.length > 0){
						for(int k=0;k<index.length;k++){
							SeatInfo seatInfo = new SeatInfo();
							
							seatInfo.setCangwei(index[k] + ""); // 设置舱位
							seatInfo.setCangwei_data(data[k]); // 设置舱位信息
							
							if(SeatUtils.getSeatNum(data[k]) != null){
								if(fdList != null && fdList.size() > 0){
									for(FDItem item : fdList){
										// 根据当前航司代码、及舱位获取对应的运价信息
										if(bean.getAirCode().equals(item.getAirline()) && (index[k] + "").equals(item.getCabin())){
											if(!StringUtils.isEmpty(item.getOnewayPrice())){
												seatInfo.setOnewayPrice(item.getOnewayPrice()); // 设置单程运价
											}
											if(!StringUtils.isEmpty(item.getRoundtripPrice())){
												seatInfo.setRoundtripPrice(item.getRoundtripPrice()); // 设置往返运价
											}
											if(!StringUtils.isEmpty(item.getBasicCabin())){
												seatInfo.setBasicCabin(item.getBasicCabin()); // 设置基础舱位信息
											}
										}
									}
								}
							}
							if(!StringUtils.isEmpty(seatInfo.getOnewayPrice()) && !StringUtils.isEmpty(seatInfo.getRoundtripPrice())){
								seatList.add(seatInfo); // 添加可用舱位信息
							}
						}
					}
					bean.setSeatList(seatList);
					if(bean.getSeatList().size()>0&&!"".equals(bean.getOrgCity())&&org.equals(bean.getOrgCity())&&dst.equals(bean.getDstCity())){ //只搜直达的航班，去掉中转的航班
						System.out.println("去程的航班信息："+bean.toString());
						departAv.add(bean);
					} 
			}
		}
		
		//处理回程的航班，重构回程航班链表
		System.out.println("==========================回程的航班==========================");
		for(int i=0; i<AVDouble.getReturnItemsCount(); i++){
			for(int j=0; j<AVDouble.getReturnAvItems().get(i).getSegments().size(); j++){
					FlightInfo bean = new FlightInfo(); // 航班信息
					bean.setFlightNo(AVDouble.getReturnAvItems().get(i).getSegments().get(j).getAirline());
					bean.setAirCode((bean.getFlightNo()).substring(0,2));
					bean.setDeplaneName(CityUtils.huoquPlane(CityUtils.getAirportNameByCode(AVDouble.getReturnAvItems().get(i).getSegments().get(j).getOrgcity())));
					bean.setArrPlaneName(CityUtils.huoquPlane(CityUtils.getAirportNameByCode(AVDouble.getReturnAvItems().get(i).getSegments().get(j).getDstcity())));
					bean.setPlaneStyle(AVDouble.getReturnAvItems().get(i).getSegments().get(j).getPlanestyle());
					bean.setDepTime(AVDouble.getReturnAvItems().get(i).getSegments().get(j).getDepTime());
					bean.setArrTime(AVDouble.getReturnAvItems().get(i).getSegments().get(j).getArriTime());
					bean.setOrgCity(AVDouble.getReturnAvItems().get(i).getSegments().get(j).getOrgcity()); 
					bean.setDstCity(AVDouble.getReturnAvItems().get(i).getSegments().get(j).getDstcity()); 

					List<SeatInfo> seatList = new ArrayList<SeatInfo>(); // 航班座位信息
					String[] data = avList.get(0).getCangwei_data(); // 初始化座位数据
					char[] index = avList.get(0).getCangwei_index(); // 初始化座位信息
					
					AvSegment avSeg = null;
					for(AvSegment as : avList){
						// 根据当前航班号、起始城市及到达城市，得到对应的座位信息
						if(bean.getFlightNo().equals(as.getAirline()) && org.equals(as.getOrgcity()) && dst.equals(as.getDstcity())){
							avSeg = as;
						}
					}
					
					if(avSeg != null){
						data = avSeg.getCangwei_data(); // 得到对应的座位信息
						index = avSeg.getCangwei_index(); // 得到对应的座位信息
					}
					
					if(index != null && index.length > 0){
						for(int k=0;k<index.length;k++){
							SeatInfo seatInfo = new SeatInfo();
							
							seatInfo.setCangwei(index[k] + ""); // 设置舱位
							seatInfo.setCangwei_data(data[k]); // 设置舱位信息
							
							if(SeatUtils.getSeatNum(data[k]) != null){
								if(fdList != null && fdList.size() > 0){
									for(FDItem item : fdList){
										// 根据当前航司代码、及舱位获取对应的运价信息
										if(bean.getAirCode().equals(item.getAirline()) && (index[k] + "").equals(item.getCabin())){
											if(!StringUtils.isEmpty(item.getOnewayPrice())){
												seatInfo.setOnewayPrice(item.getOnewayPrice()); // 设置单程运价
											}
											if(!StringUtils.isEmpty(item.getRoundtripPrice())){
												seatInfo.setRoundtripPrice(item.getRoundtripPrice()); // 设置往返运价
											}
											if(!StringUtils.isEmpty(item.getBasicCabin())){
												seatInfo.setBasicCabin(item.getBasicCabin()); // 设置基础舱位信息
											}
										}
									}
								}
							}
							if(!StringUtils.isEmpty(seatInfo.getOnewayPrice()) && !StringUtils.isEmpty(seatInfo.getRoundtripPrice())){
								seatList.add(seatInfo); // 添加可用舱位信息
							}
						}
					}
					bean.setSeatList(seatList);
					if(bean.getSeatList().size()>0&&!"".equals(bean.getOrgCity())&&dst.equals(bean.getOrgCity())&&org.equals(bean.getDstCity())){  //只搜直达的航班，去掉中转的航班
						System.out.println("回程航班："+bean);
						returnAv.add(bean);
					}
			}
		}
		map.put("departAv", departAv); //去程的列表
		map.put("returnAv", returnAv); //回程的列表
		return map;
	}
	
	// 支付前再确认该舱位是否还有空余座位
	public Integer confirmCabin(String org, String dst, String date, String flightNo, String cabin){
		List<AvSegment> avList = new ECUtils().av(null, null, date, null, null, null, null, null, flightNo); // 查询座位可用 
		if(avList != null && avList.size() > 0){
			for(AvSegment avSeg : avList){
				// 判断是否是当前的出发城市及到达城市
				if(org.equals(avSeg.getOrgcity()) && dst.equals(avSeg.getDstcity())){
					int i = 0;
					for(char ind : avSeg.getCangwei_index()){
						// 判断是否是当前舱位
						if(cabin.equals(ind + "")){
							return SeatUtils.getSeatNum(avSeg.getCangwei_data()[i]); // 返回舱位可用座位数
						}
						i++;
					}
				}
			}
		}
		return null;
	}
}