package com.solar.tech.service;

import java.util.Map;

import org.springframework.stereotype.Service;

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
import me.chanjar.weixin.mp.bean.WxMpXmlOutTextMessage;
import me.chanjar.weixin.mp.bean.result.WxMpOAuth2AccessToken;
import me.chanjar.weixin.mp.bean.result.WxMpUser;

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
		wxMpConfigStorage.setAppId("wx0c792f8b27916232"); // 设置微信公众号的appid
		wxMpConfigStorage.setSecret("05c4c9112586340e9825213e85a9b47d"); // 设置微信公众号的app
																			// corpSecret
		wxMpConfigStorage.setToken("gzyhinctoken"); // 设置微信公众号的token
		wxMpConfigStorage.setAesKey("9kR01rJTqlVt4aQcqbBzlTiiXWICoSSQL0qpDjRzHhc"); // 设置微信公众号的EncodingAESKey

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

		wxMpMessageRouter = new WxMpMessageRouter(wxMpService);
		wxMpMessageRouter.rule().async(false).content("哈哈") // 拦截内容为“哈哈”的消息
				.handler(handler).end().rule().async(false).event(WxConsts.EVT_SUBSCRIBE).handler(handler).end().rule()
				.event(WxConsts.EVT_UNSUBSCRIBE).async(false).handler(handler).end();

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
