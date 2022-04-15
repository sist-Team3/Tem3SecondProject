<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
function searchToggle(){
	
	if($.trim($('.search-input').val())==''){
		alert('검색어를 입력하시오!')
		return false;
	}
    let form = $('#searchForm')
    let category= $('select[name=searchCategory] option:selected').val()
    var searchFd = document.getElementById("searchFd").value;
    if(category=='1'){
    	$('#searchForm').attr('action','../product/apartmentlist.do')
    }else if(category=='2'){
    	$('#searchForm').attr('action','../product/villalist.do')
    }else if(category=='3'){
    	$('#searchForm').attr('action','../product/officetellist.do')
    }else{
    	$('#searchForm').attr('action','../product/apartmentlist.do')
    }
    form.submit();
}
</script>
<link rel="stylesheet" type="text/css" href="../resources/css/content.css">
</head>
<body>
	<section class="banner-sec" id="home" >
		<div class="container">
			<div class="jumbotron">
				<h1>어떤 집을 찾고 계세요?</h1>
				<br>
				<h2>
					<!-- 찾고자하는 조건? -->
				</h2>
				<div class="search-wrapper active">
					<form id ="searchForm" method="GET" action="" >
						<div class="search-category">
							<select class="form-control search-category" name="searchCategory"
								id="search_main_cate_sel" >
								<option ${category ==1?'selected': '' } value="1">아파트</option>
								<option ${category ==2?'selected': '' } value="2">연립/다세대</option>
								<option ${category ==3?'selected': '' } value="3">오피스텔</option>
							</select>
						</div>
						<div class="input-holder">
							<input type="text" class="search-input"  name="fd" placeholder="search-for.." id="searchFd"/>
							<button class="search-icon" onclick="searchToggle();">
								<span></span>
							</button>
						</div>
					</form>
				</div>
				<%-- 			<form id="searchForm" action="/search" method="get">
				<div class="form-group search-group">
					<select class="form-control search-category" name="searchCategory" id="search_main_cate_sel">
						<option ${category ==4?'selected': '' } value="4">통합검색</option>
						<option ${category ==1?'selected': '' } value="1">아파트</option>
						<option ${category ==2?'selected': '' } value="2">연립/다세대</option>
						<option ${category ==3?'selected': '' } value="3">오피스텔</option>
					</select>
					 <div class="input-group" id="search_opt_list">
						<input type="text" class="form-control search-input" id="keyword" name="keyword" placeholder="검색어를 입력해주세요.." value="${keyword }">
					 </div>
						<button type="button" class="btn btn-default search-button"
							id="search-button" onclick="searchMain()">
							<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
						</button>
					</div>
			</form> --%>
			</div>					
		</div>
	</section>
	<section class="four-col-services" id="services">
		<div class="container">
			<div class="row">
				<h2 class="text-center">About LRoom</h2>
				<h4 class="text-center">
					안녕하세요.&nbsp; 엘룸입니다.<br> 서울시 매매정보를 기반으로 여러분이 원하는 집을 쉽고 빠르게 구할 수
					있도록<br> 주거와 관련된 정보를 제공합니다.<br> 아파트 단지부터 빌라까지 보다 정확한 최근 시세
					정보를 엘룸에서 확인하세요.<br>
				</h4>
				<div
					class="col-lg-4 col-md-4 col-sm-6 text-center service-block up-effect">
					<i class="fa fa-bar-chart" aria-hidden="true"></i>
					<h3>최신 가격 비교가능</h3>
					<p></p>
				</div>
				<div
					class="col-lg-4 col-md-4 col-sm-6 text-center service-block down-effect">
					<i class="fa fa-bookmark-o" aria-hidden="true"></i>
					<h3>내가 본 매물 찜하기</h3>
					<p></p>
				</div>
				<div
					class="col-lg-4 col-md-4 col-sm-6 text-center service-block down-effect">
					<i class="fa fa-calendar-o" aria-hidden="true"></i>
					<h3>날짜별 비교가능</h3>
					<p></p>
				</div>
			</div>
		</div>
	</section>
	<section class="about-se" id="abou">
		<div class="container">
			<div class="row">
				<h2>
					<a href="#">자료실</a>
				</h2>
				<p class="lead"></p>
			</div>
			<div class="row">
				<h2>
					<a href="../news/main.do">뉴스</a>
				</h2>
				<p class="lead"></p>
			</div>
		</div>
	</section>
</body>
</html>