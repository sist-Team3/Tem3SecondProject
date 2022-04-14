package com.sist.vo;

import lombok.Getter;
import lombok.Setter;
import java.util.*;

@Setter
@Getter
public class BoardVO {

	private int no,hit,count;
	private String user_id,title,content,dbday;
	private Date regdate;
}
