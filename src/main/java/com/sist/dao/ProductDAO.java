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
	public int apartment_ACount(String name)
	{
		return mapper.apartment_ACount(name);
	}
	public int apartment_BCount(String name)
	{
		return mapper.apartment_BCount(name);
	}
	public int apartment_CCount(String name)
	{
		return mapper.apartment_CCount(name);
	}
	
	//오피스텔
	public int officetel_ACount(String name)
	{
		return mapper.officetel_ACount(name);
	}
	public int officetel_BCount(String name)
	{
		return mapper.officetel_BCount(name);
	}
	public int officetel_CCount(String name)
	{
		return mapper.officetel_CCount(name);
	}
	
	//빌라
	public int villa_ACount(String name)
	{
		return mapper.villa_ACount(name);
	}
	public int villa_BCount(String name)
	{
		return mapper.villa_BCount(name);
	}
	public int villa_CCount(String name)
	{
		return mapper.villa_CCount(name);
	}
}
