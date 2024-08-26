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
</head>
<body>
	<div class="main-container">
		<div class="sub-container">
			<div class="idInfo-text">
				<div class="text-wrap">
					<span id="info-main-text">아이디 찾기</span>
				</div>
				회원님의 아이디는 <span class="id-show">${member.userId }</span>입니다
			</div>
			<a href="${path}/member/loginForm.do" class="btn btn-info">로그인</a>
		</div>

	</div>
</body>
</html>