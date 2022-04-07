package com.sist.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import java.util.*;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

import jakarta.validation.constraints.NotBlank;

@Getter @Setter @ToString
public class UserVO {
	private String id;
	@Email
	private String email;
	@NotBlank
	private String password;
	@NotBlank
	private String name;
	private String user_role;
	@NotEmpty
	private String address1; 
	private String address2;
	@NotBlank
	private String dbday;
	private int phone;
	private int postcode;
	private Date birth,registed_at;
}
