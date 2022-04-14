package com.sist.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.sist.mapper.BoardReplyMapper;
import com.sist.vo.BoardReplyVO;

@Repository
public class BoardReplyDAO {
	@Autowired
	private BoardReplyMapper mapper;
	//해당 게시물 댓글리스트
	public List<BoardReplyVO> boardReplyListData(Map map){
		return mapper.boardReplyListData(map);
	}
	//해당 게시물 댓글 총페이지 
	public int boardReplyTotalPage(int board_no) {/////////매개변수추가///수정1
		return mapper.boardReplyTotalPage(board_no);
	}
	//댓글등록
	public void replyInsert(BoardReplyVO vo) {
		mapper.replyInsert(vo);
	}
	//댓글수정
	public void replyUpdate(BoardReplyVO vo) {
		mapper.replyUpdate(vo);
		System.out.println("mapper.update   content: "+vo.getContent());
	}
	//############################################################
	//대댓글 
	//등록
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
	public void replyReplyInsert(int pno,BoardReplyVO vo) {
		BoardReplyVO pvo=mapper.replyParentInfoData(pno);//group_id/step/tab
		
		mapper.replyGroupStepIncrement(pvo);
		
		vo.setGroup_id(pvo.getGroup_id());
		vo.setGroup_step(pvo.getGroup_step()+1);
		vo.setGroup_tab(pvo.getGroup_tab()+1);
		vo.setRoot(pno);
		mapper.replyReplyInsert(vo);
		
		mapper.replyDepthIncrement(pno);
	}
	
	//삭제
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
	public void replyDelete(int no) {
		BoardReplyVO vo=mapper.replyInfoData(no);
		if(vo.getDepth()==0) {
			mapper.replyDelete(no);
		}else {
			mapper.replyDeleteMsg(no);
		}
		mapper.replyDepthDecrement(vo.getRoot());
	}
}
