package com.sist.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

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
		int price=vo.getPrice();
		int p1=price/10000;
		int p2=price-p1*10000;
		
		int area_size1=vo.getArea_size();
		int area_size2=(area_size1*3025)/10000;
		
		model.addAttribute("vo", vo);
		model.addAttribute("p1", p1);
		model.addAttribute("p2", p2);
		model.addAttribute("area_size2", area_size2);
		return "product/apartmentDetail";
	}
}
