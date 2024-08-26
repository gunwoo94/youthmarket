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
			$.post('emailChkFindPass.do', "email=" + frm.email.value
					+ "&userId=" + frm.userId.value, function(data) {
				if (data == "y") {
					alert("인증번호가 전송되었습니다");
					$("#email").prop('readonly', true);
					$("#emailConfirmHidden").show();
				} else if (data == "null") {
					alert("존재하지 않는 이메일 입니다")
				} else if (data == "n") {
					alert("이메일을 확인해주세요");
				}
			});
		}
	}

	function emailConfirmFun() {
		$
				.post(
						'emailConfirm.do',
						"emailConfirm=" + frm.emailConfirm.value,
						function(data) {
							if (data == 'y') {
								alert("인증번호가 일치합니다");
								location.href = "inputPasswordForm.do?userId=${member.userId}";
							} else if (data == 'n') {
								alert("인증번호가 일치하지 않습니다");
								return false;
							}

						});
	};

	function chk() {
		if (!$("#email").is('[readonly]')) {
			alert("이메일 인증번호를 확인해주세요");
			frm.emailConfirm.focus();
			return false;
		}
	}
</script>
</head>
<body>
	<div class="main-container">
		<form action="inputPassword.do" name="frm" onsubmit="return chk()">
			<input type="hidden" name="userId" value="${member.userId }">
			<div class="text-wrap">
				<span id="info-main-text">비밀번호 찾기 step.2</span><br> <span
					id="info-text">이메일 인증을 진행해 주세요</span>
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