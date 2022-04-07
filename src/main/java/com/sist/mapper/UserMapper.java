package com.sist.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.sist.vo.UserVO;

public interface UserMapper {
	@Insert("INSERT INTO USERS_3(ID, EMAIL, PASSWORD, NAME) VALUES(#{id}, #{email}, #{password}, #{name})")
	public void save(UserVO user);
	
	@Select("SELECT * FROM USERS_3 WHERE EMAIL = #{email}")
    public UserVO findByEmail(String email);
}
