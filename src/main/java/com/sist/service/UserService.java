package com.sist.service;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
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
	
	public void addUser(UserVO user) {
		user.setId(UUID.randomUUID().toString());		
		userDAO.save(user);
		log.info("User Service 회원 전달 = {}", user.toString());
	}
	
	
	
}
