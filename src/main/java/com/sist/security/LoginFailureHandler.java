package com.sist.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

public class LoginFailureHandler implements AuthenticationFailureHandler{

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) 
					throws IOException, ServletException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String errormsg = null;
		
		if(exception instanceof BadCredentialsException) {
            errormsg = "pe";
        } else if(exception instanceof InternalAuthenticationServiceException) {
            errormsg = "ni";
        }
        
        response.sendRedirect("user/signin.do?error="+errormsg);
        
	}
	
}
