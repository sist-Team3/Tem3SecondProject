package com.sist.mapper;
import java.util.*;
import com.sist.vo.*;

import org.apache.ibatis.annotations.Select;



public interface ProductlistMapper {
	@Select("SELECT no,area_size,price,floor"
			+ "address,name,road_name,construct_date"
			+ "FROM apartment_3"
			+ "WHERE no=#{no}")
	public ApartmentVO apartmentListData(int no);
	
	@Select("SELECT no,area_size,price,floor"
			+ "address,name,road_name,construct_date"
			+ "FROM officetel_3"
			+ "WHERE no=#{no}")
	public OfficetelVO officetelListData(int no);
	
	@Select("SELECT no,area_size,price,floor"
			+ "address,name,road_name,construct_date"
			+ "FROM villa_3"
			+ "WHERE no=#{no}")
	public VillaVO villaListData(int no);
	
}
