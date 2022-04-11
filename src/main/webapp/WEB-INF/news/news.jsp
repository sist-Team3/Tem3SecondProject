<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../resources/css/news.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.min.js"></script>
<script src="http://unpkg.com/axios/dist/axios.min.js"></script>
<script>
$(function(){
	let date = new Date();
	let year = date.getFullYear();
	let month = date.getMonth() + 1;
	let day = date.getDate();
	$('.current_date').append(year+'년'+month+'월'+day+'일')
})
</script>
</head>
<body>
	<div id="newsWrapper">
		<div class="newsTop">
			<div>
				<h1>오늘의 뉴스</h1>
				<span class="current_date"></span>
			</div>
		</div>
		<div class="newsMain">
			<nav class="newsNav">
				<span class="newsSearch">
					<input v-model="fd" type="text" placeholder="검색어를 입력하시오" @keyup.enter="findNews()">
					<button @click="findNews()">
						<span class="ir">검색하기</span>
					</button>
				</span>
			</nav>
			<section class="newsResult">
				<ul>
					<li v-for="vo in news">
						<table class="newsDetail">
							<tr>
								<td rowspan="2">
									<img :src="vo.img" style="width: 220px;height: 150px">
								</td>
								<td class="rowTd">
									<a :href="vo.originallink" target="_blank">{{vo.title}}</a>
								</td>
							</tr>
							<tr class="noRow_two">
								<td>
									<p class="news_desc">{{vo.description}}</p>
									<span>{{vo.pubDate.substring(0,vo.pubDate.indexOf("+"))}}</span>
								</td>
							</tr>
						</table>
					</li>
				</ul>
				<div class="loader">
				</div>
			</section>
		</div>
	</div>
	<script>
		new Vue({
			el:'#newsWrapper',
			data:{
				news:[],
				fd:'부동산'
			},
			mounted:function(){
				this.getNews(this.fd)
			},
			methods:{
				getNews:function(fd){
					if(fd==null){
						alert('검색어를 입력하시오')
						return;
					}
					this.loaderShow()
					axios.get('http://localhost:8080/web/news/data.do',{
						params:{
							fd:fd
						}
					}).then(res=>{
						this.loader()
						console.log(res.data)
						this.news=res.data
					})
				},findNews:function(){
					this.getNews(this.fd)
				},loader:function(){
					let loader=$('div.loader')
					loader.css("display","none");
					$('.newsResult').css("background-color","")
					$('.newsResult').css("opacity","")
				},
				loaderShow:function(){
					let loader=$('div.loader')
					loader.css("display","block"); 
					$('.newsResult').css("background-color","#f8f8f8")
					$('.newsResult').css("opacity","0.5")
				}
			}
		})
	</script>
</body>
</html>