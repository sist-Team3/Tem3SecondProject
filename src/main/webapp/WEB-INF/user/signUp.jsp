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
<link rel="stylesheet" type="text/css" href="../resources/css/signup.css">
</head>
<body>
<div style="background-image: url('../resources/img/signupimg.jpg'); width: 100vw;">
	<div class="container">
		<div class="row">
			<div class ="col-xs-8 col-xs-offset-2" id="sign-up-form">
				<div class="sign-up-title-area">
					<h1 id="sign-up-title">회원가입</h1>
					<h4 id="sign-up-subtitle">"안녕하세요, LROOM 입니다."</h4>
				</div>
				<form:form method="post" modelAttribute="user">
					<label for="email" class="form-label">이메일</label>
				  	<form:input path="email" type="email" class="form-control" id="email" name="email" placeholder="name@example.com" />
					<form:errors class="error-msg" path="email"/><br>
					<label for="password" class="form-label">비밀번호</label>
					<form:input path="password" type="password" class="form-control" id="password" name="password" placeholder="비밀번호" />
					<form:errors class="error-msg" path="password"/><br>
					<label for="name" class="form-label">이름</label>
					<form:input path="name" type="text" class="form-control" id="name" name="name" placeholder="이름" />
					<form:errors class="error-msg" path="name"/><br>
					<label for="phone" class="form-label">휴대폰번호</label>
					<form:input path="phone" type="text" class="form-control" id="phone" name="phone" placeholder="휴대폰번호" />
					<form:errors class="error-msg" path="phone"/><br>
					<div class="sign-up-btn-area">
						<input type="submit" class="btn" id="sign-up-btn" value="회원가입">
					</div>
				</form:form>
			</div>
		</div>
	</div>
</div>
</body>
</html>