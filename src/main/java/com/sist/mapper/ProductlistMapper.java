package com.sist.mapper;

import java.util.*;
import com.sist.vo.*;

import org.apache.ibatis.annotations.Select;

public interface ProductlistMapper {
	/*
	 * @Select("SELECT no,area_size,price,floor" +
	 * "address,name,road_name,construct_date" + "FROM apartment_3" +
	 * "WHERE no=#{no}") public ApartmentVO apartmentListData(String address,String
	 * road_name);
	 * 
	 * @Select("SELECT no,area_size,price,floor" +
	 * "address,name,road_name,construct_date" + "FROM officetel_3" +
	 * "WHERE no=#{no}") public OfficetelVO officetelListData(String address,String
	 * road_name);
	 * 
	 * @Select("SELECT no,area_size,price,floor" +
	 * "address,name,road_name,construct_date" + "FROM villa_3" + "WHERE no=#{no}")
	 * public VillaVO villaListData(String address,String road_name);
	 */
	@Select("SELECT no,area_size,price,floor,address,name,road_name,construction_date,contract_date,num "
			+ "FROM (SELECT no,area_size,price,floor,address,name,road_name,construction_date,contract_date,rownum as num "
			+ "FROM (SELECT /*+INDEX_ASC(apartment_3 apt_no_pk_3)*/no,area_size,price,floor,address,name,construction_date,contract_date,road_name "
			+ "FROM apartment_3))" + "WHERE num BETWEEN #{start} AND #{end}")
	public List<ApartmentVO> apartmentListData(Map map);

	@Select("SELECT no,area_size,price,floor,address,name,road_name,construction_year,contract_date,num "
			+ "FROM (SELECT no,area_size,price,floor,address,name,road_name,construction_year,contract_date,rownum as num "
			+ "FROM (SELECT /*+INDEX_ASC(officetel_3 officetel_no_pk_3)*/no,area_size,price,floor,address,name,construction_year,contract_date,road_name "
			+ "FROM officetel_3))" + "WHERE num BETWEEN #{start} AND #{end}")
	public List<OfficetelVO> officetelListData(Map map);

	@Select("SELECT no,area_size,price,floor,address,name,road_name,construction_year,contract_date,num "
			+ "FROM (SELECT no,area_size,price,floor,address,name,road_name,construction_year,contract_date,rownum as num "
			+ "FROM (SELECT /*+INDEX_ASC(villa_3 villa_no_pk_3)*/no,area_size,price,floor,address,name,construction_year,contract_date,road_name "
			+ "FROM villa_3))" + "WHERE num BETWEEN #{start} AND #{end}")
	public List<VillaVO> villaListData(Map map);

	@Select("SELECT CEIL(COUNT(*)/20.0) FROM apartment_3")
	public int apartmentTotalPage();

	@Select("SELECT CEIL(COUNT(*)/20.0) FROM officetel_3")
	public int officetelTotalPage();

	@Select("SELECT CEIL(COUNT(*)/20.0) FROM villa_3")
	
	public int villaTotalPage();
	@Select("SELECT COUNT(*) FROM apartment_3") 
	public int apartmentCount();
	 
	@Select("SELECT COUNT(*) FROM officetel_3") 
	public int officetelCount();
	
	@Select("SELECT COUNT(*) FROM villa_3") 
	public int villaCount();
	
	// 상품 검색
	public List<ApartmentVO> getApartmentlist(Criteria cri);
	
	//상품 갯수
	public int ApartmentTotal(Criteria cri);
	
    @Select("SELECT no,area_size,price,floor,address,name,road_name,construction_date,contract_date,num "
				  +"FROM (SELECT no,area_size,price,floor,address,name,road_name,construction_year,contract_date,rownum as num  "
				  +"FROM (SELECT /*+INDEX_ASC(apartment_3 apt_no_pk_3)*/no,area_size,price,floor,address,name,construction_date,contract_date,road_name  "
				  +"FROM apartment_3 "
				  +"WHERE address LIKE '%'||#{fd}||'%')) "
				  +"WHERE num BETWEEN #{start} AND #{end}")
    // #{address} => map.get("address")
    public List<ApartmentVO> apartmentFindData(Map map);
	@Select("SELECT CEIL(COUNT(*)/20.0"
			+ "FROM apartment_3"
			+ "WHERE address LIKE '%'||#{fd}||'%'")
	public int apartmentFindTotalpage(String fd);
	
	 
}
