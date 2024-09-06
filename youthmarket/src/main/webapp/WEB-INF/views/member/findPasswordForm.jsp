<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.main-container {
	text-align: center;
}
</style>
</head>
<body>
	<div class="main-container">
		<form action="${path}/member/findPassword.do" method="post">
			<div class="text-wrap">
				<span id="info-main-text">비밀번호 찾기</span><br> <span
					id="info-text">회원님의 아이디를 입력해주세요</span>
			</div>
			<div class="login-wrap">
				<input type="text" name="userId" placeholder="아이디를 입력해주세요"
					required="required" autofocus="autofocus">
			</div>

			<input type="submit" value="다음" class="joinBtn">
		</form>
	</div>
</body>
</html>