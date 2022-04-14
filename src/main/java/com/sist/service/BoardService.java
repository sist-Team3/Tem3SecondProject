package com.sist.service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

import com.sist.dao.BoardDAO;
import com.sist.vo.BoardReplyVO;
import com.sist.vo.BoardVO;

@Service
public interface BoardService {
	//게시물
	//목록
	public List<BoardVO> boardListData(Map map);
	public int boardCount();
	public int boardTotalPage();
	//상세
	public BoardVO boardDetailData(int no);
	//비밀번호 확인
	public String boardGetPwd(String user_id);
	//추가
	public void boardInsertData(BoardVO vo);
	//수정
	public void boardUpdate(BoardVO vo);
	//삭제
	public void boardDelete(int no);
	//############################################################
	//댓글
	//해당 게시물 댓글리스트
	public List<BoardReplyVO> boardReplyListData(Map map);
	//해당게시물의 댓글 총페이지
	public int boardReplyTotalPage();
	//댓글등록
	public void replyInsert(BoardReplyVO vo);
	//댓글수정
	public void replyUpdate(BoardReplyVO vo);
	//############################################################
	//대댓글 등록
	public void replyReplyInsert(int pno,BoardReplyVO vo);
	//(대)댓글 삭제
	public void replyDelete(int no);
}
