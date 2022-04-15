package com.sist.dao;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

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
	}
	public void saveOauthUser(UserVO user, HttpServletRequest request) {
		user.setId(UUID.randomUUID().toString());
		String pw = request.getSession().getAttribute("oauthUserPassword").toString();
		user.setPassword(passwordEncoder.encode(pw));
		userMapper.saveOauth(user);
	}
	public UserVO findUserByEmail(String email) {
		return userMapper.findByEmail(email);
	}
	public String isUserByName(String name) {
		return userMapper.findByName(name) > 0 ? "true" : "false";
	}
	public boolean isUserByPhone(String phone) {
		return userMapper.findByPhone(phone) > 0 ? true : false;
	}
	public boolean isUserByEmail(String email) {
		return userMapper.findByEmail(email) != null ? true : false;
	}
	public String getEmailByPhone(String phone) {
		return userMapper.findEmailByPhone(phone);
	}
	public String getNewPasswordByPhone(String phone) {
		String newPW = UUID.randomUUID().toString().replaceAll("-", "");
		String password = passwordEncoder.encode(newPW);
		userMapper.updatePasswordByPhone(password, phone);
		return newPW;
	}
}
