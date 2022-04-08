package com.sist.service;

import java.util.*;
import com.sist.mapper.*;
import com.sist.service.*;
import com.sist.vo.ApartmentVO;
import com.sist.vo.Criteria;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.java.Log;
import lombok.extern.log4j.Log4j;
import lombok.extern.log4j.Log4j2;

@Service
public class ProductlistServiceImpl implements ProductlistService{
	@Autowired
	private ProductlistMapper productlistMapper;

	@Override
	public List<ApartmentVO> getApartmentlist(Criteria cri) {
		// TODO Auto-generated method stub
		System.out.println("getApartmentlist()..............");
		return productlistMapper.getApartmentlist(cri);
	}

	@Override
	public int ApartmentTotal(Criteria cri) {
		System.out.println("ApartmentTotal()......");
		return productlistMapper.ApartmentTotal(cri);
		
	}
	
	
}
