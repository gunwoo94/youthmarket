<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
* {
	text-align: center;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$('#emailConfirmHidden').hide();
	});

	function emailChkShow() {
		if ($('#email').val() == "") {
			alert("이메일 주소를 입력해주세요");
			frm.email.focus();
			return false;
		} else if ($('#email').val() != "") {
			$('#email-msg').html('');
			$.post('emailChkFindId.do', "email=" + frm.email.value, function(
					data) {
				var msg = data;
				if (msg == "") {
					$("#emailConfirmHidden").show();
					alert("인증번호가 전송되었습니다");
					$("#email" ).prop('readonly', true);
					frm.emailConfirm.focus();
				} else
					alert(msg);
			});
		}
	}

	function emailConfirmFun() {
		$.post('emailConfirm.do', "emailConfirm=" + frm.emailConfirm.value,
				function(data) {
					if (data == 'y') {
						alert("인증번호가 일치합니다");
						location.href = "findId.do?email=" + frm.email.value;
					} else if (data == 'n') {
						alert("인증번호가 일치하지 않습니다");
						return false;
					}

				});
	};

	function chk() {
		//이메일 인증번호 확인 여부
		if ($("#emailConfirmHidden").is('[show]')
				&& !$("#email").is('[readonly]')) {
			$('#emailChk-msg').html("이메일 인증번호를 확인해주세요");
			frm.emailConfirm.focus();
			return false;
		}
	}
	
	
</script>
</head>
<body>
	<div class="main-container">
		<form action="findId.do" method="post" name="frm"
			onsubmit="return chk()">
			<div class="text-wrap">
				<span id="info-main-text">아이디 찾기</span><br> <span
					id="info-text">메일주소를 입력하신 후 전송 버튼을 눌러주세요</span>
			</div>
			<!-- 이메일 -->
			<div class="join-wrap">
				<div class="row-div">
					<input id="email" type="email" name="email"
						placeholder="이메일주소를 입력해주세요" class="input1"> <input
						type="button" name="emailSend" class="btn"
						onclick="emailChkShow()" id="emailChk-button" value="전송" />
				</div>
				<div id="email-msg"></div>
			</div>
			<!-- 이메일 인증번호 -->
			<div class="join-wrap" id="emailConfirmHidden">
				<div class="row-div">
					<input id="emailChk-input" type="text" name="emailConfirm"
						placeholder="인증번호를 입력해주세요" class="input1" /> <input type="button"
						name="emailConfirmBtn" class="btn" onclick="emailConfirmFun()"
						id="emailConfirm-button" value="확인" />
				</div>
				<div id="emailChk-msg"></div>
			</div>
		</form>
	</div>
</body>
</html>