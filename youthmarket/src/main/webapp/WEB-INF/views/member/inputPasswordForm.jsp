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

.text-wrap{
	margin-bottom: 15px;
}

.join-wrap {
	margin-bottom: 15px;
}
</style>
<script type="text/javascript">

	function chk() {
		if (frm.userPassword.value != frm.userPassword2.value) {
			$('#passChk-msg').html('암호와 암호 확인이 다릅니다');
			frm.userPassword.focus();
			frm.userPassword.value = "";
			frm.userPassword2.value = "";
			return false;
		} else {
			$('#passChk-msg').html('');
		}
	}
</script>
</head>
<body>
	<div class="main-container">
		<form action="inputPassword.do" onsubmit="return chk()" name="frm">
			<input type="hidden" name="userId" value="${member.userId }">
			<div class="text-wrap">
				<span id="info-main-text">비밀번호 찾기 step.3</span><br> <span
					id="info-text">보안을 위해 비밀번호를 재설정 해주세요</span>
			</div>
			<!-- 비밀번호 -->
			<div class="join-wrap">
				<div>
					<input type="password" id="password" name="userPassword"
						placeholder="비밀번호를 입력해주세요" class="input2">
				</div>
				<div id="password-msg"></div>
			</div>
			<!-- 비밀번호 확인 -->
			<div class="join-wrap" id="passConfimHidden">
				<div>
					<input type="password" id="passConfirm" name="userPassword2"
						placeholder="비밀번호 확인을 입력해주세요" class="input2">
				</div>
				<div id="passChk-msg"></div>
			</div>
			<input type="submit" value="비밀번호 변경" class="joinBtn">
		</form>
	</div>
</body>
</html>