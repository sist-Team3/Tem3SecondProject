package com.sist.web;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
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
	private BCryptPasswordEncoder passwordEncoder;
	private NaverLoginBO naverLoginBO;
	private UserParser userParser;
	
	@Autowired
	public UserController(UserService userService, 
						UserValidator userValidator,
						BCryptPasswordEncoder passwordEncoder,
						NaverLoginBO naverLoginBO,
						UserParser userParser) {
		this.userService = userService;
		this.userValidator = userValidator;
		this.passwordEncoder = passwordEncoder;
		this.naverLoginBO = naverLoginBO;
		this.userParser = userParser;
	}
	
	@InitBinder
	public void init(WebDataBinder webDataBinder) {
		webDataBinder.addValidators(userValidator);
	}
	
	@GetMapping("/signUp.do")
	public String getSignUp(Model model) {
		model.addAttribute("user", new UserVO());
		return "user/signUp";
	}
	
	@PostMapping("/signUp.do")
    public String postSignUp(@Validated @ModelAttribute("user") UserVO user, BindingResult bindingResult) {
		// 검증 실패 시 다시 입력 폼으로
        if (bindingResult.hasErrors()) {
            return "user/signUp";
        }
        // 검증 성공 시 회원 저장 (비밀번호 인코딩 포함)
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userService.addUser(user);
        return "user/userOk";
    }
	
	@GetMapping("/admin.do")
	@ResponseBody
	public String getAdmin() {
		return "Admin";
	}
	
	@GetMapping("/signIn.do")
	public String getSignIn(HttpSession session, Model model) {
        /* 네아로 인증 URL을 생성하기 위하여 getAuthorizationUrl을 호출 */
        String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
        model.addAttribute("url", naverAuthUrl);
        
		return "user/signIn";
	}
	
	@RequestMapping("callback.do")
	public String getNaver(@RequestParam String code, Model model) throws Exception{
		UserVO oauthUser = userParser.parseUser(naverLoginBO.getUserProfile(code));
		
		if (userService.isUser(oauthUser.getEmail())) {
			return userService.oauthLogIn(oauthUser.getEmail(), oauthUser.getPassword());
		}
		model.addAttribute("user", oauthUser);
	    return "user/oauthSignUp";
	}
	
	@PostMapping("/oauthSignUp.do")
	public String signUpByOauth(@ModelAttribute("user") UserVO user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userService.addUser(user);
		return "user/userOk";
	}
}
