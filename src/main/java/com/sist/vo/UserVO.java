package com.sist.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import java.util.*;

@Getter @Setter @ToString
public class UserVO {
	private String id;
	private String email;
	private String password;
	private String name, user_role,address1,address2,dbday;
	private int phone,postcode;
	private Date birth,registed_at;
}
