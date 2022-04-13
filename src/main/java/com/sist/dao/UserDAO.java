package com.sist.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

import com.sist.mapper.UserMapper;
import com.sist.vo.UserVO;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Repository
public class UserDAO {
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	public void save(UserVO user) {
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		userMapper.save(user);
		log.info("User DAO 회원 전달 = {}", user.toString());
	}
	public UserVO findUserByEmail(String email) {
		return userMapper.findByEmail(email);
	}
	public String isUserByName(String name) {
		return userMapper.findByName(name) > 0 ? "true" : "false";
	}
	public boolean isUserByEmail(String email) {
		return userMapper.findByEmail(email) != null ? true : false;
	}
	public String getEmailByPhone(String phone) {
		return userMapper.findEmailByPhone(phone);
	}
}
