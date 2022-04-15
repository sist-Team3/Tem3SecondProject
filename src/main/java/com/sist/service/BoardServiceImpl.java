package com.sist.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.vo.BoardReplyVO;
import com.sist.vo.BoardVO;
import com.sist.dao.*;

@Service
public class BoardServiceImpl implements BoardService{
	@Autowired
	private BoardDAO dao;
	@Autowired
	private BoardReplyDAO rdao;

	//게시물
	@Override
	public List<BoardVO> boardListData(Map map) {
		// TODO Auto-generated method stub
		return dao.boardListData(map);
	}

	@Override
	public int boardCount() {
		// TODO Auto-generated method stub
		return dao.boardCount();
	}

	@Override
	public int boardTotalPage() {
		// TODO Auto-generated method stub
		return dao.boardTotalPage();
	}

	@Override
	public BoardVO boardDetailData(int no) {
		// TODO Auto-generated method stub
		return dao.boardDetailData(no);
	}

	@Override
	public String boardGetPwd(String user_id) {
		// TODO Auto-generated method stub
		return dao.boardGetPwd(user_id);
	}

	@Override
	public void boardInsertData(BoardVO vo) {
		// TODO Auto-generated method stub
		dao.boardInsertData(vo);
	}

	@Override
	public void boardUpdate(BoardVO vo) {
		// TODO Auto-generated method stub
		dao.boardUpdate(vo);
	}

	@Override
	public void boardDelete(int no) {
		// TODO Auto-generated method stub
		dao.boardDelete(no);
	}
	//########################################################
	//댓글

	@Override
	public List<BoardReplyVO> boardReplyListData(Map map) {
		// TODO Auto-generated method stub
		return rdao.boardReplyListData(map);
	}

	@Override
	public int boardReplyTotalPage(int board_no) {
		// TODO Auto-generated method stub
		return rdao.boardReplyTotalPage(board_no);
	}

	@Override
	public void replyInsert(BoardReplyVO vo) {
		// TODO Auto-generated method stub
		rdao.replyInsert(vo);
	}

	@Override
	public void replyUpdate(BoardReplyVO vo) {
		// TODO Auto-generated method stub
		rdao.replyUpdate(vo);
	}
	
	
	@Override
	public void replyReplyInsert(int pno,BoardReplyVO vo) {
		// TODO Auto-generated method stub
		rdao.replyReplyInsert(pno, vo);
	}


	@Override
	public void replyDelete(int no) {
		// TODO Auto-generated method stub
		rdao.replyDelete(no);
	}

	@Override
	public int myBoardCount(String user_id) {
		// TODO Auto-generated method stub
		return dao.myBoardCount(user_id);
	}

	@Override
	public int myReplyCount(String user_id) {
		// TODO Auto-generated method stub
		return dao.myReplyCount(user_id);
	}



}
