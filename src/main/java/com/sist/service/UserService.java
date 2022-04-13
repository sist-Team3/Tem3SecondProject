package com.sist.service;

import java.util.Collection;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	
	public void addUser(UserVO user) {
		user.setId(UUID.randomUUID().toString());		
		userDAO.save(user);
		log.info("User Service 회원 전달 = {}", user.toString());
	}
	
	public boolean isUser(String email) {
		return userDAO.isUserByEmail(email);
	}
	public String oauthLogIn(String email, String password, HttpServletRequest request) {
		UsernamePasswordAuthenticationToken loginToken = new UsernamePasswordAuthenticationToken(email, password);
	    Authentication authenticatedUser = authenticationManager.authenticate(loginToken);
	    SecurityContextHolder.getContext().setAuthentication(authenticatedUser);
	    
	    request.getSession().setAttribute("username", email);
	    
	    return "redirect:/";
	}
	public String getLoggedUserName() {
		UserDetails userDetails = (UserDetails)SecurityContextHolder.getContext()
				.getAuthentication().getPrincipal();
		return userDetails.getUsername();
	}
	public boolean checkPw() {
		UserDetails userDetails = (UserDetails)SecurityContextHolder.getContext()
				.getAuthentication().getPrincipal();
		String oldPasswordString = userDetails.getPassword();
		return passwordEncoder.matches("새로 받은 비밀번호", "UserDetails에서 받아온 비밀번호");
	}
	public String getPhoneCertification() {
		String api_key = "NCSLZJGA8HIBAJBT";
	    String api_secret = "H3JWEZAYSRSIULBEO2OBFAJOHNAZOPP7";
	    Message coolsms = new Message(api_key, api_secret);

	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", "01040962435");
	    params.put("from", "07079544672");
	    params.put("type", "SMS");
	    params.put("text", "Coolsms Testing Message!");
	    params.put("app_version", "test app 1.2"); // application name and version

	    try {
	      JSONObject obj = (JSONObject) coolsms.send(params);
	      System.out.println(obj.toString());
	    } catch (CoolsmsException e) {
	      System.out.println(e.getMessage());
	      System.out.println(e.getCode());
	    }
		return "야호";
	}
}
