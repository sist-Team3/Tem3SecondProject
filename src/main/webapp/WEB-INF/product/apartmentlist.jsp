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
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.min.js"></script>
<script src="http://unpkg.com/axios/dist/axios.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
 <script>
  $( function() {
    $( "#slider-range" ).slider({
      range: true,
      min: 0,
      max: 500,
      values: [ 75, 300 ],
      slide: function( event, ui ) {
        $( "#amount" ).val( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
      }
    });
    $( "#amount" ).val( "$" + $( "#slider-range" ).slider( "values", 0 ) +
      " - $" + $( "#slider-range" ).slider( "values", 1 ) );
  } );
 </script>
<style>
li{
list-style-type: none;
float : left; 
margin-left : 20px;
}
</style>

</head>
<body>

	<div class="wrapper">
	<div class="search-option">
      <input type=text size=20 class="input-sm" id="searchfd" style="float: left" v-model="fd" value="${fd }">
       <input type=button value="검색"   class="btn btn-sm btn-danger" @click="findApart()">
     </div>
	<div>
	<span style="color : #5d5d5d; font-size: 13px;">
       <b>검색 조건</b>
     </div>
 	 <div>
      <li>       
       <input type="checkbox" id="searchadr" name="searchoption" value="지역" >
         <label class="sc1">
                   지역
         </label>
      </li>
       <li>
        <input type="checkbox" id="searchroadname" name="searchoption" value="도로명주소" >
         <label class="sc2">
                    도로명주소
         </label>                                 
      </li>
      <li>
       <input type="checkbox" id="searchname" name="searchoption" value="매물명" >
        <label class="sc3">
                  매물명
        </label>                      
 	 </div>
 	 <p>
  <label for="amount">Price range:</label>
  <input type="text" id="amount" readonly style="border:0; color:#f6931f; font-weight:bold;">
</p>
 
<div id="slider-range"></div>

		
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
							<td width=20% class="text-center">{{vo.address }}</td>
							<td width=15% class="text-center">{{vo.road_name }}</td>
							<td width=20% class="text-center">
										<a :href="'../product/apartmentDetail.do?no='+vo.no">{{vo.name }}</a>
							</td>							
							<td width=10% class="text-center">{{vo.price | currency}}</td>
							 <td width=10% class="text-center">{{vo.construction_date}}년</td>
							<td width=10% class="text-center">{{vo.area_size }} ㎡</td>
							<td width=15% class="text-center">{{vo.contract_date | yyyyMMdd}}</td>
						</tr> 
				</table>
				<div class = "wrapper2" id= "apartpaging">
				<nav class="pagination">
					<ul>
						<li v-if="startPage!=1"><a @click="prev()">&laquo;</a></li>
							<li v-for="i in pageList" :class="i==curpage?{currentRed: isActive}:{currentRed:false}" ><a @click="apartmentlistData(i)">{{i }}</a></li>
						<li v-if="endPage<totalpage"><a @click="next()">&raquo;</a></li> 
					</ul> 
				</nav>				
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
    		fd:$('#searchfd').val(),
    		isActive:true
    	},
    	filters: {
	       currency: function(value) {
	       var num = new Number(value);
	       return num.toFixed(0).replace(/(\d)(?=(\d{3})+(?:\.\d+)?$)/g, "$1,")
	        },
			yyyyMMdd : function(value){ 
	          if(value == '') return '';
	          var js_date = new Date(value);
	          var year = js_date.getFullYear();
	          var month = js_date.getMonth() + 1;
	          var day = js_date.getDate();
	          if(month < 10){
	          	month = '0' + month;
	          }
	          if(day < 10){
	          	day = '0' + day;
	          }
	          return year + '-' + month + '-' + day;
			}
		},
    	mounted:function(){
    		this.apartmentlistData(this.curpage);
    	},
    	methods:{
    		apartmentlistData:function(page){
    			console.log('apart')
    			let _this=this;
    			console.log($('#searchfd').val())
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