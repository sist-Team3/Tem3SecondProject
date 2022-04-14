package com.sist.dao;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.ProductMapper;
import com.sist.vo.*;

@Repository
public class ProductDAO {
	@Autowired
	private ProductMapper mapper;
	
	//상세정보
	public ApartmentVO apartmentDetailData(int no)
	{
		return mapper.apartmentDetailData(no);
	}
	public OfficetelVO officetelDetailData(int no)
	{
		return mapper.officetelDetailData(no);
	}
	public VillaVO villaDetailData(int no)
	{
		return mapper.villaDetailData(no);
	}
	
	//아파트
	public int apartment_ACount(String road_name)
	{
		return mapper.apartment_ACount(road_name);
	}
	public int apartment_BCount(String road_name)
	{
		return mapper.apartment_BCount(road_name);
	}
	public int apartment_CCount(String road_name)
	{
		return mapper.apartment_CCount(road_name);
	}
	
	public List<ApartmentVO> apartmentSameData(String road_name)
	{
		return mapper.apartmentSameData(road_name);
	}
	
	//오피스텔
	public int officetel_ACount(String road_name)
	{
		return mapper.officetel_ACount(road_name);
	}
	public int officetel_BCount(String road_name)
	{
		return mapper.officetel_BCount(road_name);
	}
	public int officetel_CCount(String road_name)
	{
		return mapper.officetel_CCount(road_name);
	}
	
	public List<OfficetelVO> officetelSameData(String road_name)
	{
		return mapper.officetelSameData(road_name);
	}
	
	//빌라
	public int villa_ACount(String road_name)
	{
		return mapper.villa_ACount(road_name);
	}
	public int villa_BCount(String road_name)
	{
		return mapper.villa_BCount(road_name);
	}
	public int villa_CCount(String road_name)
	{
		return mapper.villa_CCount(road_name);
	}
	
	public List<VillaVO> villaSameData(String road_name)
	{
		return mapper.villaSameData(road_name);
	}
	
	// 즐겨찾기
	public void insertMarkApart(Map map) {
		mapper.insertMarkApart(map);
	}

	
}
