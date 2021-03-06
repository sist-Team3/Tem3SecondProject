<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.containerBoard{
	margin-top: 200px;
	width: 80%;
	margin: 0px auto;
	font-size: 20px;
}
.row {
	margin: 0px auto;
	width: 850px;
}
th{
	font-size: 20px;
	background-color : #72a4d9;;
	color:white;
}
tr{
	
}
.top-bar{
   background-color : rgb(31, 45 , 60);
}
/******************************/
.jb-wrap {
				
				margin: 0px auto;
				position: relative;
			}
			.jb-wrap img {
				width: 100%;
				vertical-align: middle;
			}
			.jb-text {
				position: absolute;
				top: 0px;
				width: 100%;
				height: 100%;
			}
			.jb-text-table {
				display: table;
				width: 100%;
				height: 100%;
			}
			.jb-text-table-row {
				display: table-row;
			}
			.jb-text-table-cell {
				display: table-cell;
				vertical-align: middle;
			}
			.jb-text p {
				margin: 0px 40px;
				padding: 10px;
				background-color: #ffffff;
				text-align: center;
			}
.board_btn{
	border:1px solid;
	background:#72a4d9;
	color:white;
	border-radius: 15px;
	font-weight: bold;
}
</style>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.min.js"></script>
<script src="http://unpkg.com/axios/dist/axios.min.js"></script>
<link rel="stylesheet" href="../resources/css/board.css">
</head>
<body>
	<div class="containerBoard">
		<div class="text-center" style="height: 110px;margin: 0px auto;"></div> 
<!-- ################################# -->
<div class="jb-wrap">
			<div class="jb-image" stye="background-color: #ffffff;
        background-color: rgba( 255, 255, 255, 0.5 );"><img class="arw" src="../resources/img/2p.PNG" style="width: 100%;height: 300px;"></div>
			<div class="jb-text">
				<div class="jb-text-table">
					<div class="jb-text-table-row">
						<div class="jb-text-table-cell" style="width:100%;height:100%;">
							<p><span style="width:100%;height:100%;font-size: 50px; background-color: rgba( 255, 255, 255, 1 );color:rgb(31, 45 , 60);">????????? ????????????</span><br>
							
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	
		<div style="height: 50px"></div>
		<!-- <h3 class="text-center"><strong>?????????</strong></h3><br><br> -->
		
		<div class="row"style="width: 100%;height: 100%">
			<table class="table" style="width: 100%;height: 100%">
				<tr>
					<th width="10%" class="text-center" style="vertical-align: middle;">???&nbsp;???&nbsp;???</th>
					<td width="80%">				
						<input type="text" id="user_id" style="padding:10px;color:black;border-style: none;" readonly="readonly" v-model="user_id" >
					</td>
				</tr>
				<tr>
					<th width="10%"class="text-center" style="height:50px; vertical-align: middle;">???&nbsp;&nbsp;&nbsp;&nbsp;???</th>
					<td width="80%">
						<input type="text" size=50 placeholder="??? ??? ???    ??? ??? ??? ??? ???  :)"style="margin:2px 10px;padding:10px;width:70%;border-style: none;background-color: #f3f3f3; border-radius: 8px;"id="title" v-model="title">
					</td>
				</tr>
				<tr>
					<th width="10%"class="text-center" style="vertical-align: middle;">???&nbsp;&nbsp;&nbsp;&nbsp;???</th>
					<td width="80%">
						<textarea rows="10" cols="50"placeholder="??? ??? ???    ??? ??? ??? ??? ???  :)"style="margin:2px 10px;padding:10px;resize:none;width:100%;border-style: none;white-space: pre-wrap; min-height: 500px;background-color: #f3f3f3;border-radius: 15px;" id="content" v-model="content"></textarea>
					</td>
				</tr>
			</table>
			<div style="height: 10px;"></div>
			<div>
				<button class="btn btn-primary btn-sm board_btn text-center" v-on:click="write()">????????????</button>&nbsp;&nbsp;
				<input type="button" class="btn btn-primary btn-sm board_btn" style="float: inherit;" value="??????"
						onclick="javascript:history.back()"
				>
			</div>
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
				let t1 = document.querySelectorAll(".navbar-default.affix .navbar-nav li a")
				t1.forEach(t => t.style.color="white")
				let t2 = document.getElementById("headTitle")
				t2.style.color="white"
				console.log("user_id: "+this.user_id);
				console.log("sessionScope.id : "+'${sessionScope.username}');
			},
			methods:{
				write:function(){
					if(this.title==''){
						alert("????????? ??????????????????.")
						let n=document.getElementById("title");
						n.focus();
						return;
					}
					if(this.content==''){
						alert("????????? ??????????????????.")
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