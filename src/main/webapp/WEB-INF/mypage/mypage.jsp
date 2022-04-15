<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../resources/css/mypage.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.min.js"></script>
<script src="http://unpkg.com/axios/dist/axios.min.js"></script>
<script type="text/javascript" >
$(function(){
	$('.navbar-default').css('background-color','#1F2D3C')
	$('.navbar-default.affix .navbar-nav li a').css('color','white')
	$('.navbar-default.affix .container .navbar-header a.dark').css('color','white')
	$('#account-delete').hover(function(){
		$(this).css('cursor','pointer')
	})
	$()
	const openButton = document.querySelector("#account-delete");
	const modal = document.querySelector(".modal");
	const closeButton = modal.querySelector("#btn_modal_close");
	const modalBackground = modal.querySelector(".modal__background");
	function displayModal(){
	    modal.classList.toggle("hidden");
	}
	openButton.addEventListener("click", displayModal);
	closeButton.addEventListener("click", displayModal)
	modalBackground.addEventListener("click", displayModal);
})
function telMax(el, maxlength) {
  if(el.value.length > maxlength)  {
    el.value 
      = el.value.substr(0, maxlength);
  }
}

</script>
</head>
<body>
	<div class="wrapper">
	    <div class="container" id="myPage">
	        <div class="content-title">
	            <span id="main-title">내 계정</span>
	            <button id="account-delete" >회원탈퇴</button>
	        </div>        
	        <div class="modal hidden">
			  <div class="modal__background"></div>
			  <div class="modal__content">
			    <h3>회원탈퇴</h3>
			    <div id="modal_del">
			    	<p style="color: red">※ 탈퇴한 아이디로는 다시 가입할 수 없습니다.<br>
					※ 탈퇴한 뒤에는 아이디 및 데이터를 복구할 수 없으니 <br>&nbsp;&nbsp;&nbsp;&nbsp;신중히 진행해 주시기 바랍니다.
			    	</p>
			    	<span>비밀번호</span> 
			    	<input type="password" size=20 id="delete_pwd" v-model="pwd.delete_pwd">
			    </div>
			    <div id="modal_btn">
			    	<button id="btn_modal_delete" v-on:click="deleteUser()">탈퇴</button>
			    	<button id="btn_modal_close">취소</button>
			    </div>
			  </div>
			</div>
	        <div id="profile-body">
	        	<h2>최근 본 거래</h2>
	        	<table id="recent-table">
	        		<tr>
						<th width=24% class="text-center">지역</th>
						<th width=16% class="text-center">도로명 주소</th>
						<th width=25% class="text-center">매물명</th>
						<th width=10% class="text-center">가격<br/>(단위:만원)</th>
						<th width=10% class="text-center">건축년도</th>
						<th width=15% class="text-center">거래 일자</th>
					</tr>
					<tr v-for="vo in recent">
						<td width=22% class="text-center">{{vo.address}}</td>
						<td width=18% class="text-center">{{vo.road_name}}</td>
						<td width=25% class="text-center">
							<a :href="vo.type==1?'../product/apartmentDetail.do?no='+vo.no:
										vo.type==2?'../product/officetelDetail.do?no='+vo.no:
													'../product/villaDetail.do?no='+vo.no">
								<b>{{vo.name}}</b>
							</a>
						</td>
						<td width=10% class="text-center">{{vo.price | currency}}</td>
						<td width=10% class="text-center">{{vo.construction_date==null?vo.construction_year:vo.construction_date}}년</td>
						<td width=15% class="text-center">{{vo.contract_date | yyyyMMdd}}</td>
					</tr>
	        	</table>
	            <h2>개인정보</h2>
	                <table id="profile-table">
	                    <tr>
	                        <th>* 이름</th>
	                        <td colspan="3">
	                            <input type="text" id="name" class="form-control name" v-model="user.name"  maxlength="10" @keyup="checkup()">
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>* 생년월일</th>
	                        <td colspan="3">
	                            <input type="date" id="birth" class="form-control" style="width: 150px" v-model="user.dbday" @keyup="checkup()">
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>* 휴대폰 번호</th>
	                        <td colspan="3">
	                            <div class="row">
	                                <div class="col-xs-3">
	                                    <select v-model=tel[0] class="form-control" >
	                                       <option value="010">010</option><option value="011">011</option><option value="016">016</option><option value="017">017</option><option value="018">018</option><option value="019">019</option>
	                                    </select>
	                                </div>
	                                <div class="col-xs-3">
	                                    <input type="number" id="mobile1" oninput="telMax(this,4)" v-model="tel[1]"  class="form-control input-tel" @keyup="checkup()">
	                                </div>
	                                <div class="col-xs-3">
	                                    <input type="number" id="mobile2" oninput="telMax(this,4)" v-model="tel[2]"  class="form-control input-tel" @keyup="checkup()">
	                                </div>
	                            </div>    
	                        </td>
	                    </tr>
	                    <tr class="available-time-block">
	                        <th>* 주소</th>
	                        <td colspan="3">
	                            <div class="row">
	                               <input type=text id="post" class="form-control" size="10" v-model="user.postcode"  readonly @keyup="checkup()">
						         	<a id="upostBtn" @click="postFindBtn()"
						          	class="btn btn-sm btn-success">
						          	우편번호찾기
						          	</a>
	                            </div>
	                            <div class="row">
	                            	<input type="text" v-model="user.address1" class="form-control address1" id="address1" readonly size="40" @keyup="checkup()">
	                            </div>
	                            <div class="row">
	                                <input type="text" v-model="user.address2" class="form-control address2">
	                            </div>
	                        </td>
	                    </tr>
	               </table>
	               <div class="text-right">
	                    <button v-on:click="updateMy()" class="btn btn-info btn-sm btn-block profile-update">수정하기</button>
	                </div>
	                <h2>비밀번호 변경</h2>
	                <table id="email-table">
	                	<tr>
	                        <th>이메일 인증</th>
	                        <td colspan="3">
	                        	<input type="email" id="email" v-model="user.email"  class="form-control email" readonly>
	                            <a @click="emailSend()" class="btn btn-sm btn-success" id="email_send">이메일 인증</a>
	                            <div>
	                            	<input type="number" id="confirm_email" class="form-control email" oninput="telMax(this,6)" style="margin-top: 5px" readonly> 
	                            	<a @click="emailCheck()" class="btn btn-sm btn-warning" id="emailCk_btn" >인증</a>
	                            	<span id="timer" style="color:red"></span>
	                            </div>
	                        </td>
	                    </tr>
	                </table>
	                <table id="password-table" style="display: none">
	                    <tr>
	                        <th>현재 비밀번호</th>
	                        <td>
	                            <input type="password" v-model="pwd.now_pwd" id="now_pwd" class="form-control" placeholder="현재 비밀번호를 입력해주세요.">
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>비밀번호</th>
	                        <td>
	                            <input type="password" v-model="pwd.change_pwd" id="change_pwd" class="form-control" placeholder="숫자/영문/특수문자 조합 9자 이상만 가능합니다." @keyup="chkPW()" >
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>비밀번호 확인</th>
	                        <td>
	                            <input type="password" v-model="pwd.confirm_pwd" id="confirm_pwd" class="form-control" placeholder="비밀번호를 재입력해주세요.">
	                        </td>
	                    </tr>
	                </table>
	                <div class="text-right">
	                    <button v-on:click="updatePwd()" class="btn btn-info btn-sm btn-block profile-update">변경하기</button>
	                </div>
	        </div>
	    </div>
	</div>
	<script>
	axios.defaults.headers.post["Content-Type"] = "application/json; charset=utf-8"
		new Vue({
			el:'#myPage',
			data:{
				user:{},
				tel:[],
				pwd:{},
				email_ck:0,
				email_confirm:'NO',
				recent:[],
				type:''
			},
			mounted:function(){
				this.getData();
				this.getRecent();
			},
			methods:{
				getData:function(){
					axios.get("http://localhost:8080/web/mypage/mypage_vue.do",{
					}).then(res=>{
						console.log(res.data)
						this.user=res.data
						this.user.prevEmail=res.data.email
						console.log('postcode= '+this.user.postcode)
						console.log('address1= '+this.user.address1)
						let tmp = String(res.data.phone)
						if(tmp.length>10){
							this.tel[0] = tmp.substring(0,3)
							this.tel[1] = tmp.substring(3,7)
							this.tel[2] = tmp.substring(7,11)
						}else{
							this.tel[0] = tmp.substring(0,3)
							this.tel[1] = tmp.substring(3,6)
							this.tel[2] = tmp.substring(6,10)
						}
					})
				},getRecent:function(){
					axios.get("http://localhost:8080/web/mypage/mypage_recent.do",{
					}).then(res=>{
						console.log(res.data)
						this.recent=res.data
					})
				},
				checkup:function(){
					console.log('checkup')
					$('span#validation').remove()
					if($.trim(this.user.name)==""){
						this.validAlert('name','이름을 입력하시오!');
						return false;
					}
					else if($.trim(this.user.dbday)==""){
						this.validAlert('birth','생년월일을 입력하시오!');
						return false;
					}
					else if($.trim(this.tel[1])=="" ||$.trim(this.tel[1]).length<3){
						this.validAlert('mobile1','&emsp;3~4자리 번호를 입력하시오!');
						return false;
					}
					else if($.trim(this.tel[2])=="" ||$.trim(this.tel[2]).length<4){
						this.validAlert('mobile2','&emsp;4자리 번호를 입력하시오!');
						return false;
					}
					else if($.trim(this.user.postcode)==""){
						this.validAlert('postcode','주소를 입력하시오!');
						return false;
					}else{
						return true;
					}
					
				},updateMy:function(){
					window.scrollTo(0,200);
					if(this.checkup()){
						/* if(this.user.prevEmail!=this.user.email){
							if(this.email_confirm=='NO'){
								$('#timer').remove()
								this.validAlert('email_send','&emsp;이메일 인증을 다시 하시오!')
								$('#confirm_email').focus()
								return false;
							}
							if(this.email_confirm!='OK'){
								this.validAlert('timer','&emsp;인증코드를 입력하시오!')
								$('#confirm_email').focus()
								return false;
							} */
						this.user.phone=this.tel[0]+this.tel[1]+this.tel[2]
						axios.post("http://localhost:8080/web/mypage/mypage_update.do",this.user,{
								headers: {
				                    "Content-Type": "application/json;charset=utf-8"
				                },
						}).then(res=>{
								console.log(res.data)
								alert("정보가 수정되었습니다!")
								location.href="../mypage/main.do"
						})
					}else{
						return
					}
				}
				,chkPW:function(){
					 $('span#validation').remove()
					 let pw = this.pwd.change_pwd
					 let eng = pw.search(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[~!@#$%^&*()+|=])[A-Za-z\d~!@#$%^&*()+|=]{8,16}$/ig);
					 if(pw.search(/\s/) != -1){
						this.validAlert('change_pwd','비밀번호는 공백 없이 입력하시오.')
					  	return false;
					 }else if(pw.length < 9 || pw.length > 16){
						 this.validAlert('change_pwd','비밀번호는 9 ~ 16자리 사이로 입력하시오!');
					  	return false;
					 }else if(eng < 0 ){
						 this.validAlert('change_pwd','영문,숫자,특수문자를 혼합하여 입력하시오.');
					  	return false;
					 }else if(pw==this.pwd.now_pwd){
						 this.validAlert('change_pwd','현재 비밀번호와 같습니다!')
						return false;
					 }else {
						console.log("통과"); 
					    return true;
					 }
				},
				updatePwd:function(){
					$('span#validation').remove()
					let pwdCheck=false;
					if(this.email_ck == 0){
						alert('이메일 인증 후 비밀번호 변경이 가능합니다!')
						return
					}
					if($.trim(this.pwd.now_pwd)==""){
						this.validAlert('now_pwd','비밀번호를 입력하시오!')
						return;
					}
					if($.trim(this.pwd.change_pwd)==""){
						this.validAlert('change_pwd','비밀번호를 입력하시오!')
						return;
					}
					pwdCheck=this.chkPW()
					if(!pwdCheck)
						return;
					if($.trim(this.pwd.confirm_pwd)==""){
						this.validAlert('confirm_pwd','비밀번호를 입력하시오!')
						return;
					}
					
					if(this.pwd.change_pwd===this.pwd.confirm_pwd){
						axios.post("http://localhost:8080/web/mypage/mypage_pwd_update.do",JSON.stringify(this.pwd)
						).then(res=>{
							if(res.data=='NO'){
								this.validAlert('now_pwd','비밀번호가 틀렸습니다!')
								$('#now_pwd').val("")
								return;
							}
							alert("비밀번호가 변경되었습니다.!");
							location.href="../logout"
							this.$session.clear()
							
						})
					}else{
						this.validAlert('confirm_pwd','비밀번호가 다릅니다!')
						$('#confirm_pwd').val("")
						return;
					}
				},
				deleteUser:function(){
					$('span#validation').remove()
					if($.trim(this.pwd.delete_pwd)==""){
						this.validAlert('modal_del','&emsp;&emsp;&emsp;&emsp;비밀번호를 입력하시오!')
						return;
					}
					axios.post("http://localhost:8080/web/mypage/mypage_delete.do",this.pwd.delete_pwd
						).then(res=>{
						if(res.data=='NO'){
							this.validAlert('modal_del','&emsp;&emsp;&emsp;&emsp;비밀번호가 틀렸습니다!')
							$('#modal_del').val("")
						}else{
							alert("회원탈퇴가 완료되었습니다!");
							location.href="../logout"
							this.$session.clear()
						}
					})		
				}, 
				emailSend:function(){
					$('span#validation').remove()
					/*
					 let regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
					 if(this.user.email==this.user.prevEmail){
						this.validAlert('email_send','&emsp;기존 email과 같습니다!')
						return;
					}
					if (regEmail.test(this.user.email) === false){
				          alert('이메일 형식으로 입력하시오.');
				          return;
				      } */
					this.sendAuthNum();
					alert("인증번호를 발송했습니다.")
					$('#confirm_email').attr('readonly',false)
					this.email_ck=1
					$('#confirm_email').focus()
					axios.post("http://localhost:8080/web/mypage/sendMail.do",this.user.email
							).then(res=>{
								this.email_confirm=res.data.code
							})
				},
				emailCheck:function(){
					$('span#validation').remove()
					let code=$('#confirm_email').val()
					if(this.email_ck==0){
						alert('이메일 인증을 진행하시오!')
						return;
					}
					if(code==""){
						this.validAlert('timer','&emsp;인증코드를 입력하시오!')
						$('#confirm_email').focus()
						return;
					}
					if(code.length<6){
						this.validAlert('timer','&emsp;6자리 인증코드를 입력하시오!')
						$('#confirm_email').focus()
						return;
					}
					if($('#confirm_email').val()==this.email_confirm){
						clearInterval(timer);
						$('#timer').text("OK")
						alert("이메일이 인증 되었습니다!")
						$('#confirm_email').attr('readonly',true)
						this.email_confirm='OK'
						$('#password-table').show()
					}else{
						this.validAlert('timer','&emsp;인증번호가 다릅니다!')
						this.email_confirm='NO'
						$('#confirm_email').focus()
					}
					
				},
				sendAuthNum:function(){
					// 남은 시간
					var leftSec = 180,
					display = document.querySelector('#timer');
					// 이미 타이머가 작동중이면 중지
					this.startTimer(leftSec, display);
				},
				startTimer:function (count, display) {
					var minutes, seconds;
					_this = this
					let _email_confirm=this.email_confirm
					timer = setInterval(function () {
						minutes = parseInt(count / 60, 10);
						seconds = parseInt(count % 60, 10);
						minutes = minutes < 10 ? "0" + minutes : minutes;
						seconds = seconds < 10 ? "0" + seconds : seconds;
						display.textContent = minutes + ":" + seconds;
						// 타이머 끝
						if (--count < 0) {
							console.log('count')
							$('#confirm_email').attr('readonly',true)
							$('span#validation').remove()
							display.textContent = '인증시간이 만료되었습니다.'
							_this.email_ck=0
							_this.email_confirm='NO'
							clearInterval(timer)
						}
					}, 1000);
				},
				validAlert:function(sel,msg){
					html="<span id='validation' style='color:red;white-space: nowrap;'>"+msg+"</span>"
					let s = '#'+sel
					$(s).focus();
					$(s).after(html)
				},
				postFindBtn:function(){
					_this=this
					_this.user.address2='';
					new daum.Postcode({
						oncomplete:function(data)
						{
							_this.user.postcode=data.zonecode
							_this.user.address1=data.address
						}
					}).open()
				}
			},
			filters: {
			    	currency: function(value) {
				       var num = new Number(value);
				       return num.toFixed(0).replace(/(\d)(?=(\d{3})+(?:\.\d+)?$)/g, "$1,")
				    },
					yyyyMMdd : function(value){ 
				        if(value == '') return '';
				        let js_date = new Date(value);
				        let year = js_date.getFullYear();
				        let month = js_date.getMonth() + 1;
				        let day = js_date.getDate();
				        if(month < 10){
				      	month = '0' + month;
				    }
				    if(day < 10){
				        day = '0' + day;
				    }
				    return year + '-' + month + '-' + day;
				}
			}
		})
	</script>
</body>
</html>