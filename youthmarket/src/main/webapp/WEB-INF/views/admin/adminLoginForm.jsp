<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
body {
	margin: 0;
}

.loginForm {
	margin: 0;
	width: 100%;
	height: 100vh;
	background-color: white;
	background-image: url(/youthmarket/resources/images/admin/청년마켓.png);
	background-repeat: no-repeat;
	background-size: cover;
}

.login-wrap {
	padding-top: 150px;
}

.login-input {
	margin-top: 3px;
	display: inline-block;
	width: 335px;
	height: 47px;
	padding: 0 14px 2px;
	color: #000;
	font-size: 14px;
	line-height: 42px;
	letter-spacing: -0.01em;
	font-family: "Noto Sans KR", sans-serif;
	background-color: #F8F8F8;
	border: 1px solid black;
	border-radius: 6px;
	box-sizing: border-box;
	transition: border-color 0.2s ease-out;
	outline: none;
}

.login-input:hover {
	border: 1px solid #091b50;
}

.login-input:focus {
	border: 1px solid #091b50;
}

#login-btn {
	width: 335px;
	background: #293b4b;
	border: 1px solid #293b4b;
	border-radius: 6px;
	height: 50px;
	margin-top: 30px;
	transition: background-color 0.2s ease-out, border-color 0.2s ease-out;
	color: #fff;
	font-size: 15px;
	font-weight: 600;
}

#login-btn:hover {
	cursor: pointer;
	background: #445666;
}

.a1 {
	font-size: 40px;
	margin-bottom: 50px;
}

.m-container {
	display: flex;
}

.menu-main-container {
	margin: 0;
	height: 100vh;
	background-color: #293b4b;
}

#icon-div {
	background-color: #243646;
	height: 90px;
}

.menu-div {
	width: 200px;
	height: 60px;
	color: white;
	font-size: 16px;
	display: flex;
	justify-content: center;
	align-items: center;
	cursor: pointer;
}

.menu-div:hover {
	background-color: #243646;
}

.menu-img {
	width: 20px;
}

.menu-img2 {
	width: 25px;
}
</style>

<script type="text/javascript">
	//관리자 페이지 사이드 메뉴 이동
	function pageView(data, message) {
		alert(message);
		location.href = data;
	}
</script>

</head>
<body>
	<div class="m-container">
		<div class="menu-main-container">
			<div class="menu-div"
				onclick="pageView('adminLoginForm.do', '로그인 후에 사용 가능 합니다.')">
				<img class="menu-img5">&nbsp;관리자 페이지
			</div>
			<div class="menu-div"
				onclick="pageView('adminUser.do','로그인 후에 사용 가능 합니다.')">
				<img class="menu-img" alt="이미지 없음"
					src="/youthmarket/resources/images/admin/유저.png" />&nbsp;유저 관리
			</div>
			<!-- <div class="menu-div"
				onclick="pageView('adminBoard.do','로그인 후에 사용 가능 합니다.')">
				<img class="menu-img2" alt="이미지 없음"
					src="/youthmarket/resources/images/admin/게시글.png" />&nbsp;게시글 관리
			</div> -->
			<div class="menu-div"
				onclick="pageView('adminNotice.do', '로그인 후에 사용 가능 합니다.')">
				<img class="menu-img" alt="이미지 없음"
					src="/youthmarket/resources/images/admin/공지사항.png" />&nbsp; 공지사항
				관리

			</div>
			<div class="menu-div"
				onclick="pageView('adminBlockList.do', '로그인 후에 사용 가능 합니다.')">
				<img class="menu-img" alt="이미지 없음"
					src="/youthmarket/resources/images/admin/차단.png" />&nbsp; 차단 회원 목록
			</div>
	<div class="menu-div" onclick="pageView('/youthmarket/sell/home.do', '홈페이지로 이동합니다.')">
				<img class="menu-img" alt="이미지 없음"
					src="/youthmarket/resources/images/icon/icon.png" />&nbsp; 홈페이지로 이동
			</div>
		</div>

		<div class="loginForm" align="center">

			<form action="adminLogin.do" method="post">
				<div class="login-wrap">
					<div class="a1">관리자 로그인</div>
					<div>
						<input class="login-input login-input2" type="text" name="adminId"
							required="required" placeholder="아이디">
					</div>
					<div>
						<input class="login-input login-input2" type="password"
							name="adminPassword" required="required" placeholder="비밀번호">
					</div>
					<div>
						<input class="login-input" id="login-btn" type="submit" value="확인">
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>