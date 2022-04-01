package com.sist.validation;

import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.sist.vo.UserVO;

@Component
public class UserValidator implements Validator {
    @Override
    public boolean supports(Class<?> clazz) {
        return UserVO.class.isAssignableFrom(clazz); // Member 혹은 Member의 자식 클래스가 clazz와 같는지 확인
    }
    @Override
    public void validate(Object target, Errors errors) {
    	UserVO user = (UserVO) target;
        // 검증 로직
        if (!StringUtils.hasText(user.getEmail())) {
            errors.rejectValue("email","required");
        }
        if (user.getPassword().length() < 9) {
            errors.rejectValue("password","min");
        }
        if (!StringUtils.hasText(user.getName())) {
            errors.rejectValue("name","required");
        }
    }
}
