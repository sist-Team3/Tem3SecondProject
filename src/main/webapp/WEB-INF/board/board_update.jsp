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
						<input type="text" readonly="readonly" :value="user_id" v-model="user_id">
						<input type="hidden" v-model="no" :value="no">
					</td>
				</tr>
				<tr>
					<th width="20%">제목</th>
					<td width="80%">
						<input type="text" size=50 v-model="title" :value="title">
					</td>
				</tr>
				<tr>
					<th width="20%">내용</th>
					<td width="80%">
						<textarea rows="10" cols="50" v-model="content">{{content }}</textarea>
					</td>
				</tr>
				<!-- <tr>
					<th width="20%">비밀번호</th>
					<td width="80%">
						<input type="password" name="pwd" >
					</td>
				</tr> -->
				<tr>
					<td colspan="2">
						<button class="btn btn-sm" style="float: inherit;" value="수정" v-on:click="boardUpdate()">
						<input type="button" class="btn btn-sm text-right" style="float: inherit;" value="취소"
							onclick="javascript:history.back()"
						>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<script>
	new Vue({
		el:'.row',
		data:{
			no:${no},
			user_id:'',
			title:'',
			content:''
		},//
		mounted:function(){
			axios.get("http://localhost:8080/web/board/board_update_vue.do",{
				params:{
					no:this.no
				}
			}).then(res=>{
				this.user_id=res.data.user_id;
				this.title=res.data.title;
				this.content=res.data.content;
			})
		},
		methods:{
			boardUpdate:function(){
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
				axios.get("http://localhost:8080/web/board/board_update_ok.do",{
					params:{
						no:this.no,
						user_id:this.user_id,
						title:this.title,
						content:this.content
					}
				}).then(res=>{
					if(res.data=="Y"){
						location.href="../board/board_detail.do?no="+this.no;
					}
				})
			}
		}//
	})
	</script>
</body>
</html>