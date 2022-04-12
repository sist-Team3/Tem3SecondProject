package com.sist.service;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import com.sist.dao.UserDAO;
import com.sist.vo.UserVO;

import lombok.RequiredArgsConstructor;
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
	
	public boolean isUser(String email) {
		return userDAO.isUserByEmail(email);
	}
	public String oauthLogIn(String email, String password) {
		UsernamePasswordAuthenticationToken loginToken = new UsernamePasswordAuthenticationToken(email, password);
	    Authentication authenticatedUser = authenticationManager.authenticate(loginToken);
	    SecurityContextHolder.getContext().setAuthentication(authenticatedUser);
	    return "redirect:/";
	}
	public String getLoggedUserName() {
		UserDetails userDetails = (UserDetails)SecurityContextHolder.getContext()
				.getAuthentication().getPrincipal();
		return userDetails.getUsername();
	}
	
}
