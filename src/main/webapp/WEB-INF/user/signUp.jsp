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
<style type="text/css">
.top-bar{
	background-color : rgb(31, 45 , 60);
}
.navbar-default top-bar affix .navbar-nav li a{
	color:white;
}
.navbar-default a.navbar-brand.dark{
	color:white;
}
#sign-up-form{
	margin-top: 30vh;
	margin-bottom: 30vh;
}
</style>
</head>
<body>
<div class="container">
	<div class="row">
		<div class ="col-xs-12" id="sign-up-form">
			<form:form method="post" modelAttribute="user">
				<label for="email" class="form-label">이메일</label>
			  	<form:input path="email" type="email" class="form-control" id="email" name="email" placeholder="name@example.com" />
				<form:errors path="email"/><br>
				<label for="password" class="form-label">비밀번호</label>
				<form:input path="password" type="password" class="form-control" id="password" name="password" placeholder="비밀번호" />
				<form:errors path="password"/><br>
				<label for="name" class="form-label">이름</label>
				<form:input path="name" type="text" class="form-control" id="name" name="name" placeholder="이름" />
				<form:errors path="name"/><br>
				<label for="phone" class="form-label">휴대폰번호</label>
				<form:input path="phone" type="text" class="form-control" id="phone" name="phone" placeholder="휴대폰번호" />
				<form:errors path="phone"/><br>
				<input type="submit" value="회원가입">
			</form:form>
		</div>
	</div>
</div>
</body>
</html>