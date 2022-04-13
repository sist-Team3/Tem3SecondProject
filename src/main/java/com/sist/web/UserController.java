package com.sist.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
	
	@GetMapping("/signup.do")
	public String getSignUp(Model model) {
		model.addAttribute("user", new UserVO());
		return "user/signUp";
	}
	
	@PostMapping("/signup.do")
    public String postSignUp(@Validated @ModelAttribute("user") UserVO user, BindingResult bindingResult) {
		// 검증 실패 시 다시 입력 폼으로
        if (bindingResult.hasErrors()) {
            return "user/signUp";
        }
        // 검증 성공 시 회원 저장
        userService.addUser(user);
        return "user/userOk";
    }
	
	@GetMapping("/username.do")
	@ResponseBody
	public String getAdmin() {
		return userService.getLoggedUserName();
	}
	
	@GetMapping("/pwcheck.do")
	@ResponseBody
	public String checkPw() {
		return userService.checkPw() ? "TRUE" : "FALSE";
	}
	
	@RequestMapping("/signin.do")
	public String getSignIn(HttpSession session, Model model) {
        /* 네아로 인증 URL을 생성하기 위하여 getAuthorizationUrl을 호출 */
        String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
        model.addAttribute("url", naverAuthUrl);
        
		return "user/signIn";
	}
	
	@RequestMapping("callback.do")
	public String getNaver(@RequestParam String code, Model model, HttpServletRequest request) throws Exception{
		UserVO oauthUser = userParser.parseUser(naverLoginBO.getUserProfile(code));
		
		if (userService.isUser(oauthUser.getEmail())) {
			return userService.oauthLogIn(oauthUser.getEmail(), oauthUser.getPassword(), request);
		}
		model.addAttribute("user", oauthUser);
	    return "user/oauthSignUp";
	}
	
	@PostMapping("/oauthsignup.do")
	public String signUpByOauth(@ModelAttribute("user") UserVO user) {
        userService.addUser(user);
		return "user/userOk";
	}
	@GetMapping("/find.do")
	public String findUsernameAndPassword() {
		return "user/findUser";
	}
	@PostMapping("/phonecert")
	@ResponseBody
	public String getPhoneCertification() {
		return userService.getPhoneCertification();
	}
}
