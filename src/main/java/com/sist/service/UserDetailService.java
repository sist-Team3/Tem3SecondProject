package com.sist.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.sist.dao.UserDAO;
import com.sist.security.UserDetail;
import com.sist.vo.UserVO;

@Service
public class UserDetailService implements UserDetailsService{
	@Autowired
	private UserDAO userDAO;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UserVO user = userDAO.findUserByEmail(username);
		if (user != null) {
			return new UserDetail(user);
		}
		return null;
	}
	
	
	
}
