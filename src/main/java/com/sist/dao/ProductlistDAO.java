package com.sist.dao;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.ProductlistMapper;
import com.sist.vo.ApartmentVO;
import com.sist.vo.OfficetelVO;
import com.sist.vo.VillaVO;


@Repository
public class ProductlistDAO {
	@Autowired
	private ProductlistMapper mapper;
	
	public ApartmentVO apartmentListData(int no)
	{
		return mapper.apartmentListData(no);
	}
	public OfficetelVO officetelListData(int no)
	{
		return mapper.officetelListData(no);
	}
	public VillaVO villaListData(int no)
	{
		return mapper.villaListData(no);
	}
}
