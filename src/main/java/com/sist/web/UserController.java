package com.sist.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sist.security.NaverLoginBO;
import com.sist.service.UserService;
import com.sist.util.UserParser;
import com.sist.validation.UserValidator;
import com.sist.vo.UserVO;

@Controller
@RequestMapping("user")
public class UserController {
	private UserService userService;
	private UserValidator userValidator;
	private NaverLoginBO naverLoginBO;
	private UserParser userParser;
	
	@Autowired
	public UserController(UserService userService, 
						UserValidator userValidator,
						NaverLoginBO naverLoginBO,
						UserParser userParser) {
		this.userService = userService;
		this.userValidator = userValidator;
		this.naverLoginBO = naverLoginBO;
		this.userParser = userParser;
	}
	
	@InitBinder
	public void init(WebDataBinder webDataBinder) {
		webDataBinder.addValidators(userValidator);
	}
	
	/* 
	 * 1. 회원가입 페이지 
	 * 1-1. 회원가입 페이지 출력
	 */
	@GetMapping("/signup.do")
	public String getSignUp(Model model) {
		model.addAttribute("user", new UserVO());
		return "user/signUp";
	}
	// 1-2. 회원가입 처리 (일반)
	@PostMapping("/signup.do")
    public String postSignUp(@Validated @ModelAttribute("user") UserVO user, 
    						  BindingResult bindingResult) {
		// 검증 실패 시 다시 입력 폼으로
        if (bindingResult.hasErrors()) {
            return "user/signUp";
        }
        // 검증 성공 시 회원 저장
        userService.addUser(user);
        return "user/userOk";
    }
	// 1-3. 회원가입 처리 (OAuth)
	@PostMapping("/oauthsignup.do")
	public String signUpByOauth(@ModelAttribute("user") UserVO user) {
		userService.addOauthUser(user);
		return "user/userOk";
	}
	
	/* 
	 * 2. 로그인 페이지 
	 * 2-1. 로그인 페이지 출력
	 */
	@RequestMapping("/signin.do")
	public String getSignIn(HttpSession session, Model model) {
        String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
        model.addAttribute("url", naverAuthUrl);
		return "user/signIn";
	}
	// 2-2. OAuth 로그인 처리
	@RequestMapping("callback.do")
	public String getNaver(@RequestParam String code, 
							Model model, 
							HttpServletRequest request) throws Exception{
		
		UserVO oauthUser = userParser.parseUser(naverLoginBO.getUserProfile(code));
		if (userService.isUser(oauthUser.getEmail())) {
			return userService.oauthLogIn(oauthUser.getEmail(), oauthUser.getPassword(), request);
		}
		model.addAttribute("user", oauthUser);
	    return "user/oauthSignUp";
	}
	
	/* 
	 * 3. 아이디 찾기 페이지 
	 * 3-1. 아이디 찾기 페이지 출력
	 */
	@GetMapping("/find.do")
	public String findUsername() {
		return "user/findUser";
	}
	// 3-2. 이름으로 가입여부 확인
	@PostMapping("/checkUsername.do")
	@ResponseBody
	public String checkUserByName(@RequestParam String username) {
		return userService.isUserByName(username);
	}
	// 3-3. 본인인증 기반 이메일 전달
	@PostMapping("/emailcert.do")
	@ResponseBody
	public String getEmailByCert(@RequestParam("certNum") String certNum,
								 @RequestParam("phone") String phone,
								  HttpServletRequest request) {
		return userService.getEmailByPhoneCertification(certNum, phone, request);
	}
	
	/* 
	 * 4. 비밀번호 찾기 페이지 
	 * 4-1. 비밀번호 찾기 페이지 출력
	 */
	@GetMapping("/findpw.do")
	public String findPassword() {
		return "user/findPassword";
	}
	// 4-2. 이메일로 가입여부 확인
	@PostMapping("/checkemail.do")
	@ResponseBody
	public String checkUserByEmail(@RequestParam String email) {
		return Boolean.toString(userService.isUser(email));
	}
	// 4-3. 본인인증 기반 임시 비밀번호 전달
	@PostMapping("/pwcert.do")
	@ResponseBody
	public String getPasswordByCert(@RequestParam("certNum") String certNum,
									@RequestParam("phone") String phone,
									 HttpServletRequest request) {
		return userService.getPasswordByPhoneCertification(certNum, phone, request);
	}
	
	/* 
	 * 5. 아이디/비밀번호 찾기 공통
	 *    본인 휴대폰 인증번호 전송
	 */
	@PostMapping("/phonecert.do")
	@ResponseBody
	public String getPhoneCertCode(@RequestParam String phone, 
									HttpServletRequest request) {
		return userService.getPhoneCertification(phone, request);
	}
}
