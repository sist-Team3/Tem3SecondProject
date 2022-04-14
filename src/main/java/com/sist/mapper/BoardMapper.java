package com.sist.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.*;

public interface BoardMapper {
	
	//게시판 목록
	@Select("SELECT no,user_id,title,content,TO_CHAR(regdate,'YYYY-MM-DD') as dbday,hit,num "
			+"FROM (SELECT no,user_id,title,content,regdate,hit,rownum as num "
			+"FROM (SELECT /*+ INDEX_DESC(freeboard_3 free_no_pk_3)*/no,user_id,title,content,regdate,hit "
			+"FROM freeboard_3)) "
			+"WHERE num BETWEEN #{start} AND #{end}")
	public List<BoardVO> boardListData(Map map);
	//게시물 번호 / 총페이지
	@Select("SELECT COUNT(*) FROM freeboard_3")
	public int boardCount();
	//상세페이지
	@Update("UPDATE freeboard_3 SET "
			+"hit=hit+1 "
			+"WHERE no=#{no}")
	public void hitIncrement(int no);
	@Select("SELECT no,user_id,title,content,TO_CHAR(regdate,'YYYY-MM-DD') as dbday,hit "
			+"FROM freeboard_3 "
			+"WHERE no=#{no}")
	public BoardVO boardDetailData(int no);
	//비밀번호 확인
	@Select("SELECT password FROM user_3 WHERE id=#{id}")
	public String boardGetPwd(String id);
	
	//추가
	@SelectKey(keyProperty = "no",resultType = int.class,before=true,
				statement="SELECT NVL(MAX(no)+1,1) as no FROM freeboard_3")
	@Insert("INSERT INTO freeboard_3(no,user_id,title,content) VALUES("
			+"#{no},#{user_id},#{title},#{content})")
	public void boardInsertData(BoardVO vo);	
	//수정
	@Update("UPDATE freeboard_3 SET "
			+"title=#{title},content=#{content} "
			+"WHERE no=#{no}")
	public void boardUpdateData(BoardVO vo);
	//삭제
	@Delete("DELETE FROM freeboard_3 "
			+"WHERE no=#{no}")
	public void boardDelete(int no);
	
	//비밀번호 확인
//	@Select("SELECT password FROM user_3 WHERE id=#{id}")
//	public String boardGetPwd(String id);
	

	
//	@Insert("INSERT INTO freeboard_3 VALUE("
//			+"#{no},#{user_id},#{title},#{content},SYSDATE,0)")
//	public void boardInsert(BoardVO vo);
	
}
