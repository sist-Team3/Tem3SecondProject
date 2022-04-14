package com.sist.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.sist.dao.ProductlistDAO;

@Controller
public class ProductlistController {
	@Autowired
	private ProductlistDAO dao; 
	
	@GetMapping("product/apartmentlist.do")
	public String apartment_list(String fd,Model model){
		  // JSP 전송 
		  model.addAttribute("fd", fd);
		  return "product/apartmentlist";
	  }
	@GetMapping("product/officetellist.do")
	public String officetel_list(String fd,Model model){
		model.addAttribute("fd", fd);
		  return "product/officetellist";
	  }
	@GetMapping("product/villalist.do")
	public String villa_list(String fd,Model model){
		model.addAttribute("fd", fd);
		  return "product/villalist";
	}

}
