package com.sist.web;

import java.text.SimpleDateFormat;
import java.util.*;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.sist.dao.MyPageDAO;
import com.sist.dao.ProductDAO;
import com.sist.service.UserService;
import com.sist.vo.ApartmentVO;
import com.sist.vo.OfficetelVO;
import com.sist.vo.UserVO;
import com.sist.vo.VillaVO;

@RestController
@RequestMapping("mypage/")
public class MyPageRestController {
	@Autowired
	private MyPageDAO dao;
	@Autowired
	private UserService uService;
	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	@Autowired
	private ProductDAO pDao;
	
	@GetMapping(value ="mypage_vue.do",produces="text/plain;charset=utf-8")
	public String myPage_main_vue() {
		String result="";
		String email = uService.getLoggedUserName();
		UserVO vo = dao.getUserData(email);
		if(vo.getDbday()==null) {
			Date date=new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String day = sdf.format(date);
//			vo.setDbday(day);
			vo.setAddress1(" ");
//			vo.setPostcode(12345);
		}
		if(vo.getAddress2()==null) {
			vo.setAddress2("");
		}
		Gson gson = new Gson();
		result=gson.toJson(vo);
		return result;
	}
	@GetMapping(value="mypage_recent.do",produces="text/plain;charset=utf-8" )
	public String mypage_recent(HttpServletRequest req) {
		String result="";
		List<Object> list = new ArrayList<>();
		Cookie[] getCookie=req.getCookies();
		if(getCookie != null) {
			int k=0;
			for(int i=getCookie.length-1;i>=0;i--) {
				if(k>4)
					break;
				if(getCookie[i].getName().startsWith("a") && getCookie[i].getValue()!=null) {
					String value=getCookie[i].getValue();
					ApartmentVO vo = pDao.apartmentDetailData(Integer.parseInt(value));
					vo.setType(1);
					list.add(vo);
					k++;
				}
				if(getCookie[i].getName().startsWith("o") && getCookie[i].getValue()!=null) {
					String value=getCookie[i].getValue();
					OfficetelVO vo = pDao.officetelDetailData(Integer.parseInt(value));
					vo.setType(2);
					list.add(vo);
					k++;
				}
				if(getCookie[i].getName().startsWith("v") && getCookie[i].getValue()!=null) {
					String value=getCookie[i].getValue();
					VillaVO vo = pDao.villaDetailData(Integer.parseInt(value));
					vo.setType(3);
					list.add(vo);
					k++;
				}
			}
		}
		Gson gson = new Gson();
		result = gson.toJson(list);
		return result;
	}
	
	@PostMapping(value="mypage_update.do",produces = "text/plain;charset=utf-8")
	public String myPage_update(@RequestBody  UserVO vo) {
		Gson gson = new Gson();
		String email = uService.getLoggedUserName();
		try {
			if(vo.getAddress2()==null)
				vo.setAddress2("");
			dao.updateUserData(vo);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return gson.toJson(vo);
	}
	@PostMapping(value="mypage_pwd_update.do",produces = "text/plain;charset=utf-8")
	public String myPage_pwd_update(@RequestBody String pwd) {
		String result="";
		String email = uService.getLoggedUserName();
		String u_pwd = uService.updateLoggedUserPassword();
		
		Gson gson = new Gson();
		Map<String,Object> map = gson.fromJson(pwd, Map.class);
		String now_pwd = map.get("now_pwd").toString();
		String change_pwd = map.get("change_pwd").toString();
		
		if(passwordEncoder.matches(now_pwd, u_pwd)) {
			Map<String, String> cMap = new HashMap<String, String>();
			cMap.put("pwd",passwordEncoder.encode(change_pwd));
			cMap.put("email",email);
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
		String u_pwd = uService.updateLoggedUserPassword();
		if(passwordEncoder.matches(pwd, u_pwd)) {
			dao.deleteUser(email);
			result="YES";
		}else {
			result="NO";
		}
		return result;
	}
	
	@PostMapping(value="sendMail.do",produces = "text/plain;charset=utf-8")
	public String sendMailTest(@RequestBody String email) throws Exception{
		/* ????????????(??????) ?????? */
        Random random = new Random();
        int checkNum = random.nextInt(888888) + 111111;
        
		String subject = "LRoom ????????? ?????? ????????????";
        String from = "LRoom <jim2353@naver.com>";
        String to = email;
        String content = 
                "LRoom??? ?????????????????? ???????????????." +
                "<br><br>" + 
                "?????? ????????? <strong>" + checkNum + "</strong>?????????." + 
                "<br>" + 
                "?????? ??????????????? ???????????? ???????????? ???????????? ?????????.";
        JSONObject obj = new JSONObject();
        try {
            MimeMessage mail = mailSender.createMimeMessage();
            MimeMessageHelper mailHelper = new MimeMessageHelper(mail,true,"UTF-8");
            // true??? ???????????? ???????????? ?????????????????? ??????
            
            /*
             * ????????? ????????? ???????????? ???????????? ????????? ????????? ?????? ?????? 
             * MimeMessageHelper mailHelper = new MimeMessageHelper(mail,"UTF-8");
             */
            
            mailHelper.setFrom(from);
            // ?????? ????????? ????????? ?????? ????????? smtp ????????? ?????? ?????? ?????? ????????? ????????????(setFrom())????????? ??????
            mailHelper.setTo(to);
            mailHelper.setSubject(subject);
            mailHelper.setText(content, true);
            // true??? html??? ?????????????????? ??????.
            
            // application-context - <property name="password" value=""/>  value??? ???????????? ????????? ?????????
            //mailSender.send(mail); 
            
            obj.put("code",123456);
            
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        return obj.toJSONString();
	}
}
