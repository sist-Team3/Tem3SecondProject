package com.sist.util;

import org.springframework.stereotype.Component;

import com.google.gson.JsonObject;
import com.sist.vo.UserVO;

@Component
public class UserParser {
	
	public UserVO parseUser(String json) {
		JsonObject userObject = com.google.gson.JsonParser.parseString(json)
								   .getAsJsonObject()
								   .get("response")
								   .getAsJsonObject();
		
		String email = userObject.get("email").getAsString();
		String password = userObject.get("id").getAsString();
		String name = userObject.get("name").getAsString();
		
		UserVO user = new UserVO();
		user.setEmail(email);
		user.setPassword(password);
		user.setName(name);
		
		return user;
	}
}
