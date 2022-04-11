package com.sist.security;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

@Component
public class NaverLoginBO {
	private final static String CLIENT_ID = "Xv_9yEzXHLvOqMwQl94F";
	private final static String CLIENT_SECRET = "9lXC4PWAEn";
	private final static String REDIRECT_URI = "http://localhost:8080/web/user/callback.do";
	
	/* 네아로 인증  URL 생성  Method */
	public String getAuthorizationUrl(HttpSession session) {

		/* Scribe에서 제공하는 인증 URL 생성 기능을 이용하여 네아로 인증 URL 생성 */
		OAuth20Service oauthService = 
				new ServiceBuilder(CLIENT_ID)
				.apiSecret(CLIENT_SECRET)
				.callback(REDIRECT_URI)
				.build(NaverLoginApi.instance());

		return oauthService.getAuthorizationUrl();
	}
	public String getUserProfile(String code) throws Exception {
		OAuth20Service oauthService = 
				new ServiceBuilder(CLIENT_ID)
				.apiSecret(CLIENT_SECRET)
				.callback(REDIRECT_URI)
				.build(NaverLoginApi.instance());
		
		OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
		
		OAuthRequest request = new OAuthRequest(Verb.GET, "https://openapi.naver.com/v1/nid/me");
		oauthService.signRequest(accessToken, request);
		
		Response response = oauthService.execute(request);
		return response.getBody();
	}
}
