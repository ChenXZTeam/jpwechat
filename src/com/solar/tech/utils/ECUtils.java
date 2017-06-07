package com.solar.tech.utils;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.travelsky.sbeclient.SBEClient;
import com.travelsky.sbeclient.authorization.AccountActiveRequest;
import com.travelsky.sbeclient.authorization.AuthorizationRequest;
import com.travelsky.sbeclient.exceptions.SBEClientException;
import com.travelsky.sbeclient.obe.AVClient;
import com.travelsky.sbeclient.obe.CreatePnrClient;
import com.travelsky.sbeclient.obe.DFSQClient;
import com.travelsky.sbeclient.obe.DSGClient;
import com.travelsky.sbeclient.obe.DrawDomesticTicketClient;
import com.travelsky.sbeclient.obe.ETRYClient;
import com.travelsky.sbeclient.obe.FDClient;
import com.travelsky.sbeclient.obe.FFClient;
import com.travelsky.sbeclient.obe.PATClient;
import com.travelsky.sbeclient.obe.PNRManageClient;
import com.travelsky.sbeclient.obe.PataFareClient;
import com.travelsky.sbeclient.obe.QTEClient;
import com.travelsky.sbeclient.obe.RtPnrClient;
import com.travelsky.sbeclient.obe.SKClient;
import com.travelsky.sbeclient.obe.TRFDClient;
import com.travelsky.sbeclient.obe.XSFSDClient;
import com.travelsky.sbeclient.obe.book.BookContact;
import com.travelsky.sbeclient.obe.book.BookFCInfo;
import com.travelsky.sbeclient.obe.book.BookFNInfo;
import com.travelsky.sbeclient.obe.book.BookFPInfo;
import com.travelsky.sbeclient.obe.book.OSIInfo;
import com.travelsky.sbeclient.obe.book.PassengerInfo;
import com.travelsky.sbeclient.obe.book.RMKInfo;
import com.travelsky.sbeclient.obe.book.SSRInfo;
import com.travelsky.sbeclient.obe.book.SegmentInfo;
import com.travelsky.sbeclient.obe.exceptions.ObeException;
import com.travelsky.sbeclient.obe.request.AVRequest;
import com.travelsky.sbeclient.obe.request.AVRoundTripRequest;
import com.travelsky.sbeclient.obe.request.BookingInfoRequest;
import com.travelsky.sbeclient.obe.request.ChildInfPassenger;
import com.travelsky.sbeclient.obe.request.DFSQRequest;
import com.travelsky.sbeclient.obe.request.DrawDomesticTicketRequest;
import com.travelsky.sbeclient.obe.request.DsgRequest;
import com.travelsky.sbeclient.obe.request.FDRequest;
import com.travelsky.sbeclient.obe.request.FFRequest;
import com.travelsky.sbeclient.obe.request.PNRAirSegmentRequest;
import com.travelsky.sbeclient.obe.request.PNRBookInfoRequest;
import com.travelsky.sbeclient.obe.request.PNRCancelRequest;
import com.travelsky.sbeclient.obe.request.PNRChangeCertificateRequest;
import com.travelsky.sbeclient.obe.request.PNRChdInfPassengersRequest;
import com.travelsky.sbeclient.obe.request.PNRDeleteIdxesRequest;
import com.travelsky.sbeclient.obe.request.PNRPassengersRequest;
import com.travelsky.sbeclient.obe.request.PNRReleaseSeatRequest;
import com.travelsky.sbeclient.obe.request.PNRRequest;
import com.travelsky.sbeclient.obe.request.PNRTKTAirSegmentRequest;
import com.travelsky.sbeclient.obe.request.PNRTKTLRequest;
import com.travelsky.sbeclient.obe.request.PatRequest;
import com.travelsky.sbeclient.obe.request.PataFareInfo;
import com.travelsky.sbeclient.obe.request.PataFareRequest;
import com.travelsky.sbeclient.obe.request.QTERequest;
import com.travelsky.sbeclient.obe.request.RefundFormRequest;
import com.travelsky.sbeclient.obe.request.RefundTktRequest;
import com.travelsky.sbeclient.obe.request.SKRequest;
import com.travelsky.sbeclient.obe.request.XSFSDRequest;
import com.travelsky.sbeclient.obe.response.AVDoubleResponse;
import com.travelsky.sbeclient.obe.response.AVResponse;
import com.travelsky.sbeclient.obe.response.AvItem;
import com.travelsky.sbeclient.obe.response.AvSegment;
import com.travelsky.sbeclient.obe.response.DfsqResponse;
import com.travelsky.sbeclient.obe.response.DsgResponse;
import com.travelsky.sbeclient.obe.response.DsgSegment;
import com.travelsky.sbeclient.obe.response.FDItem;
import com.travelsky.sbeclient.obe.response.FDResponse;
import com.travelsky.sbeclient.obe.response.FFResponse;
import com.travelsky.sbeclient.obe.response.FFSegment;
import com.travelsky.sbeclient.obe.response.OBECommonResponse;
import com.travelsky.sbeclient.obe.response.PATFareItem;
import com.travelsky.sbeclient.obe.response.PatResponse;
import com.travelsky.sbeclient.obe.response.PataFarePriceInfo;
import com.travelsky.sbeclient.obe.response.PataFareResponse;
import com.travelsky.sbeclient.obe.response.PnrResponse;
import com.travelsky.sbeclient.obe.response.QTEResult;
import com.travelsky.sbeclient.obe.response.RefundFormResponse;
import com.travelsky.sbeclient.obe.response.SKResponse;
import com.travelsky.sbeclient.obe.response.SkItem;
import com.travelsky.sbeclient.obe.response.SkSegment;
import com.travelsky.sbeclient.obe.response.XSFSPFare;
import com.travelsky.sbeclient.obe.response.Xsfsd;
import com.travelsky.sbeclient.obe.response.XsfsdResponse;
import com.travelsky.sbeclient.obe.response.drawDomesticTicket.DrawDomesticTicketResponse;
import com.travelsky.sbeclient.obe.response.drawDomesticTicket.PsgInfo;
import com.travelsky.sbeclient.obe.response.rt.RTResponse;
import com.travelsky.sbeclient.obe.response.rt.TN;
import com.travelsky.sbeclient.utils.SBEUtil;

