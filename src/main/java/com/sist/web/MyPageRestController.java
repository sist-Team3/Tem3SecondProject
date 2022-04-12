package com.sist.web;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.sist.dao.MyPageDAO;
import com.sist.service.UserService;
import com.sist.vo.UserVO;

@RestController
@RequestMapping("mypage/")
public class MyPageRestController {
	@Autowired
	private MyPageDAO dao;
	
	@Autowired
	private UserService uService;
	@Autowired
	private JavaMailSender mailSender;
	
	@GetMapping(value ="mypage_vue.do",produces="text/plain;charset=utf-8")
	public String myPage_main_vue() {
		String result="";
		String email = uService.getLoggedUserName();
		UserVO vo = dao.getUserData(email);
		if(vo.getDbday()==null) {
			Date date=new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String day = sdf.format(date);
			vo.setDbday(day);
			vo.setAddress1(" ");
			vo.setPostcode(12345);
			vo.setPhone("01000000000");
			vo.setAddress1("서울시");
		}
		if(vo.getAddress2()==null) {
			vo.setAddress2("");
		}
		Gson gson = new Gson();
		result=gson.toJson(vo);
		return result;
	}
	@PostMapping(value="mypage_update.do",produces = "text/plain;charset=utf-8")
	public String myPage_update(@RequestBody  UserVO vo) {
		Gson gson = new Gson();
		String email = uService.getLoggedUserName();
		try {
			System.out.println(vo);
			if(vo.getAddress2()==null)
				vo.setAddress2("");
			dao.updateUserData(vo);
			String db_pwd=dao.getPwd(email);
			// 새로운 email로 update가 필요
//			uService.updateLoggedUserName(vo.getEmail(), db_pwd);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return gson.toJson(vo);
	}
	@PostMapping(value="mypage_pwd_update.do",produces = "text/plain;charset=utf-8")
	public String myPage_pwd_update(@RequestBody String pwd) {
		String email = uService.getLoggedUserName();
		String result="";
		Gson gson = new Gson();
		Map<String,Object> map = gson.fromJson(pwd, Map.class);
		// db에서 password 바꿔서 가져오기
		String db_pwd=dao.getPwd(email);
		System.out.println(map.get("now_pwd"));
		if(db_pwd.equals(map.get("now_pwd").toString())) {
			Map<String, Object> cMap = new HashMap<String, Object>();
			cMap.put("pwd",map.get("change_pwd"));
			cMap.put("id","kim1");
			dao.updatePwd(cMap);
			result="YES";
		}else {
			result="NO";
		}
		return result;
	}
	@PostMapping(value="mypage_delete.do",produces = "text/plain;charset=utf-8")
	public String mypage_delete(@RequestBody String pwd,HttpSession session) {
		String result="";
		String email = uService.getLoggedUserName();
		String db_pwd=dao.getPwd(email);
		if(db_pwd.equals(pwd)) {
			dao.deleteUser(email);
			result="YES";
		}else {
			result="NO";
		}
		return result;
	}
	
	@PostMapping(value="sendMail.do",produces = "text/plain;charset=utf-8")
	public String sendMailTest(@RequestBody String email) throws Exception{
		System.out.println("email= "+email);
		/* 인증번호(난수) 생성 */
        Random random = new Random();
        int checkNum = random.nextInt(888888) + 111111;
        
		String subject = "LRoom 이메일 변경 인증번호";
        String from = "LRoom <jim2353@naver.com>";
        String to = email;
        String content = 
                "LRoom을 방문해주셔서 감사합니다." +
                "<br><br>" + 
                "인증 번호는 <strong>" + checkNum + "</strong>입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
        JSONObject obj = new JSONObject();
        try {
            MimeMessage mail = mailSender.createMimeMessage();
            MimeMessageHelper mailHelper = new MimeMessageHelper(mail,true,"UTF-8");
            // true는 멀티파트 메세지를 사용하겠다는 의미
            
            /*
             * 단순한 텍스트 메세지만 사용시엔 아래의 코드도 사용 가능 
             * MimeMessageHelper mailHelper = new MimeMessageHelper(mail,"UTF-8");
             */
            
            mailHelper.setFrom(from);
            // 빈에 아이디 설정한 것은 단순히 smtp 인증을 받기 위해 사용 따라서 보내는이(setFrom())반드시 필요
            mailHelper.setTo(to);
            mailHelper.setSubject(subject);
            mailHelper.setText(content, true);
            // true는 html을 사용하겠다는 의미입니다.
            
            // application-context - <property name="password" value=""/>  value에 비밀번호 넣어야 전송됨
            //mailSender.send(mail); 
            
            obj.put("code",123456);
            
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        return obj.toJSONString();
	}
}
