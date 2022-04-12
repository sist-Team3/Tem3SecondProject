package com.sist.web;

import org.hamcrest.core.SubstringMatcher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.text.SimpleDateFormat;
import java.util.*;
import com.sist.vo.*;
import com.sist.dao.*;

@Controller
public class ProductController {
	@Autowired
	private ProductDAO dao;
	
	@GetMapping("product/apartmentDetail.do")
	public String apartmetDetail(int no,Model model)
	{
		ApartmentVO vo=dao.apartmentDetailData(no);
		
		// 거래금액 억단위 변경
		int price=vo.getPrice();
		int p1=price/10000;
		int p2=price-p1*10000;
		
		// 면적 유형 = 제곱미터 & 평수 
		int area_size1=vo.getArea_size();
		int area_size2=(area_size1*3025)/10000;
		
		// 거래일자 YY/MM/DD 에서 YY년MM월DD일 변경
		Date contract_date=vo.getContract_date();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy년 MM월 dd일");
		String c_date=simpleDateFormat.format(contract_date);
		
		
		// 주소 연결
		String addr_B=vo.getAddress()+vo.getBunji();
		String addr_R=vo.getAddress()+vo.getRoad_name();
		
		// 월별 계약건수
		int ACount=dao.apartment_ACount(vo.getName());
		int BCount=dao.apartment_BCount(vo.getName());
		int CCount=dao.apartment_CCount(vo.getName());
		
		model.addAttribute("vo", vo);
		model.addAttribute("p1", p1);
		model.addAttribute("p2", p2);
		model.addAttribute("area_size1", area_size1);
		model.addAttribute("area_size2", area_size2);
		model.addAttribute("addr_B", addr_B);
		model.addAttribute("addr_R", addr_R);
		model.addAttribute("c_date", c_date);
		model.addAttribute("ACount", ACount);
		model.addAttribute("BCount", BCount);
		model.addAttribute("CCount", CCount);
		return "product/apartmentDetail";
	}
}
