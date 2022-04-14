<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userOK</title>
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
#welcome-area{
	margin-top: 30vh;
	margin-bottom: 30vh;
}
</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-xs-12" id="welcome-area">
				<h1>회원가입 축하합니다!</h1>
				<ul>
					<li>${user.name}</li>
					<li>${user.email}</li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>