package com.sist.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.UserVO;

public interface UserMapper {
	@Insert("INSERT INTO USERS_3(ID, EMAIL, PASSWORD, NAME, PHONE) VALUES(#{id}, #{email}, #{password}, #{name}, #{phone})")
	public void save(UserVO user);
	
	@Select("SELECT COUNT(*) FROM USERS_3 WHERE NAME = #{name}")
    public Integer findByName(String name);
	
	@Select("SELECT COUNT(*) FROM USERS_3 WHERE PHONE = #{phone}")
	public Integer findByPhone(String phone);
	
	@Select("SELECT * FROM USERS_3 WHERE EMAIL = #{email}")
    public UserVO findByEmail(String email);
	
	@Select("SELECT EMAIL FROM USERS_3 WHERE PHONE = #{phone}")
    public String findEmailByPhone(String phone);
	
	@Update("UPDATE USERS_3 SET PASSWORD = #{password} WHERE PHONE = #{phone}")
	public void updatePasswordByPhone(@Param("password")String password, @Param("phone")String phone);
}

