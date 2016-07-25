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

	private static final String USERNAME = "GZRDAPI02";		// 账号
	private static final String PASSWORD = "GZRDAPI0304";	// 密码
	private static final String OFFICENO = "CAN666";		// 操作员
	
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
			avRequest.setFltNo(fltNo); // ����ų��˲�ѯ�����⣬��������������������ܹ���
		}
		
		AVClient avClient=new AVClient(); // �½��ͻ��˶���
		try {
			AVResponse avResponse=avClient.avForObe(avRequest); // �½�һ����Ӧ����
			if(avResponse != null && avResponse.getResultCode() == 0){
				
				List<AvSegment> resultList = new ArrayList<AvSegment>();
				
				List<AvItem> avList = avResponse.getAvItems();
				if(avList != null && avList.size() > 0){
					for(AvItem item : avList){
						for(AvSegment avSeg : item.getSegments()){
							resultList.add(avSeg); // ��ȡ��Ӧ�е����к�����λ
						}
					}
				}
				
				if(resultList != null && resultList.size() > 0){
					return resultList;
				}
			}
		} catch (ObeException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return null;
	}
	
	// �˼۲�ѯ
	public List<FDItem> fd(String org, String dst, String date, String airline, String planeModel, String passType, String fullFareBasis) {
		FDRequest fdRequest = new FDRequest(); // �½�һ���������
		fdRequest.setOfficeNo(OFFICENO); // ����Office��
		fdRequest.setToken(token); // �������ƺ�
		
		fdRequest.setOrg(org); // ���ó�������
		fdRequest.setDst(dst); // ���õ������
		fdRequest.setDate(date); // ���ò�ѯ����
		if(airline == null){
			fdRequest.setAirline("");
		}else{
			fdRequest.setAirline(airline); // ���չ�˾������
		}
		fdRequest.setPlaneModel(planeModel); // ���û���
		fdRequest.setPassType(passType); // �ÿ����� ��"ad"�����ˣ�"IN"��Ӥ��"CH"����ͯ��
		fdRequest.setFullFareBasis(fullFareBasis); // �˼ۻ� ����Ϊ��
		
		FDClient fdClient = new FDClient(); // �½��ͻ��˶���
		try {
			FDResponse fdResponse = fdClient.fdForObe(fdRequest); // �½�һ����Ӧ����
			if(fdResponse != null && fdResponse.getResultCode() == 0){
				return fdResponse.getFare().getSortedfares(); // �������е��˼���Ϣ
			}
		} catch (ObeException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return null;
	}
	
	// ��ȡ��������(��ѯһ���ж����ض����������к������Ϣ,ֻ�ܲ�ѯ���졢���켰�Ժ������)
	public List<SkSegment> sk(String org, String dst, String date, String airline, String direct, String noStop){
		SKRequest skRequest = new SKRequest(); // �½�һ���������
		skRequest.setToken(token); // �������ƺ�
		skRequest.setOfficeNo(OFFICENO); // ����Office��
		
		skRequest.setOrg(org); // ���ó�������
		skRequest.setDst(dst); // ���õ������
		skRequest.setDate(date); // ���ò�ѯ����
		if(airline == null){
			skRequest.setAirline("");
		}else{
			skRequest.setAirline(airline); // ���ú��չ�˾
		}
		skRequest.setDirect(direct); // ָ���Ƿ�ֱ�ɺ��� ��Ĭ��Ϊfalse 
		skRequest.setNoStop(noStop); // ָ���Ƿ�ֻ��ѯ�޾�ͣ���� ��Ĭ��Ϊfalse 
		
		SKClient skClient = new SKClient(); // �½��ͻ��˶���
		try {
			SKResponse skResponse = skClient.skForObe(skRequest); // �½�һ����Ӧ����
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
						return resultList; // �������з�������
					}
				}
			}
		} catch (ObeException e) { 
			e.printStackTrace(); 
		}
		return null;
	}
	
	// ��ѯ��ʾָ�����ڵĺ����ϵĺ�����Ϣ(��ݺ����)
	public DsgSegment[] dsgByFlightNo(String flightNo, String flightDate, String cabin, String segment){
		DsgRequest dsgRequest=new DsgRequest(); // �½�һ���������
		
		dsgRequest.setToken(token); // �������ƺ�
		dsgRequest.setOfficeNo(OFFICENO); // ����Office��
		
		dsgRequest.setFlightNo(flightNo); // ���ú����
		dsgRequest.setFlightDate(flightDate); // ���ú�������
		if(!StringUtils.isEmpty(cabin)){
			dsgRequest.setCabin(cabin);  // ��λ
		}
		if(!StringUtils.isEmpty(segment)){
			dsgRequest.setSegment(segment); // ���Σ����жԣ�
		}
		
		DSGClient dsgClient = new DSGClient(); // �½��ͻ��˶���
		try {
			DsgResponse dsgResponse = dsgClient.dsg(dsgRequest); // �½�һ����Ӧ����
			if(dsgResponse != null && dsgResponse.getResultCode() == 0){
				return dsgResponse.getSegments(); // �������к�����Ϣ
			}
		} catch (ObeException e) { 
			e.printStackTrace(); 
		}
		return null;
	}
	
	// ��ѯ��ʾָ�����ڵĺ����ϵĺ�����Ϣ(���PNR��)
	public DsgSegment[] dsgByPnrNo(String pnrNo, int[] segIdxInPnr){
		DsgRequest dsgRequest=new DsgRequest(); // �½�һ���������
		
		dsgRequest.setToken(token); // �������ƺ�
		dsgRequest.setOfficeNo(OFFICENO); // ����Office��
		
		dsgRequest.setPnrNo(pnrNo); // ����PNR��
		dsgRequest.setSegIdxInPnr(segIdxInPnr); // PNR��ĺ�����ţ���ѡ
		
		DSGClient dsgClient = new DSGClient(); // �½��ͻ��˶���
		try {
			DsgResponse dsgResponse = dsgClient.dsg(dsgRequest); // �½�һ����Ӧ����
			if(dsgResponse != null && dsgResponse.getResultCode() == 0){
				return dsgResponse.getSegments(); // �������к�����Ϣ
			}
		} catch (ObeException e) { 
			e.printStackTrace(); 
		}
		return null;
	}
	
	// ��ȡ������Ϣ
	public FFSegment[] ff(String flightNo, String flightDate){ 
		FFRequest ffRequest= new FFRequest(); // �½�һ���������
		ffRequest.setOfficeNo(OFFICENO); // ����Office��
		ffRequest.setToken(token); // �������ƺ�
		
		ffRequest.setFlightNo(flightNo); // ���ú���� 
		ffRequest.setFlightDate(flightDate); // ���ú�������
		
		FFClient ffClient = new FFClient(); // �½��ͻ��˶���
		try {
			FFResponse response = ffClient.ffForObe(ffRequest); // �½�һ����Ӧ����
			if(response !=null && response.getResultCode() == 0){
				return response.getSegments(); // �������к�����Ϣ
			}
		} catch (ObeException e) { 
			e.printStackTrace(); 
		}
		return null;
	}
	
	// �����Ʊ��
	public List<Xsfsd> xsfsd(String fsqIndex, String depCity, String arrCity, String depDate, String airlineCode, String routeType, String travelerType, String priceOrder, String cabin, String isNego, String accountCode, String isPrivatePriceOnly) {
		XSFSDRequest request =new XSFSDRequest (); // �½�һ��������� 
		request.setOfficeNo(OFFICENO); // ����Office��
		request.setToken(token); // �������ƺ�
		
		if(fsqIndex != null){
			request.setFsqIndex(fsqIndex); // ���ü۸����
		}
		request.setDepCity(depCity); // ���ó�������
		request.setArrCity(arrCity); // ���õ������
		request.setDepDate(depDate); // ���ó˻����� ddMMMyy
		request.setAirlineCode(airlineCode); // ���ú��չ�˾
		request.setRouteType(routeType); // ����OW������RT
		if(travelerType != null){
			request.setTravelerType(travelerType); // �ÿ�����,ADT ����, CHD ��ͯ,UM ��������ͯ,Ĭ��null����
		}
		if(priceOrder != null){
			request.setPriceOrder(priceOrder); // ��ͼ۸����� true��false
		}
		if(cabin != null){
			request.setCabin(cabin); // ��λ
		}
		request.setIsNego(isNego); // �Ƿ�ʹ��Э���
		request.setAccountCode(accountCode); // ��ͻ�����
		request.setIsPrivatePriceOnly(isPrivatePriceOnly); // �Ƿ����ʾ���а��ͻ��ŵ�˽���˼�
	
		XSFSDClient client = new XSFSDClient(); // �½��ͻ��˶���
		try {
			XsfsdResponse response = client.xsfsd(request); // �½�һ����Ӧ����
			if(response != null && response.getResultCode() == 0){
				return response.getXsfsdList(); // �������й����Ʊ��
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
	
	// ��ʳ�Ʊ
	public List<TN> dfsq(String pnrNo, String carrier){ 
		// �½�һ��������� 
		DFSQRequest request = new DFSQRequest();
		
		request.setOfficeNo(OFFICENO); // ����Office��
		request.setToken(token); // �������ƺ�

		request.setPnrNo(pnrNo); // ����Pnr��
		request.setLowestonly("true"); // �����Ƿ�������˼�
		request.setValidateCarrier(carrier); // ��Ʊ���չ�˾
		request.setPrinterNo("1"); // ���ô�Ʊ���
		
		DFSQClient client = new DFSQClient();// �½��ͻ��˶���
		try { 
			DfsqResponse response = client.dfsq(request); // �½�һ����Ӧ����
			if(response != null && response.getResultCode() == 0){
				return response.getTnList(); // �������е�Ʊ����Ϣ
			}
		} catch (ObeException e) { 
			e.printStackTrace();
		} 
		return null;
	} 
	
	// eTerm���ӿ�Ʊ��Ʊ���ԡ�
	public boolean etry(String pnrNo) { 
		PNRRequest request = new PNRRequest(); // �½�һ���������
		
		request.setOfficeNo(OFFICENO); // ����Office��
		request.setToken(token); // �������ƺ�
		
		request.setPnrNo(pnrNo); // ����PNR��
		ETRYClient client = new ETRYClient(); //�½�һ���ͻ���
		try{
			OBECommonResponse response = client.etry(request); // �½�һ����Ӧ����
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
					System.out.print("删除成功");
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
		PNRTKTAirSegmentRequest request = new PNRTKTAirSegmentRequest(); // �½�һ���������
		request.setOfficeNo(OFFICENO); // ����Office�� 
		request.setToken(token); // �������ƺ�
		
		request.setPnrNo(pnrNo); // ����PNR�� 
		request.setFltNoOld(fltNoOld); // ���þɺ����
		request.setFltDateOld(fltDateOld); // ���þɺ�������
		request.setFltNoNew(fltNoNew); // �����º����
		request.setFltDateNew(fltDateNew); // �����º�������
		
		request.setActionCode ("NN"); // �����ж����룬ֻ��ΪNN
		
		PNRManageClient client = new PNRManageClient();
		try{
			OBECommonResponse response = client.changeTKTAirSegment(request); // �½�һ����Ӧ����
			if(response != null && response.getResultCode() == 0){
				if("OK".equals(response.getResultMsg())){
					return true; // ����ͬ�ո��ڽ��
				}
			}
		}catch(ObeException e){
			e.printStackTrace();
		}
		return false;
	}
	
	// ���ڰ������˼ۼ���
	public List<PataFarePriceInfo> pataFare(PataFareInfo[] pataFareInfos, String passengerType) { 
		PataFareRequest request = new PataFareRequest (); // �½�һ���������
		request.setOfficeNo(OFFICENO); // ��ȡoffice��
		request.setToken(token); // �������ƺ�
		
		 
		request.setSegmentInfo(pataFareInfos); // ���ú�����Ϣ�����֧��5������
		if(!StringUtils.isEmpty(passengerType)){
			request.setPassengerType(passengerType); // �ÿ����� Ĭ���ǳ��˳���:���� IN:Ӥ�� CH:��ͯ JC:�򹫴��˾���GM���˲о���
		}
		
		PataFareClient client=new PataFareClient(); // �½��ͻ��˶���
		try { 
			PataFareResponse response=client.pataFare(request); 
			if(response != null && response.getResultCode() == 0){
				return response.getPriceInfoList(); // �������м۸���Ϣ
			}
		} catch (ObeException e) { 
			e.printStackTrace(); 
		} 
		return null;
	} 
	
	// ���ڰ������˼ۼ���
	public List<PataFarePriceInfo> pataFare(PataFareInfo pataFareInfo, String passengerType) { 
		PataFareRequest request = new PataFareRequest (); // �½�һ���������
		request.setOfficeNo(OFFICENO); // ��ȡoffice��
		request.setToken(token); // �������ƺ�
		
		request.setSegmentInfo(new PataFareInfo[]{pataFareInfo}); // ���ú�����Ϣ����������
		if(!StringUtils.isEmpty(passengerType)){
			request.setPassengerType(passengerType); // �ÿ����� Ĭ���ǳ��˳���:���� IN:Ӥ�� CH:��ͯ JC:�򹫴��˾���GM���˲о���
		}
		
		PataFareClient client=new PataFareClient(); // �½��ͻ��˶���
		try { 
			PataFareResponse response=client.pataFare(request); 
			if(response != null && response.getResultCode() == 0){
				return response.getPriceInfoList(); // �������м۸���Ϣ
			}
		} catch (ObeException e) { 
			e.printStackTrace(); 
		} 
		return null;
	}
	
	// �����Ʊ���
	public RefundFormResponse getRefund(String option, String tktNo, String tktType) { 
		RefundTktRequest request=new RefundTktRequest(); // �½�һ���������
		
		request.setOfficeNo(OFFICENO); // ����Office��
		request.setToken(token); // �������ƺ�
		
		request.setOption(option); // Ʊ��ѡ�AMƱ�ţ�M��Ʊ����
		request.setTktNo(tktNo); // Ʊ��
		request.setTktType(tktType); // Ʊ����: D ����,I ���
		request.setPrintNo("1"); // ��ӡ�����
		
		TRFDClient client=new TRFDClient(); //�½�һ���ͻ���
		try{
			RefundFormResponse response=client.getRefundTKTForm(request); // �½�һ����Ӧ����
			if(response != null && response.getResultCode() == 0){
				return response; // ������Ʊ���
			}
		}catch(ObeException e){
			e.printStackTrace();
		}
		return null;
	}
		
	// ��Ʊ
	public boolean refund(RefundFormResponse response){
		RefundFormRequest request = new RefundFormRequest(); // �½�һ���������
		request.setOfficeNo(OFFICENO); // office��
		request.setToken(token); // �������ƺ�
		
		//��response �?���ݸ��Ƶ�formRequest,���а���cmdOption cmdPrnt cmdTktType cmdNo command�⼸����Ϊԭ���������� 
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
		
		TRFDClient trfdClient = new TRFDClient(); //�½�һ���ͻ���
		try {
			OBECommonResponse obeResp = trfdClient.changeRefund(request); // �½�һ����Ӧ����
			if(obeResp != null && obeResp.getResultCode() == 0){
				if("OK".equals(obeResp.getResultMsg())){
					return true; // ������Ʊ���
				}
			}
		} catch (ObeException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
	// PNR������addBookInfo
	public boolean addBookInfo(String pnrNo, SSRInfo[] ssrInfos, RMKInfo rmkInfo, BookFCInfo[] bookFCInfos, BookFNInfo[] bookFNInfos, BookFPInfo[] bookFPInfo) {
		PNRBookInfoRequest request = new PNRBookInfoRequest(); // �½�һ���������
		request.setOfficeNo(OFFICENO); // office��
		request.setToken(token); // �������ƺ�
		
		request.setPnrNo(pnrNo); // ����PNR��
		request.setSsres(ssrInfos); // �������������(SSR)
		request.setRemark(rmkInfo); // ���ñ�ע��
		request.setFces(bookFCInfos); // ����Ʊ����
		request.setFnes(bookFNInfos); // ����˰��
		request.setFpes(bookFPInfo); // ����֧����ʽ
		
		PNRManageClient client=new PNRManageClient(); //�½�һ���ͻ���
		try { 
			OBECommonResponse response =client.addBookInfo(request); // �½�һ����Ӧ����
			if(response != null && response.getResultCode() == 0){
				if("OK".equals(response.getResultMsg())){
					return true; // �������ӽ��
				}
			}
		} catch (ObeException e) { 
			e.printStackTrace(); 
		} 
		return false;
	}
	
	// PNR��ɾ��
	public boolean deleteIdxes(String pnrNo, int[] idxes) { 
		PNRDeleteIdxesRequest request = new PNRDeleteIdxesRequest(); // �½�һ��������� 
		request.setOfficeNo(OFFICENO); // ����Office��
		request.setToken(token); // �������ƺ�
		
		request.setPnrNo(pnrNo); // ����Pnr����
		request.setIdxes(idxes); // ɾ������
		
		PNRManageClient pNRManageClient = new PNRManageClient() ; // �½�һ���ͻ��˶���
		try{
			OBECommonResponse response = pNRManageClient.deleteIdxes(request); // �½�һ����Ӧ���� 
			if(response != null && response.getResultCode() == 0){
				if("OK".equals(response.getResultMsg())){
					return true; // ����ɾ����
				}
			}
		}catch (ObeException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// �޸ĺ���
	public boolean changeAirSegment(String pnrNo, String fltNoOld, String fltDateOld, SegmentInfo[] segmentInfos){ 
		PNRAirSegmentRequest request = new PNRAirSegmentRequest(); // �½�һ��������� 

		request.setOfficeNo(OFFICENO); // ����Office��
		request.setToken(token); // �������ƺ�
		
		request.setPnrNo(pnrNo); // ����PNR��
		request.setFltNoOld(fltNoOld); // ���þɺ����
		request.setFltDateOld(fltDateOld); // ���þɺ�������
		request.setSegmentInfo(segmentInfos); // ������Ϣ
		
		PNRManageClient client = new PNRManageClient(); // �½�һ���ͻ���
		try{
			OBECommonResponse response = client.changeAirSegment(request); // �½�һ����Ӧ����
			if(response != null && response.getResultCode() == 0){
				if("OK".equals(response.getResultMsg())){
					return true; // �����޸Ľ��
				}
			}
		}catch(ObeException e){
			e.printStackTrace();
		}
		return false;
	}
	
	// �޸��ÿ�֤��
	public boolean changeCertificate(String pnrNo, PassengerInfo[] passengerInfos) { 
		PNRChangeCertificateRequest request = new PNRChangeCertificateRequest();                     // �½�һ��������� 

		request.setOfficeNo(OFFICENO); // ����Office��
		request.setToken(token); // �������ƺ�
		
		request.setPnrNo(pnrNo); // ����PNR��
		request.setPassengers(passengerInfos); //�ÿ���Ϣ

		PNRManageClient client = new PNRManageClient(); //�½�һ���ͻ���
		try{
			OBECommonResponse response=client.changeCertificate(request); // �½�һ����Ӧ����
			if(response != null && response.getResultCode() == 0){
				if("OK".equals(response.getResultMsg())){
					return true; // �����޸Ľ��
				}
			}
		}catch(ObeException e){
			e.printStackTrace();
		}
		return false;
	}
	
	// PAT�����˼�
	public PATFareItem[] patPNR(String pnrNo, String option, String type, Integer index, Boolean ifinput, String license, String payment, Integer priceIndex){ 
		PatRequest request = new PatRequest(); // �½�һ��������� 
		request.setOfficeNo(OFFICENO); // ����Office�� 
		request.setToken(token); // �������ƺ�
		
		request.setPnrNo(pnrNo); // ����Pnr��
		request.setOption(option); // �����Ƿ񽫲�ѯ���˼۽��¼��
		request.setType(type); // ���ò�ѯ����
		if(index != null){
			request.setIndex(index); // �����ÿ����
		}
		if(ifinput != null){
			request.setIfinput(ifinput); // �Ƿ񽫲�ѯ���˼۽��¼��PNR������۸���ͼ۸�д��pnr��
		}
		request.setLicense(license); // ��Э���
		request.setPayment(payment); // ֧����ʽ��"CC" ���ÿ�
		if(priceIndex != null){
			request.setPriceIndex(priceIndex); // �۸����
		}
		
		PATClient client = new PATClient();// �½��ͻ��˶���
		try { 
			PatResponse response = client.pat(request); // �½�һ����Ӧ����
			if(response != null && response.getResultCode() == 0){
				return response.getFareItems(); // �������й����˼���Ϣ
			}
		} catch (ObeException e) { 
			e.printStackTrace();
		} 
		return null;
	} 
	
	// QTE����˼�
	public List<XSFSPFare> qte(String pnrNo, String queryType, String fareType, String currency, String lowestonly, String validateCarrier, 
			String index, String needEtermStr, String license){ 
		QTERequest  request = new QTERequest (); // �½�һ��������� 
		request.setOfficeNo(OFFICENO); // ����Office��
		request.setToken(token); // �������ƺ�
		
		request.setPnrNo(pnrNo); // ����Pnr��
		if(!StringUtils.isEmpty(queryType)){
			request.setQueryType(queryType); // �ÿ����ͣ�Ĭ��Ϊ����AD, "CH" ��ͯ,"SD"ѧ��"IN"Ӥ��"ZZ"����"EM"����"VAC"����������"VFR"̽��
		}
		if(!StringUtils.isEmpty(fareType)){
			request.setFareType(fareType); // ��ѯ���ͣ���Ʊ��Ϊ"N"������Ʊ��Ϊ"S"
		}
		if(!StringUtils.isEmpty(currency)){
			request.setCurrency(currency); // �����ֶ�[��Ҫ����Ļ�������]
		}
		if(!StringUtils.isEmpty(lowestonly)){
			request.setLowestonly(lowestonly); // �Ƿ����ѯ������˼��ۿ������е�����˼�
		}
		if(!StringUtils.isEmpty(validateCarrier)){
			request.setValidateCarrier(validateCarrier); // ��Ʊ���չ�˾
		}
		if(!StringUtils.isEmpty(index)){
			request.setIndex(index); // ����ѯ�Ľ�����һ����������"1"��"2"����Բ�ѯ˰����ϸ����ѯ������XSFSQResult��,����?NONE?�������˼۾������ϸ��ѯ
		}
		if(!StringUtils.isEmpty(needEtermStr)){
			request.setNeedEtermStr(needEtermStr); // �Ƿ���Ҫ���غ���ԭʼ�ַ�,true:���� false:������ Ĭ��Ϊfalse
		}
		if(!StringUtils.isEmpty(license)){
			request.setLicense(license); // ��ͻ�����
		}
	
		QTEClient client = new QTEClient();// �½��ͻ��˶���
		try { 
			QTEResult response = client.qte(request); // �½�һ����Ӧ����
			if(response != null && response.getResultCode() == 0){
				return response.getFares(); // �������й���˼���Ϣ
			}
		} catch (ObeException e) { 
			e.printStackTrace();
		} 
		return null;
	} 
	
	// �Ŷ��ͷ���λ�ӿ�
	public boolean releaseSeat(String pnrNo, Integer releaseSeat){ 
		PNRReleaseSeatRequest request = new PNRReleaseSeatRequest(); // �½�һ��������� 
		
		request.setOfficeNo(OFFICENO); // ����Office��
		request.setToken(token); // �������ƺ�
		
		request.setPnrNo(pnrNo); // ����Pnr��
		request.setReleaseSeat(releaseSeat); // ����ɾ�����λ��
		 
		PNRManageClient client = new PNRManageClient(); // �½��ͻ��˶���
		try {
			OBECommonResponse response = client.releaseSeat(request);// �½�һ����Ӧ����
			if(response != null && response.getResultCode() == 0){
				if("OK".equals(response.getResultMsg())){
					return true; // ���ؽ��
				}
			}
		} catch (ObeException e) {
			e.printStackTrace();
		} 
		return false;
	} 
	
	// �Ŷ������ÿ�������Ҫע����Ƕ��ڷ��Ŷ�Ʊ�������鲻����ӡ�
	public boolean addPassengers(String pnrNo, String[] passengers){ 
		PNRPassengersRequest request = new PNRPassengersRequest(); // �½�һ��������� 
		
		request.setOfficeNo(OFFICENO); // ����Office��
		request.setToken(token); // �������ƺ�
		
		request.setPnrNo(pnrNo); // ����Pnr��
		request.setPassengers(passengers); // �ÿ������
		
		PNRManageClient client = new PNRManageClient(); // �½��ͻ��˶���
		try {
			OBECommonResponse response = client.addPassengers (request); // �½�һ����Ӧ����
			if(response != null && response.getResultCode() == 0){
				if("OK".equals(response.getResultMsg())){
					return true; // �������ӽ��
				}
			}
		} catch (ObeException e) {
			e.printStackTrace();
		} 
		return false;
	}
	
	// �Ŷ�ɾ���ÿ�����
	public boolean delPassengers(String pnrNo, String[] passengers){ 
		PNRPassengersRequest request = new PNRPassengersRequest(); // �½�һ���������
		
		request.setOfficeNo(OFFICENO); // ����Office��	
		request.setToken(token); // �������ƺ�
		
		request.setPnrNo(pnrNo); // ����Pnr��
		request.setPassengers(passengers); // �ÿ������
		
		PNRManageClient client = new PNRManageClient(); // �½��ͻ��˶���
	
		try { 
			OBECommonResponse response = client.delPassengers(request); // �½�һ����Ӧ����
			if(response != null && response.getResultCode() == 0){
				if("OK".equals(response.getResultMsg())){
					return true; // ���ؽ��
				}
			}
		} catch (ObeException e) { 
			e.printStackTrace();
		}
		return false;
	} 
	
	// �Ŷ�PNR����Ӥ���ͯ�ӿ�
	public List<SegmentInfo> testAddChildInfats(String pnrNo, ChildInfPassenger[] passengers) { 
		PNRChdInfPassengersRequest request = new PNRChdInfPassengersRequest(); // �½�һ���������
		
		request.setOfficeNo(OFFICENO); // ����Office��	
		request.setToken(token); // �������ƺ�
		
		request.setPnrNo(pnrNo); // �������ƺ�
		request.setPassengers(passengers); // Ӥ���ͯ����
		
		PNRManageClient client = new com.travelsky.sbeclient.obe.PNRManageClient(); // �½��ͻ��˶���
		try {
			PnrResponse response = client.addChildInfats(request); // �½�һ����Ӧ����
			if(response != null && response.getResultCode() == 0){
				return response.getSegList(); 
			}
		} catch (ObeException e) {
			e.printStackTrace();
		}
		return null;
	}
		
	// ����
	private void hang() {
		AccountActiveRequest accountActiveRequest = new AccountActiveRequest(USERNAME, SBEUtil.md5(PASSWORD), "0");
		SBEClient activeClient = new SBEClient();
		try {
			activeClient.inactiveAccount(accountActiveRequest);
		} catch (SBEClientException e) {
			e.printStackTrace();
		}
	}
	
	// ����
	private void activate() {
		AccountActiveRequest accountActiveRequest = new AccountActiveRequest(USERNAME, SBEUtil.md5(PASSWORD), "1");
		SBEClient activeClient = new SBEClient();
		try {
			activeClient.activeAccount(accountActiveRequest);
		} catch (SBEClientException e) {
			e.printStackTrace();
		}
	}
	
	// �������
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