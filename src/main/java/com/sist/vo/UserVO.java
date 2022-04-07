package com.sist.vo;

import java.util.Date;


import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter @Setter @ToString
public class UserVO {
	
	private String id;
	private String email;
	private String password;
	private String name,dbday,address1;
	private String address2;
	private String userRole;
	private Integer phone,postcode;
	private Date birth,registed_at;
}
