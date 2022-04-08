<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<title>LOGIN</title>
</head>
<body>
<form method="post" action="../login">
	<label for="email" class="form-label">이메일</label>
  	<input type="text" class="form-control" id="email" name="email" placeholder="name@example.com" />
<%--	<form:errors path="email"/><br>--%>
	<label for="password" class="form-label">비밀번호</label>
	<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호" />
<%--	<form:errors path="password"/><br>--%>
<%--	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>--%>
	<input type="submit" value="로그인">
</form>
<a href="${url}">네이버 로그인</a>
</body>
</html>