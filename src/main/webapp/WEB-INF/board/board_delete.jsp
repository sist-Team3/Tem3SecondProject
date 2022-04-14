<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
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

.periodBox{
	margin: 30px 0px;
	padding: 20px;
	align-content: center;
	align-items: center;	
	align-self: center;
	border-radius: 8px;
	border: 2px solid #72a4d9;	
	
}
.box-radio-input input[type="checkbox"]{/******************************/
   display:none;
}
.box-radio-input input[type="checkbox"] +span{/******************************/
  display:inline-block;
  background:none;
  border:1px solid #dfdfdf;  
  padding:0px 10px;
  text-align:center;
  height:40px;
  line-height:33px;
  font-weight:500;
  cursor:pointer;
  border-radius: 15px;
  background-color: #f3f3f3;
  color:#999999
}
label{
	cursor: pointer;
}
.box-radio-input input[type="checkbox"]:checked +span{/******************************/
  border:1px solid;
  background:#72a4d9;
  color:white;
  border-radius: 15px;
  font-weight: bold;
  
}

select{
	margin: 0;
	padding: 0;
	font-size: 12px;
	vertical-align: middle;	
}

hr{
	color: #dedede;    /* IE */
    border-color: #dedede;  /* 사파리 */
    background-color: #dedede;   /* 크롬, 모질라 등, 기타 브라우저 */
}
.Back_LG{
	background-color: #F3F3F3;
}

/*color:하늘 #59c6d5 #B8F8FB /핑크 #f48fb1  포인트색: #3A85C7 , #579fd3 옅은블랙: #555555 연그레이:#ABABAB dedede 999999*/
</style>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.min.js"></script>
<script src="http://unpkg.com/axios/dist/axios.min.js"></script>
</head>
<body>
   <div class="container">
     <h1 class="text-center">삭제하기</h1>
     <div class="row">
      <table class="table">
        <tr>
          <td class="text-center">
           비밀번호 : <input type=password id="pwd" size=15 class="input-sm"
              v-model="pwd">
          </td>
        </tr>
        <tr>
          <td class="text-center">
            <button class="btn btn-sm btn-danger" v-on:click="del()">삭제</button>
            <button class="btn btn-sm btn-primary" v-on:click="cancel()">취소</button>
          </td>
        </tr>
      </table>
     </div>
   </div>
   <script>
    new Vue({
    	el:'.container',
    	data:{
    		pwd:'',
    		no:${no},
    		msg:''
    	},
    	methods:{
    		cancel:function(){
    			history.back();
    		},
    		del:function(){
    			let _this=this;
    			if(this.pwd=="")
    			{
    				// 유효성 검사 
    				let p=document.getEelementById("pwd");
    				p.focus();
    				return;
    			}
    			// 서버로 값을 전송 
    			axios.get('http://localhost:8080/web/food/board_delete_ok.do',{
    				// 요청 데이터를 전송하는 영역
    				params:{
    					no:this.no,
    					pwd:this.pwd
    				}
    			// success:function(res)
    			}).then(function(res){
    				console.log(res.data);
    				_this.msg=res.data //YES/NO
    				// function을 사용하면 => this(axios) , => (this는 Vue)
    				if(_this.msg=="YES")
    				{
    					// 이동 => 목록으로 이동 
    					location.href="board.do"; // sendRedirect
    				}
    				else
    				{
    					alert("비밀번호가 틀립니다!!")
    					let i=document.getElementById("pwd");
    					_this.pwd="";
    					i.focus();
    				}
    			})
    		}
    	}
    })
   </script>
</body>
</html>





