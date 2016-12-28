package com.solar.tech.service;

import java.util.Map;

import javax.annotation.Resource; 

import com.solar.tech.bean.entity.CharaRoute;
import com.solar.tech.bean.entity.Info;
import com.solar.tech.bean.entity.OutInfo;
import com.solar.tech.utils.MyApplicationContextUtil;

import me.chanjar.weixin.common.api.WxConsts;
import me.chanjar.weixin.common.bean.WxMenu;
import me.chanjar.weixin.common.exception.WxErrorException;
import me.chanjar.weixin.common.session.WxSessionManager;
import me.chanjar.weixin.mp.api.WxMpInMemoryConfigStorage;
import me.chanjar.weixin.mp.api.WxMpMessageHandler;
import me.chanjar.weixin.mp.api.WxMpMessageRouter;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.api.WxMpServiceImpl;
import me.chanjar.weixin.mp.bean.WxMpXmlMessage;
import me.chanjar.weixin.mp.bean.WxMpXmlOutMessage;
import me.chanjar.weixin.mp.bean.WxMpXmlOutNewsMessage;
import me.chanjar.weixin.mp.bean.WxMpXmlOutTextMessage;
import me.chanjar.weixin.mp.bean.WxMpXmlOutNewsMessage.Item;
import me.chanjar.weixin.mp.bean.result.WxMpOAuth2AccessToken;

/**
 * 
 * @ClassName: WechatService
 * @Description: TODO
 * @author: ChenXZ
 * @date: 2016年4月22日 下午11:52:03
 */

public class WechatService {

	/** 微信公众号配置信息 **/
	private WxMpInMemoryConfigStorage wxMpConfigStorage;
	/** 服务类 **/
	private WxMpService wxMpService;
	/** 消息路由 **/
	private WxMpMessageRouter wxMpMessageRouter;

	/** 单例 **/
	private static WechatService uWechatService = null;
	private Object uWechatServiceObject = new Object();