public class ECUtils {

	private static final String USERNAME = "tanjianqin";	// 账号
	private static final String PASSWORD = "tanjianqin";	// 密码
	private static final String OFFICENO = "bjs187";		// 操作员
	
	private String token; // 口令
	
	public ECUtils(){
		hang(); 		// 挂起
		activate();		// 激活
		applyToken(); 	// 申请口令
	}
	
	// 航班座位可利用显示
	public List<AvSegment> av(String org, String dst, String date, String time, String airline, String direct, String nonstop, String stopCity, String fltNo){
		AVRequest avRequest=new AVRequest (); // 新建一个请求对象
		avRequest.setOfficeNo(OFFICENO);  // 设置Office号
		avRequest.setToken(token); // 设置令牌号
		
		if(!StringUtils.isEmpty(org)){
			avRequest.setOrg(org); // 设置出发城市
		}
		if(!StringUtils.isEmpty(dst)){
			avRequest.setDst(dst); // 设置到达城市 
		}
		if(!StringUtils.isEmpty(date)){
			avRequest.setDate(date); // 设置查询日期，格式 yyy-MM-dd
		}
		if(!StringUtils.isEmpty(time)){
			avRequest.setTime(time); // 设置查询时间，格式 HH:MM
		}
		if(!StringUtils.isEmpty(airline)){
			avRequest.setAirline(airline); // 设置航空公司，如：CZ
		}
		if(!StringUtils.isEmpty(direct)){
			avRequest.setDirect(direct); // 是否直飞
		}
		if(!StringUtils.isEmpty(nonstop)){
			avRequest.setNonstop(nonstop); // 是否有经停点
		}
		if(!StringUtils.isEmpty(stopCity)){
			avRequest.setStopCity(stopCity); // 转机地（中转城市）
		}
		if(!StringUtils.isEmpty(fltNo)){
			avRequest.setFltNo(fltNo);// 航班号除了查询日期外，这个条件跟其他条件不能共存
		}
		
		AVClient avClient=new AVClient(); // 新建客户端对象
		try {
			AVResponse avResponse=avClient.avForObe(avRequest); // 新建一个响应对象
			if(avResponse != null && avResponse.getResultCode() == 0){
				
				List<AvSegment> resultList = new ArrayList<AvSegment>();
				
				List<AvItem> avList = avResponse.getAvItems();
				if(avList != null && avList.size() > 0){
					for(AvItem item : avList){
						for(AvSegment avSeg : item.getSegments()){
							resultList.add(avSeg); // 获取响应中的所有航班座位
						}
					}
				}
				
				if(resultList != null && resultList.size() > 0){
					return resultList;
				}
			}
		} catch (ObeException e) {
			e.printStackTrace();
		} 
		return null;
	}
	
	// 运价查询
	public List<FDItem> fd(String org, String dst, String date, String airline, String planeModel, String passType, String fullFareBasis) {
		FDRequest fdRequest = new FDRequest(); // 新建一个请求对象
		fdRequest.setOfficeNo(OFFICENO); // 设置Office号
		fdRequest.setToken(token); // 设置令牌号
		
		fdRequest.setOrg(org); // 设置出发城市
		fdRequest.setDst(dst); // 设置到达城市
		fdRequest.setDate(date); // 设置查询日期
		if(airline == null){
			fdRequest.setAirline("");
		}else{
			fdRequest.setAirline(airline); // 航空公司两字码
		}
		fdRequest.setPlaneModel(planeModel); // 设置机型
		fdRequest.setPassType(passType); // 旅客类型 （"ad"：成人；"IN"：婴儿；"CH"：儿童）
		fdRequest.setFullFareBasis(fullFareBasis); // 运价基础 ，可为空
		
		FDClient fdClient = new FDClient(); // 新建客户端对象
		try {
			FDResponse fdResponse = fdClient.fdForObe(fdRequest); // 新建一个响应对象
			if(fdResponse != null && fdResponse.getResultCode() == 0){
				return fdResponse.getFare().getSortedfares(); // 返回所有的运价信息
			}
		} catch (ObeException e) {
			System.out.println("接口运价异常  出发城市："+org+", "+"到达城市："+dst+", 出发日期："+date+", 航空公司："+airline);
			e.printStackTrace();
		} 
		return null;
	}
	
