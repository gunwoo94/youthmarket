<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"> 
<title>Insert title here</title>
</head>
<body> 
<script type="text/javascript">
<c:if test="${result > 0  }">
	alert("로그인 되었습니다")
	location.href="adminUser.do"
</c:if>
<c:if test="${result == 0 }">
	alert("아이디 혹은 비밀번호가 틀립니다, 다시 확인해주세요")
	history.back()
</c:if>
</script>
</body>
</html>

