<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="../resources/css/apartmentlist.css">
<link rel="stylesheet" href="../resources/img/apartmap.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.min.js"></script>
<script src="http://unpkg.com/axios/dist/axios.min.js"></script>
<script type="text/javascript">
let i=0;
$(function(){
	$('.images').hover(function(){
		$(this).css("cursor","pointer");
	},function(){
		$(this).css("cursor","none")
	})
	
	$('.images').click(function(){
		let gu=$(this).attr("data-value");
		for(let i=1;i<=25;i++)
		{
			$('#gu'+i).attr("src","../resources/img/map/gu_"+i+"_off.png")
		}
		$(this).attr("src","../resources/img/map/gu_"+gu+"_on.png")
	})
	
})
</script>
</head>
<body>
	<div class="container" id="apartmentlist">
		<main class="container clear">
			<div class="wrapper">
			<!-- 검색 옵션 -->
				<div class="search-option">
				<!-- 지도로 찾기  -->
				<div class="search-option3">
				 	 <b type=text id="search-text">지도에서 원하는 지역을 선택하세요!</b>
				 	 <img id="seoul_1" src="../resources/img/map/1111.png">
				 	 <c:forEach var="i" begin="1" end="25">
				 		<img id="gu${i }" src="../resources/img/map/gu_${i }_off.png" class="images" data-value="${i }" @click="mapFindvilla(${i })">
				 	 </c:forEach>
				</div>		
				<div class="search-option1">
			     	<input type=text size=20 class="input-sm" id="searchfd" style="float: left" v-model="fd" value="${fd }" @keyup.enter="findvilla()">
			        <input type=button value="검색" id="searchbtn"  class="btn btn-sm btn-danger" @click="findvilla()">
			    </div>
				<div class="search-option2">
					<ul class="search-option4">
						<li class="search-option5">
							<span style="color : #5d5d5d; font-size: 13px;">
			       				<b>검색 조건</b>
			       			</span>
						</li>
				     	<li id="option">       
					        <input type="checkbox" id="searchadr" v-model="checkOption" value="지역" >
					        <label for="searchadr">
					                   지역
					         </label>
				        </li>
				      	 <li id="option">
					         <input type="checkbox" id="searchroadname" v-model="checkOption" value="도로명주소" >
					         <label for="searchroadname">
					                  도로명주소
					         </label>                                 
				      	 </li>
				      	 <li id="option">
					         <input type="checkbox" id="searchname" v-model="checkOption" value="매물명" >
					         <label for="searchname">
					                  매물명
					         </label>
				        </li> 
			      </ul>                      
	<!-- 		      <li class="option"> -->
	<!-- 				<input type="text" id="datepicker"> -->
	<!-- 		        <label class="sc3"> -->
	<!-- 		      	   거래일자 -->
	<!-- 		        </label> -->
	<!-- 		      </li>                       -->
	<!--  	 <p> -->
	<!--   <label for="amount">Price range:</label> -->
	<!--   <input type="text" id="amount" readonly style="border:0; color:#f6931f; font-weight:bold;"> -->
	<!-- </p> -->
			 	 </div>
	<!--정렬 -->
				<div class="search-sort">
					<ul id="search-sort1">
						<li id="rsort">
							<span style="color : #5d5d5d; font-size: 13px;"> 
								<b id="sc">정렬하기</b>
							</span>
						</li>
						<li id="rsort">
							<a :class="sort=='price'?'sorted':''"  @click="sortBtn('price')">가격순</a>
						</li>
						<li id="rsort">
							<a :class="sort=='construction'?'sorted':''" @click="sortBtn('construction')">건축년도순</a>
						</li>
						<li id="rsort">
							<a :class="sort=='size'?'sorted':''" @click="sortBtn('size')">전용면적순</a>
						</li>
						<li id="rsort">
							<a :class="sort=='contract'?'sorted':''" @click="sortBtn('contract')">거래일자순</a>
						</li>
					</ul>
			 </div>
			 </div>
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
							<tr id="tabledown" v-for="(vo,index) in villa_list">
								<td width=5% class="text-center">{{(curpage-1)*20+index+1 }}</td>
								<td width=20% class="text-center">{{vo.address }}</td>
								<td width=15% class="text-center">{{vo.road_name }}</td>
								<td width=20% class="text-center">
											<a :href="'../product/cookie.do?type=3&no='+vo.no">{{vo.name }}</a>
								</td>							
								<td width=10% class="text-center">{{vo.price | currency}}</td>
								 <td width=10% class="text-center">{{vo.construction_year}}년</td>
								<td width=10% class="text-center">{{vo.area_size }} ㎡</td>
								<td width=15% class="text-center">{{vo.contract_date | yyyyMMdd}}</td>
							</tr> 
					</table>
					<div class = "wrapper2" id= "apartpaging">
					<nav class="pagination">
						<ul>
							<li v-if="startPage!=1"><a @click="prev()">&laquo;</a></li>
								<li v-for="i in pageList" :class="i==curpage?{currentRed: isActive}:{currentRed:false}" ><a @click="villalistData(i)">{{i }}</a></li>
							<li v-if="endPage<totalpage"><a @click="next()">&raquo;</a></li> 
						</ul> 
					</nav>				
				</div>
				</div>
				<div class="clear"></div>
				</div>
			</main>
		</div>
		<script>
	    new Vue({
	    	el:'.wrapper',
	    	data:{
	    		villa_list:[],
	    		curpage:1,
	    		totalpage:0,
	    		startPage:1,
	    		endPage:10,
	    		pageList:[],
	    		fd:$('#searchfd').val(),
	    		isActive:true,
	    		checkOption:['지역'],
	    		sort:'contract',
	    		gu:''
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
	    		this.villalistData(1);
	    	},
	    	methods:{
	    		villalistData:function(page){
	    			console.log('villa')
	    			let _this=this;
	    			let data = new Object() ;
	    			data.page = page
	    			data.fd=_this.fd
	    			data.sort=_this.sort
	    			data.checkOption=_this.checkOption
	    			data.gu=_this.gu
	    			if(_this.fd.length>0){
	    				data.gu=''
	    				let i = _this.gu.substring(9)
	    				$('#gu'+i).attr("src","../resources/img/map/gu_"+i+"_off.png")
	    			}
	    			axios.post("http://localhost:8080/web/product/villalist_vue.do",JSON.stringify(data),{
	    				headers: {
		                    "Content-Type": "application/json;charset=utf-8"
		                },
	    			}).then(function(res){
	    				console.log(res)
	    				_this.villa_list=res.data;
	    				_this.curpage=res.data[0].curpage;
	    				_this.totalpage=res.data[0].totalpage;
	    				_this.startPage=res.data[0].startPage
	    				_this.endPage=res.data[0].endPage;
	    				_this.pageList=_this.pagingSet()
	    				_this.sort=res.data[0].sort;
	    			})
	    		},
	    		prev:function(){
	    			this.curpage=this.curpage>1?this.startPage-1:this.curpage;
	    			this.villalistData(this.curpage);
	    		},
	    		next:function(){
	    			
	    			this.curpage=this.curpage<this.totalpage?this.endPage+1:this.curpage;
	    			this.villalistData(this.curpage);
	    		},
	    		findvilla:function(){
	    			this.curpage=1;
	    			this.villalistData(this.curpage);
					if(this.fd == 0){
						alert('검색어를 입력해주세요!')
						return
					}
	    		},
	    		pagingSet:function(){
	    			let list=[]
	    			for(let i=this.startPage; i<=this.endPage;i++){
						list.push(i)
					}
	    			return list
	    		},
	    		sortBtn:function(sort){
	    			this.sort=sort
	    			this.villalistData(1)
	    		},
	    		mapFindvilla:function(gu){
	    			this.gu='searchMap'+gu
	    			this.fd=''
	    			this.checkOption.push('지역')
	    			this.villalistData(1)
	    		}
	    	}
	    })
  </script>
</body>
</html>