<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOGIN</title>
<link rel="stylesheet" type="text/css" href="../resources/css/signin.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
</head>
<body>
	<div class="container" id="login-area">
		<div class="row">
			<div class="col-xs-7 login-picture">
				<img alt="Login Main Image" src="../resources/img/login-side-img.jpg">
			</div>
			<div class="col-xs-5">
				<h2 id="login-title">LOGIN</h2>
				<c:choose>
					<c:when test="${param.error eq 'ni'}">
						<div class="login-error-msg">
							<p><i class="bi bi-exclamation-circle"></i>
							아이디가 존재하지 않습니다.</p>
						</div>
					</c:when>
					<c:when test="${param.error eq 'pe'}">
						<div class="login-error-msg">
							<p><i class="bi bi-exclamation-circle"></i>
							비밀번호가 일치하지 않습니다.</p>
						</div>
					</c:when>
					<c:otherwise></c:otherwise>
				</c:choose>	
				<form method="post" action="../login" id="login-form" class="form-floating">
					<label for="email-input" id="email-label">Email</label>
				  	<input type="email" class="form-control" id="email-input" name="email" placeholder="name@example.com" />
					<label for="password-input" id="password-label">Password</label>
					<input type="password" class="form-control" id="password-input" name="password" placeholder="비밀번호" />
					<a href="../user/find.do" id="find-id-pw">아이디/비밀번호 찾기</a><br>
					<button type="submit" class="btn btn-info" id="btn-login-default">회원 로그인</button>
				</form>
				<a href="${url}" id="login-naver">
					<img alt="Naver Login Button" src="../resources/img/login-naver.png">
				</a>
			</div>
		</div>		
	</div>
</body>
</html>