<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addMember</title>
<link rel="stylesheet" type="text/css" href="../resources/css/oauthSignUp.css">
</head>
<body>
<div class="oauth-sign-up-area">
	<div class="container">
		<div class="row">
			<div class="col-xs-6 col-xs-offset-3" id="sign-up-form">
				<img id="naver-logo" alt="naver logo" src="../resources/img/naver_icon_square.png">
				<h1 id="oauth-sign-title">간편 회원가입</h1>
				<p id="oauth-sign-sub"><strong>${user.email}</strong>로 가입하시겠습니까?</p>
				<form method="post" action="../user/oauthsignup.do">
				  	<input type="hidden" class="form-control" name="email" value="${user.email}"/>
					<input type="hidden" class="form-control" name="password" value="${user.password}"/>
					<input type="hidden" class="form-control" name="name" value="${user.name}"/>
					<input type="submit" class="btn" id="naver-sign-in-btn" value="회원가입">
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>