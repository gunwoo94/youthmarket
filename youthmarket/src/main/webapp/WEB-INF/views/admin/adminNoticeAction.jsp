<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>

	<c:if test="${result > 0  }">
		<script type="text/javascript">
			alert("수정 완료")
			location.href = "${path}/admin/adminNotice.do"
		</script>
	</c:if>

	<c:if test="${result == 0  }">
		<script type="text/javascript">
			alert("수정 실패")
			history.back()
		</script>
	</c:if>


</body>
</html>

