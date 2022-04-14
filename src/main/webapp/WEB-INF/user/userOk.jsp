<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userOK</title>
<link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="../resources/css/signupok.css">
</head>
<body>
	<div id="welcome-area">
		<div class="container">
			<div class="row">
				<div class="col-xs-12" id="welcome-form">
					<h1 id="welcome-main">Welcome,</h1>
					<h1 id="welcome-sub"><strong>${user.name}</strong> 님 회원가입 축하합니다!</h1>
					<button id="main-btn" class="btn" type="button" onclick="location.href='../';">메인으로 가기</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>