	// 获取飞行周期(查询一城市对在特定周期内所有航班的信息,只能查询当天、昨天及以后的周期)
	public List<SkSegment> sk(String org, String dst, String date, String airline, String direct, String noStop){
		SKRequest skRequest = new SKRequest();// 新建一个请求对象
		skRequest.setToken(token); // 设置令牌号
		skRequest.setOfficeNo(OFFICENO); // 设置Office号
		
		skRequest.setOrg(org); // 设置出发城市
		skRequest.setDst(dst); // 设置到达城市
		skRequest.setDate(date); // 设置查询日期
		if(airline == null){
			skRequest.setAirline("");
		}else{
			skRequest.setAirline(airline); // 设置航空公司
		}
		skRequest.setDirect(direct); // 指明是否直飞航班 ，默认为false 
		skRequest.setNoStop(noStop); // 指明是否只查询无经停航班 ，默认为false 
		
		SKClient skClient = new SKClient(); // 新建客户端对象
		try {
			SKResponse skResponse = skClient.skForObe(skRequest); // 新建一个响应对象
			if(skResponse !=null && skResponse.getResultCode() == 0){
				List<SkItem> skList = skResponse.getSkItems();
				if(skList != null && skList.size() > 0){
					
					List<SkSegment> resultList = new ArrayList<SkSegment>();
					
					for(SkItem item : skList){
						for(SkSegment skSeg : item.getSegments()){
							resultList.add(skSeg);
						}
					}
					
					if(resultList != null && resultList.size() > 0){
						return resultList; // 返回所有飞行周期
					}
				}
			}
		} catch (ObeException e) { 
			e.printStackTrace(); 
		}
		return null;
	}
	
	// 查询显示指定日期的航段上的航班信息(根据航班号)
	public DsgSegment[] dsgByFlightNo(String flightNo, String flightDate, String cabin, String segment){
		DsgRequest dsgRequest=new DsgRequest(); // 新建一个请求对象
		
		dsgRequest.setToken(token); // 设置令牌号
		dsgRequest.setOfficeNo(OFFICENO); // 设置Office号
		
		dsgRequest.setFlightNo(flightNo); // 设置航班号
		dsgRequest.setFlightDate(flightDate); // 设置航班日期
		if(!StringUtils.isEmpty(cabin)){
			dsgRequest.setCabin(cabin);  // 舱位
		}
		if(!StringUtils.isEmpty(segment)){
			dsgRequest.setSegment(segment);  // 航段（城市对）
		}
		
		DSGClient dsgClient = new DSGClient(); // 新建客户端对象
		try {
			DsgResponse dsgResponse = dsgClient.dsg(dsgRequest); // 新建一个响应对象
			if(dsgResponse != null && dsgResponse.getResultCode() == 0){
				return dsgResponse.getSegments(); // 返回所有航班信息
			}
		} catch (ObeException e) { 
			e.printStackTrace(); 
		}
		return null;
	}
	
	//查询往返的方法
	public AVDoubleResponse roundtripAv(String org, String dst, String date, String returnDate, String airline, Integer page){
			AVRoundTripRequest request = new AVRoundTripRequest ();
			request.setOfficeNo(OFFICENO);
			request.setToken(token);
			System.out.println(org+", "+dst+", "+date+", "+returnDate+", "+airline+", "+page);
			request.setOrg(org);     // 出发城市
			request.setDst(dst);	// 抵达城市
			request.setDepartDate(date);	// 查询日期，格式 yyy-MM-dd
			request.setReturnDate(returnDate);   // 返回日期，格式 yyy-MM-dd
			if(!airline.equals("")||!airline.equals(" ")||airline!=null){
				request.setAirline(airline);	// 航空公司（可选）
			}
			if(page != null){
				request.setPage(page); 	// 限制最大翻页次数（可选，默认20）
			}
			
			AVClient avClient=new AVClient();
			try { 
				AVDoubleResponse avResponse = avClient.avForRoundTrip(request);
				return avResponse;
			} catch (ObeException e) { 
				e.printStackTrace(); 
				return null;
			} 
	}
	
	// 查询显示指定日期的航段上的航班信息(根据PNR号)
	public DsgSegment[] dsgByPnrNo(String pnrNo, int[] segIdxInPnr){
		DsgRequest dsgRequest=new DsgRequest(); // 新建一个请求对象
		
		dsgRequest.setToken(token); // 设置令牌号
		dsgRequest.setOfficeNo(OFFICENO); // 设置Office号
		
		dsgRequest.setPnrNo(pnrNo); // 设置PNR号
		dsgRequest.setSegIdxInPnr(segIdxInPnr); // PNR里的航段序号，可选
		
		DSGClient dsgClient = new DSGClient(); // 新建客户端对象
		try {
			DsgResponse dsgResponse = dsgClient.dsg(dsgRequest); // 新建一个响应对象
			if(dsgResponse != null && dsgResponse.getResultCode() == 0){
				return dsgResponse.getSegments(); // 返回所有航班信息
			}
		} catch (ObeException e) { 
			e.printStackTrace(); 
		}
		return null;
	}
	
	// 获取航班信息
	public FFSegment[] ff(String flightNo, String flightDate){ 
		FFRequest ffRequest= new FFRequest(); // 新建一个请求对象
		ffRequest.setOfficeNo(OFFICENO); // 设置Office号
		ffRequest.setToken(token); // 设置令牌号
		
		ffRequest.setFlightNo(flightNo); // 设置航班号 
		ffRequest.setFlightDate(flightDate); // 设置航班日期
		
		FFClient ffClient = new FFClient(); // 新建客户端对象
		try {
			FFResponse response = ffClient.ffForObe(ffRequest); // 新建一个响应对象
			if(response !=null && response.getResultCode() == 0){
				return response.getSegments(); // 返回所有航段信息
			}
		} catch (ObeException e) { 
			e.printStackTrace(); 
		}
		return null;
	}
	
