package com.sist.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.sist.dao.MyPageDAO;
import com.sist.vo.UserVO;

@RestController
@RequestMapping("mypage/")
public class MyPageRestController {
	@Autowired
	private MyPageDAO dao;
	
	@GetMapping(value ="mypage_vue.do",produces="text/plain;charset=utf-8")
	public String myPage_main_vue(Model model,HttpSession session) {
		String result="";
		String id = (String)session.getAttribute("id");
		UserVO vo = dao.getUserData("kim1");
		//vo.setId(id);
		vo.setId("kim1");
		Gson gson = new Gson();
		result=gson.toJson(vo);
		
		return result;
	}
	@PostMapping(value="mypage_update.do",produces = "text/plain;charset=utf-8")
	public String myPage_update(@RequestBody String vo) {
			Gson gson = new Gson();
			UserVO uvo = gson.fromJson(vo, UserVO.class);
			if(uvo.getAddress2()==null)
				uvo.setAddress2("");
			dao.updateUserData(uvo);
		return "OK";
	}
	@PostMapping(value="mypage_pwd_update.do",produces = "text/plain;charset=utf-8")
	public String myPage_pwd_update(@RequestBody String pwd,HttpSession session) {
		String result="";
		String id = (String)session.getAttribute("id");
		Gson gson = new Gson();
		Map<String,Object> map = gson.fromJson(pwd, Map.class);
		String db_pwd=dao.getPwd("kim1");
		if(db_pwd.equals(map.get("now_pwd"))) {
			Map cMap = new HashMap();
			cMap.put("pwd",map.get("change_pwd"));
			cMap.put("id","kim1");
			dao.updatePwd(cMap);
			result="YES";
		}else {
			result="NO";
		}
		return result;
	}
}
