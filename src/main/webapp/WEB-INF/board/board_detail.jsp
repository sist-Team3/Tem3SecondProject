<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.min.js"></script>
<script src="http://unpkg.com/axios/dist/axios.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<link rel="stylesheet" type="text/css" href="../resources/css/board.css">
<style type="text/css">
/* .color_Mgray{
	color:#999999;
}
 */.Back_LG{
	background-color: #F3F3F3;
}

th{
	background-color : #72a4d9;
	color:white;
}
/* .box{   
    height: 100px;
    border: 0;
    border-radius: 10px;
    outline: none;
    padding-left: 10px;
    background-color: #f6f6f6;
    box-shadow: 1px 1px gray;
    
} */
textarea {
	resize: none;
	min-width:500px;
	height: 100px;
}
.arw{
	width:23px;
	height:21px;
}
.containerBoard{
	margin-top: 200px;
	width: 80%;
	margin: 0px auto;
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

</head>
<body>
	<!-- <div style="height: 100px;"></div> -->
	<div class="containerBoard">
		<div class="text-center" style="height: 110px;margin: 0px auto;"></div> 
<!-- ------------------------- -->		
		<div class="jb-wrap">
			<div class="jb-image" stye="background-color: #ffffff;
        background-color: rgba( 255, 255, 255, 0.5 );"><img class="arw" src="../resources/img/2p.PNG" style="width: 100%;height: 300px;"></div>
			<div class="jb-text">
				<div class="jb-text-table">
					<div class="jb-text-table-row">
						<div class="jb-text-table-cell" style="width:100%;height:100%;">
							<p><span style="width:100%;height:100%;font-size: 50px; background-color: rgba( 255, 255, 255, 1 );color:rgb(31, 45 , 60);">게시글 상세보기</span><br>
							
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>		
<!-- ------------------------- -->			
		<div style="height: 50px"></div>
		
			
		<!-- <h3 class="text-center">게시판 상세</h3> -->
		<div class="row vue1">
			<div style="float:right; margin:10px;">
				<button class="btn btn-sm board_btn" style="float: inherit;margin-left: 10px;" v-on:click="update()" v-if="idCheck=='true'">수정</button>
				<input type=hidden v-else>
	           	<button class="btn btn-sm board_btn" style="float: inherit;margin-left: 10px;" v-on:click="del()" v-if="idCheck=='true'">삭제</button>
	           	<input type=hidden v-else>
	        	<button class="btn btn-sm board_btn"style="float: inherit;margin-left: 10px;" v-on:click="list()">목록</button>
	        </div>
			<table class="table">
				<tr>
					<th class="text-center" width="20%">고&nbsp;&nbsp;유&nbsp;&nbsp;번&nbsp;&nbsp;호</th>
					<td class="text-center" width="30%">{{vo.no}}</td>
					<th class="text-center" width="20%">작&nbsp;&nbsp;&nbsp;성&nbsp;&nbsp;&nbsp;일</th>
					<td class="text-center" width="30%">{{vo.dbday}}</td>
				</tr>
				<tr>
					<th class="text-center" width="20%">작&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;자</th>
					<td class="text-center" width="30%">{{vo.user_id}}</td>
					<th class="text-center" width="20%">조&nbsp;&nbsp;회&nbsp;&nbsp;수</th>
					<td class="text-center" width="30%">{{vo.hit}}</td>
				</tr>
				<tr>
					<th class="text-center" width="20%">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</th>
					<td colspan="3">{{vo.title}}</td>
				</tr>
				<tr>
					<td colspan="4" valign="top" class="text-left" min-height="200" width="100%">
						<pre style="padding:10px;resize:none;width:100%;border-style: none;white-space: pre-wrap; min-height: 500px;background-color: #f3f3f3;border-radius: 8px;">{{vo.content}}</pre>
					</td>
				</tr>
			</table>
					 
		</div>
		<!-- 댓글 등록-->
		<div class="row" ></div>
		<div class="row vue2" >
			<table class="table" style="width: 100%">
				<tr>
					<td>
						<textarea class="box" placeholder="댓글을 남겨보세요 :)" style="border-style: none;width:100%;white-space: pre-wrap; background-color: #f3f3f3;border-radius: 8px; "rows="8" cols="108" id="content" v-model="content"></textarea>
					</td>
					<td>
						<button class="btn board_btn"style="width: 100%;height: 100px;margin-left:0px;" v-on:click="reply()">등록</button>
					</td>
				</tr>
			</table>
		<!-- 댓글 목록-->
		<div class="replyClass">
			<table class="table text-left" style="width: 100%" v-for="rvo in rList">
				<tr style="margin-bottom:3px;width: 100%">
					<td>                   <!-- style="margin-left:rvo.group_tab*10px"  v-if="rvo.group_tab>0" -->
						<img class="arw" src="../resources/img/arw.png" title="=>" :style="'margin-left:'+(rvo.group_tab*30)+'px'" v-if="rvo.group_tab>0">
						<input type=hidden :value="rvo.no">
						<strong>{{rvo.user_id}}</strong> &nbsp;&nbsp;&nbsp;&nbsp;({{rvo.dbday}})&nbsp;&nbsp;
						
					
						<button class="btn btn-xs board_btn"style="float:inherit;" v-if="session_id===rvo.user_id" v-on:click="updateFormOpen(rvo.no,rvo.content)">수정</button>						
						<button class="btn btn-xs board_btn"style="float:inherit;" v-if="session_id===rvo.user_id" v-on:click="replyDelete(rvo.no,rvo.content)">삭제</button>
						<!--  <button class="btn btn-sm" style="float: inherit;" v-on:click="good(rvo.no)">하트 +{{rvo.heart}}</button>-->
						<input type=hidden v-if="session_id===rvo.user_id">
						<button  class="btn btn-xs board_btn" style="float:right inherit;" v-on:click="replyFormOpen(rvo.no)" v-else>댓글쓰기</button>
					</td>
					
				</tr>
				<!-- 댓글 수정 -->
				<tr>
					<td colspan="2" v-if="updateForm===1 && parentNo===rvo.no">
						<textarea rows="3" cols="50" style="border:none;":value="updateContent" :style="'margin-left:'+(rvo.group_tab*10)+'px'"id="updateContent" v-model="updateContent"v-if="rvo.group_tab>0"></textarea>
						<textarea rows="3" cols="50" style="border:none;" :value="updateContent" id="updateContent" v-model="updateContent" v-else></textarea>
						<button class="btn btn-xs text-right board_btn"style="float: inherit;" v-on:click="replyUpdate(rvo.no,updateContent)">확인</button>
						<button class="btn btn-xs text-right board_btn"style="float: inherit;" v-on:click="updateCancle()">취소</button>	
					</td>
					<td colspan="2" v-else>
						<textarea rows="3" cols="50" :value="rvo.content" style="border:none;" readonly="readonly" :style="'margin-left:'+(rvo.group_tab*30)+'px'" v-if="rvo.group_tab>0"></textarea>
						<textarea rows="3" cols="50" :value="rvo.content" style="border:none;" readonly="readonly" v-else></textarea>
					</td>
				</tr>
				<!-- 대댓글 입력폼 -->
				<tr v-if="replyForm===1 && parentNo===rvo.no">
					<td>
						<textarea style="width: 100%"rows="3" cols="50" id="contentReply" v-model="contentReply"></textarea>
					</td>
					<td>
						<button style="width: 40%;height:100%; inherit;"class="btn btn-sm board_btn" v-on:click="replyReply()" >등록</button>
						<button style="width: 40%;height:100%;"class="btn btn-sm board_btn text-right"style="float: inherit;" v-on:click="insertCancle()">취소</button>	
					</td>
				</tr>
				<input type=hidden v-else>
				
			</table>
			<table class="table">
				<tr>
					<td>
						<button class="btn btn-sm board_btn"style="float:left;" v-on:click="prev()">&lt;</button>
						<button class="btn btn-sm board_btn"style="float:right;" v-on:click="next()">&gt;</button>
					</td>
				</tr>
			</table>
			</div>
		</div>
	</div>
	<script>
	new Vue({
		el:'.vue1',
		data:{
			vo:{},
			no:${no},
			session_id:'${sessionScope.username}',
			user_id:'',
			idCheck:''//
		},
		mounted:function(){
			this.boardList();
		},
		methods:{
			boardList:function(){
				axios.get("http://localhost:8080/web/board/board_detail_vue1.do",{
					params:{
						no:this.no//해당게시물 번호
					}
				}).then(res=>{
					console.log(res.data);
					console.log("sessionID: "+res.data.session_id
								+"	userID: "+res.data.user_id
								+"	idCheck: "+res.data.idCheck);
					this.vo=res.data;
					this.session_id=res.data.session_id;
					this.idCheck=res.data.idCheck;
				})
			},//
			list:function(){
	   			location.href="board.do";
	   		},//
			update:function(){
				location.href="board_update.do?no="+this.no;
			},//
			del:function(){
				axios.get("http://localhost:8080/web/board/board_delete_ok.do",{
					params:{
						no:this.no
					}
				}).then(res=>{
						alert("게시물이 삭제되었습니다.");
						location.href="board.do";
				})
				
			}//
			
		}//
	})
	new Vue({
		el:'.vue2',
		data:{
			no:${no},
			rList:[],
			curpage:1,
			totalpage:0,
			session_id:'${sessionScope.username}',
			content:'',      //댓글내용
			contentReply:'', //대댓글 내용
			parentNo:0,	     //대댓글 입력 대상
			replyForm:0,     //대댓글 입력창 close상태
			updateForm:0,
			updateContent:''
		},
		mounted:function(){
			this.replyList();
		},//
		methods:{
			replyList:function(){
				axios.get("http://localhost:8080/web/board/board_detail_vue2.do",{
					params:{
						no:this.no,//해당게시물 번호
						page:this.curpage//댓글 페이지
					}
				}).then(res=>{
					console.log(res.data);
					this.rList=res.data;
					this.curpage=res.data[0].curpage;
					this.totalpage=res.data[0].totalpage;
					this.session_id=res.data[0].session_id;
				})
			},//
			prev:function(){
				this.curpage=this.curpage>1?this.curpage-1:this.curpage;
				this.replyList();
			},//
			next:function(){
				this.curpage=this.curpage<this.totalpage?this.curpage+1:this.curpage;
				this.replyList();
			},//댓글등록
			reply:function(){//댓글 등록
				if(this.content==''){
					alert("댓글을 입력해주세요.")
					let n=document.getElementById("content");
					n.focus();
					return;
				}
				axios.get("http://localhost:8080/web/board/board_reply_vue.do",{
					params:{
						board_no:this.no,//게시물번호
						content:this.content,
						user_id:this.session_id
					}
				}).then(res=>{
					console.log(res.data);
					this.replyList();
					this.content='';
				})
			},//댓글수정
			updateFormOpen:function(no,content){
				console.log("no:"+no);
				console.log("content:"+content);
				this.parentNo=no; 
				this.updateContent=content;
				this.replyForm=0;
				this.updateForm=1;
			},//
			updateCancle:function(){
				this.updateForm=0;
			},//
			replyUpdate:function(no,content){
				console.log(no);
				console.log(content);
				if(this.updateContent==''){
					alert("댓글을 입력해주세요.")
					let n=document.getElementById("updateContent");
					n.focus();
					return;
				}
				axios.get("http://localhost:8080/web/board/reply_update_vue.do",{
					params:{
						no:no,
						content:content
					}
				}).then(res=>{
					console.log(res.data);
					this.updateForm=0;
					this.replyList();
				})
			},//대댓글추가
			replyFormOpen:function(no){
				
				console.log(no);
				this.parentNo=no; 
				this.updateForm=0;//수정입력창 close
				this.replyForm=1;//댓글입력창 open
				let n=document.getElementById("contentReply");
				n.focus();
			},//
			replyReply:function(){
				if(this.contentReply==''){
					alert("댓글을 입력해주세요.");
					let n=document.getElementById("contentReply");
					n.focus();
					return;
				}
				axios.get("http://localhost:8080/web/board/replyReply_insert_vue.do",{
					params:{
						content:this.contentReply,
						pno:this.parentNo,
						user_id:this.session_id,
						board_no:this.no
					}
				}).then(res=>{
					console.log(res.data);
					this.replyForm=0;//댓글입력창 close
					this.replyList();
					this.contentReply='';
				})
			},
			insertCancle:function(){
				this.replyForm=0;
				this.contentReply='';
			},//(대)댓글삭제
			replyDelete:function(no,content){
				console.log(no);
				alert("댓글이 삭제되었습니다.");
				axios.get("http://localhost:8080/web/board/reply_delete_vue.do",{
					params:{
						no:no
					}
				}).then(res=>{
					console.log(res.data);
					this.replyList();
				})
			}/*,//
			good:function(no){
				axios.get("http://localhost:8080/web/board/reply_good_vue.do",{
					params:{
						no:no,
						user_id:this.session_id
					}
				}).then(res=>{
					console.log(res.data);
				})
			}*///
			
		}
	})
	</script>
</body>
</html>