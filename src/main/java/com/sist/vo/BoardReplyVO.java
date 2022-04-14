package com.sist.vo;
import java.util.*;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class BoardReplyVO {
	
	private int no,board_no,heart;
	private String user_id,content,dbday;
	private Date regdate;
	private int group_id,group_step,group_tab,root,depth;
	//출력용
//	private int rNo;
//	private String rUser_id,rContent,rDbday;
	
	
}
