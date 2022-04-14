package com.sist.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sist.service.BoardService;
import com.sist.vo.BoardVO;

@Controller
/* @RequestMapping("board/") */
public class BoardController {
	@Autowired
	private BoardService service;
	
	@GetMapping("board/board.do")
	public String board_board(String page,Model model,HttpSession session) {
		try {
			if(page==null)
				page="1";
			int curpage=Integer.parseInt(page);
			int rowSize=20;
			int start=(curpage*rowSize)-(rowSize-1);
			int end=curpage*rowSize;
			
			//페이지번호
			final int BLOCK=5;
			int startPage=((curpage-1)/BLOCK*BLOCK)+1;
			int endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
			int count=service.boardCount();
			count=count-((curpage*rowSize)-rowSize);
			int totalpage=service.boardTotalPage();
			if(endPage>totalpage)
				endPage=totalpage;
			
			
			Map map=new HashMap();
			map.put("start", start);
			map.put("end", end);
			List<BoardVO> bList=service.boardListData(map);
			
			model.addAttribute("bList",bList);
			model.addAttribute("curpage",curpage);
			model.addAttribute("count",count);
			model.addAttribute("totalpage",totalpage);
			model.addAttribute("startPage",startPage);
			model.addAttribute("endPage",endPage);
		}catch(Exception ex) {}
		
		return "board/board";
	}
	
	@GetMapping("board/board_detail.do")
	public String board_detail(int no,Model model) {
		System.out.println("Controller_상세 no: "+no);
		//vueJS로 구현 => RestController
//		BoardVO vo=service.boardDetailData(no);
//		model.addAttribute("vo",vo);
		model.addAttribute("no",no);
		
		return "board/board_detail";
	}
	
	//글쓰기****
	@GetMapping("board/board_insert.do")
	public String board_insert() {
		
		return "board/board_insert";
	}
	//수정
	@GetMapping("board/board_update.do")
	public String board_update(int no,Model model){
	System.out.println("Controller_수정 no: "+no);
//	   BoardVO vo=service.boardDetailData(no);
//	   model.addAttribute("vo",vo);
		model.addAttribute("no",no);
		return "board/board_update";
	}
	//삭제
//	@GetMapping("board/board_delete.do")
//	public String board_delete(int no,Model model) {
//		System.out.println("Controller_삭제  no: "+no);
//		service.boardDelete(no);
//		//return "board/board";
//		return "board/board_delete";
//	}
	
	
	
}
