<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드</title>
<style>
/* 필요한 스타일을 여기에 추가 */
</style>
</head>
<body>
<c:if test="${result > 0}">
	<script type="text/javascript">
		alert('성공')
		location.href="${path}/qa/QaBoard.do"
	</script>
</c:if>

<c:if test="${result == 0}">
	<script type="text/javascript">
		alert('실패')
		history.go(-1)
	</script>
</c:if>
</body>
</html>
