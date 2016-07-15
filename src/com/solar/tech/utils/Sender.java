package com.solar.tech.utils;

import java.io.*;
import java.net.*;
/**
 * 
 * @ClassName: Sender 
 * @Description: 短信发送类
 * @author: Administrator
 * @date: 2016年5月6日 下午2:28:55
 */
public class Sender {
	private String comName;
	private String comPwd;
	private String Server;

	/**
	 * 
	 * @Title:Sender
	 * @Description:TODO
	 */
	public Sender() {
		this("default", "default");
	}

	/**
	 * 
	 * @Title:Sender
	 * @Description:TODO 
	 * @param name
	 * @param pwd
	 */
	public Sender(String name, String pwd) {
		comName = name;
		comPwd = pwd;
		Server = "http://www.139000.com";
	}

	/**
	 * 
	 * @Title:Sender
	 * @Description:TODO 
	 * @param name
	 * @param pwd
	 * @param serverNum
	 */
	public Sender(String name, String pwd, int serverNum) {
		comName = name;
		comPwd = pwd;
		if (serverNum == 2)
			Server = "http://www6.china-sms.com";
		else
			Server = "http://www.china-sms.com";
	}

	/**
	 * 
	 * @Title: massSend 
	 * @Description: TODO
	 * @param dst
	 * @param msg
	 * @param time
	 * @param subNo
	 * @return
	 * @return: String
	 */
	public String massSend(String dst, String msg, String time, String subNo) {
		String sUrl = null;
		try {
			sUrl = Server + "/send/gsend.asp?name=" + comName + "&pwd=" + comPwd + "&dst=" + dst + "&msg="
					+ URLEncoder.encode(msg, "GB2312") + "&time=" + time + "&sender=" + subNo;// �������GB2312���򷢵��ֻ�����
		} catch (UnsupportedEncodingException uee) {
			System.out.println(uee.toString());
		}
		return getUrl(sUrl);
	}

	/**
	 * 
	 * @Title: readSms 
	 * @Description: TODO
	 * @return
	 * @return: String
	 */
	public String readSms() {
		String sUrl = null;
		sUrl = Server + "/send/readsms.asp?name=" + comName + "&pwd=" + comPwd;
		try {
			URLEncoder.encode(sUrl, "GB2312");
		} catch (UnsupportedEncodingException uee) {
			System.out.println(uee.toString());
		}
		return getUrl(sUrl);
	}

	/**
	 * 
	 * @Title: getFee 
	 * @Description: TODO
	 * @return
	 * @return: String
	 */
	public String getFee() {
		String sUrl = null;
		sUrl = Server + "/send/getfee.asp?name=" + comName + "&pwd=" + comPwd;
		return getUrl(sUrl);
	}

	/**
	 * 
	 * @Title: changePwd 
	 * @Description: TODO
	 * @param newPwd
	 * @return
	 * @return: String
	 */
	public String changePwd(String newPwd) {
		String sUrl = null;
		sUrl = Server + "/send/cpwd.asp?name=" + comName + "&pwd=" + comPwd + "&newpwd=" + newPwd;
		try {
			URLEncoder.encode(sUrl, "GB2312");
		} catch (UnsupportedEncodingException uee) {
			System.out.println(uee.toString());
		}
		return getUrl(sUrl);
	}

	/**
	 * 
	 * @Title: checkContent 
	 * @Description: TODO
	 * @param content
	 * @return
	 * @return: String
	 */
	public String checkContent(String content) {
		String sUrl = null;
		sUrl = Server + "/send/checkcontent.asp?name=" + comName + "&pwd=" + comPwd + "&content=" + content;
		try {
			URLEncoder.encode(sUrl, "GB2312");
		} catch (UnsupportedEncodingException uee) {
			System.out.println(uee.toString());
		}
		return getUrl(sUrl);
	}

	/**
	 * 
	 * @Title: getUrl 
	 * @Description: TODO
	 * @param urlString
	 * @return
	 * @return: String
	 */
	public String getUrl(String urlString) {
		StringBuffer sb = new StringBuffer();
		try {
			URL url = new URL(urlString);
			URLConnection conn = url.openConnection();
			BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			for (String line = null; (line = reader.readLine()) != null;)
				sb.append(line + "\n");

			reader.close();
		} catch (IOException e) {
			System.out.println(e.toString());
		}
		return sb.toString();
	}

	/**
	 * 
	 * @Title: msg 
	 * @Description: TODO
	 * @param phone
	 * @param code
	 * @return
	 * @throws UnsupportedEncodingException
	 * @return: boolean
	 */
	public static boolean msg(String phone, String code) throws UnsupportedEncodingException {
		String returnCode;
		Sender sms = new Sender("gzjiaotong", "gtg96122");
		returnCode = sms.massSend(phone, "您的验证码是:" + code, "", "");
		String encode = null;
		encode = new String(returnCode.getBytes("GBK"), "GB2312");
		if ("num=1".equals(encode.substring(0, 5))) {
			return true;
		} else {
			System.out.println(encode);
			return false;
		}
	}
}
