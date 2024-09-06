<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
body {
	margin: 0;
}
/* ========================== */
/* 로그아웃 */
.header-main-container {
	width: 100%;
	height: 70px;
	display: flex;
	justify-content: end;
	align-items: center;
	background-color: #e5e1dc;
}

.logout-div {
	margin-right: 25px;
	display: flex;
}

.logout-img {
	width: 15px;
	align-items: center;
	height: 15px;
	display: flex;
	margin: auto;
}

.logout-text {
	color: #00944e;
}
/* ========================== */
/* ========================== */
/* top 상단바 */
#layout-body {
	height: 90vh;
	background-color: #e5e1dc;
}

}
.content {
	position: static;
	background-color: #e5e1dc;
	height: 900px;
}

.top-div {
	background-color: #fff;
	height: 50px;
}

.top-title {
	margin: 10px 0 0 25px;
	font-weight: 900;
	font-size: 30px;
}
/* ========================== */
.adminboard-container {
	margin: 0;
	width: 100%;
	height: 100vh;
	background-color: #e5e1dc;
	background-size: cover;
}

.m-container {
	display: flex;
}

.menu-main-container {
	margin: 0;
	height: 100vh;
	background-color: #293b4b;
}

#icon-div {
	background-color: #243646;
	height: 90px;
}

.menu-div {
	width: 200px;
	height: 60px;
	color: white;
	font-size: 16px;
	display: flex;
	justify-content: center;
	align-items: center;
	cursor: pointer;
}

.menu-div:hover {
	background-color: #243646;
}

.menu-img {
	width: 20px;
}

.menu-img2 {
	width: 25px;
}

.a_content {
	font-size: 14px;
	text-align: center;
}

.h-100 {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	height: 100%;
}

.search-container {
	background-color: #fff;
	padding: 10px;
	border-radius: 5px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
	width: fit-content; /* 검색창 크기를 입력 필드와 일치시킴 */
}

.search-container form {
	display: flex;
	align-items: center;
}

.search-container select {
	padding: 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 5px 0 0 5px;
	outline: none;
	background-color: #fff;
	cursor: pointer;
}

.search-container input[type="text"] {
	padding: 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-left: none;
	border-radius: 0;
	width: 200px;
	outline: none;
}

.search-container button {
	padding: 10px 20px;
	font-size: 16px;
	border: none;
	background-color: #007BFF;
	color: white;
	border-radius: 0 5px 5px 0;
	cursor: pointer;
}

.search-container button:hover {
	background-color: #0056b3;
}
</style>

<script type="text/javascript">
	//관리자 페이지 사이드 메뉴 이동
	function pageView(data,message) {
		alert(message);
		location.href = data;
	}
	
	// 게시글 삭제 기능
	function userDelete(noticeNo) {
		let cf = confirm("해당 게시글을 삭제 하시겠습니까?");
		if (cf) {
			$.post('adminNoticeDelete.do', "noticeNo="+noticeNo, function(data) {
				if(data == 1) {
					alert("해당 게시글을 삭제 했습니다.")
					location.reload();
				}
			})
		} else {
			alert ("삭제가 취소 되었습니다.");
		}
	}
	
	// 게시글 수정 기능
	function userUpdate(noticeNo) {
	    // 수정 페이지로 이동
	    alert(noticeNo)
	    location.href = 'adminNoticeEdit.do?noticeNo=' + noticeNo;
	}
	
/* 	// 게시글 수정
	function userDelete(noticeNo) {
		let cf = confirm("해당 게시글을 삭제 하시겠습니까?");
		if (cf) {
			$.post('adminNoticeDelete.do', "noticeNo="+noticeNo, function(data) {
				if(data == 1) {
					alert("해당 게시글을 삭제 했습니다.")
					location.reload();
				}
			})
		} else {
			alert ("삭제가 취소 되었습니다.");
		}
	} */
</script>

