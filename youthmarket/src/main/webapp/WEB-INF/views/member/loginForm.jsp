<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.container{
		text-align: center;
		
	}

	.container form{
		width: 500px;
		margin: auto;
	}
	
	.container form div{
		margin-bottom: 5px;
	}
	
	.container form .btn{
		margin: 50px 0; 
	}
	
	.container form div ul{
		list-style: none;
		display: flex;
		justify-content: center;
	}
	
	.container form div ul li a{
		text-decoration: none;
		color: #666;
		font-size: 14px;
			
	}

</style>
</head>
<body>
	<!-- 메인 컨테이너 -->
	<div class="container">
		<form action="/youthmarket/member/login.do" method="post">
			<!-- 아이디 -->
			<div>
				<input type="text" name="userId" required="required"
					autofocus="autofocus" class="form-control"
					placeholder="아이디를 입력해주세요">
			</div>
			<!-- 비밀번호 -->
			<div>
				<input type="password" name="userPassword" required="required"
					class="form-control" placeholder="비밀번호를 입력해주세요">
			</div>

			<!-- 로그인 버튼 -->
			<input type="submit" value="로그인" class="btn btn-success">

			<div>
				<ul>
					<li><a href="/youthmarket/nolay/joinForm.do">회원가입</a></li>
					<li>&nbsp;|&nbsp;</li>
					<li><a href="findIdForm.do">아이디 찾기</a></li>
					<li>&nbsp;|&nbsp;</li>
					<li><a href="findPasswordForm.do">비밀번호 찾기</a></li>
				</ul>
			</div>
		</form>


	</div>
</body>
</html>