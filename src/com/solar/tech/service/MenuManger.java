package com.solar.tech.service;

import java.util.ArrayList; 
import java.util.List;

import me.chanjar.weixin.common.api.WxConsts;
import me.chanjar.weixin.common.bean.WxMenu;
import me.chanjar.weixin.common.bean.WxMenu.WxMenuButton;
import me.chanjar.weixin.common.exception.WxErrorException;

/**
 * 
 * @ClassName: MenuManger
 * @Description: TODO
 * @author: ChenXZ
 * @date: 2016年4月24日 下午11:47:32
 */
public class MenuManger {

	private WechatService wxMpService = new WechatService().getInstance();

	/**
	 * 
	 * @Title: CheckMenu 
	 * @Description: TODO
	 * @return: void
	 */
	public void CheckMenu() {
		try {
			// 1.获取公众号自定义菜单
			// 2.判断是否已经存在自定义菜单
			System.out.println(wxMpService);
			WxMenu wxMenuOld = wxMpService.menuGet();
			if (wxMenuOld == null) {
				WxMenu wxMenuNew = new WxMenu();
				WxMenuButton orderButton = new WxMenuButton();
				orderButton.setName("微.预定");
				orderButton.setType(WxConsts.BUTTON_CLICK);
				
				WxMenuButton planeButton = new WxMenuButton();
				planeButton.setName("机票预定");
				planeButton.setType(WxConsts.BUTTON_VIEW);
				planeButton.setUrl(buildAuthorizationUrl(
						"http://jp.gzyhinc.com/BookTicketsys/wechatController/page/planTek.action",
						WxConsts.OAUTH2_SCOPE_BASE, null));
				
				/*WxMenuButton inviteButton = new WxMenuButton();
				inviteButton.setName("我的邀请");
				inviteButton.setType(WxConsts.BUTTON_VIEW);
				inviteButton.setUrl(buildAuthorizationUrl(
						"http://jp.gzyhinc.com/BookTicketsys/wechatController/page/kaifing.action",
						WxConsts.OAUTH2_SCOPE_BASE, null));*/
				
				/*WxMenuButton inewsButton = new WxMenuButton();
				inewsButton.setType(WxConsts.BUTTON_CLICK);
				inewsButton.setName("最近资讯(国内)");
				inewsButton.setKey("InContraty");*/

				orderButton.getSubButtons().add(planeButton);
				/*orderButton.getSubButtons().add(inviteButton);
				orderButton.getSubButtons().add(inewsButton);*/
				
				
				WxMenuButton worldButton = new WxMenuButton();
				worldButton.setName("看.世界");
				worldButton.setType(WxConsts.BUTTON_CLICK);
				
				/*WxMenuButton wnewsButton = new WxMenuButton();
				wnewsButton.setType(WxConsts.BUTTON_CLICK);
				wnewsButton.setName("最近资讯(国际)");
				wnewsButton.setKey("OutContraty");*/
				
				WxMenuButton visaButton = new WxMenuButton();
				visaButton.setType(WxConsts.BUTTON_VIEW);
				visaButton.setName("签证信息");
				visaButton.setUrl(
						buildAuthorizationUrl("http://jp.gzyhinc.com/BookTicketsys/wechatController/page/visaMessage.action",
								WxConsts.OAUTH2_SCOPE_BASE, null));
				
				/*WxMenuButton featureButton = new WxMenuButton();
				featureButton.setType(WxConsts.BUTTON_CLICK);
				featureButton.setName("特色线路");
				featureButton.setKey("charaRoute");*/
				
				WxMenuButton rateButton = new WxMenuButton();
				rateButton.setType(WxConsts.BUTTON_VIEW);
				rateButton.setName("汇率查询");
				rateButton.setUrl(
						buildAuthorizationUrl("http://jp.gzyhinc.com/BookTicketsys/wechatController/page/huilvSearch.action",
								WxConsts.OAUTH2_SCOPE_BASE, null));
				
				//worldButton.getSubButtons().add(wnewsButton);
				worldButton.getSubButtons().add(visaButton);
				//worldButton.getSubButtons().add(featureButton);
				worldButton.getSubButtons().add(rateButton);
				
				WxMenuButton tourButton = new WxMenuButton();
				tourButton.setName("知.旅讯");
				tourButton.setType(WxConsts.BUTTON_CLICK);
				
				WxMenuButton myOrderButton = new WxMenuButton();
				myOrderButton.setType(WxConsts.BUTTON_VIEW);
				myOrderButton.setName("个人中心");
				myOrderButton.setUrl(
						buildAuthorizationUrl("http://jp.gzyhinc.com/BookTicketsys/wechatController/page/oneself.action",
								WxConsts.OAUTH2_SCOPE_BASE, null));
				
				WxMenuButton weatherButton = new WxMenuButton();
				weatherButton.setType(WxConsts.BUTTON_VIEW);
				weatherButton.setName("城市天气");
				weatherButton.setUrl(
						buildAuthorizationUrl("http://jp.gzyhinc.com/BookTicketsys/wechatController/page/dayWeath.action",
								WxConsts.OAUTH2_SCOPE_BASE, null));
				
				/*WxMenuButton typeButton = new WxMenuButton();
				typeButton.setType(WxConsts.BUTTON_VIEW);
				typeButton.setName("飞机机型");
				typeButton.setUrl(
						buildAuthorizationUrl("http://jp.gzyhinc.com/BookTicketsys/wechatController/page/fjModel.action",
								WxConsts.OAUTH2_SCOPE_BASE, null));*/
				
				WxMenuButton packingButton = new WxMenuButton();
				packingButton.setType(WxConsts.BUTTON_VIEW);
				packingButton.setName("行李须知");
				packingButton.setUrl(
						buildAuthorizationUrl("http://jp.gzyhinc.com/BookTicketsys/wechatController/page/travelCost.action",
								WxConsts.OAUTH2_SCOPE_BASE, null));
				
				WxMenuButton serviceButton = new WxMenuButton();
				serviceButton.setType(WxConsts.BUTTON_VIEW);
				serviceButton.setName("联系客服");
				serviceButton.setUrl(
						buildAuthorizationUrl("http://jp.gzyhinc.com/BookTicketsys/wechatController/page/callKeFu.action",
								WxConsts.OAUTH2_SCOPE_BASE, null));
				
				tourButton.getSubButtons().add(myOrderButton);
				tourButton.getSubButtons().add(weatherButton);
				//tourButton.getSubButtons().add(typeButton);
				tourButton.getSubButtons().add(packingButton);
				tourButton.getSubButtons().add(serviceButton);
				
				wxMenuNew.getButtons().add(orderButton);
				wxMenuNew.getButtons().add(worldButton);
				wxMenuNew.getButtons().add(tourButton);

				wxMpService.menuCreate(wxMenuNew);

			} else {
				wxMpService.menuDelete();
				WxMenu wxMenuNew = new WxMenu();
				WxMenuButton orderButton = new WxMenuButton();
				orderButton.setName("微.预定");
				orderButton.setType(WxConsts.BUTTON_CLICK);
				
				WxMenuButton planeButton = new WxMenuButton();
				planeButton.setName("机票预定");
				planeButton.setType(WxConsts.BUTTON_VIEW);
				planeButton.setUrl(buildAuthorizationUrl(
						"http://jp.gzyhinc.com/BookTicketsys/wechatController/page/planTek.action",
						WxConsts.OAUTH2_SCOPE_BASE, null));
				
				/*WxMenuButton inviteButton = new WxMenuButton();
				inviteButton.setName("我的邀请");
				inviteButton.setType(WxConsts.BUTTON_VIEW);
				inviteButton.setUrl(buildAuthorizationUrl(
						"http://jp.gzyhinc.com/BookTicketsys/wechatController/page/yqUser.action",
						WxConsts.OAUTH2_SCOPE_BASE, null));*/
				
				/*WxMenuButton inewsButton = new WxMenuButton();
				inewsButton.setType(WxConsts.BUTTON_CLICK);
				inewsButton.setName("最近资讯(国内)");
				inewsButton.setKey("InContraty");*/

				orderButton.getSubButtons().add(planeButton);
				/*orderButton.getSubButtons().add(inviteButton);
				orderButton.getSubButtons().add(inewsButton);*/
				
				
				WxMenuButton worldButton = new WxMenuButton();
				worldButton.setName("看.世界");
				worldButton.setType(WxConsts.BUTTON_CLICK);
				
				/*WxMenuButton wnewsButton = new WxMenuButton();
				wnewsButton.setType(WxConsts.BUTTON_CLICK);
				wnewsButton.setName("最近资讯(国际)");
				wnewsButton.setKey("OutContraty");*/
				
				WxMenuButton visaButton = new WxMenuButton();
				visaButton.setType(WxConsts.BUTTON_VIEW);
				visaButton.setName("签证信息");
				visaButton.setUrl(
						buildAuthorizationUrl("http://jp.gzyhinc.com/BookTicketsys/wechatController/page/visaMessage.action?dd=2131",
								WxConsts.OAUTH2_SCOPE_BASE, null));
				
				/*WxMenuButton featureButton = new WxMenuButton();
				featureButton.setType(WxConsts.BUTTON_CLICK);
				featureButton.setName("特色线路");
				featureButton.setKey("charaRoute");*/
				
				WxMenuButton rateButton = new WxMenuButton();
				rateButton.setType(WxConsts.BUTTON_VIEW);
				rateButton.setName("汇率查询");
				rateButton.setUrl(
						buildAuthorizationUrl("http://jp.gzyhinc.com/BookTicketsys/wechatController/page/huilvSearch.action",
								WxConsts.OAUTH2_SCOPE_BASE, null));
				
				//worldButton.getSubButtons().add(wnewsButton);
				worldButton.getSubButtons().add(visaButton);
				//worldButton.getSubButtons().add(featureButton);
				worldButton.getSubButtons().add(rateButton);
				
				WxMenuButton tourButton = new WxMenuButton();
				tourButton.setName("知.旅讯");
				tourButton.setType(WxConsts.BUTTON_CLICK);
				
				WxMenuButton myOrderButton = new WxMenuButton();
				myOrderButton.setType(WxConsts.BUTTON_VIEW);
				myOrderButton.setName("个人中心");
				myOrderButton.setUrl(
						buildAuthorizationUrl("http://jp.gzyhinc.com/BookTicketsys/wechatController/page/oneself.action",
								WxConsts.OAUTH2_SCOPE_BASE, null));
				
				WxMenuButton weatherButton = new WxMenuButton();
				weatherButton.setType(WxConsts.BUTTON_VIEW);
				weatherButton.setName("城市天气");
				weatherButton.setUrl(
						buildAuthorizationUrl("http://jp.gzyhinc.com/BookTicketsys/wechatController/page/dayWeath.action",
								WxConsts.OAUTH2_SCOPE_BASE, null));
				
				/*WxMenuButton typeButton = new WxMenuButton();
				typeButton.setType(WxConsts.BUTTON_VIEW);
				typeButton.setName("飞机机型");
				typeButton.setUrl(
						buildAuthorizationUrl("http://jp.gzyhinc.com/BookTicketsys/wechatController/page/fjModel.action",
								WxConsts.OAUTH2_SCOPE_BASE, null));*/
				
				WxMenuButton packingButton = new WxMenuButton();
				packingButton.setType(WxConsts.BUTTON_VIEW);
				packingButton.setName("行李须知");
				packingButton.setUrl(
						buildAuthorizationUrl("http://jp.gzyhinc.com/BookTicketsys/wechatController/page/travelCost.action",
								WxConsts.OAUTH2_SCOPE_BASE, null));
				
				WxMenuButton serviceButton = new WxMenuButton();
				serviceButton.setType(WxConsts.BUTTON_VIEW);
				serviceButton.setName("联系客服");
				serviceButton.setUrl(
						buildAuthorizationUrl("http://jp.gzyhinc.com/BookTicketsys/wechatController/page/callKeFu.action",
								WxConsts.OAUTH2_SCOPE_BASE, null));
				
				tourButton.getSubButtons().add(myOrderButton);
				tourButton.getSubButtons().add(weatherButton);
				//tourButton.getSubButtons().add(typeButton);
				tourButton.getSubButtons().add(packingButton);
				tourButton.getSubButtons().add(serviceButton);
				
				wxMenuNew.getButtons().add(orderButton);
				wxMenuNew.getButtons().add(worldButton);
				wxMenuNew.getButtons().add(tourButton);

				wxMpService.menuCreate(wxMenuNew);
			}

		} catch (WxErrorException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 
	 * @Title: buildAuthorizationUrl 
	 * @Description: TODO
	 * @param redirectURI
	 * @param scope
	 * @param state
	 * @return
	 * @return: String
	 */
	private String buildAuthorizationUrl(String redirectURI, String scope, String state) {
		return wxMpService.oauth2buildAuthorizationUrl(redirectURI, scope, state);
	}

	/**
	 * 
	 * @Title: main 
	 * @Description: TODO
	 * @param args
	 * @return: void
	 */
	public static void main(String[] args) {
		MenuManger mm = new MenuManger();
		String url = mm.buildAuthorizationUrl("http://jp.gzyhinc.com/BookTicketsys/wechatController/page/mine.action",
				WxConsts.OAUTH2_SCOPE_BASE, null);
		System.out.println(url);
	}
}
