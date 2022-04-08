package com.sist.service;
import java.util.*;

import com.sist.vo.ApartmentVO;
import com.sist.vo.Criteria;
public interface ProductlistService {
	
	public List<ApartmentVO> getApartmentlist(Criteria cri);
	
	public int ApartmentTotal(Criteria cri);
}
