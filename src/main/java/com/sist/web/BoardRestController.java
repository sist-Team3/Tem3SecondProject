package com.sist.web;


import java.util.*;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.sist.service.BoardService;
import com.sist.vo.BoardReplyVO;
import com.sist.vo.BoardVO;

@RestController
@RequestMapping("board/")
public class BoardRestController {
	
	@Autowired 
	private BoardService service;
	
	//상세 vueJS
	@GetMapping(value="board_detail_vue1.do",produces = "text/plain;charset=utf-8")
	public String board_detail_vue1(int no,HttpSession session) {
		System.out.println("Vue1_RESTCONTROLLER : NO:"+no);//
		String result="";
		try {
			String idCheck="false";
			
			BoardVO vo=service.boardDetailData(no);
			System.out.println("Board vo: "+vo.getNo());//
			String session_id=(String)session.getAttribute("username");
			System.out.println("session_id: "+session_id);//
			if(session_id.equals(vo.getUser_id())) 
				idCheck="true";
			System.out.println("idCheck: "+idCheck);//
			
			JSONObject obj=new JSONObject();
				
			//해당 게시물 상세정보
			obj.put("no",vo.getNo());
			obj.put("user_id",vo.getUser_id());
			obj.put("title",vo.getTitle());
			obj.put("content",vo.getContent());
			obj.put("dbday",vo.getDbday());
			obj.put("hit",vo.getHit());
			obj.put("session_id",session_id);
			obj.put("idCheck",idCheck);
				
			result=obj.toJSONString();
			System.out.println("상세페이지 boardVO : "+result);//
		}catch(Exception ex) {}
		return result;
	}
	// 수정vueJS
	@GetMapping(value="board_update_vue.do",produces = "text/plain;charset=utf-8")
	public String board_update_vue(int no) {
		String result="";
		try {
			BoardVO vo=service.boardDetailData(no);
			JSONObject obj=new JSONObject();
			obj.put("no",vo.getNo());
			obj.put("user_id",vo.getUser_id());
			obj.put("title",vo.getTitle());
			obj.put("content",vo.getContent());
			obj.put("dbday",vo.getDbday());
			obj.put("hit",vo.getHit());
			
			result=obj.toJSONString();
			System.out.println("상세페이지 boardVO : "+result);//
		}catch(Exception ex) {}
		return result;
	}
	//추가
	@GetMapping(value="board_insert_vue.do",produces = "text/plain;charset=utf-8")
	public String board_insert_vue(BoardVO vo) {		
		System.out.println(vo.getUser_id()+"##"+vo.getTitle()+"##"+vo.getContent());//		
		service.boardInsertData(vo);
		String result="Y";
			
		return result;
	}
	//수정
	
	@GetMapping(value="board_update_ok.do",produces = "text/plain;charset=utf-8;")
	public String board_update_ok(BoardVO vo) {
		System.out.println("content: "+vo.getContent());
		System.out.println("title: "+vo.getTitle());
		System.out.println("no: "+vo.getNo());
		System.out.println("user_id: "+vo.getUser_id());
		
		String result="";
		service.boardUpdate(vo);
		result="Y";
		
		return result;
	}
	//삭제... 비번입력 없이 바로 삭제
	@GetMapping(value="board_delete_ok.do",produces = "text/plain;charset=utf-8")
	public String board_delete_ok(int no) {
		String result="";
		service.boardDelete(no);
//		result="<script>location.href=\"../board/board.do\";</script>";
		result="Y";
		
		return result;
	}
	//####################################################################################
	//댓글
	//목록
	@GetMapping(value="board_detail_vue2.do",produces = "text/plain;charset=utf-8")
	public String board_detail_vue2(int no,int page,HttpSession session) {
		System.out.println("Vue2_RESTCONTROLLER : NO:"+no);//
		String result="";
		try {
			   
			String session_id=(String)session.getAttribute("username");
			int curpage=page;
			Map map=new HashMap();
			int rowSize=5;
			int start=(rowSize*curpage)-(rowSize-1);
			int end=rowSize*curpage;
			map.put("start", start);
			map.put("end", end);
			map.put("board_no", no);
			//해당게시물 댓글리스트
			List<BoardReplyVO> rList=service.boardReplyListData(map);
			System.out.println("rList: "+rList.get(0));//
			//해당게시물 댓글 총페이지
			int totalpage=service.boardReplyTotalPage();
			System.out.println("totalpage: "+totalpage);
			JSONArray arr=new JSONArray();
			int i=0;
			for(BoardReplyVO rvo:rList) {
				JSONObject obj=new JSONObject();
				obj.put("no",rvo.getNo());
				obj.put("user_id",rvo.getUser_id().trim());
				obj.put("content",rvo.getContent());
				obj.put("dbday",rvo.getDbday());
				obj.put("heart",rvo.getHeart());
				obj.put("group_tab",rvo.getGroup_tab());
				if(i==0) {
					//댓글 페이지 정보
					obj.put("curpage", curpage);
					obj.put("totalpage", totalpage);
					obj.put("session_id",session_id.trim());
				}
				arr.add(obj);
				i++;
			}
			
			result=arr.toJSONString();
			System.out.println("상세페이지boardReplyList : "+result);//
		}catch(Exception ex) {}
		return result;
	}
	//등록
	@GetMapping(value="board_reply_vue.do",produces = "text/plain;charset=utf-8")
	public String reply_insert_vue(int board_no,String content,String user_id) {
		System.out.println("restCont등록: board_no:"+board_no+" ## content: "+content
							+" ##  user_id(session): "+user_id);//
		
		BoardReplyVO vo=new BoardReplyVO();
		vo.setBoard_no(board_no);
		vo.setUser_id(user_id);
		vo.setContent(content);
		service.replyInsert(vo);
		
		System.out.println("insert vo완료 : "+vo);
		String result="insert 성공";
		
		return result;
	}
	//수정..void
	@GetMapping(value="reply_update_vue.do",produces = "text/plain;charset=utf-8")
	public String reply_update_vue(int no,String content) {
		System.out.println("<수정_RestController> no: "+no+" ## content: "+content);//
		
		BoardReplyVO vo=new BoardReplyVO();
		vo.setNo(no);
		vo.setContent(content);
		service.replyUpdate(vo);
		
		String result="수정완료 no: "+no+"  ## content: "+content;//
		return result;
	}
	//############################################################################
	//대댓글
	//등록
	@GetMapping(value="replyReply_insert_vue.do",produces = "text/plain;charset=utf-8")
	public String replyReply_insert_vue(int board_no,int pno,String content,String user_id) {
		System.out.println("<대댓글 등록_RestController> content: "+content +" ##  pno: "+pno+" ##  user_id: "+user_id);
		
		BoardReplyVO vo=new BoardReplyVO();
		vo.setContent(content);
		vo.setUser_id(user_id);
		vo.setBoard_no(board_no);
		service.replyReplyInsert(pno,vo);
		
		String result="대댓글 등록 완료  no: ";//
		return result;
	}
	//삭제 .. void
	@GetMapping(value="reply_delete_vue.do",produces = "text/plain;charset=utf-8")
	public String reply_delete_vue(int no) {
		System.out.println("<삭제_RestController> no: "+no);
		
		service.replyDelete(no);
		
		String result="삭제 완료  no: "+no;//
		return result;
	}
	
}
