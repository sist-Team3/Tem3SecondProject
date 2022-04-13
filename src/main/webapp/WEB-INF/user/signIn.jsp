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
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
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
#login-area{
	height: 70vh;
	margin-top: 25vh;
	margin-bottom: 20vh;
	background-color: rgb(247,247,247,255);
	box-shadow: 12px 12px 10px 0px rgba(0, 0, 0, 0.1);
	border-radius: 5px 5px 5px 5px;
	text-align: center;
}
#login-form{
	margin-top: 10vh;
}
div.login-picture{
	background-color: green;
	height: 70vh;
	overflow: hidden;
}
div.login-picture>img{
	margin-top: -40vh;
	margin-left: -30px;
	width: 43vw;
	overflow: hidden;
}
#btn-login-default{
	margin: 20px 0px 0px 0px;
	width: 15vw;
	height: 7vh;
	font-size: 25px;
}
#login-naver>img{
	margin: 20px 0px 20px 0px;
	width: 15vw;
}
</style>
</head>
<body>
	<div class="container" id="login-area">
		<div class="row">
			<div class="col-xs-7 login-picture">
				<img alt="Naver Login Button" src="../resources/img/login-side-img.jpg">
			</div>
			<div class="col-xs-5">
				<form method="post" action="../login" id="login-form" class="form-floating">
					<label for="floatingInputValue">이메일</label>
				  	<input type="email" class="form-control" id="floatingInputValue" name="email" placeholder="name@example.com" />
				<%--	<form:errors path="email"/><br>--%>
					<label for="floatingPassword">Password</label>
					<input type="password" class="form-control" id="floatingPassword" name="password" placeholder="비밀번호" />
					<button type="submit" class="btn btn-info" id="btn-login-default">회원 로그인</button>
				</form>
				<a href="${url}" id="login-naver">
					<img alt="Naver Login Button" src="../resources/img/login-naver.png">
				</a>
				<c:choose>
					<c:when test="${param.error eq 'ni'}">
						<p>아이디가 존재하지 않습니다.</p>
					</c:when>
					<c:when test="${param.error eq 'pe'}">
						<p>비밀번호가 일치하지 않습니다.</p>
					</c:when>
					<c:otherwise></c:otherwise>
				</c:choose>	
			</div>
		</div>		
	</div>
</body>
</html>