	public WechatService() {
		wxMpConfigStorage = new WxMpInMemoryConfigStorage();
		wxMpConfigStorage.setAppId("wx21f1f64150786239"); // 设置微信公众号的appid
		wxMpConfigStorage.setSecret("594a178490b9bc9c15748ca7e8b24038"); // 设置微信公众号的app
																			// corpSecret
		wxMpConfigStorage.setToken("gzrdswzx"); // 设置微信公众号的token
		wxMpConfigStorage.setAesKey("titPyhhqAfqV7hFFuWsdH64hQD29OqRXdlscOTShhv6"); // 设置微信公众号的EncodingAESKey

		wxMpService = new WxMpServiceImpl();
		wxMpService.setWxMpConfigStorage(wxMpConfigStorage);

		WxMpMessageHandler handler = new WxMpMessageHandler() {
			@Override
			public WxMpXmlOutMessage handle(WxMpXmlMessage wxMessage, Map<String, Object> context,
					WxMpService wxMpService, WxSessionManager wxSessionManager) throws WxErrorException {

				WxMpXmlOutTextMessage m = WxMpXmlOutMessage.TEXT().content("测试加密消息").fromUser(wxMessage.getToUserName())
						.toUser(wxMessage.getFromUserName()).build();

				return m;
			}
		};
		
		WxMpMessageHandler handler4 = new WxMpMessageHandler() {
			@Override
			public WxMpXmlOutMessage handle(WxMpXmlMessage wxMessage, Map<String, Object> context,
					WxMpService wxMpService, WxSessionManager wxSessionManager) throws WxErrorException {			
				Item item = new Item();
				InfoService infoService= (InfoService)MyApplicationContextUtil.getBean("infoService");  
				Info chInfo = infoService.getNewInfo();
				item.setTitle(chInfo.getTitle());
				item.setDescription(chInfo.getIntroduction());
				item.setPicUrl("http://d2.freep.cn/3tb_161221134600uo2r581058.jpg");
				item.setUrl("www.baidu.com");
			
				WxMpXmlOutNewsMessage m = WxMpXmlOutMessage.NEWS().addArticle(item).fromUser(wxMessage.getToUserName())
						.toUser(wxMessage.getFromUserName()).build();

				return m;
			}
		};
		
		WxMpMessageHandler handler5 = new WxMpMessageHandler() {
			@Override
			public WxMpXmlOutMessage handle(WxMpXmlMessage wxMessage, Map<String, Object> context,
					WxMpService wxMpService, WxSessionManager wxSessionManager) throws WxErrorException {			
				Item item = new Item();
				OutInfoService outinfoService= (OutInfoService)MyApplicationContextUtil.getBean("outInfoService");  
				OutInfo chInfo = outinfoService.getNewOutInfo();
				item.setTitle(chInfo.getTitle());
				item.setDescription(chInfo.getIntroduction());
				item.setPicUrl("http://d2.freep.cn/3tb_161221134600uo2r581058.jpg");
				item.setUrl("www.baidu.com");
			
				WxMpXmlOutNewsMessage m = WxMpXmlOutMessage.NEWS().addArticle(item).fromUser(wxMessage.getToUserName())
						.toUser(wxMessage.getFromUserName()).build();

				return m;
			}
		};
		
		WxMpMessageHandler handler6 = new WxMpMessageHandler() {
			@Override
			public WxMpXmlOutMessage handle(WxMpXmlMessage wxMessage, Map<String, Object> context,
					WxMpService wxMpService, WxSessionManager wxSessionManager) throws WxErrorException {			
				Item item = new Item();
				RDcharaRouteService charaRoute= (RDcharaRouteService)MyApplicationContextUtil.getBean("outInfoService");  
				CharaRoute chInfo = charaRoute.getCharaRoute();
				item.setTitle(chInfo.getTitle());
				item.setDescription(chInfo.getIntroduction());
				item.setPicUrl("http://d2.freep.cn/3tb_161221134600uo2r581058.jpg");
				item.setUrl("www.baidu.com");
			
				WxMpXmlOutNewsMessage m = WxMpXmlOutMessage.NEWS().addArticle(item).fromUser(wxMessage.getToUserName())
						.toUser(wxMessage.getFromUserName()).build();

				return m;
			}
		};

		wxMpMessageRouter = new WxMpMessageRouter(wxMpService); //charaRoute
		wxMpMessageRouter
				.rule().async(false).content("哈哈")	.handler(handler).end() //拦截“哈哈”的内容
				.rule().async(false).event(WxConsts.EVT_SUBSCRIBE).handler(handler).end() //订阅时自动回复
				.rule().async(false).event(WxConsts.EVT_UNSUBSCRIBE).handler(handler).end()  //取消订阅时自动回复
				.rule().async(false).event(WxConsts.BUTTON_CLICK).eventKey("InContraty").handler(handler4).end()  //国内资讯
				.rule().async(false).event(WxConsts.BUTTON_CLICK).eventKey("OutContraty").handler(handler5).end() //国际资讯
				.rule().async(false).event(WxConsts.BUTTON_CLICK).eventKey("charaRoute").handler(handler6).end(); //特色路线
	}

	public boolean checkSignature(String timestamp, String nonce, String signature) {
		return wxMpService.checkSignature(timestamp, nonce, signature);
	}

	public WxMpXmlOutMessage route(WxMpXmlMessage inMessage) {
		return wxMpMessageRouter.route(inMessage);
	}

	public WxMpInMemoryConfigStorage getWxMpInMemoryConfigStorage() {
		return wxMpConfigStorage;
	}

	public WxMenu menuGet() throws WxErrorException {
		return wxMpService.menuGet();
	}

	public void menuCreate(WxMenu menu) throws WxErrorException {
		wxMpService.menuCreate(menu);
	}

	public void menuDelete() throws WxErrorException {
		wxMpService.menuDelete();
	}

	public String oauth2buildAuthorizationUrl(String redirectURI, String scope, String state) {
		return wxMpService.oauth2buildAuthorizationUrl(redirectURI, scope, state);
	}
	
	public String getWxUser(String code) throws WxErrorException {
		WxMpOAuth2AccessToken wxMpOAuth2AccessToken = wxMpService.oauth2getAccessToken(code);
		
		return wxMpOAuth2AccessToken.getOpenId();
	}

	public WechatService getInstance() {
		synchronized (uWechatServiceObject) {
			if (uWechatService == null) {
				uWechatService = new WechatService();
			}
		}
		return uWechatService;
	}
}
