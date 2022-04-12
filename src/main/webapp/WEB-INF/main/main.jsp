<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<title>LRoom</title>

<!--Bootstrap core CSS-->
<link href="../resources/css/bootstrap.min.css" rel="stylesheet">
<!--Custom Fonts-->
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800'
	rel='stylesheet' type='text/css'>
<link
	href='http://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic,900,900italic'
	rel='stylesheet' type='text/css'>

<!-- Custom styles for this template -->
<link href="../resources/css/custom.css" rel="stylesheet">
<link rel="stylesheet" href="../resources/css/contact-input-style.css">
<link rel="stylesheet" href="../resources/css/hover-effect.css">
<link rel="stylesheet" type="text/css" href="../resources/css/font-awesome.min.css" />
</head>

<body>
	<!-- Header 위치 -->
	<tiles:insertAttribute name="header"/>
	<!-- 내용 (변경) -->
	<tiles:insertAttribute name="content"/>
	<!-- footer 위치 -->
	<tiles:insertAttribute name="footer"/>
	<!-- JAVASCRIPTS --> 
	<!-- <script src="../resources/js/jquery.min.js"></script> -->
    <script src="../resources/js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../resources/js/ie10-viewport-bug-workaround.js"></script>
    <script src="../resources/js/oppear_1.1.2.min.js"></script>
    <script> 
	
		$(window).scroll(function () {
			var sticky = $('.navbar-brand'),
			    scroll = $(window).scrollTop();
				
				if (scroll >= 250) sticky.addClass('dark');
				else sticky.removeClass('dark');
				
		});
		
		$('.service-box').Oppear({
			delay : 500,
			});
		$('.main-text').Oppear({
			direction:'right',
		});
		$('.points').Oppear({
			direction:'left',
		});
		$('.up-effect').Oppear({
			direction:'up',
		});
		$('.down-effect').Oppear({
			direction:'down',
		});
		$('.left-effect').Oppear({
			direction:'right',
		});
		$('.right-effect').Oppear({
			direction:'left',
		});
			
	    </script>
	    <script>
		$('a[href^="#"]').on('click', function(event) {
	
	    var target = $( $(this).attr('href') );
	
	    if( target.length ) {
	        event.preventDefault();
	        $('html, body').animate({
	            scrollTop: target.offset().top
	        }, 1000);
	    }
	
	});

    </script>
</body>
</html>