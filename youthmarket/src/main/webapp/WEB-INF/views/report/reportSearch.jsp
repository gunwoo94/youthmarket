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
	<c:if test="${result > 0 }">
		<script type="text/javascript">
			alert("입력하신 상점명으로 검색을 시작합니다")
			location.href = "${path}/report/reportSearchResult.do?userName=${member.userName}"
		</script>
	</c:if>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			alert("오류입니다")
			history.back()
		</script>
	</c:if>
	<c:if test="${result < 0 }">
		<script type="text/javascript">
			alert("입력하신 상점명은 존재하지 않습니다")
			history.back()
		</script>
	</c:if>
</body>
</html>