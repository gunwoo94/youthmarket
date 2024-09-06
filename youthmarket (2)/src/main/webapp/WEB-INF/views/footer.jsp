<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
footer{
	width: 100%;
}
.footer-container{
	 /* border-top: 1px solid #cbcbcb; */ 
	display: flex;
	justify-content: center;
	flex-direction: row;
	margin-top:20px;
	margin-bottom : 20px;
}
#logo-footer-image{
    width: 120px;
}
.footer-hr{
	color: gray;
}
.footer-span{
	margin-top: 24px;
	color: #6b6b6b;
}
</style>
</head>
<body>
	<footer>
		<hr class="footer-hr">
		<div class="footer-container">
			<img id="logo-footer-image" alt="이미지가 없습니다" src="/youthmarket/resources/images/chackcheckCheckLogo2-1.png"> 
			<span class="footer-span">&nbsp;Copyright ©청년마켓</span>
		</div>
	</footer>
</body>

</html>