package com.sist.dao;

import java.time.Duration;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Repository;

import com.sist.mapper.MyPageMapper;
import com.sist.vo.UserVO;

@Repository
public class MyPageDAO {
	@Autowired
	private MyPageMapper mapper;
	
	private final String PREFIX ="email:";
	private final int LIMIT_TIME = 3*60;
	
	private final StringRedisTemplate stringRedisTemplate = new StringRedisTemplate();
	
	public UserVO getUserData(String id) {
		return mapper.getUserData(id);
	}
	
	public void updateUserData(UserVO vo) {
		mapper.updateUserData(vo);
	}
	public String getPwd(String id) {
		return mapper.getPwd(id);
	}
	public void updatePwd(Map map) {
		mapper.updatePwd(map);
	}
	public void deleteUser(String id) {
		mapper.deleteUser(id);
	}
	
}
