<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			location.href = "${path}/member/findPasswordForm2.do?userId=${member.userId}"
		</script>
	</c:if>
	<c:if test="${result < 0 }">
		<script type="text/javascript">
			alert("없는 아이디입니다")
			history.back()
		</script>
	</c:if>

</body>
</html>