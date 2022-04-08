package com.sist.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.io.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sist.dao.ProductlistDAO;
import com.sist.service.ProductlistService;
import com.sist.vo.ApartmentVO;
import com.sist.vo.Criteria;
import com.sist.vo.OfficetelVO;
import com.sist.vo.VillaVO;

import lombok.extern.log4j.Log4j;

@Controller
public class ProductlistController {
	@Autowired
	private ProductlistDAO dao; 
	@Autowired
	private ProductlistService productlistService;
	@GetMapping("product/apartmentlist.do")
	public String apartment_list(String page,Model model)
	{
		if(page==null)
			  page="1"; //default page 
		  int curpage=Integer.parseInt(page);
		  Map map=new HashMap();
		  int rowSize=20;
		  int start=(rowSize*curpage)-(rowSize-1);
		  int end=rowSize*curpage;
		  map.put("start", start);
		  map.put("end", end);
		  
		  List<ApartmentVO> alist=dao.apartmentListData(map);
		  int totalpage=dao.apartmentTotalPage();

		  
		  // 블록 
		  final int BLOCK=10;
		  int startPage=((curpage-1)/BLOCK*BLOCK)+1;
		  int endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
		  if(endPage>totalpage)
			  endPage=totalpage;
		  
		  // JSP 전송 
		  model.addAttribute("curpage", curpage);
		  model.addAttribute("totalpage", totalpage);
		  model.addAttribute("alist", alist);
		  model.addAttribute("startPage", startPage);
		  model.addAttribute("endPage", endPage);
		  return "product/apartmentlist";
	  }
	@GetMapping("product/officetellist.do")
	public String officetel_list(String page,Model model)
	{
		if(page==null)
			  page="1"; //default page 
		  int curpage=Integer.parseInt(page);
		  Map map=new HashMap();
		  int rowSize=20;
		  int start=(rowSize*curpage)-(rowSize-1);
		  int end=rowSize*curpage;
		  map.put("start", start);
		  map.put("end", end);
		  
		  List<OfficetelVO> olist=dao.officetelListData(map);
		  int totalpage=dao.officetelTotalPage();

		  
		  // 블록 
		  final int BLOCK=10;
		  int startPage=((curpage-1)/BLOCK*BLOCK)+1;
		  int endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
		  if(endPage>totalpage)
			  endPage=totalpage;
		  
		  // JSP 전송 
		  model.addAttribute("curpage", curpage);
		  model.addAttribute("totalpage", totalpage);
		  model.addAttribute("olist", olist);
		  model.addAttribute("startPage", startPage);
		  model.addAttribute("endPage", endPage);
		  return "product/officetellist";
	  }
	@GetMapping("product/villalist.do")
	public String villa_list(String page,Model model)
	{
		if(page==null)
			  page="1"; //default page 
		  int curpage=Integer.parseInt(page);
		  Map map=new HashMap();
		  int rowSize=20;
		  int start=(rowSize*curpage)-(rowSize-1);
		  int end=rowSize*curpage;
		  map.put("start", start);
		  map.put("end", end);
		  
		  List<VillaVO> vlist=dao.villaListData(map);
		  int totalpage=dao.villaTotalPage();
		  
		  // 블록 
		  final int BLOCK=10;
		  int startPage=((curpage-1)/BLOCK*BLOCK)+1;
		  int endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
		  if(endPage>totalpage)
			  endPage=totalpage;
		  
		  // JSP 전송 
		  model.addAttribute("curpage", curpage);
		  model.addAttribute("totalpage", totalpage);
		  model.addAttribute("vlist", vlist);
		  model.addAttribute("startPage", startPage);
		  model.addAttribute("endPage", endPage);
		  return "product/villalist";
		 }
	/* 상품 검색 */
	@GetMapping("search")
	public String searchApartment(Criteria cri, Model model)
	{
		System.out.println("cri : " + cri);
		List<ApartmentVO> list= productlistService.getApartmentlist(cri);
		System.out.println("pre list: "+ list);
		if(!list.isEmpty()) {
			model.addAttribute("list", list);
			System.out.println("list : "+ list);
		}else {
			model.addAttribute("listcheck", "empty");
			return "search";
		}
		
		return "search";
	}
}
