package com.sist.validation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.sist.dao.UserDAO;
import com.sist.vo.UserVO;

@Component
public class UserValidator implements Validator {
	@Autowired
	private UserDAO userDAO;
	
	private final static String PASSWORD_REGEXP = 
			"^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&].{1,}$";
	private final static String NAME_REGEXP = 
			"^(?=.*[가-힣])[가-힣].{1,}$";
	private final static String PHONE_REGEXP = 
			"^01(?:0|1|[6-9])(?:\\d{3}|\\d{4})\\d{4}$";	
    @Override
    public boolean supports(Class<?> clazz) {
        return UserVO.class.isAssignableFrom(clazz); // Member 혹은 Member의 자식 클래스가 clazz와 같는지 확인
    }
    @Override
    public void validate(Object target, Errors errors) {
    	UserVO user = (UserVO) target;
        // 이메일 검증
        if (!StringUtils.hasText(user.getEmail())) {
            errors.rejectValue("email","required");
        } else if (userDAO.isUserByEmail(user.getEmail())) {
			errors.rejectValue("email", "duplicate");
		}
        
        // 비밀번호 검증
        if (user.getPassword().length() < 9 || user.getPassword().length() > 20) {
            errors.rejectValue("password","range");
        } else if (!user.getPassword().matches(PASSWORD_REGEXP)) {
            errors.rejectValue("password", "rule");
        }
        
        // 이름 검증
        if (!user.getName().matches(NAME_REGEXP)) {
        	errors.rejectValue("name", "rule");
        }
        
        // 전화번호 검증
        if (!user.getPhone().matches(PHONE_REGEXP)) {
        	errors.rejectValue("phone", "rule");
        } else if (userDAO.isUserByPhone(user.getPhone())) {
        	errors.rejectValue("phone", "duplicate");
        }

    }
}
