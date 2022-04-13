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
#user-info-area{
	margin-top: 20vh
}
#name-ok{
	color: green;
}
#name-no{
	color: red;
}
#cert-ok{
	color: blue;
}
#cert-no{
	color: red;
}
</style>
</head>
<body>
	<div class="container">
		<div class="row" id="user-info-area">
			<div class="col-xs-12" id="user-find-form">
				<input type="text" id="username" placeholder="이름">
				<span class="name-msg">이름을 입력해주세요.</span><br>
				<input type="text" id="phone-number" placeholder="전화번호">
				<button id="cert-button">인증번호 전송</button>
			</div>
		</div>		
	</div>
</body>
<script
  src="https://code.jquery.com/jquery-3.6.0.min.js"
  integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
  crossorigin="anonymous"></script>
<script type="text/javascript">
	let phone = '';
	let certNum = '';
	$('#username').change(function(){
		console.log($('#username').val())
		$.ajax({
			url: '/web/user/checkUsername.do',
			data: { username: $('#username').val() },
			method: 'POST',
			dataType: 'text'
		})
		.done(function(data){
			if(data == 'true') {
				$('span.name-msg').replaceWith('<span class="name-msg" id="name-ok">이름이 확인되었습니다.</span>');
			} else {
				$('span.name-msg').replaceWith('<span class="name-msg" id="name-no">가입되지 않은 이름입니다.</span>');
			} 	
		});
	});
	$('#cert-button').click(function(){
		phone = $('#phone-number').val();
		console.log(phone);
		$.ajax({
			url: '/web/user/phonecert.do',
			data: { phone: phone },
			method: 'POST',
			dataType: 'json'
		})
		.done(function(data){
			if(!$('#cert-ok-form').length) {
				$('#user-find-form').append('<br><div id="cert-ok-form"><input id="cert-num" type="text" placeholder="인증번호">'
						  					  + '<button id="cert-ok-button">확인</button><br></div>');
			}
		})
		.fail(function(xhr, status, errorThrown){
			console.log(status + ' ' + errorThrown);
		})
	});
	$(document).on("click", "#cert-ok-button" , function(){
		$.ajax({
			url: '/web/user/emailcert.do',
			data: { certNum : $('#cert-num').val(),
					phone: phone	
			},
			method: 'POST',
			dataType: 'text'
		})
		.done(function(data){
			if(data == 'false') {
				$('span#cert-no').remove();
				$('#cert-ok-form').append('<span id="cert-no">인증번호가 일치하지 않습니다. 다시 확인해주세요.</span>');
			} else {
				$('#user-find-form').remove();
				$('#user-info-area').append('<span id="cert-ok">고객님의 아이디는 ' + data + ' 입니다.</span>');				
			}
		})
		.fail(function(xhr, status, errorThrown){
			console.log(status + ' ' + errorThrown);
		});
	});
</script>
</html>