	// 国际运票价
	public List<Xsfsd> xsfsd(String fsqIndex, String depCity, String arrCity, String depDate, String airlineCode, String routeType, String travelerType, String priceOrder, String cabin, String isNego, String accountCode, String isPrivatePriceOnly) {
		XSFSDRequest request =new XSFSDRequest (); // 新建一个请求对象 
		request.setOfficeNo(OFFICENO); // 设置Office号
		request.setToken(token); // 设置令牌号
		
		if(fsqIndex != null){
			request.setFsqIndex(fsqIndex); // 设置价格序号
		}
		request.setDepCity(depCity); // 设置出发城市
		request.setArrCity(arrCity); // 设置到达城市
		request.setDepDate(depDate); // 设置乘机日期 ddMMMyy
		request.setAirlineCode(airlineCode); // 设置航空公司
		request.setRouteType(routeType); // 单程OW，来回RT
		if(travelerType != null){
			request.setTravelerType(travelerType); // 旅客类型,ADT 成人, CHD 儿童,UM 无人陪伴儿童,默认null成人
		}
		if(priceOrder != null){
			request.setPriceOrder(priceOrder); // 最低价格排序 true或false
		}
		if(cabin != null){
			request.setCabin(cabin); // 舱位
		}
		request.setIsNego(isNego); // 是否使用协议价
		request.setAccountCode(accountCode); // 大客户编码
		request.setIsPrivatePriceOnly(isPrivatePriceOnly); // 是否仅显示带有包含大客户号的私有运价
	
		XSFSDClient client = new XSFSDClient(); // 新建客户端对象
		try {
			XsfsdResponse response = client.xsfsd(request); // 新建一个响应对象
			if(response != null && response.getResultCode() == 0){
				return response.getXsfsdList(); // 返回所有国际运票价
			}
		} catch (ObeException e) {
			e.printStackTrace();
		} 
		return null;
	}
	
	// 机票预订
	public PnrResponse booking(BookContact bookContact, SegmentInfo[] segmentInfos, PassengerInfo[] passengerInfos, String ticketLimit,
			SSRInfo[] ssrInfos, OSIInfo[] osiInfos, RMKInfo[] rmkInfos, Boolean team, String teamName, Integer teamPsgNum){
		
		BookingInfoRequest request = new BookingInfoRequest(); // 新建一个请求对象
		request.setOfficeNo(OFFICENO); // 设置Office号
		request.setToken(token); // 设置令牌号
		
		request.setContact(bookContact); // 设置联系组
		request.setSegments(segmentInfos); // 设置航段信息
		request.setPassengers(passengerInfos); // 旅客信息
		request.setTicketLimit(ticketLimit); // 设置出票时限
		if(ssrInfos != null){
			request.setSsrs(ssrInfos); // 设置 SSR组
		}
		request.setOsis(osiInfos); // 设置OSI组
		if(rmkInfos != null){
			request.setRmks(rmkInfos); // 设置RMK组
		}
		if(team != null){
			request.setTeam(team); // 团队标志־
		}else{
			request.setTeam(false);
		}
		request.setTeamName(teamName); // 团队名
		request.setTeamPsgNum(teamPsgNum); // 团队人数
		
		CreatePnrClient client = new CreatePnrClient(); // 新建一个客户端对象
		try {
			PnrResponse response =client.createPnr(request); // // 新建一个响应对象
			if(response != null && response.getResultCode() == 0){
				return response; // 返回响应对象
			}
		} catch (ObeException e) {
			e.printStackTrace();
		} 
		return null;
	}
	
