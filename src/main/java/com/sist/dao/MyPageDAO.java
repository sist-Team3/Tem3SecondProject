package com.sist.dao;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.MyPageMapper;
import com.sist.vo.UserVO;

@Repository
public class MyPageDAO {
	@Autowired
	private MyPageMapper mapper;
	
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
}
