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
						<tr id="tabledown" v-for="vo in apartment_list">
							<td width=5% class="text-center">{{vo.no }}</td>
							<th width=20% class="text-center">{{vo.address }}</th>
							<th width=15% class="text-center">{{vo.road_name }}</th>
							<th width=20% class="text-center">{{vo.name }}</th>							
							<th width=10% class="text-center">{{vo.price}}</th>
							<!-- <th width=10% class="text-center">{{vo.construction_date}}년</th> -->
							<th width=10% class="text-center">{{vo.area_size }} ㎡</th>
							<th width=15% class="text-center">{{vo.contract_date }}</th>
						</tr> 
				</table>
				<div class = "wrapper2" id= "apartpaging">
				<nav class="pagination">
					<ul>
						<li v-if="startPage!=1"><a @click="prev()">&laquo;</a></li>
							<li v-for="i in pageList"><a @click="apartmentlistData(i)">{{i }}</a></li>
						<li v-if="endPage<totalpage"><a @click="next()">&raquo;</a></li> 
					</ul> 
				</nav>				
			</div>
					<div class="heading">
						<input type=text size=20 class="input-sm" style="float: left" v-model="fd" :value="fd">
						 <input type=button value="검색"	class="btn btn-sm btn-danger" @click="findApart()">
					</div>
				</div>
			</div>
		<div class="clear"></div>
		</main>
		</div>
	
		<script>
		axios.defaults.headers.post["Content-Type"] = "application/json; charset=utf-8"
    new Vue({
    	el:'.wrapper',
    	data:{
    		apartment_list:[],
    		curpage:1,
    		totalpage:0,
    		startPage:1,
    		endPage:10,
    		pageList:[],
    		fd:''
    	},
    	mounted:function(){
    		this.apartmentlistData(this.curpage);
    	},
    	methods:{
    		apartmentlistData:function(page){
    			console.log('apart')
    			let _this=this;
    			axios.get("http://localhost:8080/web/product/apartmentlist_vue.do",{
    				params:{
    					page: page,
    					fd:_this.fd
    				}
    			// then(res=>{})
    			}).then(function(res){
    				console.log(res)
    				_this.apartment_list=res.data;
    				_this.curpage=res.data[0].curpage;
    				_this.totalpage=res.data[0].totalpage;
    				_this.startPage=res.data[0].startPage
    				_this.endPage=res.data[0].endPage;
    				_this.pageList=_this.pagingSet()
    			})
    		},
    		prev:function(){
    			this.curpage=this.curpage>1?this.startPage-1:this.curpage;
    			this.apartmentlistData(this.curpage);
    		},
    		next:function(){
    			
    			this.curpage=this.curpage<this.totalpage?this.endPage+1:this.curpage;
    			this.apartmentlistData(this.curpage);
    		},
    		findApart:function(){
    			this.curpage=1;
    			this.apartmentlistData(this.curpage);
    		},
    		pagingSet:function(){
    			let list=[]
    			for(let i=this.startPage; i<=this.endPage;i++){
					list.push(i)
				}
    			return list
    		},
    		
    	}
    })
  </script>
</body>
</html>