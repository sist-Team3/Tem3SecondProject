package com.sist.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.UserMapper;
import com.sist.vo.UserVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class UserDAO {
	@Autowired
	private UserMapper userMapper;
	
	public void save(UserVO user) {
		userMapper.save(user);
		log.info("User DAO 회원 전달 = {}", user.toString());
	}
}
