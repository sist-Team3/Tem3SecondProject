package com.sist.mapper;

import java.util.*;
import com.sist.vo.*;
import org.apache.ibatis.annotations.Select;

public interface ProductMapper {
	@Select("SELECT no,area_size,price,floor,construction_date,"
			+"address,bunji,name,road_name,deal_type,agent_seat,construct_date "
			+"FROM apartment_3 "
			+"WHERE no=#{no}")
	public ApartmentVO apartmentDetailData(int no);
	
	@Select("SELECT no,area_size,price,floor,construction_year,"
			+"address,bunji,name,road_name,deal_type,agent_seat,construct_date "
			+"FROM officetel_3 "
			+"WHERE no=#{no}")
	public OfficetelVO officetelDetailData(int no);
	
	@Select("SELECT no,area_size,landarea_size,price,floor,construction_year,"
			+"address,bunji,name,road_name,deal_type,agent_seat,construct_date "
			+"FROM villa_3 "
			+"WHERE no=#{no}")
	public VillaVO villaDetailData(int no);
}
