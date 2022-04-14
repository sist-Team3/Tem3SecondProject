package com.sist.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.BoardReplyVO;

public interface BoardReplyMapper {
	//댓글 목록
	@Select("SELECT no,user_id,content,TO_CHAR(regdate,'YYYY-MM-DD HH24:MI:SS') as dbday,heart,group_tab,num "
			+"FROM (SELECT no,user_id,content,regdate,heart,group_tab,rownum as num "
			+"FROM (SELECT no,user_id,content,regdate,heart,group_tab "
			+"FROM board_reply_3 "
			+"WHERE board_no=#{board_no} "
			+"ORDER BY group_id DESC,group_step ASC)) "
			+"WHERE num BETWEEN #{start} AND #{end}")
	public List<BoardReplyVO> boardReplyListData(Map map);
	@Select("SELECT CEIL(COUNT(*)/5.0) FROM board_reply_3 WHERE board_no=#{board_no}")///////////WHERE절 추가 //////////////////수정1
	public int boardReplyTotalPage(int board_no);
	//댓글 등록
	@Insert("INSERT INTO board_reply_3(no,user_id,board_no,content,group_id) "
			+"VALUES(br_no_seq_3.nextval,#{user_id},#{board_no},#{content},"
			+"(SELECT NVL(MAX(group_id)+1,1) FROM board_reply_3))")
	public void replyInsert(BoardReplyVO vo);
	//댓글 수정
	@Update("UPDATE board_reply_3 SET "
			+"content=#{content} "
			+"WHERE no=#{no}")
	public void replyUpdate(BoardReplyVO vo);
	
	
	
	//##################################################################
	//대댓글 등록
	@Select("SELECT group_id,group_step,group_tab "
			+"FROM board_reply_3 "
			+"WHERE no=#{no}")
	public BoardReplyVO replyParentInfoData(int no);
	//위치변경
	@Update("UPDATE board_reply_3 SET "
			+"group_step=group_step+1 "
			+"WHERE group_id=#{group_id} AND group_step>#{group_step}")
	public void replyGroupStepIncrement(BoardReplyVO vo);
	
	@Insert("INSERT INTO board_reply_3 VALUES("
			+"br_no_seq_3.nextval,#{user_id},#{board_no},#{content},"
			+"SYSDATE,0,#{group_id},#{group_step},#{group_tab},#{root},0)")
	public void replyReplyInsert(BoardReplyVO vo);
	@Update("UPDATE board_reply_3 SET "
			+"depth=depth+1 "
			+"WHERE no=#{no}")
	public void replyDepthIncrement(int no);
	
	//대댓글 삭제
	@Select("SELECT depth,root "
			+"FROM board_reply_3 "
			+"WHERE no=#{no}")
	public BoardReplyVO replyInfoData(int no);
	@Update("UPDATE board_reply_3 SET "
			+"content='작성자가 삭제한 댓글입니다' "
			+"WHERE no=#{no}")
	public void replyDeleteMsg(int no);
	@Delete("DELETE FROM board_reply_3 "
			+"WHERE no=#{no}")
	public void replyDelete(int no);
	@Update("UPDATE board_reply_3 SET "
			+"depth=depth-1 "
			+"WHERE no=#{no}")
	public void replyDepthDecrement(int no);
	
}
