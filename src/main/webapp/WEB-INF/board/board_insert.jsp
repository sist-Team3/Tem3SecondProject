<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.continer {
	margin-top: 50x;
}

.row {
	margin: 0px auto;
	width: 850px;
}
</style>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.min.js"></script>
<script src="http://unpkg.com/axios/dist/axios.min.js"></script>
<link rel="stylesheet" href="../resources/css/board.css">
</head>
<body>
	<div class="container">
		<div style="height: 100px"></div>
		<h1 class="text-center">게시판 상세</h1>
		<div class="row">
			<table class="table">
				<tr>
					<th width="20%">닉네임</th>
					<td width="80%">				
						<input type="text" id="user_id" readonly="readonly" v-model="user_id" >
					</td>
				</tr>
				<tr>
					<th width="20%">제목</th>
					<td width="80%">
						<input type="text" size=50 id="title" v-model="title">
					</td>
				</tr>
				<tr>
					<th width="20%">내용</th>
					<td width="80%">
						<textarea rows="10" cols="50" id="content" v-model="content"></textarea>
					</td>
				</tr>
			</table>
			<table>
				<tr>
					<td colspan="3"class="text-right">
						<button class="btn btn-sm" v-on:click="write()">등록하기</button>
					</td>
				</tr>
			</table>
			<div style="height: 50px"></div>
		</div>
	</div>
			<!-- user_id:${user_id} -->
	<script>
		new Vue({
			el:'.row',
			data:{
				user_id:'${sessionScope.username}',
				title:'',
				content:''
			},
			mounted:function(){
				console.log("user_id: "+this.user_id);
				console.log("sessionScope.id : "+'${sessionScope.username}');
			},
			methods:{
				write:function(){
					if(this.title==''){
						alert("제목을 입력해주세요.")
						let n=document.getElementById("title");
						n.focus();
						return;
					}
					if(this.content==''){
						alert("내용을 입력해주세요.")
						let n=document.getElementById("content");
						n.focus();
						return;
					}
					axios.get("http://localhost:8080/web/board/board_insert_vue.do",{
						params:{
							user_id:this.user_id,
							title:this.title,
							content:this.content,
							pwd:this.pwd
						}
					}).then(res=>{
						if(res.data=="Y"){
							location.href="../board/board.do";
						}
					})
				}//
			}
		})
	</script>
			

</body>
</html>