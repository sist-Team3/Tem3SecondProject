package com.sist.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@CrossOrigin(origins="*")
public class MainController {
	@GetMapping("main/main.do")
	public String main_main() {
		return "main";
	}
	@GetMapping("news/main.do")
	public String news_main() {
		return "news/news";
	}
}
