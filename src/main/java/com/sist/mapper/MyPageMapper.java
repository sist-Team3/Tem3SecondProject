package com.sist.mapper;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.UserVO;
public interface MyPageMapper {
	// 정보 가져오기
	@Select("SELECT email,phone,name,TO_CHAR(birth,'YYYY-MM-DD') as dbday,postcode,address1,address2 "
			+ "FROM users_3 "
			+ "WHERE id=#{id}")
	public UserVO getUserData(String id);
	// 정보 수정
	@Update("UPDATE users_3 SET name=#{name},birth=TO_DATE(#{dbday},'YYYY-MM-DD'),phone=#{phone},email=#{email},postcode=#{postcode},address1=#{address1},address2=#{address2} "
			+ "WHERE id=#{id}")
	public void updateUserData(UserVO vo);
	// 비밀번호 가져오기
	@Select("SELECT password FROM users_3 WHERE id=#{id}")
	public String getPwd(String id);
	// 비밀번호 변경하기
	@Update("UPDATE users_3 SET password=#{pwd} WHERE id=#{id}")
	public void updatePwd(Map map);
	// 정보 삭제
	@Delete("DELETE FROM users_3 WHERE id=#{id}")
	public void deleteUser(String id);
}
