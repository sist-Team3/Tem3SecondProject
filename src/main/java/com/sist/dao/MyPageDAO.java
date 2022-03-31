package com.sist.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.MypageMapper;

@Repository
public class MyPageDAO {
	@Autowired
	private MypageMapper mapper;
	
	
}
