package com.sist.mapper;

import java.util.*;
import com.sist.vo.*;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

public interface ProductMapper {
	// 아파트
	@Select("SELECT no,area_size,price,floor,construction_date,"
			+"address,bunji,name,road_name,deal_type,agent_seat,contract_date "
			+"FROM apartment_3 "
			+"WHERE no=#{no}")
	public ApartmentVO apartmentDetailData(int no);
	
	// 아파트 거래일자 개수 _ 그래프 이용
	@Select("SELECT COUNT(*) FROM apartment_3 "
			+"WHERE road_name=#{road_name} AND contract_date BETWEEN TO_DATE('2022-01-01','yyyy-mm-dd') and TO_DATE('2022-01-31','yyyy-mm-dd')")
	public int apartment_ACount(String road_name);
	@Select("SELECT COUNT(*) FROM apartment_3 "
			+"WHERE road_name=#{road_name} AND contract_date BETWEEN TO_DATE('2022-02-01','yyyy-mm-dd') and TO_DATE('2022-02-28','yyyy-mm-dd')")
	public int apartment_BCount(String road_name);
	@Select("SELECT COUNT(*) FROM apartment_3 "
			+"WHERE road_name=#{road_name} AND contract_date BETWEEN TO_DATE('2022-03-01','yyyy-mm-dd') and TO_DATE('2022-03-31','yyyy-mm-dd')")
	public int apartment_CCount(String road_name);
	
	// 이름같은 매물
	@Select("SELECT no,area_size,price,floor,address,name,road_name,construction_date,contract_date,deal_type "
			+ "FROM apartment_3 WHERE road_name=#{road_name}")
	public List<ApartmentVO> apartmentSameData(String road_name);
	
	
	
	// 오피스텔
	@Select("SELECT no,area_size,price,floor,construction_year,"
			+"address,bunji,name,road_name,deal_type,agent_seat,contract_date "
			+"FROM officetel_3 "
			+"WHERE no=#{no}")
	public OfficetelVO officetelDetailData(int no);
	
	// 오피스텔 거래일자 개수 _ 그래프 이용
	@Select("SELECT COUNT(*) FROM officetel_3 "
			+"WHERE road_name=#{road_name} AND contract_date BETWEEN TO_DATE('2022-01-01','yyyy-mm-dd') and TO_DATE('2022-01-31','yyyy-mm-dd')")
	public int officetel_ACount(String road_name);
	@Select("SELECT COUNT(*) FROM officetel_3 "
			+"WHERE road_name=#{road_name} AND contract_date BETWEEN TO_DATE('2022-02-01','yyyy-mm-dd') and TO_DATE('2022-02-28','yyyy-mm-dd')")
	public int officetel_BCount(String road_name);
	@Select("SELECT COUNT(*) FROM officetel_3 "
			+"WHERE road_name=#{road_name} AND contract_date BETWEEN TO_DATE('2022-03-01','yyyy-mm-dd') and TO_DATE('2022-03-31','yyyy-mm-dd')")
	public int officetel_CCount(String road_name);
	
	// 이름같은 매물
	@Select("SELECT no,area_size,price,floor,address,name,road_name,construction_year,contract_date,deal_type "
			+ "FROM officetel_3 WHERE road_name=#{road_name}")
	public List<OfficetelVO> officetelSameData(String road_name);
	
	
	
	//빌라
	@Select("SELECT no,area_size,landarea_size,price,floor,construction_year,"
			+"address,bunji,name,road_name,deal_type,agent_seat,contract_date "
			+"FROM villa_3 "
			+"WHERE no=#{no}")
	public VillaVO villaDetailData(int no);
	
	// 빌라 거래일자 개수 _ 그래프 이용
	@Select("SELECT COUNT(*) FROM villa_3 "
			+"WHERE road_name=#{road_name} AND contract_date BETWEEN TO_DATE('2022-01-01','yyyy-mm-dd') and TO_DATE('2022-01-31','yyyy-mm-dd')")
	public int villa_ACount(String road_name);
	@Select("SELECT COUNT(*) FROM villa_3 "
			+"WHERE road_name=#{road_name} AND contract_date BETWEEN TO_DATE('2022-02-01','yyyy-mm-dd') and TO_DATE('2022-02-28','yyyy-mm-dd')")
	public int villa_BCount(String road_name);
	@Select("SELECT COUNT(*) FROM villa_3 "
			+"WHERE road_name=#{road_name} AND contract_date BETWEEN TO_DATE('2022-03-01','yyyy-mm-dd') and TO_DATE('2022-03-31','yyyy-mm-dd')")
	public int villa_CCount(String road_name);
	
	// 이름같은 매물
	@Select("SELECT no,area_size,landarea_size,price,floor,address,name,road_name,construction_year,contract_date,deal_type "
			+ "FROM villa_3 WHERE road_name=#{road_name}")
	public List<VillaVO> villaSameData(String road_name);
	
	
	/*
	 * @Insert("INSERT INTO mark_3 (no,type,email) VALUES ((SELECT NVL(MAX(no)+1,1) FROM mark_3),#{type},#{email})"
	 * ) public void insertMarkApart(Map map);
	 * 
	 * @Select("SELECT count(*) FROM mark_3 WHERE email=#{email} AND type=#{type}")
	 * public int checkMark(Map map);
	 */
}
