package com.sist.service;

import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.sist.dao.UserDAO;
import com.sist.vo.UserVO;

import lombok.extern.slf4j.Slf4j;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Slf4j
@Service
public class UserService {
	@Autowired
	private UserDAO userDAO;
	@Autowired
	private AuthenticationManager authenticationManager;
	
	public void addUser(UserVO user) {
		user.setId(UUID.randomUUID().toString());		
		userDAO.save(user);
		log.info("User Service 회원 전달 = {}", user.toString());
	}
	
	// 회원 확인 메서드 (이메일 기반 & 이름 기반)
	public boolean isUser(String email) {
		return userDAO.isUserByEmail(email);
	}
	public String isUserByName(String name) {
		return userDAO.isUserByName(name);
	}
	
    // OAuth 로그인 메서드
	public String oauthLogIn(String email, String password, HttpServletRequest request) {
		UsernamePasswordAuthenticationToken loginToken = new UsernamePasswordAuthenticationToken(email, password);
	    Authentication authenticatedUser = authenticationManager.authenticate(loginToken);
	    SecurityContextHolder.getContext().setAuthentication(authenticatedUser);
	    
	    request.getSession().setAttribute("username", email);
	    
	    return "redirect:/";
	}
	
	// 휴대폰 인증번호 전송 메서드
	public String getPhoneCertification(String phone, HttpServletRequest request) {
		String api_key = "NCSLZJGA8HIBAJBT";
	    String api_secret = "H3JWEZAYSRSIULBEO2OBFAJOHNAZOPP7";
	    Message coolsms = new Message(api_key, api_secret);
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
	      System.out.println(e.getMessage());
	      System.out.println(e.getCode());
	    }
		return Integer.toString(certNum);
	}
	
	// 휴대폰 인증 기반 정보 전송 메서드 (아이디 & 비밀번호)
	public String getEmailByPhoneCertification(String certNum, String phone, HttpServletRequest request) {
		HttpSession session = request.getSession();
		if (certNum.equals(session.getAttribute("phoneCertNum").toString())) {
			session.removeAttribute("phoneCertNum");
			return userDAO.getEmailByPhone(phone);
		}
		return "false";
	}
	public String getPasswordByPhoneCertification(String certNum, String phone, HttpServletRequest request) {
		HttpSession session = request.getSession();
		if (certNum.equals(session.getAttribute("phoneCertNum").toString())) {
			session.removeAttribute("phoneCertNum");
			return userDAO.getNewPasswordByPhone(phone);
		}
		return "false";
	}
}