<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../resources/css/apartmentlist.css">
</head>

<body>

	<div class="wrapper">
		<div class="container" id="apartmentlist">
			<div class="row">
				<table class="table">
					<tr>
						<th width=5% class="text-center">번호</th>
						<th width=20% class="text-center">지역</th>
						<th width=15% class="text-center">도로명 주소</th>
						<th width=10% class="text-center">전용 면적(㎡))</th>
						<th width=10% class="text-center">가격 (단위:만원)</th>
						<th width=5% class="text-center">건축년도</th>
					</tr>
					<c:forEach var="vo" items="${alist }">
						<tr>
							<td width=5% class="text-center">${vo.no }</td>
							<th width=20% class="text-center">${vo.address }</th>
							<th width=15% class="text-center">${vo.road_name }</th>
							<th width=15% class="text-center">${vo.area_size }</th>
							<th width=20% class="text-center"><fmt:formatNumber
									value="${vo.price }" pattern="#,###" /></th>
							<th width=10% class="text-center">${vo.construction_date }년</th>
						</tr>
					</c:forEach>
				</table>

				<nav class="pagination">
					<ul>
						<c:if test="${startPage>1 }">
							<li><a href="../apartmnetlist.do?page=${startPage-1 }">&laquo;
									Previous</a></li>
						</c:if>
						<c:forEach var="i" begin="${startPage }" end="${endPage }">
							<c:if test="${i==curpage }">
								<c:set var="style" value="class=current" />
							</c:if>
							<c:if test="${i!=curpage }">
								<c:set var="style" value="" />
							</c:if>
							<li ${style }><a href="../apartmentlist.do?page=${i }">${i }</a></li>
						</c:forEach>

						<c:if test="${endPage<totalpage }">
							<li><a href="../apartmentlist.do?page=${endPage+1 }">Next
									&raquo;</a></li>
						</c:if>
					</ul>
				</nav>				
			</div>
		<div class="clear"></div>
		</div>
	</div>
</body>
</html>