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
					<input v-model="fd" type="text" placeholder="검색어를 입력하시오" @keyup.enter="findNews()" size=20 
						style="height: 40px;font-size: 17px;">
					<button @click="findNews()">
						<span class="ir">검색</span>
					</button>
				</span>
				<ul class="pagination">
					<li :class="page==1?'active':''"><a @click="findPage(1)">1</a></li>
					<li :class="page==2?'active':''"><a @click="findPage(2)">2</a></li>
					<li :class="page==3?'active':''"><a @click="findPage(3)">3</a></li>
					<li :class="page==4?'active':''"><a @click="findPage(4)">4</a></li>
					<li :class="page==5?'active':''"><a @click="findPage(5)">5</a></li>
				</ul>
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
									<span style="font-size: 15px">{{vo.pubDate | yyyyMMdd}}</span>
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
				fd:'부동산',
				page:1
			},
			mounted:function(){
				this.getNews()
			},
			methods:{
				getNews:function(){
					if(this.fd==null){
						alert('검색어를 입력하시오')
						return;
					}
					this.loaderShow()
					axios.get('http://localhost:8080/web/news/data.do',{
						params:{
							fd:this.fd,
							page:this.page
						}
					}).then(res=>{
						this.loader()
						console.log(res.data)
						this.news=res.data
						this.page=res.data[0].page
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
				},findPage:function(pages){
					this.page=pages
					this.getNews()
				}
			},
			filters: {
				yyyyMMdd : function(value){ 
			        if(value == '') 
			        	return '';
			        let js_date = new Date(value);
			        let year = js_date.getFullYear();
			        let month = js_date.getMonth() + 1;
			        let day = js_date.getDate();
			        let hour = js_date.getHours();
			        let minutes = js_date.getMinutes();
			        if(month < 10){
			      	month = '0' + month;
			    }
			    if(day < 10){
			        day = '0' + day;
			    }
			    if(hour< 10){
			        hour = '0' + hour;
			    }
			    if(minutes< 10){
			        minutes = '0' + minutes;
			    }
			    return year + '-' + month + '-' + day +'  '+hour+':'+minutes
			}
		}
		})
	</script>
</body>
</html>