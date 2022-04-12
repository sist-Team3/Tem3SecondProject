package com.sist.mapper;

import java.util.*;
import com.sist.vo.*;
import org.apache.ibatis.annotations.Select;

public interface ProductMapper {
	@Select("SELECT no,area_size,price,floor,construction_date,"
			+"address,bunji,name,road_name,deal_type,agent_seat,contract_date "
			+"FROM apartment_3 "
			+"WHERE no=#{no}")
	public ApartmentVO apartmentDetailData(int no);
	
	@Select("SELECT no,area_size,price,floor,construction_year,"
			+"address,bunji,name,road_name,deal_type,agent_seat,constract_date "
			+"FROM officetel_3 "
			+"WHERE no=#{no}")
	public OfficetelVO officetelDetailData(int no);
	
	@Select("SELECT no,area_size,landarea_size,price,floor,construction_year,"
			+"address,bunji,name,road_name,deal_type,agent_seat,constract_date "
			+"FROM villa_3 "
			+"WHERE no=#{no}")
	public VillaVO villaDetailData(int no);
	
	// 아파트 거래일자 개수 _ 그래프 이용
	@Select("SELECT COUNT(*) FROM apartment_3 "
			+"WHERE name=#{name} AND contract_date BETWEEN TO_DATE('2022-01-01','yyyy-mm-dd') and TO_DATE('2022-01-31','yyyy-mm-dd')")
	public int apartment_ACount(String name);
	@Select("SELECT COUNT(*) FROM apartment_3 "
			+"WHERE name=#{name} AND contract_date BETWEEN TO_DATE('2022-02-01','yyyy-mm-dd') and TO_DATE('2022-02-28','yyyy-mm-dd')")
	public int apartment_BCount(String name);
	@Select("SELECT COUNT(*) FROM apartment_3 "
			+"WHERE name=#{name} AND contract_date BETWEEN TO_DATE('2022-03-01','yyyy-mm-dd') and TO_DATE('2022-03-31','yyyy-mm-dd')")
	public int apartment_CCount(String name);
	
	// 오피스텔 거래일자 개수 _ 그래프 이용
	@Select("SELECT COUNT(*) FROM officetel_3 "
			+"WHERE name=#{name} AND contract_date BETWEEN TO_DATE('2022-01-01','yyyy-mm-dd') and TO_DATE('2022-01-31','yyyy-mm-dd')")
	public int officetel_ACount(String name);
	@Select("SELECT COUNT(*) FROM officetel_3 "
			+"WHERE name=#{name} AND contract_date BETWEEN TO_DATE('2022-02-01','yyyy-mm-dd') and TO_DATE('2022-02-28','yyyy-mm-dd')")
	public int officetel_BCount(String name);
	@Select("SELECT COUNT(*) FROM officetel_3 "
			+"WHERE name=#{name} AND contract_date BETWEEN TO_DATE('2022-03-01','yyyy-mm-dd') and TO_DATE('2022-03-31','yyyy-mm-dd')")
	public int officetel_CCount(String name);
	
	// 빌라 거래일자 개수 _ 그래프 이용
	@Select("SELECT COUNT(*) FROM villa_3 "
			+"WHERE name=#{name} AND contract_date BETWEEN TO_DATE('2022-01-01','yyyy-mm-dd') and TO_DATE('2022-01-31','yyyy-mm-dd')")
	public int villa_ACount(String name);
	@Select("SELECT COUNT(*) FROM villa_3 "
			+"WHERE name=#{name} AND contract_date BETWEEN TO_DATE('2022-02-01','yyyy-mm-dd') and TO_DATE('2022-02-28','yyyy-mm-dd')")
	public int villa_BCount(String name);
	@Select("SELECT COUNT(*) FROM villa_3 "
			+"WHERE name=#{name} AND contract_date BETWEEN TO_DATE('2022-03-01','yyyy-mm-dd') and TO_DATE('2022-03-31','yyyy-mm-dd')")
	public int villa_CCount(String name);
}
