let phone = '';
let certNum = '';
$('#email').change(function(){
	$.ajax({
		url: '/web/user/checkemail.do',
		data: { email: $('#email').val() },
		method: 'POST',
		dataType: 'text'
	})
	.done(function(data){
		if(data == 'true') {
			$('span.email-msg').replaceWith('<span class="email-msg" id="email-ok">이메일이 확인되었습니다.</span>');
		} else {
			$('span.email-msg').replaceWith('<span class="email-msg" id="email-no">가입되지 않은 이메일입니다.</span>');
		} 	
	});
});
$('#cert-button').click(function(){
	phone = $('#phone-number').val();
	$.ajax({
		url: '/web/user/phonecert.do',
		data: { phone: phone },
		method: 'POST',
		dataType: 'json'
	})
	.done(function(data){
		if(!$('#cert-ok-input').length) {
			$('#user-find-input-part').append('<div id="cert-ok-input"><input id="cert-num" class="form-control" type="text" placeholder="인증번호"></div>').trigger('create');
		}
		if(!$('#cert-ok-submit').length) {
			$('#user-find-submit-part').append('<div id="cert-ok-submit"><button class="btn" id="cert-ok-button" style="margin-top: 20px; margin-left: -15px;">확인</button></div>').trigger('create');
		}
	})
	.fail(function(xhr, status, errorThrown){
		console.log(status + ' ' + errorThrown);
	})
});
$(document).on("click", "#cert-ok-button" , function(){
	console.log('clicked!');
	$.ajax({
		url: '/web/user/pwcert.do',
		data: { certNum : $('#cert-num').val(),
				phone: phone	
		},
		method: 'POST',
		dataType: 'text'
	})
	.done(function(data){
		console.log(data);
		if(data == 'false') {
			$('span#cert-no').remove();
			$('#cert-ok-input').append('<span id="cert-no">인증번호가 일치하지 않습니다. 다시 확인해주세요.</span>');
		} else {
			$('#user-find-input-group').empty();
			$('#user-find-input-group').append('<span id="cert-ok">임시비밀번호는 <strong>' + data + '</strong> 입니다.</span>');				
		}
	})
	.fail(function(xhr, status, errorThrown){
		console.log(status + ' ' + errorThrown);
	});
});