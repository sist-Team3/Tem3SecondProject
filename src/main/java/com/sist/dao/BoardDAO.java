package com.sist.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.BoardMapper;
import com.sist.vo.BoardVO;

@Repository
public class BoardDAO {
	@Autowired
	private BoardMapper mapper;
	//목록
	public List<BoardVO> boardListData(Map map){
		return mapper.boardListData(map);
	}
	//게시물 번호
	public int boardCount() {
		return mapper.boardCount();
	}
	//총페이지
	public int boardTotalPage() {
		return (int)(Math.ceil(mapper.boardCount()/20.0));
	}
	//상세
	public BoardVO boardDetailData(int no) {
		mapper.hitIncrement(no);
		return mapper.boardDetailData(no);
	}
	//비밀번호 확인
	public String boardGetPwd(String user_id) {
		return mapper.boardGetPwd(user_id);
	}
	//추가
	public void boardInsertData(BoardVO vo) {
		mapper.boardInsertData(vo);
		System.out.println("DAOcls_boardInsertData");
	
	}
	//수정
	public void boardUpdate(BoardVO vo) {
		mapper.boardUpdateData(vo);
	}
	
	//삭제
	public void boardDelete(int no) {
		mapper.boardDelete(no);
	}
	
	//내 게시글 수
	public int myBoardCount(String user_id) {
		return mapper.myBoardCount(user_id);
	}
	
	//내 댓글 수
	public int myReplyCount(String user_id) {
		return mapper.myReplyCount(user_id);
	}
}
