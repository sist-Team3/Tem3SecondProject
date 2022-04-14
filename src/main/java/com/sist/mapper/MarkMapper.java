package com.sist.mapper;

import java.util.*;
import com.sist.vo.*;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

public interface MarkMapper {
	
	@Select("SELECT no,ano FROM mark_3 WHERE ano=#{ano}")
	public List<ApartmentVO> apartmentMarkList(int ano);
	
	@Select("SELECT no,ono FROM mark_3 WHERE ono=#{ono}")
	public List<OfficetelVO> officetelMarkList(int ono);
	
	@Select("SELECT no,vno FROM mark_3 WHERE vno=#{vno}")
	public List<VillaVO> villaMarkList(int vno);
	
	@Insert("INSERT INTO mark_3(no,ano,vno,ono,email) VALUES(mark_no_seq.nextval,#{ano},#{vno},#{ono},#{email}")
	public void insertMark();
	
	@Delete("DELETE FROM mark_3 WHERE no=#{no}")
	public void deleteMark();
}
