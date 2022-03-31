package com.sist.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sist.dao.MyPageDAO;

@Controller
@RequestMapping("mypage")
public class MypageController {
	@Autowired
	private MyPageDAO dao;
	
	@GetMapping("/main.do")
	public String mypage_main(Model model) {
		
		return"mypage/mypage";
	}
}
