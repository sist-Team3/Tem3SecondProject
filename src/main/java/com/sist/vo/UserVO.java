package com.sist.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class UserVO {
	private String id;
	private String email;
	private String password;
	private String name;
}
