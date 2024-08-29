<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function chk() {
		if (frm.userPassword.value != frm.userPassword2.value) {
			alert("암호와 암호확인이 다릅니다");
			frm.userPassword.focus();
			frm.userPassword.value = "";
			frm.userPassword2.value = "";
			return false;
		}
	}
</script>
</head>
<body>
	<div class="container text-center">
		<h2 class="text-primary">회원 정보 수정</h2>
		<form action="${path}/member/update.do" method="post" name="frm"
			enctype="multipart/form-data" onsubmit="return chk()">
			<input type="hidden" name="userId" value="${member.userId }">
			<table class="table table-bordered">
				<tr>
					<th>아이디 <i class="bi bi-file-earmark-person icofont-2x"></i></th>
					<td>${member.userId }</td>
				</tr>
				<tr>
					<th>암호 <i class="bi bi-file-lock2 icofont-2x"></i></th>
					<td><input type="password" name="userPassword"
						required="required" class="form-control"></td>
				</tr>

				<tr>
					<th>암호확인 <i class="bi bi-file-lock2 icofont-2x"></i></th>
					<td><input type="password" name="userPassword2"
						required="required" class="form-control"></td>
				</tr>
				<tr>
					<th>상점명 <i class="bi bi-person-vcard"></i></th>
					<td><input type="text" name="userName" required="required"
						class="form-control" value="${member.userName }"></td>
				</tr>
				<tr>
					<th>전화 <i class="bi bi-envelope icofont-2x"></i></th>
					<td><input type="tel" name="phone" required="required"
						class="form-control" placeholder="010-1111-1111"
						pattern="010-\d{3,4}-\d{4}" title="전화번호는 010-1111-1234형식"
						value="${member.phone }"></td>
				</tr>
				<tr>
					<th>생일 <i class="bi bi-envelope icofont-2x"></i></th>
					<td><input type="date" name="birth" required="required"
						class="form-control" value="${member.birth }"></td>
				</tr>
				<tr>
					<th>이메일 <i class="bi bi-envelope icofont-2x"></i></th>
					<td><input type="email" name="email" required="required"
						class="form-control" value="${member.email }"></td>
				</tr>
				<tr>
					<th>계좌번호 <i class="bi bi-envelope icofont-2x"></i></th>
					<td><input type="number" name="account" required="required"
						class="form-control" value="${member.account }"></td>
				</tr>
				<tr>
					<th>사진 <i class="bi bi-file-earmark-person icofont-2x"></i></th>
					<td><input type="file" name="file" class="form-control"></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="확인"
						class="btn btn-primary"></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>