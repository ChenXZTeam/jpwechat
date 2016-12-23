package com.solar.tech.controller.framework;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.lxq.wxMess.util.AccessToken;
import org.lxq.wxMess.util.CommUtil;
import org.lxq.wxMess.util.WeixinUtil;
import org.lxq.wxMess.util.getMidio_id;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.service.RDwechatUserService;

@Controller
@RequestMapping("/framework/wxInfo")
public class WxsendMessController {
	@Autowired
	private RDwechatUserService RDUserService;
	// 第三方用户唯一凭证  
    public static String appid = "wx0c792f8b27916232";
    // 第三方用户唯一凭证密钥
    public static String appsecret = "05c4c9112586340e9825213e85a9b47d";
    public static AccessToken accessToken = null;
    
	/**
	 * 用户输入关键字时进行自动图文回复
	 * @param req
	 * @param resp
	 * @throws IOException
	 */
	@RequestMapping("/wxMesgess.action")
	@ResponseBody
	public void wxMesgess(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		
	}
	
	/**
	 * 管理员点击推送消息的时候推送图文回复
	 */
	@RequestMapping("/wxTsMesgess.action")
	@ResponseBody
	public Map<String,Object> wxTsMesgess(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		Map<String,Object> map = new HashMap<String,Object>();
		String mittitle = req.getParameter("mittitle");
		String fmUrl = req.getParameter("fmUrl");
		String mitcont = req.getParameter("mitcont");
		String contText = req.getParameter("contText");
		/**
		 * 第一步：获取AccessToken
		 * 第二步：上传图片，获取media_id 需要用到第一步的AccessToken
		 * 第三步：上传图文消息，需要用到第二步的media_id和第一步的AccessToken
		 * 第四步：开始推送图文消息
		 */
		try {  
            accessToken = WeixinUtil.getAccessToken(appid, appsecret);  
            if (null != accessToken) {  
            	//第一步 获取AccessToken
            	String AccessToken = accessToken.getToken();
            	System.out.println("获取到AccessToken："+AccessToken);
            	//第二步 上传图片
            	getMidio_id fileUpload = new getMidio_id();  
            	String sendUrl = "http://file.api.weixin.qq.com/cgi-bin/media/upload?access_token="+AccessToken+"&type=image";
                String media_id = fileUpload.send(sendUrl, fmUrl);
                JSONObject jsonObject=JSONObject.fromObject(media_id); //对结果json数据进行装换获取其中的media_id
                media_id = jsonObject.get("media_id")+"";
                System.out.println("获取到图片media_id："+media_id);
                //第三步 上传图文消息
                String url = "https://api.weixin.qq.com/cgi-bin/media/uploadnews?access_token="+AccessToken;
                String jsonData = "{\"articles\":[{\"author\":\"\",\"content\":\""+contText+"\",\"content_source_url\":\"www.baidu.com\",\"digest\":\""+mitcont+"\",\"show_cover_pic\":1,\"title\":\""+mittitle+"\",\"thumb_media_id\":\""+media_id+"\"}]}";  
                JSONObject json = CommUtil.httpRequest(url, "POST", jsonData);
                JSONObject tw_jsonObject = JSONObject.fromObject(json.toString()); //对结果json数据进行装换获取其中的media_id
                String tw_media_id = tw_jsonObject.get("media_id")+"";
                System.out.println("获取到图文media_id："+tw_media_id);
                //第四部 开始推送
                String userStr = RDUserService.getUserList();
                String groupUrl1 = "https://api.weixin.qq.com/cgi-bin/message/mass/send?access_token="+AccessToken;//根据openid发群发消息地址
                String openid4data = "{\"touser\":[\""+userStr+"\"], \"mpnews\": {\"media_id\":\""+tw_media_id+"\"},\"msgtype\":\"mpnews\"}";//推送的内容
                JSONObject ws_jsonResult = CommUtil.httpRequest(groupUrl1, "POST", openid4data);
                System.out.println(ws_jsonResult.toString());
                JSONObject resuTs = JSONObject.fromObject(ws_jsonResult.toString());
                String IsSuccess = resuTs.get("errcode")+"";
                if(IsSuccess.equals("0")||"0".equals(IsSuccess)){
                	map.put("msg", "消息推送成功，消息会有延迟...");
                	System.out.println("消息推送成功，消息会有延迟...");
                }else{
                	map.put("msg", "消息推送失败...");
                	System.out.println("消息推送失败...");
                }
            } else {  
            	System.out.println("图文推送失败，AccessToken无效");
            	map.put("msg", "图文推送失败，AccessToken无效");
            }  
        } catch (Exception e) {  
        	System.out.println("图文推送失败，AccessToken异常");
        	map.put("msg", "图文推送失败，AccessToken异常");
        } 
		return map;
	}
}
