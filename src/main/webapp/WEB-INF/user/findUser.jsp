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
#user-find-form{
	margin-top: 20vh
}
</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-xs-12" id="user-find-form">
				<input type="text" placeholder="이름"><br>
				<input type="text" placeholder="전화번호">
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
	$('#cert-button').click(function(){
		$.ajax({
			url: '/web/user/phonecert.do',
			data: { name: '홍길동' },
			method: 'POST',
			dataType: 'text'
		})
		.done(function(data){
			$('#user-find-form').append('<br><input type="text" placeholder="인증번호">'
					  + '<button id="cert-button">확인</button>');
			console.log(data);
		})
		.fail(function(xhr, status, errorThrown){
			console.log(status + ' ' + errorThrown);
		})
	});
	
</script>
</html>