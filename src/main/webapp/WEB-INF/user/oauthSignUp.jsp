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
<title>addMember</title>
</head>
<body>
<h1>간편 회원가입</h1>
<p>${user.email}로 회원가입 하시겠습니까?</p>
<form method="post" action="../user/oauthsignup.do">
  	<input type="hidden" class="form-control" name="email" value="${user.email}"/>
	<input type="hidden" class="form-control" name="password" value="${user.password}"/>
	<input type="hidden" class="form-control" name="name" value="${user.name}"/>
<%-- 	<label for="name" class="form-label">이름</label>
	<form:input path="name" type="text" class="form-control" id="name" name="name" placeholder="이름" />
	<form:errors path="name"/><br> --%>
	<input type="submit" value="회원가입">
</form>
</body>
</html>