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
}
