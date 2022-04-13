<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<nav class="navbar navbar-default top-bar affix" data-spy="affix"
		data-offset-top="250">
		<div class="container">
			<div class="navbar-header page-scroll">
				<button data-target="#bs-example-navbar-collapse-1"
					data-toggle="collapse" class="navbar-toggle" type="button">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a href="../main/main.do" class="navbar-brand">LRoom</a>
			</div>
			<div id="bs-example-navbar-collapse-1"
				class="collapse navbar-collapse">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="../product/apartmentlist.do">아파트</a></li>
					<li><a href="../product/villalist.do">연립/다세대</a></li>
					<li><a href="../product/officetellist.do">오피스텔</a></li>
					<li><a href="../board/board.do">게시판</a></li>
					<li><a href="../news/main.do">부동산 뉴스</a></li>
					<c:if test="${empty sessionScope.username}">
						<li><a href="../user/signup.do">회원가입</a></li>
						<li><a href="../user/signin.do">로그인</a></li>
					</c:if>
					<c:if test="${not empty sessionScope.username}">
						<li><a href="../mypage/main.do">마이페이지</a></li>
						<li><a href="../logout">로그아웃</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</nav>
</body>
</html>