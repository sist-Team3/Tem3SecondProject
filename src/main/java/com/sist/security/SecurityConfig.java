package com.sist.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;


@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.csrf().disable();
		http.authorizeRequests()
			.antMatchers("/user/username.do").authenticated()
			.antMatchers("/mypage/main.do").authenticated()
			.antMatchers("/board/board.do").authenticated()
			.antMatchers("/css/**","/js/**","/img/**").permitAll()
			.anyRequest().permitAll()
			.and()
            .formLogin()
            	.loginPage("/user/signin.do")
            	.usernameParameter("email")
            	.loginProcessingUrl("/login")
            	.successHandler(authenticationSuccessHandler())
            	.failureHandler(authenticationFailureHandler())
            .and()
            .logout()
            	.logoutSuccessUrl("/")
            	.invalidateHttpSession(true)
            	.deleteCookies("JSESSIONID");
	}
	
	@Bean
	public AuthenticationSuccessHandler authenticationSuccessHandler() {
		return new LoginSuccessHandler();
	}
	
	@Bean
	public AuthenticationFailureHandler authenticationFailureHandler() {
		return new LoginFailureHandler();
	}
	
	@Bean
	@Override
	public AuthenticationManager authenticationManagerBean() throws Exception {
		return super.authenticationManagerBean();
	}
	
}