</head>
<body>
	<div class="m-container">
		<div class="menu-main-container">
			<div class="menu-div"
				onclick="pageView('adminLoginForm.do', '관리자 로그인으로 이동합니다.')">
				<img class="menu-img5">&nbsp;관리자 페이지
			</div>
			<div class="menu-div"
				onclick="pageView('adminUser.do','유저 관리 페이지로 이동합니다.')">
				<img class="menu-img" alt="이미지 없음"
					src="/youthmarket/resources/images/admin/유저.png" />&nbsp;유저 관리
			</div>
			<!-- <div class="menu-div"
				onclick="pageView('adminBoard.do','게시글 관리 페이지로 이동합니다.')">
				<img class="menu-img2" alt="이미지 없음"
					src="/youthmarket/resources/images/admin/게시글.png" />&nbsp;게시글 관리
			</div> -->
			<div class="menu-div"
				onclick="pageView('adminNotice.do', '공지사항 관리 페이지로 이동합니다.')">
				<img class="menu-img" alt="이미지 없음"
					src="/youthmarket/resources/images/admin/공지사항.png" />&nbsp; 공지사항
				관리
			</div>
			<div class="menu-div"
				onclick="pageView('adminBlockList.do', '차단 회원 목록 페이지로 이동합니다.')">
				<img class="menu-img" alt="이미지 없음"
					src="/youthmarket/resources/images/admin/차단.png" />&nbsp; 차단 회원 목록
			</div>
				<div class="menu-div" onclick="pageView('/youthmarket/sell/home.do', '홈페이지로 이동합니다.')">
				<img class="menu-img" alt="이미지 없음"
					src="/youthmarket/resources/images/icon/icon.png" />&nbsp; 홈페이지로 이동
			</div>
		</div>
		<div class="adminboard-container">
			<div class="header-main-container">
				<div class="logout-div">
					<img class="logout-img" alt=""
						src="/youthmarket/resources/images/admin/로그아웃.png"> <a
						href="adminLoginForm.do"> <span class="logout-text">Log
							out</span>
					</a>
				</div>
			</div>
			<div id="layout-body">
				<div class="main-container">
					<div class="content">

						<div class="top-div">
							<div class="top-title">
								공지사항 관리 <a class="btn btn-primary btn-lg "
									href="adminNoticeWriteForm.do" role="button">글쓰기</a>
							</div>
						</div>
					</div>
				</div>
				<div class=" h-100 ">
					<table
						class="table table-info table-hover table-bordered rounded h-75">
						<thead>
							<tr>
								<th scope="col"></th>
								<th scope="col">번호</th>
								<th scope="col">제목</th>
								<th scope="col">공지사항 내용</th>
								<th scope="col">조회수</th>
								<th scope="col">작성일</th>
								<th scope="col">수정</th>
								<th scope="col">삭제</th>
							</tr>
						</thead>
						<tbody class="a_content">
							<c:if test="${empty noticeList }">
								<tr>
									<th colspan="9">데이터가 없습니다</th>
								</tr>
							</c:if>

							<c:if test="${not empty noticeList }">
								<c:forEach var="notice" items="${noticeList}">
									<tr>
										<th scope="row">${count }<c:set var="count"
												value="${count - 1 }"></c:set></th>
										<td><a>${notice.noticeNo }</a></td>
										<td><a>${notice.noticeTitle }</a></td>
										<td><a>${notice.noticeContent }</a></td>
										<td><a>${notice.noticeHit }</a></td>
										<td><a>${notice.createDate }</a></td>
										<td><button type="button" class="btn btn-primary"
												onclick="userUpdate(${notice.noticeNo })">수정</button></td>
										<td><button type="button" class="btn btn-secondary"
												onclick="userDelete(${notice.noticeNo })">삭제</button></td>
									</tr>
								</c:forEach>
							</c:if>

						</tbody>
					</table>

					<!-- 	<div class="search-container">
						<form action="/search">
							<select name="search_type">
								<option value="title">회원번호</option>
								<option value="author">이름</option>
							</select> <input type="text" placeholder="Search..." name="search">
							<button type="submit">검색</button>
						</form>
					</div> -->

					<ul class="pagination justify-content-center">
						<!-- 앞에 보여줄 것이 있다 -->
						<c:if test="${pb.startPage > pb.pagePerBlock }">
							<li class="page-item"><a class="page-link"
								href="${path }/admin/adminUser.do?pageNum=1"> <i
									class="icofont-duotone icofont-arrow-first"></i></a></li>
							<li class="page-item"><a class="page-link"
								href="${path }/admin/adminUser.do?pageNum=${pb.startPage -1 }">
									<i class="bi bi-arrow-left-circle"></i>
							</a></li>
						</c:if>
						<c:forEach var="i" begin="${pb.startPage }" end="${pb.endPage }">
							<c:if test="${pb.currentPage == i }">
								<li class="page-item"><a class="page-link active"
									href="${path }/admin/adminUser.do?pageNum=${i}">${i }</a></li>
							</c:if>
							<c:if test="${pb.currentPage != i }">
								<li class="page-item"><a class="page-link"
									href="${path }/admin/adminUser.do?pageNum=${i}">${i }</a></li>
							</c:if>
						</c:forEach>
						<!-- 뒤에 보여줄 것이 있다 -->
						<c:if test="${pb.endPage < pb.totalPage }">
							<li class="page-item"><a class="page-link"
								href="${path }/admin/adminUser.do?pageNum=${pb.endPage+1 }">
									<i class="bi bi-arrow-right-circle"></i>
							</a></li>
							<li class="page-item"><a class="page-link"
								href="${path }/admin/adminUser.do?pageNum=${pb.totalPage}">
									<i class="icofont-duotone icofont-arrow-last"></i>
							</a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</div>

</body>
</html>