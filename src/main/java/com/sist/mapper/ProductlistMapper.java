package com.sist.mapper;

import java.util.*;
import com.sist.vo.*;

import org.apache.ibatis.annotations.Select;
import org.junit.platform.suite.api.SelectClasses;

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
	
	// 아파트 상품 검색
	public List<ApartmentVO> getApartmentlist(Criteria cri);
	
	// 아파트 상품 갯수
	public int ApartmentTotal(Criteria cri);
	
    @Select("<script>"
    		+ "SELECT no,area_size,price,floor,address,name,road_name,construction_date,contract_date,num "
				  +"FROM (SELECT no,area_size,price,floor,address,name,road_name,construction_date,contract_date,rownum as num  "
				  +"FROM (SELECT no,area_size,price,floor,address,name,construction_date,contract_date,road_name  "
				  +"FROM apartment_3 "
				  + "<if test=\"optArr.size > 0\">"
				  + "WHERE "
				  + "<trim prefixOverrides=\"OR\">"
				  + "<foreach collection=\"optArr\" item=\"opt\">"
				  + "<trim prefix=\"OR\">"
				  + "<choose>"
				  + "<when test=\"opt=='지역'.toString()\">"
				  + " address LIKE '%'||#{fd}||'%'"
				  + "</when>"
				  + "<when test=\"opt=='도로명주소'.toString()\">"
				  + " road_name LIKE '%'||#{fd}||'%'"
				  + "</when>"
				  + "<when test=\"opt=='매물명'.toString()\">"
				  + " name LIKE '%'||#{fd}||'%'"
				  + "</when>"
				  + "</choose>"
				  + "</trim>"
				  + "</foreach>"
				  + "</trim>"
				  + "</if>"
				  + " ORDER BY "
				  + "<trim suffix=\")) \">"
				  + "<choose>"
				  + "<when test=\"sort=='price'.toString()\">"
				  + "price DESC"
				  + "</when>"
				  + "<when test=\"sort=='construction'.toString()\">"
				  + "construction_date DESC"
				  + "</when>"
				  + "<when test=\"sort=='size'.toString()\">"
				  + "area_size DESC"
				  + "</when>"
				  + "<when test=\"sort=='contract'.toString()\">"
				  + "contract_date DESC"
				  + "</when>"
				  + "</choose>"
				  + "</trim>"
				  +"WHERE num BETWEEN #{start} AND #{end}"
				  + "</script>")
    public List<ApartmentVO> apartmentFindData(Map map);
    
	@Select("<script>"
			+ "SELECT COUNT(*)"
			+ "FROM apartment_3 "
			+ "<if test=\"optArr.size > 0\">"
			  + "WHERE "
			  + "<trim prefixOverrides=\"OR\">"
			  + "<foreach collection=\"optArr\" item=\"opt\">"
			  + "<trim prefix=\"OR\">"
			  + "<choose>"
			  + "<when test=\"opt=='지역'.toString()\">"
			  + " address LIKE '%'||#{fd}||'%'"
			  + "</when>"
			  + "<when test=\"opt=='도로명주소'.toString()\">"
			  + " road_name LIKE '%'||#{fd}||'%'"
			  + "</when>"
			  + "<when test=\"opt=='매물명'.toString()\">"
			  + " name LIKE '%'||#{fd}||'%'"
			  + "</when>"
			  + "</choose>"
			  + "</trim>"
			  + "</foreach>"
			  + "</trim>"
			  + "</if>"
			  + "</script>")
	public int apartmentFindTotalCount(Map map);
	// 아파트 지도로 찾기
	@Select("SELECT no,area_size,price,floor,address,name,road_name,construction_date,contract_date,num "
			+ "FROM (SELECT no,area_size,price,floor,address,name,road_name,construction_date,contract_date "
			+ "FROM apartment3"
			+ "WHERE address LIKE '%'||#{address}||'%' "
			+ "WHERE rownum<=20")
	public List<ApartmentVO> apartmentMapFindData(String address);
	
	// 오피스텔 상품 검색
	public List<OfficetelVO> getOfficetellist(Criteria cri);
	
	// 오피스텔 상품 갯수
	public int OfficetelTotal(Criteria cri);
	
	@Select("<script>"
			+ "SELECT no,area_size,price,floor,address,name,road_name,construction_year,contract_date,num "
			+"FROM (SELECT no,area_size,price,floor,address,name,road_name,construction_year,contract_date,rownum as num  "
			+"FROM (SELECT no,area_size,price,floor,address,name,construction_year,contract_date,road_name  "
			+"FROM officetel_3 "
			+ "<if test=\"optArr.size > 0\">"
			+ "WHERE "
			+ "<trim prefixOverrides=\"OR\">"
			+ "<foreach collection=\"optArr\" item=\"opt\">"
			+ "<trim prefix=\"OR\">"
			+ "<choose>"
			+ "<when test=\"opt=='지역'.toString()\">"
			+ " address LIKE '%'||#{fd}||'%'"
			+ "</when>"
			+ "<when test=\"opt=='도로명주소'.toString()\">"
			+ " road_name LIKE '%'||#{fd}||'%'"
			+ "</when>"
			+ "<when test=\"opt=='매물명'.toString()\">"
			+ " name LIKE '%'||#{fd}||'%'"
			+ "</when>"
			+ "</choose>"
			+ "</trim>"
			+ "</foreach>"
			+ "</trim>"
			+ "</if>"
			+ " ORDER BY "
			+ "<trim suffix=\")) \">"
			+ "<choose>"
			+ "<when test=\"sort=='price'.toString()\">"
			+ "price DESC"
			+ "</when>"
			+ "<when test=\"sort=='construction'.toString()\">"
			+ "construction_date DESC"
			+ "</when>"
			+ "<when test=\"sort=='size'.toString()\">"
			+ "area_size DESC"
			+ "</when>"
			+ "<when test=\"sort=='contract'.toString()\">"
			+ "contract_date DESC"
			+ "</when>"
			+ "</choose>"
			+ "</trim>"
			+"WHERE num BETWEEN #{start} AND #{end}"
			+ "</script>")
	public List<OfficetelVO> officetelFindData(Map map);
	
	@Select("<script>"
			+ "SELECT COUNT(*)"
			+ "FROM officetel_3 "
			+ "<if test=\"optArr.size > 0\">"
			+ "WHERE "
			+ "<trim prefixOverrides=\"OR\">"
			+ "<foreach collection=\"optArr\" item=\"opt\">"
			+ "<trim prefix=\"OR\">"
			+ "<choose>"
			+ "<when test=\"opt=='지역'.toString()\">"
			+ " address LIKE '%'||#{fd}||'%'"
			+ "</when>"
			+ "<when test=\"opt=='도로명주소'.toString()\">"
			+ " road_name LIKE '%'||#{fd}||'%'"
			+ "</when>"
			+ "<when test=\"opt=='매물명'.toString()\">"
			+ " name LIKE '%'||#{fd}||'%'"
			+ "</when>"
			+ "</choose>"
			+ "</trim>"
			+ "</foreach>"
			+ "</trim>"
			+ "</if>"
			+ "</script>")
	public int officetelFindTotalCount(Map map);
	// 오피스텔 지도로 찾기
	@Select("SELECT no,area_size,price,floor,address,name,road_name,construction_year,contract_date,num "
			+ "FROM (SELECT no,area_size,price,floor,address,name,road_name,construction_year,contract_date "
			+ "FROM apartment3"
			+ "WHERE address LIKE '%'||#{address}||'%' "
			+ "WHERE rownum<=20")
	public List<OfficetelVO> officetelMapFindData(String address);
	// 빌라 상품 검색
	public List<VillaVO> getvillalist(Criteria cri);
	
	// 빌라 상품 갯수
	public int villaTotal(Criteria cri);
	
	@Select("<script>"
			+ "SELECT no,area_size,price,floor,address,name,road_name,construction_year,contract_date,num "
			+"FROM (SELECT no,area_size,price,floor,address,name,road_name,construction_year,contract_date,rownum as num  "
			+"FROM (SELECT no,area_size,price,floor,address,name,construction_year,contract_date,road_name  "
			+"FROM villa_3 "
			+ "<if test=\"optArr.size > 0\">"
			+ "WHERE "
			+ "<trim prefixOverrides=\"OR\">"
			+ "<foreach collection=\"optArr\" item=\"opt\">"
			+ "<trim prefix=\"OR\">"
			+ "<choose>"
			+ "<when test=\"opt=='지역'.toString()\">"
			+ " address LIKE '%'||#{fd}||'%'"
			+ "</when>"
			+ "<when test=\"opt=='도로명주소'.toString()\">"
			+ " road_name LIKE '%'||#{fd}||'%'"
			+ "</when>"
			+ "<when test=\"opt=='매물명'.toString()\">"
			+ " name LIKE '%'||#{fd}||'%'"
			+ "</when>"
			+ "</choose>"
			+ "</trim>"
			+ "</foreach>"
			+ "</trim>"
			+ "</if>"
			+ " ORDER BY "
			+ "<trim suffix=\")) \">"
			+ "<choose>"
			+ "<when test=\"sort=='price'.toString()\">"
			+ "price DESC"
			+ "</when>"
			+ "<when test=\"sort=='construction'.toString()\">"
			+ "construction_date DESC"
			+ "</when>"
			+ "<when test=\"sort=='size'.toString()\">"
			+ "area_size DESC"
			+ "</when>"
			+ "<when test=\"sort=='contract'.toString()\">"
			+ "contract_date DESC"
			+ "</when>"
			+ "</choose>"
			+ "</trim>"
			+"WHERE num BETWEEN #{start} AND #{end}"
			+ "</script>")
	public List<VillaVO> villaFindData(Map map);
	
	@Select("<script>"
			+ "SELECT COUNT(*)"
			+ "FROM villa_3 "
			+ "<if test=\"optArr.size > 0\">"
			+ "WHERE "
			+ "<trim prefixOverrides=\"OR\">"
			+ "<foreach collection=\"optArr\" item=\"opt\">"
			+ "<trim prefix=\"OR\">"
			+ "<choose>"
			+ "<when test=\"opt=='지역'.toString()\">"
			+ " address LIKE '%'||#{fd}||'%'"
			+ "</when>"
			+ "<when test=\"opt=='도로명주소'.toString()\">"
			+ " road_name LIKE '%'||#{fd}||'%'"
			+ "</when>"
			+ "<when test=\"opt=='매물명'.toString()\">"
			+ " name LIKE '%'||#{fd}||'%'"
			+ "</when>"
			+ "</choose>"
			+ "</trim>"
			+ "</foreach>"
			+ "</trim>"
			+ "</if>"
			+ "</script>")
	public int villaFindTotalCount(Map map);
	// 빌라 지도로 찾기
	@Select("SELECT no,area_size,price,floor,address,name,road_name,construction_year,contract_date,num "
			+ "FROM (SELECT no,area_size,price,floor,address,name,road_name,construction_year,contract_date "
			+ "FROM apartment3"
			+ "WHERE address LIKE '%'||#{address}||'%' "
			+ "WHERE rownum<=20")
	public List<VillaVO> villaMapFindData(String address);
	 
}
