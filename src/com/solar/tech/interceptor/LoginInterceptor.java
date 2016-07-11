package com.solar.tech.interceptor;

//import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.solar.tech.bean.entity.RD_wechatUser;
import com.solar.tech.service.WechatService;
import com.solar.tech.service.RDwechatUserService;

import me.chanjar.weixin.mp.bean.result.WxMpUser;

/**
 * 
 * @ClassName: LoginInterceptor
 * @Description: 拦截器，作用拦截公众号自定义菜单按钮，判断是否绑定
 * @author: ChenXZ
 * @date: 2016年4月27日 下午4:05:37
 */
@Repository
public class LoginInterceptor extends HandlerInterceptorAdapter {
	private WechatService wxMpService = new WechatService().getInstance();
	@Autowired
	private RDwechatUserService RDUserService;

	/**
	 * 
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String path = request.getRequestURI();
		String ContextPath = request.getContextPath();
		String pageurl = path.replace(ContextPath, "");
		String root = request.getContextPath();
		String basePath = request.getScheme() + "://" + request.getServerName() + root + "/";

		if (pageurl.equals("/wechatController/page/regies.action")
				|| pageurl.equals("/wechatController/page/mine.action")) {
			HttpSession session = request.getSession();
			String newCode = request.getParameter("code");
			String number = (String) session.getAttribute("number");
			String openId = (String) session.getAttribute("openId");
			System.out.println("啥都看见哈萨克的");
			if (newCode == null && "".equals(newCode)) {
				response.sendRedirect(basePath + "console/wechat/business/bindAccount.jsp");
				return false;
			}
			System.out.println("start...55");
			if (number == null || openId == null) {
				System.out.println("start...57");
				openId = wxMpService.getWxUser(newCode);
				if (openId != null) {
					session.setAttribute("openId", openId);

					boolean exist = RDUserService.findbyOpenid(openId);
					if (!exist) {
						response.sendRedirect(basePath + "console/wechat/business/bindAccount.jsp");
						return false;
					} else {
						RD_wechatUser yHopenID = RDUserService.findbyOpenids(openId);
						number = yHopenID.getPhoneNum();
						session.setAttribute("number", number);
					}
				}
			} else {
				System.out.println("pageurl:" + pageurl +"number:" + number + " " + "openId:" + openId);
			}

		}

		return true;
	}

	/**
	 * 
	 */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}
}