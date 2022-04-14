<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 비밀번호 찾기<</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<link rel="stylesheet" type="text/css" href="../resources/css/findpassword.css">
</head>
<body>
	<div class="container user-find-area">
		<div class="row">
			<div class="col-xs-6 col-xs-offset-3 tab-group">
				<div class="row">
					<div class="col-xs-3 find-tab" id="id-tab">
						<a href="../user/find.do" id="id-tab-con">이메일 찾기</a>
					</div>
					<div class="col-xs-3 find-tab" id="pw-tab">
						<span id="pw-tab-con">비밀번호 찾기</span>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-6 col-xs-offset-3" id="user-find-form">
				<div id="user-find-input-group">
					<h1 id="find-email-title">비밀번호 찾기</h1>
					<div class="row">
						<div class="col-xs-7" id="user-find-input-part">
							<input type="email" class="form-control" id="email" placeholder="email@example.com">
							<input type="text" class="form-control" id="phone-number" placeholder="전화번호">
						</div>
						<div class="col-xs-5" id="user-find-submit-part">
							<span class="email-msg" id="email-default">이메일(아이디)를 입력해주세요.</span><br>
							<button class="btn" id="cert-button">인증번호 전송</button>			
						</div>
					</div>
				</div>
			</div>			
		</div>
	</div>	
</body>
<script
  src="https://code.jquery.com/jquery-3.6.0.min.js"
  integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
  crossorigin="anonymous"></script>
<script type="text/javascript" src="../resources/js/findpassword.js"></script>
</html>