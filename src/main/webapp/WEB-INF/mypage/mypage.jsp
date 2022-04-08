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
function postFindBtn(){
	$('#address2').val('')
	new daum.Postcode({
		oncomplete:function(data)
		{
			$('#post').val(data.zonecode)
			$('#address1').val(data.address)
		}
	}).open()
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
	            <h2>개인정보</h2>
	                <table id="profile-table">
	                    <tr>
	                        <th>* 이름</th>
	                        <td colspan="3">
	                            <input type="text" id="name" class="form-control name" v-model="user.name"  maxlength="20">
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>* 생년월일</th>
	                        <td colspan="3">
	                            <input type="date" id="birth" class="form-control" style="width: 150px" v-modle="user.dbday" :value="user.dbday" >
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
	                                    <input type="number" id="mobile1" oninput="telMax(this,4)" v-model="tel[1]"  class="form-control input-tel">
	                                </div>
	                                <div class="col-xs-3">
	                                    <input type="number" id="mobile2" oninput="telMax(this,4)" v-model="tel[2]"  class="form-control input-tel">
	                                </div>
	                            </div>    
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>이메일 주소</th>
	                        <td colspan="3">
	                        	<input type="email" id="email" v-model="user.email"  class="form-control email">
	                            <a @click="emailSend()" class="btn btn-sm btn-success" id="email_send">이메일 인증</a>
	                            <div>
	                            	<input type="number" id="confirm_email" class="form-control email" oninput="telMax(this,6)" style="margin-top: 5px" readonly> 
	                            	<a @click="emailCheck()" class="btn btn-sm btn-warning" id="emailCk_btn" >인증</a>
	                            	<span id="timer"></span>
	                            </div>
	                        </td>
	                    </tr>
	                    <tr class="available-time-block">
	                        <th>* 주소</th>
	                        <td colspan="3" style="position: relative;">
	                            <div class="row">
	                               <input type=text name=post id=post class="form-control" size=10 v-model="user.postcode"  readonly>
						         	<a id="upostBtn" href="javascript:postFindBtn()"
						          	class="btn btn-sm btn-success">
						          	우편번호찾기
						          	</a>
	                            </div>
	                            <div class="row">
	                            	<input type=text v-model="user.address1" class="form-control address1" readonly size=40>
	                            </div>
	                            <div class="row">
	                                <input type=text v-model="user.address2" class="form-control address2">
	                            </div>
	                        </td>
	                    </tr>
	               </table>
	               <div class="text-right">
	                    <button v-on:click="updateMy()" class="btn btn-info btn-sm btn-block profile-update">수정하기</button>
	                </div>
	                <h2>비밀번호 변경</h2>
	                <table id="password-table">
	                    <tr>
	                        <th>현재 비밀번호</th>
	                        <td>
	                            <input type="password" v-model="pwd.now_pwd" id="now_pwd" class="form-control" placeholder="현재 비밀번호를 입력해주세요.">
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>비밀번호</th>
	                        <td>
	                            <input type="password" v-model="pwd.change_pwd" id="change_pwd" class="form-control" placeholder="숫자/영문 조합 8자 이상만 가능합니다.">
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
				now_email:'',
				email_ck:0,
				email_confirm:'OK',
			},
			mounted:function(){
				this.getData();
			},
			methods:{
				getData:function(){
					axios.get("http://localhost:8080/web/mypage/mypage_vue.do",{
					}).then(res=>{
						console.log(res.data)
						this.user=res.data
						this.now_email=res.data.email
						let tmp = String(res.data.phone)
						console.log(tmp)
						if(tmp.length>9){
							this.tel[0] = 0+tmp.substring(0,2)
							this.tel[1] = tmp.substring(2,6)
							this.tel[2] = tmp.substring(6,10)
						}else{
							this.tel[0] = 0+tmp.substring(0,2)
							this.tel[1] = tmp.substring(2,5)
							this.tel[2] = tmp.substring(5,9)
						}
						
					})
						
				},
				updateMy:function(){
					$('span#validation').remove()
					window.scrollTo(0,200);
					console.log(this.now_email)
					if($.trim(this.user.name)=="")
					{
						this.validAlert('name','이름을 입력하시오!');
						return;
					}
					if($.trim(this.user.dbday)=="")
					{
						this.validAlert('birth','생년월일을 입력하시오!');
						return;
					}
					if($.trim(this.tel[1])=="" ||$.trim(this.tel[1]).length<3)
					{
						this.validAlert('mobile1','&emsp;3~4자리 번호를 입력하시오!');
						return;
					}
					if($.trim(this.tel[2])=="" ||$.trim(this.tel[2]).length<4){
						this.validAlert('mobile2','&emsp;4자리 번호를 입력하시오!');
						return;
					}
					if($.trim(this.user.postcode)=="")
					{
						this.validAlert('postcode','주소를 입력하시오!');
						return;
					}
					if(this.now_email!=this.user.email){
						if(this.email_confirm=='NO'){
							$('#timer').remove()
							this.validAlert('email_send','&emsp;이메일 인증을 다시 하시오!')
							$('#confirm_email').focus()
							return;
						}
						if(this.email_confirm!='OK'){
							this.validAlert('timer','&emsp;인증코드를 입력하시오!')
							$('#confirm_email').focus()
							return;
						}
					}
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
				},chkPW:function(){
					 $('span#validation').remove()
					 let pw = this.pwd.change_pwd
					 let eng = pw.search(/[0-9]+[a-z]+/ig);
					 if(pw.length < 8 || pw.length > 16){
						this.validAlert('change_pwd','비밀번호는 8 ~ 16자리 사이로 입력하시오!')
					  	return false;
					 }else if(pw.search(/\s/) != -1){
						 this.validAlert('change_pwd','비밀번호는 공백 없이 입력하시오.');
					  	return false;
					 }else if(eng < 0 ){
						 this.validAlert('change_pwd','영문,숫자를 혼합하여 입력하시오.');
					  	return false;
					 }else {
						console.log("통과"); 
					    return true;
					 }
				},
				updatePwd:function(){
					$('span#validation').remove()
					let pwdCheck=false;
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
							}else{
								if($.trim(this.pwd.change_pwd)==$.trim(this.pwd.now_pwd)){
									this.validAlert('change_pwd','현재 비밀번호와 같습니다!')
									return;
								}
								alert("비밀번호가 변경되었습니다.!");
								location.href="../main/main.do"
								// 로그아웃생기면 변경
								this.$session.clear()
							}
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
							location.href="../main/main.do"
							this.$session.clear()
						}
					})		
				}, 
				emailSend:function(){
					$('span#validation').remove()
					let regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
					if(this.user.email==this.now_email){
						this.validAlert('email_send','&emsp;기존 email과 같습니다!')
						return;
					}
					if (regEmail.test(this.user.email) === false){
				          alert('이메일 형식으로 입력하시오.');
				          return;
				      }
					this.sendAuthNum();
					alert("인증번호를 발송했습니다.")
					$('#confirm_email').attr('readonly',false)
					this.email_ck=1
					$('#email').attr('readonly',true)
					$('#confirm_email').focus()
					axios.post("http://localhost:8080/web/mypage/sendMail.do",this.user.email
							).then(res=>{
								this.email_confirm=res.data.code
							})
							
				},
				emailCheck:function(){
					$('span#validation').remove()
					let code=$('#confirm_email').val()
					console.log(this.email_ck)
					if(this.email_ck==0){
						alert('이메일 인증 버튼을 눌러주세요!')
						return;
					}
					if($('#timer').text()==''){
						this.validAlert('timer','&emsp;인증시간이 만료되었습니다!')
						this.email_confirm='NO'
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
						console.log(this.email_confirm)
					}else{
						this.validAlert('timer','&emsp;인증번호가 다릅니다!')
						this.email_confirm='NO'
						$('#confirm_email').focus()
					}
					
				},
				sendAuthNum:function(){
					// 남은 시간
					var leftSec = 5,
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
							$('#email').attr('readonly',false)
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
				}
			}
		})
	</script>
</body>
</html>