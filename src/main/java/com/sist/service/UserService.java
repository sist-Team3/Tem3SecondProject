package com.sist.service;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import com.sist.dao.UserDAO;
import com.sist.util.CoolSmsProvider;
import com.sist.vo.UserVO;

import lombok.extern.slf4j.Slf4j;

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
	public void addOauthUser(UserVO user, HttpServletRequest request) {		
		userDAO.saveOauthUser(user, request);
		request.getSession().removeAttribute("oauthUserPassword");
	}
	
	// 회원 확인 메서드 (이메일 기반 & 이름 기반)
	public boolean isUser(String email) {
		return userDAO.isUserByEmail(email);
	}
	public String isUserByName(String name) {
		return userDAO.isUserByName(name);
	}
	// 마이페이지 비밀번호 변경 시 사용
	public String updateLoggedUserPassword() {
		UserDetails userDetails = (UserDetails)SecurityContextHolder.getContext()
				.getAuthentication().getPrincipal();
		return userDetails.getPassword();
	}
	// 마이페이지 정보 변경 시 사용
	public String getLoggedUserName() {
		UserDetails userDetails = (UserDetails)SecurityContextHolder.getContext()
				.getAuthentication().getPrincipal();
		return userDetails.getUsername();
	}
	
    // OAuth 로그인 메서드
	public String oauthLogIn(String email, String password, HttpServletRequest request) {
		
		UsernamePasswordAuthenticationToken loginToken = new UsernamePasswordAuthenticationToken(email, password);
	    Authentication authenticatedUser = authenticationManager.authenticate(loginToken);
	    SecurityContextHolder.getContext().setAuthentication(authenticatedUser);
	    
	    request.getSession().setAttribute("username", email);
	    
	    return "redirect:/";
	}
	
	// 휴대폰 인증번호 전송 후 인증번호 출력 메서드
	public String getPhoneCertification(String phone, HttpServletRequest request) {
		CoolSmsProvider smsProvider = new CoolSmsProvider();
		return smsProvider.sendSmsAndGetCertNum(phone, request);
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