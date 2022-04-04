package com.sist.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.sist.dao.ProductlistDAO;

@Controller
public class ProductlistController {
	@Autowired
	private ProductlistDAO dao; 
}