	// 提取PNR
	public RTResponse rt(String pnrNo){
		PNRRequest request = new PNRRequest(); // 新建一个请求对象 

		request.setOfficeNo(OFFICENO); // 设置Office号
		request.setToken(token);  // 设置令牌号
		
		request.setPnrNo(pnrNo); // 设置pnr号码
		try{
			RtPnrClient rtClient = new RtPnrClient(); // 新建一个客户端对象
			RTResponse response=rtClient.rt(request); // 新建一个响应对象
			if(response != null && response.getResultCode() == 0){
				return response; // 返回提取的PNR
			}
		}catch (ObeException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 修改出票时限(时限必须在飞机起飞时间以前)
	public boolean tktl(String pnrNo, String tktl){ 
		PNRTKTLRequest request = new PNRTKTLRequest(); // 新建一个请求对象 
		request.setOfficeNo(OFFICENO); // 设置Office号
		request.setToken(token); // 设置令牌号
		
		request.setPnrNo(pnrNo); // 设置Pnr号码
		request.setTktl(tktl);  // 设置新的出票时限
		
		PNRManageClient client =new PNRManageClient(); // 新建一个客户端对象
		try{
			OBECommonResponse response = client.tktl(request); // 新建一个响应对象
			if(response != null && response.getResultCode() == 0){
				if("OK".equals(response.getResultMsg())){
					return true; // 返回修改结果
				}
			}
		}catch (ObeException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// 国内出票
	public List<PsgInfo> drawer(String pnrNo){
		DrawDomesticTicketRequest request = new DrawDomesticTicketRequest(); // 新建一个请求对象 
		request.setOfficeNo(OFFICENO);// 设置Office号
		request.setToken(token); // 设置令牌号
		
		request.setPnrNo(pnrNo); // 设置Pnr号 
		request.setPrinterNo("1"); // 设置打票机号
		
		DrawDomesticTicketClient client = new DrawDomesticTicketClient(); // 新建客户端对象
		try {
			DrawDomesticTicketResponse response = client.drawDomesticTicket(request); // 新建一个响应对象
			if(response != null && response.getResultCode() == 0){
				return response.getPassengerInfos(); // 返回所有的旅客出票信息
			}
		} catch (ObeException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	// 国际出票
	public List<TN> dfsq(String pnrNo, String carrier){ 
		// 新建一个请求对象 
		DFSQRequest request = new DFSQRequest();
		
		request.setOfficeNo(OFFICENO); // 设置Office号
		request.setToken(token); // 设置令牌号

		request.setPnrNo(pnrNo); // 设置Pnr号
		request.setLowestonly("true"); // 设置是否用最低运价
		request.setValidateCarrier(carrier); // 出票航空公司
		request.setPrinterNo("1"); // 设置打票机号
		
		DFSQClient client = new DFSQClient();// 新建客户端对象
		try { 
			DfsqResponse response = client.dfsq(request); // 新建一个响应对象
			if(response != null && response.getResultCode() == 0){
				return response.getTnList(); // 返回所有的票号信息
			}
		} catch (ObeException e) { 
			e.printStackTrace();
		} 
		return null;
	} 
	
	// eTerm电子客票出票重试。
	public boolean etry(String pnrNo) { 
		PNRRequest request = new PNRRequest(); // 新建一个请求对象
		
		request.setOfficeNo(OFFICENO); // 设置Office号
		request.setToken(token); // 设置令牌号
		
		request.setPnrNo(pnrNo); // 设置PNR号
		ETRYClient client = new ETRYClient(); //新建一个客户端
		try{
			OBECommonResponse response = client.etry(request); // 新建一个响应对象
			if(response != null && response.getResultCode() == 0){
				if("OK".equals(response.getResultMsg())){
					return true;
				}
			}
		}catch(ObeException e){
			e.printStackTrace();
		}
		return false;
	}
	
	// 删除PNR
	public boolean cancelPnr(String pnrNo){
		PNRCancelRequest request = new PNRCancelRequest(); // 新建一个请求对象 
		
		request.setOfficeNo(OFFICENO); // 设置Office号
		request.setToken(token); // 设置令牌号
		
		request.setPnrNo(pnrNo); // 设置PNR号
		
		// 新建客户端对象
		PNRManageClient client = new PNRManageClient(); 
		try {
			OBECommonResponse response = client.cancelPnr(request);// 新建一个响应对象 
			if(response != null && response.getResultCode() == 0){
				if("OK".equals(response.getResultMsg())){
					System.out.println("删除成功");
					return true; // 返回删除结果
				}
			}
		} catch (ObeException e) {
			e.printStackTrace();
		} 
		return false;
	}
	
	// 同舱改期
	public boolean changeTKTAirSegment(String pnrNo, String fltNoOld, String fltDateOld, String fltNoNew, String fltDateNew) { 
		PNRTKTAirSegmentRequest request = new PNRTKTAirSegmentRequest(); // 新建一个请求对象
		request.setOfficeNo(OFFICENO);// 设置Office号 
		request.setToken(token);// 设置令牌号
		
		request.setPnrNo(pnrNo); // 设置PNR号 
		request.setFltNoOld(fltNoOld); // 设置旧航班号
		request.setFltDateOld(fltDateOld); // 设置旧航班日期
		request.setFltNoNew(fltNoNew); // 设置新航班号
		request.setFltDateNew(fltDateNew); // 设置新航班日期
		
		request.setActionCode ("NN"); // 设置行动代码，只能为NN
		
		PNRManageClient client = new PNRManageClient();
		try{
			OBECommonResponse response = client.changeTKTAirSegment(request); // 新建一个响应对象
			if(response != null && response.getResultCode() == 0){
				if("OK".equals(response.getResultMsg())){
					return true; // 返回同舱改期结果
				}
			}
		}catch(ObeException e){
			e.printStackTrace();
		}
		return false;
	}
	
	// 国内按航段运价计算
	public List<PataFarePriceInfo> pataFare(PataFareInfo[] pataFareInfos, String passengerType) { 
		PataFareRequest request = new PataFareRequest (); // 新建一个请求对象
		request.setOfficeNo(OFFICENO); // 获取office号
		request.setToken(token); // 设置令牌号
		
		 
		request.setSegmentInfo(pataFareInfos); // 设置航班信息，最多支持5个航段
		if(!StringUtils.isEmpty(passengerType)){
			request.setPassengerType(passengerType); // 旅客类型 默认是成人成人:不填 IN:婴儿 CH:儿童 JC:因公带伤警察GM：伤残军人
		}
		
		PataFareClient client=new PataFareClient(); // 新建客户端对象
		try { 
			PataFareResponse response=client.pataFare(request); 
			if(response != null && response.getResultCode() == 0){
				return response.getPriceInfoList(); // 返回所有价格信息
			}
		} catch (ObeException e) { 
			e.printStackTrace(); 
		} 
		return null;
	} 
	
	// 国内按航段运价计算
	public List<PataFarePriceInfo> pataFare(PataFareInfo pataFareInfo, String passengerType) { 
		PataFareRequest request = new PataFareRequest (); // 新建一个请求对象
		request.setOfficeNo(OFFICENO); // 获取office号
		request.setToken(token); // 设置令牌号
		
		request.setSegmentInfo(new PataFareInfo[]{pataFareInfo}); // 设置航班信息，单个航段
		if(!StringUtils.isEmpty(passengerType)){
			request.setPassengerType(passengerType); // 旅客类型 默认是成人成人:不填 IN:婴儿 CH:儿童 JC:因公带伤警察GM：伤残军人
		}
		
		PataFareClient client=new PataFareClient(); // 新建客户端对象
		try { 
			PataFareResponse response=client.pataFare(request); 
			if(response != null && response.getResultCode() == 0){
				return response.getPriceInfoList(); // 返回所有价格信息
			}
		} catch (ObeException e) { 
			e.printStackTrace(); 
		} 
		return null;
	}
	
	// 生成退票表格
	public RefundFormResponse getRefund(String option, String tktNo, String tktType) { 
		RefundTktRequest request=new RefundTktRequest(); // 新建一个请求对象
		
		request.setOfficeNo(OFFICENO); // 设置Office号
		request.setToken(token); // 设置令牌号
		
		request.setOption(option); // 票类选项：AM票号，M退票单号
		request.setTktNo(tktNo); // 票号
		request.setTktType(tktType); // 票类型: D 国内,I 国际
		request.setPrintNo("1"); // 打印机号码
		
		TRFDClient client=new TRFDClient(); //新建一个客户端
		try{
			RefundFormResponse response=client.getRefundTKTForm(request); // 新建一个响应对象
			if(response != null && response.getResultCode() == 0){
				return response; // 返回退票表格
			}
		}catch(ObeException e){
			e.printStackTrace();
		}
		return null;
	}
		
	// 退票
	public boolean refund(RefundFormResponse response){
		RefundFormRequest request = new RefundFormRequest(); // 新建一个请求对象
		request.setOfficeNo(OFFICENO); // office号
		request.setToken(token); // 设置令牌号
		
		//把response 表单内容复制到formRequest,其中包括cmdOption cmdPrnt cmdTktType cmdNo command这几属性为原来返回内容 
		request.setCommand(response.getCommand());
		request.setCmdOption(response.getCmdOption());
		request.setCmdPrnt(response.getCmdPrnt());
		request.setCmdTktType(response.getCmdTktType());
		request.setCmdNo(response.getCmdNo());
		request.setAirlineCode(response.getAirlineCode());
		request.setTktNo(response.getTktNo());
		request.setTktNo_end(response.getTktNo_end());
		request.setFlagforgroup(response.getFlagforgroup());
		request.setCurrency(response.getCurrency());
		request.setPassName(response.getPassName());
		request.setGrossRefund(response.getGrossRefund());
		request.setCommissionRate(response.getCommissionRate());
		request.setDeduction(response.getDeduction());
		request.setCommission(response.getCommission());
		request.setNetRefund(response.getNetRefund());
		request.setPayMethod(response.getPayMethod());
		request.setRefund(response.getRefund());
		request.setCheck(response.getCheck());
		request.setCreditcard(response.getCreditcard());
		request.setConjunction(response.getConjunction());
		request.setCouponNo(response.getCouponNo());
		request.setTaxAmount(response.getTaxAmount());
		request.setTaxCode(response.getTaxCode());
		request.setRemark(response.getRemark());
		
		TRFDClient trfdClient = new TRFDClient(); //新建一个客户端
		try {
			OBECommonResponse obeResp = trfdClient.changeRefund(request); // 新建一个响应对象
			if(obeResp != null && obeResp.getResultCode() == 0){
				if("OK".equals(obeResp.getResultMsg())){
					return true; // 返回退票结果
				}
			}
		} catch (ObeException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// PNR项增加addBookInfo
	public boolean addBookInfo(String pnrNo, SSRInfo[] ssrInfos, RMKInfo rmkInfo, BookFCInfo[] bookFCInfos, BookFNInfo[] bookFNInfos, BookFPInfo[] bookFPInfo) {
		PNRBookInfoRequest request = new PNRBookInfoRequest(); // 新建一个请求对象
		request.setOfficeNo(OFFICENO); // office号
		request.setToken(token); // 设置令牌号
		
		request.setPnrNo(pnrNo); // 设置PNR号
		request.setSsres(ssrInfos); // 设置特殊服务组(SSR)
		request.setRemark(rmkInfo); // 设置备注组
		request.setFces(bookFCInfos); // 设置票价组
		request.setFnes(bookFNInfos); // 设置税组
		request.setFpes(bookFPInfo); // 设置支付方式
		
		PNRManageClient client=new PNRManageClient(); //新建一个客户端
		try { 
			OBECommonResponse response =client.addBookInfo(request); // 新建一个响应对象
			if(response != null && response.getResultCode() == 0){
				if("OK".equals(response.getResultMsg())){
					return true; // 返回增加结果
				}
			}
		} catch (ObeException e) { 
			e.printStackTrace(); 
		} 
		return false;
	}
	
	// PNR项删除
	public boolean deleteIdxes(String pnrNo, int[] idxes) { 
		PNRDeleteIdxesRequest request = new PNRDeleteIdxesRequest(); // 新建一个请求对象 
		request.setOfficeNo(OFFICENO);// 设置Office号
		request.setToken(token); // 设置令牌号
		
		request.setPnrNo(pnrNo); // 设置Pnr号码
		request.setIdxes(idxes); // 删除的序号
		
		PNRManageClient pNRManageClient = new PNRManageClient() ; // 新建一个客户端对象
		try{
			OBECommonResponse response = pNRManageClient.deleteIdxes(request); // 新建一个响应对象 
			if(response != null && response.getResultCode() == 0){
				if("OK".equals(response.getResultMsg())){
					return true; // 返回删除结果
				}
			}
		}catch (ObeException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// 修改航段
	public boolean changeAirSegment(String pnrNo, String fltNoOld, String fltDateOld, SegmentInfo[] segmentInfos){ 
		PNRAirSegmentRequest request = new PNRAirSegmentRequest(); // 新建一个请求对象 

		request.setOfficeNo(OFFICENO); // 设置Office号
		request.setToken(token); // 设置令牌号
		
		request.setPnrNo(pnrNo); // 设置PNR号
		request.setFltNoOld(fltNoOld); // 设置旧航班号
		request.setFltDateOld(fltDateOld); // 设置旧航班日期
		request.setSegmentInfo(segmentInfos); // 航段信息
		
		PNRManageClient client = new PNRManageClient(); // 新建一个客户端
		try{
			OBECommonResponse response = client.changeAirSegment(request); // 新建一个响应对象
			if(response != null && response.getResultCode() == 0){
				if("OK".equals(response.getResultMsg())){
					return true; // 返回增加结果
				}
			}
		}catch(ObeException e){
			e.printStackTrace();
		}
		return false;
	}
	
	// 修改旅客证件
	public boolean changeCertificate(String pnrNo, PassengerInfo[] passengerInfos) { 
		PNRChangeCertificateRequest request = new PNRChangeCertificateRequest();   // 新建一个请求对象 

		request.setOfficeNo(OFFICENO); // 设置Office号
		request.setToken(token); // 设置令牌号
		
		request.setPnrNo(pnrNo); // 设置PNR号
		request.setPassengers(passengerInfos); //旅客信息

		PNRManageClient client = new PNRManageClient(); //新建一个客户端
		try{
			OBECommonResponse response=client.changeCertificate(request); // 新建一个响应对象
			if(response != null && response.getResultCode() == 0){
				if("OK".equals(response.getResultMsg())){
					return true; // 返回修改结果
				}
			}
		}catch(ObeException e){
			e.printStackTrace();
		}
		return false;
	}
	
	// PAT国内运价
	public PATFareItem[] patPNR(String pnrNo, String option, String type, Integer index, Boolean ifinput, String license, String payment, Integer priceIndex){ 
		PatRequest request = new PatRequest(); // 新建一个请求对象 
		request.setOfficeNo(OFFICENO); // 设置Office号
		request.setToken(token); // 设置令牌号
		
		request.setPnrNo(pnrNo); // 设置Pnr号
		request.setOption(option); // 设置是否将查询的运价结果录入
		request.setType(type); // 设置查询类型
		if(index != null){
			request.setIndex(index); // 设置旅客序号
		}
		if(ifinput != null){
			request.setIfinput(ifinput); // 是否将查询的运价结果录入PNR。多个价格将最低价格写入pnr。
		}
		request.setLicense(license); // 大协议号
		request.setPayment(payment); // 支付方式，"CC" 信用卡
		if(priceIndex != null){
			request.setPriceIndex(priceIndex); // 价格序号
		}
		
		PATClient client = new PATClient();// 新建客户端对象
		try { 
			PatResponse response = client.pat(request); // 新建一个响应对象
			if(response != null && response.getResultCode() == 0){
				return response.getFareItems(); // 返回所有国内运价信息
			}
		} catch (ObeException e) { 
			e.printStackTrace();
		} 
		return null;
	} 
	
	// QTE国际运价
	public List<XSFSPFare> qte(String pnrNo, String queryType, String fareType, String currency, String lowestonly, String validateCarrier, 
			String index, String needEtermStr, String license){ 
		QTERequest  request = new QTERequest (); // 新建一个请求对象 
		request.setOfficeNo(OFFICENO); // 设置Office号
		request.setToken(token); // 设置令牌号
		
		request.setPnrNo(pnrNo); // 设置Pnr号
		if(!StringUtils.isEmpty(queryType)){
			request.setQueryType(queryType);// 旅客类型，默认为成人AD, "CH" 儿童,"SD"学生"IN"婴儿"ZZ"青年"EM"移民"VAC"访问其它国家"VFR"探亲
		}
		if(!StringUtils.isEmpty(fareType)){
			request.setFareType(fareType); // 查询类型，正常票价为"N"或特殊票价为"S"
		}
		if(!StringUtils.isEmpty(currency)){
			request.setCurrency(currency); // 保留字段[需要计算的货币类型]
		}
		if(!StringUtils.isEmpty(lowestonly)){
			request.setLowestonly(lowestonly); // 是否仅查询给出的运价折扣种类中的最低运价
		}
		if(!StringUtils.isEmpty(validateCarrier)){
			request.setValidateCarrier(validateCarrier); // 出票航空公司
		}
		if(!StringUtils.isEmpty(index)){
			request.setIndex(index); // 如果查询的结果多于一条，则输入"1"或"2"序号以查询税项明细，查询结果保存在XSFSQResult中,输入?NONE?对所有运价均不进行明细查询
		}
		if(!StringUtils.isEmpty(needEtermStr)){
			request.setNeedEtermStr(needEtermStr); // 是否需要返回黑屏原始字符串,true:返回 false:不返回 默认为false
		}
		if(!StringUtils.isEmpty(license)){
			request.setLicense(license); // 大客户编码
		}
	
		QTEClient client = new QTEClient(); // 新建客户端对象
		try { 
			QTEResult response = client.qte(request); // 新建一个响应对象
			if(response != null && response.getResultCode() == 0){
				return response.getFares(); // 返回所有国际运价信息
			}
		} catch (ObeException e) { 
			e.printStackTrace();
		} 
		return null;
	} 
	
	// 团队释放座位接口
	public boolean releaseSeat(String pnrNo, Integer releaseSeat){ 
		PNRReleaseSeatRequest request = new PNRReleaseSeatRequest(); // 新建一个请求对象 
		
		request.setOfficeNo(OFFICENO); // 设置Office号
		request.setToken(token); // 设置令牌号
		
		request.setPnrNo(pnrNo);  // 设置Pnr号
		request.setReleaseSeat(releaseSeat); // 设置删除的座位数
		 
		PNRManageClient client = new PNRManageClient(); // 新建客户端对象
		try {
			OBECommonResponse response = client.releaseSeat(request);// 新建一个响应对象
			if(response != null && response.getResultCode() == 0){
				if("OK".equals(response.getResultMsg())){
					return true; // 返回结果
				}
			}
		} catch (ObeException e) {
			e.printStackTrace();
		} 
		return false;
	} 
	
	// 团队增加旅客姓名，需要注意的是对于非团队票，姓名组不能添加。
	public boolean addPassengers(String pnrNo, String[] passengers){ 
		PNRPassengersRequest request = new PNRPassengersRequest(); // 新建一个请求对象 
		
		request.setOfficeNo(OFFICENO); // 设置Office号
		request.setToken(token); // 设置令牌号
		
		request.setPnrNo(pnrNo); // 设置Pnr号
		request.setPassengers(passengers); // 旅客姓名集合
		
		PNRManageClient client = new PNRManageClient(); // 新建客户端对象
		try {
			OBECommonResponse response = client.addPassengers (request); // 新建一个响应对象
			if(response != null && response.getResultCode() == 0){
				if("OK".equals(response.getResultMsg())){
					return true; // 返回增加结果
				}
			}
		} catch (ObeException e) {
			e.printStackTrace();
		} 
		return false;
	}
	
	// 团队删除旅客姓名
	public boolean delPassengers(String pnrNo, String[] passengers){ 
		PNRPassengersRequest request = new PNRPassengersRequest(); // 新建一个请求对象
		
		request.setOfficeNo(OFFICENO); // 设置Office号	
		request.setToken(token); // 设置令牌号
		
		request.setPnrNo(pnrNo); // 设置Pnr号
		request.setPassengers(passengers); // 旅客姓名集合
		
		PNRManageClient client = new PNRManageClient(); // 新建客户端对象
	
		try { 
			OBECommonResponse response = client.delPassengers(request); // 新建一个响应对象
			if(response != null && response.getResultCode() == 0){
				if("OK".equals(response.getResultMsg())){
					return true; // 返回结果
				}
			}
		} catch (ObeException e) { 
			e.printStackTrace();
		}
		return false;
	} 
	
	// 团队PNR增加婴儿儿童接口
	public List<SegmentInfo> testAddChildInfats(String pnrNo, ChildInfPassenger[] passengers) { 
		PNRChdInfPassengersRequest request = new PNRChdInfPassengersRequest(); // 新建一个请求对象
		
		request.setOfficeNo(OFFICENO); // 设置Office号	
		request.setToken(token); // 设置令牌号
		
		request.setPnrNo(pnrNo); // 设置令牌号
		request.setPassengers(passengers); // 婴儿儿童集合
		
		PNRManageClient client = new com.travelsky.sbeclient.obe.PNRManageClient(); // 新建客户端对象
		try {
			PnrResponse response = client.addChildInfats(request); // 新建一个响应对象
			if(response != null && response.getResultCode() == 0){
				return response.getSegList(); 
			}
		} catch (ObeException e) {
			e.printStackTrace();
		}
		return null;
	}
		
	// 挂起
	private void hang() {
		AccountActiveRequest accountActiveRequest = new AccountActiveRequest(USERNAME, SBEUtil.md5(PASSWORD), "0");
		SBEClient activeClient = new SBEClient();
		try {
			activeClient.inactiveAccount(accountActiveRequest);
		} catch (SBEClientException e) {
			e.printStackTrace();
		}
	}
	
	// 激活
	private void activate() {
		AccountActiveRequest accountActiveRequest = new AccountActiveRequest(USERNAME, SBEUtil.md5(PASSWORD), "1");
		SBEClient activeClient = new SBEClient();
		try {
			activeClient.activeAccount(accountActiveRequest);
		} catch (SBEClientException e) {
			e.printStackTrace();
		}
	}
	
	// 申请口令
	private void applyToken() {
		AuthorizationRequest accountActiveRequest = new AuthorizationRequest(USERNAME, SBEUtil.md5(PASSWORD));
		SBEClient activeClient = new SBEClient();
		try {
			token = activeClient.applyToken(accountActiveRequest).getToken();
		} catch (ObeException e) {
			e.printStackTrace();
		} catch (SBEClientException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}