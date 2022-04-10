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
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.min.js"></script>
<script src="http://unpkg.com/axios/dist/axios.min.js"></script>
</head>

<body>

	
       
	<div class="wrapper">
		<main class="container clear">
		<div class="container" id="apartmentlist">
			<div class="row">
				<table class="table">
					<tr id = "tableup">
						<th width=5% class="text-center">번호</th>
						<th width=20% class="text-center">지역</th>
						<th width=15% class="text-center">도로명 주소</th>
						<th width=20% class="text-center">매물명</th>
						<th width=10% class="text-center">가격<br/>(단위:만원)</th>
						<th width=10% class="text-center">건축년도</th>
						<th width=10% class="text-center">전용면적(㎡)</th>
						<th width=15% class="text-center">거래 일자</th>
						
					</tr>
					<c:forEach var="vo" items="${alist }">
						<tr id="tabledown">
							<td width=5% class="text-center">${vo.no }</td>
							<th width=20% class="text-center">${vo.address }</th>
							<th width=15% class="text-center">${vo.road_name }</th>
							<th width=20% class="text-center">${vo.name }</th>							
							<th width=10% class="text-center"><fmt:formatNumber
									value="${vo.price }" pattern="#,###" /></th>
							<th width=10% class="text-center">${vo.construction_date}년</th>
							<th width=10% class="text-center">${vo.area_size } ㎡</th>
							<th width=15% class="text-center">
							<fmt:formatDate pattern="yyyy-MM-dd" value="${vo.contract_date }"/></th>
							
						</tr>
					</c:forEach>
				</table>
				<div class = "wrapper2" id= "apartpaging">
				<nav class="pagination">
					<ul>
						<c:if test="${startPage>1 }">
							<li><a href="../product/apartmentlist.do?page=${startPage-1 }">&laquo;
									</a></li>
						</c:if>
						<c:forEach var="i" begin="${startPage }" end="${endPage }">
							<c:if test="${i==curpage }">
								<c:set var="style" value="class=current" />
							</c:if>
							<c:if test="${i!=curpage }">
								<c:set var="style" value="" />
							</c:if>
							<li ${style }><a href="../product/apartmentlist.do?page=${i }">${i }</a></li>
						</c:forEach>

						<c:if test="${endPage<totalpage }">
							<li><a href="../product/apartmentlist.do?page=${endPage+1 }">
									&raquo;</a></li>
						</c:if>
					</ul>
				</nav>				
			</div>
					<div class="heading">
						<input type=text size=20 class="input-sm" style="float: left" v-model="fd" :value="fd">
						 <input type=button value="검색"	class="btn btn-sm btn-danger" v-on:click="find()">
					</div>
				</div>
			</div>
		<div class="clear"></div>
		</main>
		</div>
	
		<script>
    new Vue({
    	el:'.container',
    	data:{
    		apartment_list:[],
    		curpage:1,
    		totalpage:0,
    		fd:''
    	},
    	mounted:function(){
    		this.apartmentlistData();
    	},
    	methods:{
    		apartmentlistData:function(){
    			let _this=this;
    			axios.get("http://localhost:8080/web/product/apartmentlist_vue.do",{
    				params:{
    					page:_this.curpage,
    					fd:_this.fd
    				}
    			// then(res=>{})
    			}).then(function(res){
    				console.log(res.data)
    				_this.apartment_list=res.data;
    				_this.curpage=res.data[0].curpage;
    				_this.totalpage=res.data[0].totalpage;
    			})
    		},
    		prev:function(){
    			this.curpage=this.curpage>1?this.curpage-1:this.curpage;
    			this.apartmentlistData();
    		},
    		next:function(){
    			this.curpage=this.curpage<this.totalpage?this.curpage+1:this.curpage;
    			this.apartmentlistData();
    		},
    		find:function(){
    			this.curpage=1;
    			this.apartmentlistData();
    		}
    	}
    })
  </script>
</body>
</html>