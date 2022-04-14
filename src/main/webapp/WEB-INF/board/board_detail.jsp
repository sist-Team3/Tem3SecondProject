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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
 <!--#6699cc #72a4d9  #112444  #dfdfdf  #fda4ba-->
<style type="text/css">
.color_sky{
	color:#B8F8FB;
	font-weight: bold;
}
.color_wh{
	color:white;
	font-wight: bold;
}

.bg_color_navy{
	background-color: #165fa1;
	color:white;
	font-weight: bold;
}
.bg_color_Lgray{
	background-color: #f3f3f3;
}
.color_Mgray{
	color:#999999;
}
.color_sky_point{
	color:#3A85C7;
	font-wight: bold;
}




hr{
	color: #dedede;   
    border-color: #dedede;  
    background-color: #dedede;   
}
.Back_LG{
	background-color: #F3F3F3;
}

/*color:하늘 #59c6d5 #B8F8FB /핑크 #f48fb1  포인트색: #3A85C7 , #579fd3 옅은블랙: #555555 연그레이:#ABABAB dedede 999999*/
th{
	background-color: #f3f3f3;
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
	max-height: 200px;
}
/* .replyClass table>tr>td{
	border-right:none

border-left:none

border-top:none

border-bottom:none
}
 */
 </style>

</head>
<body>
	<div class="container">
		
		<h3 class="text-center">게시판 상세</h3>
		<div class="row vue1">
			<div style="float:right; margin:10px;">
				<button class="btn btn-sm" style="float: inherit;margin-left: 10px;" v-on:click="update()" v-if="idCheck=='true'">수정</button>
				<input type=hidden v-else>
	           	<button class="btn btn-sm" style="float: inherit;margin-left: 10px;" v-on:click="del()" v-if="idCheck=='true'">삭제</button>
	           	<input type=hidden v-else>
	        	<button class="btn btn-sm"style="float: inherit;margin-left: 10px;" v-on:click="list()">목록</button>
	        </div>
			<table class="table">
				<tr>
					<th class="text-center" width="20%">고유번호</th>
					<td class="text-center" width="30%">{{vo.no}}</td>
					<th class="text-center" width="20%">작성일</th>
					<td class="text-center" width="30%">{{vo.dbday}}</td>
				</tr>
				<tr>
					<th class="text-center" width="20%">작성자</th>
					<td class="text-center" width="30%">{{vo.user_id}}</td>
					<th class="text-center" width="20%">조회수</th>
					<td class="text-center" width="30%">{{vo.hit}}</td>
				</tr>
				<tr>
					<th class="text-center" width="20%">제목</th>
					<td colspan="3">{{vo.title}}</td>
				</tr>
				<tr>
					<td colspan="4" valign="top" class="text-left" min-height="200" width="100%">
						<pre style="border: none;white-space: pre-wrap; min-height: 500px">{{vo.content}}</pre>
					</td>
				</tr>
			</table>
					 
		</div>
		<!-- 댓글 등록-->
		<div class="row" ></div>
		<div class="row vue2" >
			<table class="table">
				<tr>
					<td>
						<textarea class="box" placeholder="댓글을 남겨보세요 :)" style="outline-color: none;"rows="8" cols="108" id="content" v-model="content"></textarea>
					</td>
					<td>
						<button class="btn"style="width: 100px;height: 100px;margin-left:0px;" v-on:click="reply()">등록</button>
					</td>
				</tr>
			</table>
		<!-- 댓글 목록-->
		<div class="replyClass">
			<table class="table text-left" style="width: 100%" v-for="rvo in rList">
				<tr style="margin-bottom:3px;">
					<td>                   <!-- style="margin-left:rvo.group_tab*10px"  v-if="rvo.group_tab>0" -->
						<img src="" title="=>" :style="'margin-left:'+(rvo.group_tab*30)+'px'" v-if="rvo.group_tab>0">
						<input type=hidden :value="rvo.no">
						<strong>{{rvo.user_id}}</strong> &nbsp;&nbsp;({{rvo.dbday}})&nbsp;&nbsp;
						
					
						<button class="btn btn-xs"style="float:inherit;" v-if="session_id===rvo.user_id" v-on:click="updateFormOpen(rvo.no,rvo.content)">수정</button>						
						<button class="btn btn-xs"style="float:inherit;" v-if="session_id===rvo.user_id" v-on:click="replyDelete(rvo.no,rvo.content)">삭제</button>
						<!--  <button class="btn btn-sm" style="float: inherit;" v-on:click="good(rvo.no)">하트 +{{rvo.heart}}</button>-->
						<input type=hidden v-if="session_id===rvo.user_id">
						<button  class="btn btn-xs" style="float:right inherit;" v-on:click="replyFormOpen(rvo.no)" v-else>댓글쓰기</button>
					</td>
					
				</tr>
				<!-- 댓글 수정 -->
				<tr>
					<td colspan="2" v-if="updateForm===1 && parentNo===rvo.no">
						<textarea rows="3" cols="50" style="border:none;":value="updateContent" :style="'margin-left:'+(rvo.group_tab*10)+'px'"id="updateContent" v-model="updateContent"v-if="rvo.group_tab>0"></textarea>
						<textarea rows="3" cols="50" style="border:none;" :value="updateContent" id="updateContent" v-model="updateContent" v-else></textarea>
						<button class="btn btn-xs text-right"style="float: inherit;" v-on:click="replyUpdate(rvo.no,updateContent)">확인</button>
						<button class="btn btn-xs text-right"style="float: inherit;" v-on:click="updateCancle()">취소</button>	
					</td>
					<td colspan="2" v-else>
						<textarea rows="3" cols="50" :value="rvo.content" style="border:none;" readonly="readonly" :style="'margin-left:'+(rvo.group_tab*30)+'px'" v-if="rvo.group_tab>0"></textarea>
						<textarea rows="3" cols="50" :value="rvo.content" style="border:none;" readonly="readonly" v-else></textarea>
					</td>
				</tr>
				<!-- 대댓글 입력폼 -->
				<tr v-if="replyForm===1 && parentNo===rvo.no">
					<td>
						<textarea rows="3" cols="50" id="contentReply" v-model="contentReply"></textarea>
					</td>
					<td>
						<button class="btn btn-sm" v-on:click="replyReply()" >등록</button>
						<button class="btn btn-sm text-right"style="float: inherit;" v-on:click="insertCancle()">취소</button>	
					</td>
				</tr>
				<input type=hidden v-else>
				
			</table>
			<table class="table">
				<tr>
					<td class="text-left">
						<button class="btn btn-sm"style="float: inherit;" v-on:click="prev()">&lt;</button>
						<button class="btn btn-sm"style="float: inherit;" v-on:click="next()">&gt;</button>
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