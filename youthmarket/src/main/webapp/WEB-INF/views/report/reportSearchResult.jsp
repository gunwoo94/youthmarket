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
	margin: 0 auto;
}

.t-a-c {
	text-align: center
}
</style>
</head>
<body>
	<table>
		<tr>
			<th colspan="2"><img alt=""
				src="${path }/resources/images/fileSave/${member.fileName }"
				width="300px"></th>
		</tr>
		<tr>
			<th>상점명</th>
			<td>${member.userName }</td>
		</tr>
		<tr>
			<th>신고당한 횟수</th>
			<td>${member.reportCount }</td>
		</tr>
		<tr class="t-a-c">
			<td colspan="2"><a href="#">상점 페이지로</a></td>
		</tr>
	</table>
</body>
</html>