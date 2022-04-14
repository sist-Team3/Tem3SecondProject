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
</head>
<body>
<h1>간편 회원가입</h1>
<p>${user.email}로 회원가입 하시겠습니까?</p>
<form method="post" action="../user/oauthsignup.do">
  	<input type="hidden" class="form-control" name="email" value="${user.email}"/>
	<input type="hidden" class="form-control" name="password" value="${user.password}"/>
	<input type="hidden" class="form-control" name="name" value="${user.name}"/>
	<input type="submit" value="회원가입">
</form>
</body>
</html>