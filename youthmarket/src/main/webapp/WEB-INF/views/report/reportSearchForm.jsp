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
	text-align: center;
	margin: 0 auto;
}
</style>
</head>
<body>
	<div class="container">
		<h1>사기조회</h1>
		<form action="${path }/report/reportSearch.do" method="post" accept-charset="UTF-8">
			<table>
				<tr>
					<th colspan="2">검색할 상점명을 입력하세요</th>
				</tr>
				<tr>
					<td><input type="text" name="userName" required="required"></td>
					<td><input type="submit" value="검색"></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>