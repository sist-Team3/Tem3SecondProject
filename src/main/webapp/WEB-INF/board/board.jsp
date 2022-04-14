<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.min.js"></script>
<script src="http://unpkg.com/axios/dist/axios.min.js"></script>
<link rel="stylesheet" href="../resources/css/board.css">
</head>
<body>
	<div class="container">
		<div style="height: 100px"></div>
<!-- ################################# -->
		<h2 class="color_sky_point" style="margin-top:20px;">게시판</h2>
         <div><strong><span style="font-size: 20px">${sessionScope.username }</span>님의 게시글은 총 <span class="color_sky_point">100</span>개 (일반 <<span class="color_sky_point">10</span> + 댓글 <span class="color_sky_point">10</span>) 입니다 :)
           </strong>
           <div style="height:50px;"></div>
           <form method=GET action="../board/board_insert.do">
				<input type=submit class="btn  bg_color_navy BTN" style="box-shadow: 2px 2px 2px 2px #dfdfdf;width:90px;height: 30px;display: inline;" value="글쓰기">
				<input type=hidden name="session_id" value="${sessionScope.username }">
					
			</form>
           
          
          <label class="box-radio-input">
             <input type="checkbox" id="1m" name="period"class="rdbtn" value="1m" ><span>제목</span>
          </label>
          <label class="box-radio-input">
             <input type="checkbox" id="3m" name="period"class="rdbtn" value="3m"><span>내용</span>
          </label>
          <label class="box-radio-input">
             <input type="checkbox" id="6m" name="period"class="rdbtn" value="6m"><span>작성자</span>
          </label> 
           &nbsp;&nbsp;<input type="text" style="width:20%;height: 30px;" name="serch_oh"/>&nbsp;&nbsp;
           <a href="#" class="btn  bg_color_navy BTN" style="box-shadow: 2px 2px 2px 2px #dfdfdf;width:90px;height: 30px; ">조회</a>
        
       
       
       
         </div>
 <!-- ################################# -->
		<div class="row">
			<%-- <div style="border: 1px blue;width:100%;height:100px;border-radius: 5px;">
				<span style="font-weight: 900px ">${sessionScope.username } </span><br>
				총게시물 <span class="red">..</span> 개 (일반 <span class="red">..</span> + 답변 <span class="red">..</span>)  
			</div> --%>
			
			
			<table class="table" style="margin-top:10px;">
				<tr>
					<th width="10%" class="text-center color_Mgray Back_LG">순번</th>
					<th width="45%" class="text-center color_Mgray Back_LG">제목</th>
					<th width="15%" class="text-center color_Mgray Back_LG">작성자</th>
					<th width="20%" class="text-center color_Mgray Back_LG">작성일</th>
					<th width="10%" class="text-center color_Mgray Back_LG">조회수</th>
				</tr>
				<c:set var="count" value="${count}"/>
				<c:forEach var="vo" items="${bList}">
						<tr>
							<td width="10%" class="text-center">${count}</td>
							<td width="45%"><a href="../board/board_detail.do?no=${vo.no }">${vo.title}</a></td>
							<td width="15%" class="text-center">${vo.user_id}</td>
							<td width="20%" class="text-center">${vo.dbday}</td>
							<td width="10%" class="text-center">${vo.hit}</td>
						</tr>
				<c:set var="count" value="${count-1}"/>
				</c:forEach>
			</table>
			<div style="height: 20px;"></div>
			<div class="text-center">
					<ul class="pagination">
						<c:if test="${startPage>1 }">
							<li><a href="../board/board.do?page=${startPage-1 }">&laquo;
									Previous</a></li>
						</c:if>
						<c:forEach var="i" begin="${startPage }" end="${endPage }">
							<c:if test="${i==curpage }">
								<c:set var="style" value="class=active" />
							</c:if>
							<c:if test="${i!=curpage }">
								<c:set var="style" value="" />
							</c:if>
							<li ${style }><a href="../board/board.do?page=${i }">${i }</a></li>
						</c:forEach>
						
						<c:if test="${endPage<totalpage }">
							<li><a href="../board/board.do?page=${endPage+1 }">Next
									&raquo;</a></li>
						</c:if>
					</ul>
			</div>
		</div>
	</div>
</body>
</html>