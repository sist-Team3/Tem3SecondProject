package com.sist.dao;
import java.util.*;

import org.apache.ibatis.annotations.Select;
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
	
	/*
	public ApartmentVO apartmentListData(String address,String road_name)
	{
		return mapper.apartmentListData(address,road_name);
	}
	public OfficetelVO officetelListData(String address,String road_name)
	{
		return mapper.officetelListData(address, road_name);
	}
	public VillaVO villaListData(String address, String road_name)
	{
		return mapper.villaListData(address, road_name);
	}
	*/
	public List<ApartmentVO> apartmentListData(Map map)
	{
		return mapper.apartmentListData(map);
	}
	public List<OfficetelVO> officetelListData(Map map)
	{
		return mapper.officetelListData(map);
	}
	public List<VillaVO> villaListData(Map map)
	{
		return mapper.villaListData(map);
	}

	  public int apartmentTotalPage()
	  {
		  return mapper.apartmentTotalPage();
	  }

	  public int officetelTotalPage()
	  {
		  return mapper.officetelTotalPage();
	  }

	  public int villaTotalPage()
	  {
		  return mapper.villaTotalPage();
	  }
	  //아파트
	  public List<ApartmentVO> apartmentFindData(Map map)
	  {
		  return mapper.apartmentFindData(map);
	  }
	  public int apartmentFindTotalcount(Map map)
	  {
		 return mapper.apartmentFindTotalCount(map);
	  }
	  public List<ApartmentVO> apartmentMapFindData(String address)
	  {
		  return mapper.apartmentMapFindData(address);
	  }
	  //오피스텔
	  public List<OfficetelVO> officetelFindData(Map map)
	  {
		  return mapper.officetelFindData(map);
	  }
	  public int officetelFindTotalcount(Map map)
	  {
		  return mapper.officetelFindTotalCount(map);
	  }
	  public List<OfficetelVO> officetelMapFindData(String address)
	  {
		  return mapper.officetelMapFindData(address);
	  }
	  // 빌라
	  public List<VillaVO> villaFindData(Map map)
	  {
		  return mapper.villaFindData(map);
	  }
	  public int villaFindTotalcount(Map map)
	  {
		  return mapper.villaFindTotalCount(map);
	  }
	  public List<VillaVO> villaMapFindData(String address)
	  {
		  return mapper.villaMapFindData(address);
	  }
	  
}
