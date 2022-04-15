package com.sist.util;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import lombok.extern.slf4j.Slf4j;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;
@Slf4j
public class CoolSmsProvider {
	
	private static final String API_KEY = "NCSLZJGA8HIBAJBT";
	private static final String API_SECRET = "H3JWEZAYSRSIULBEO2OBFAJOHNAZOPP7";
	
	public String sendSmsAndGetCertNum(String phone, HttpServletRequest request) {
		Message coolsms = new Message(API_KEY, API_SECRET);
	    // 인증번호 생성
	    int certNum = (int)((Math.random()*9000)+1000);

	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", phone);
	    params.put("from", "07079544672");
	    params.put("type", "SMS");
	    params.put("text", "[LROOM]인증번호는 " + certNum + "입니다.");
	    params.put("app_version", "test app 1.2"); // application name and version

	    try {
	      JSONObject obj = (JSONObject) coolsms.send(params);
	      HttpSession session = request.getSession();
	      session.setAttribute("phoneCertNum", certNum);
	    } catch (CoolsmsException e) {
	      log.info("CoolSMS 에러 : 코드={} & 에러메시지={}", e.getCode(), e.getMessage());
	    }
		return Integer.toString(certNum);
	}
}
