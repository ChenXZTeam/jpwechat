package com.solar.tech.controller.wechat;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.service.WechatService;

import me.chanjar.weixin.common.util.StringUtils;
import me.chanjar.weixin.mp.bean.WxMpXmlMessage;
import me.chanjar.weixin.mp.bean.WxMpXmlOutMessage;
/**
 * 
 * @ClassName: WechatController 
 * @Description: 微信请求控制类
 * @author: ChenXZ
 * @date: 2016年5月6日 下午2:45:52
 */
@Controller
@RequestMapping("/wechatController")

public class WechatController {
	
	private WechatService wxMpService = new WechatService().getInstance();
    /**
     * 
     * @Title: wechatGet 
     * @Description: 微信GET请求
     * @param request
     * @param response
     * @throws IOException
     * @return: void
     */
	@ResponseBody
	@RequestMapping(value = {"/wechat.action"}, method = RequestMethod.GET)
	public void wechatGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("chenxz28");
		response.setContentType("text/html;charset=utf-8");
		response.setStatus(HttpServletResponse.SC_OK); 

		String signature = request.getParameter("signature");
		String nonce = request.getParameter("nonce");
		String timestamp = request.getParameter("timestamp");

		if (!wxMpService.checkSignature(timestamp, nonce, signature)) {
			// 消息签名不正确，说明不是公众平台发过来的消息
			response.getWriter().println("非法请求");
			return;
		}

		String echostr = request.getParameter("echostr");
		if (StringUtils.isNotBlank(echostr)) {
			// 说明是一个仅仅用来验证的请求，回显echostr
			response.getWriter().println(echostr);
			return;
		}
	}
	
	/**
	 * 
	 * @Title: wechatPost 
	 * @Description: 微信POST请求
	 * @param request
	 * @param response
	 * @throws IOException
	 * @return: void
	 */
	@ResponseBody
	@RequestMapping(value = {"/wechat.action"}, method = RequestMethod.POST)
	public void wechatPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("chenxz52");
		response.setContentType("text/html;charset=utf-8");
		response.setStatus(HttpServletResponse.SC_OK);

		String signature = request.getParameter("signature");
		String nonce = request.getParameter("nonce");
		String timestamp = request.getParameter("timestamp");

		if (!wxMpService.checkSignature(timestamp, nonce, signature)) {
			// 消息签名不正确，说明不是公众平台发过来的消息
			response.getWriter().println("非法请求");
			return;
		}

		String encryptType = StringUtils.isBlank(request.getParameter("encrypt_type")) ? "raw"
				: request.getParameter("encrypt_type");

		if ("raw".equals(encryptType)) {
			// 明文传输的消息
			WxMpXmlMessage inMessage = WxMpXmlMessage.fromXml(request.getInputStream());
			System.out.println(inMessage.toString());
			WxMpXmlOutMessage outMessage = wxMpService.route(inMessage);
			if(outMessage != null) {
				response.getWriter().write(outMessage.toXml());
			} else {
				response.getWriter().write("");
			}
			
			return;
		}

		if ("aes".equals(encryptType)) {
			// 是aes加密的消息
			String msgSignature = request.getParameter("msg_signature");
			WxMpXmlMessage inMessage = WxMpXmlMessage.fromEncryptedXml(request.getInputStream(),
					wxMpService.getWxMpInMemoryConfigStorage(), timestamp, nonce, msgSignature);
			WxMpXmlOutMessage outMessage = wxMpService.route(inMessage);
			if(outMessage != null) {
				response.getWriter().write(outMessage.toEncryptedXml(wxMpService.getWxMpInMemoryConfigStorage()));
			} else {
				response.getWriter().write("");
			}
			
			return;
		}

		response.getWriter().println("不可识别的加密类型");
		return;
	}
	
}
