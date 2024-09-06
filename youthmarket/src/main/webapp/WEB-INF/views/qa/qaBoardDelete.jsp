<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
    <%@ include file="../common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title> 
</head>
<body>
<c:if test="${result > 0  }">
<script type="text/javascript">
	alert("해당 문의 내역이 삭제 되었습니다.")
	location.href="QaBoard.do"
</script>
</c:if>

<c:if test="${result == 0 }">
<script type="text/javascript">
	alert("문의 내역 삭제에 실패했습니다.")
	history.back();
</script>
</c:if>
</body>
</html>