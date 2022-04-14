package com.sist.dao;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.MarkMapper;
import com.sist.vo.*;

@Repository
public class MarkDAO {
	@Autowired
	private MarkMapper mapper;
	
	public List<ApartmentVO> apartmentMarkList(int ano)
	{
		return mapper.apartmentMarkList(ano);
	}
	public List<OfficetelVO> officetelMarkList(int ono)
	{
		return mapper.officetelMarkList(ono);
	}
	public List<VillaVO> villaMarkList(int vno)
	{
		return mapper.villaMarkList(vno);
	}
	
	public void insertMark()
	{
		mapper.insertMark();
	}
	public void deleteMark()
	{
		mapper.deleteMark();
	}
}
