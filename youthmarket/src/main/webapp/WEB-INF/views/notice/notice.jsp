<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap CSS 추가 -->
 <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
 
</head>
<style type="text/css">
table {
	border-collapse: collapse;
	border-spacing: 0;
}

.page-title {
	margin-bottom: 60px;
}

.page-title h3 {
	font-size: 40px;
	color: #333333;
	font-weight: 400;
	text-align: center;
}

#board-search .search-window {
	padding: 15px 0;
	background-color: #f9f7f9;
	margin-bottom: 0;
}

#board-search .search-window .search-wrap {
	display: flex; /* 요소들을 수평으로 배치 */
    align-items: center; /* 수직 중앙 정렬 */
    gap: 10px; /* 요소 간의 간격을 설정 */
    width: 80%;
    max-width: 564px;
    margin: 0 auto;
}
#board-search .search-window .search-wrap select {
    width: auto; /* 셀렉트 박스 너비를 자동으로 설정 */
}

#board-search .search-window .search-wrap input {
	height: 40px;
	width: 100%;
	font-size: 14px;
	padding: 7px 14px;
	border: 1px solid #ccc;
}

#board-search .search-window .search-wrap input {
    flex-grow: 1; /* 입력 필드가 가능한 공간을 차지하도록 설정 */
    height: 40px;
    font-size: 14px;
    padding: 7px 14px;
    border: 1px solid #ccc;
}

#board-search .search-window .search-wrap .btn {
    height: 40px; /* 버튼의 높이를 입력창과 동일하게 설정 */
    padding: 0 10px; /* 버튼 좌우 패딩을 설정 */
    font-size: 16px;
    line-height: 40px; /* 버튼 내 텍스트 수직 중앙 정렬 */
}

.board-table {
	font-size: 13px;
	width: 100%;
	border-top: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}

.board-table a {
	color: #333;
	display: inline-block;
	line-height: 1.4;
	word-break: break-all;
	vertical-align: middle;
}

.board-table a:hover {
	text-decoration: underline;
}

.board-table th {
	text-align: center;
}

.board-table .th-num {
	width: 100px;
	text-align: center;
}

.board-table .th-date {
	width: 200px;
}

.board-table th, .board-table td {
	padding: 14px 0;
}

.board-table tbody td {
	border-top: 1px solid #e7e7e7;
	text-align: center;
}

.board-table tbody th {
	padding-left: 28px;
	padding-right: 14px;
	border-top: 1px solid #e7e7e7;
	text-align: left;
}

.board-table tbody th p {
	display: none;
}

.btn {
	display: inline-block;
	padding: 0 30px;
	font-size: 15px;
	font-weight: 400;
	background: transparent;
	text-align: center;
	white-space: nowrap;
	vertical-align: middle;
	-ms-touch-action: manipulation;
	touch-action: manipulation;
	cursor: pointer;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	border: 1px solid transparent;
	text-transform: uppercase;
	-webkit-border-radius: 0;
	-moz-border-radius: 0;
	border-radius: 0;
	-webkit-transition: all 0.3s;
	-moz-transition: all 0.3s;
	-ms-transition: all 0.3s;
	-o-transition: all 0.3s;
	transition: all 0.3s;
}

.btn-dark {
	background: #555;
	color: #fff;
}

.btn-dark:hover, .btn-dark:focus {
	background: #373737;
	border-color: #373737;
	color: #fff;
}

.btn-dark {
	background: #555;
	color: #fff;
}

.btn-dark:hover, .btn-dark:focus {
	background: #373737;
	border-color: #373737;
	color: #fff;
}

/* reset */
* {
	list-style: none;
	text-decoration: none;
	padding: 0;
	margin: 0;
	box-sizing: border-box;
}

.clearfix:after {
	content: '';
	display: block;
	clear: both;
}

.container {
	width: 1100px;
	margin: 0 auto;
}

.blind {
	position: absolute;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	margin: -1px;
	width: 1px;
	height: 1px;
}
</style>
<!-- jQuery 및 JavaScript 추가 -->
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
$(document).ready(function() {
    var currentNoticeNo = null; // 현재 공지사항 번호를 저장할 변수
    var isRequestInProgress = false; // 요청 진행 중 여부를 추적하는 변수

    // 제목 클릭 시 모달 창에 내용 출력
    $(".notice-title").click(function(e) {
        e.preventDefault(); // 링크 기본 동작 방지

        currentNoticeNo = $(this).data("notice-no"); // 클릭한 제목의 noticeNo 가져오기

        // 먼저 공지사항 상세 내용 요청
        $.ajax({
            url: "getNoticeDetail", // 서버에서 공지사항 내용을 가져오는 URL
            method: "GET",
            data: {
                noticeNo: currentNoticeNo
            },
            success: function(response) {
                if (response.noticeContent) {
                    // 서버에서 받은 데이터로 모달의 내용을 채움
                    $("#modalTitle").text(response.noticeTitle); // 제목 추가
                    $("#modalContent").html(response.noticeContent);
                    $("#noticeModal").modal('show'); // 모달 창 표시 (Bootstrap 모달 사용)
                } else {
                    alert("공지사항 내용을 불러오는 데 실패했습니다.");
                }
            },
            error: function() {
                alert("공지사항 내용을 불러오는 데 실패했습니다.");
            }
        });
    });

    // 모달이 닫힐 때 조회수 증가 요청 보내기
    $('#noticeModal').on('hide.bs.modal', function () {
        if (currentNoticeNo && !isRequestInProgress) {
            isRequestInProgress = true; // 요청 시작
            $.ajax({
                url: "increaseNoticeHit", // 조회수를 증가시키는 서버의 URL
                method: "POST", // POST 요청으로 조회수 증가
                data: {
                    noticeNo: currentNoticeNo
                },
                success: function() {
                    console.log("조회수가 증가했습니다.");
                },
                error: function() {
                    console.log("조회수를 증가시키는 데 실패했습니다.");
                },
                complete: function() {
                    isRequestInProgress = false; // 요청 완료
                }
            });
        }
    });

    // 모달 외부 클릭 시 모달 닫기
    $(window).click(function(event) {
        if (event.target.id === "noticeModal") {
            $("#noticeModal").modal('hide'); // 모달 숨기기 (Bootstrap 모달 사용)
        }
    });
});

</script>


</head>
<body>

	<section class="notice">
		<div class="page-title">
			<div class="container">
				<h3>공지사항</h3>
			</div>
		</div>

<!-- 검색 폼 -->
		<div id="board-search">
			<div class="container">
				<div class="search-window">
					<!-- 검색 기능을 위한 폼 -->
					<form id="searchForm" action="${path}/notice/noticeList" method="get">
						<div class="search-wrap">
							<!-- 검색 카테고리 선택 -->
							<select id="searchCategory" class="form-select" aria-label="검색 카테고리" name="searchCategory">
								<!-- 옵션 목록 - 검색할 카테고리 선택 -->
								<option value="notice_no" ${param.searchCategory == 'noticeNo' ? 'selected' : ''}>번호</option>
								<option value="notice_Title" ${param.searchCategory == 'noticeTitle' ? 'selected' : ''}>제목</option>
								<option value="notice_Content" ${param.searchCategory == 'noticeContent' ? 'selected' : ''}>내용</option>
								<option value="notice_Hit" ${param.searchCategory == 'noticeHit' ? 'selected' : ''}>조회수</option>
								<option value="create_Date" ${param.searchCategory == 'createDate' ? 'selected' : ''}>작성일</option>
							</select>
							<!-- 검색어 입력 필드 -->
							<input id="search" type="search" name="searchKeyword" placeholder="검색어를 입력하세요." value="${param.searchKeyword}" class="form-control">
							<!-- 검색 버튼 -->
							<input type="submit" class="btn btn-dark" value="검색">
                </div>
            </form>
        </div>
    </div>
</div>

	</section>
	<table class="table table-info table-hover table-bordered rounded h-75">
		<thead>
			<tr>
				<th scope="col"></th>
				<th scope="col">번호</th>
				<th scope="col">제목</th>
				<th scope="col">공지사항 내용</th>
				<th scope="col">조회수</th>
				<th scope="col">작성일</th>
			</tr>
		</thead>
		<tbody class="a_content">
			<!-- 데이터가 없을 때 표시 -->
			<c:if test="${empty noticeList }">
				<tr>
					<th colspan="7">데이터가 없습니다</th>
				</tr>
			</c:if>

			<!-- 데이터가 있을 때 표시 -->
			<c:if test="${not empty noticeList }">
				<c:forEach var="notice" items="${noticeList}">
					<tr>
						<th scope="row">${count }<c:set var="count"
								value="${count - 1 }"></c:set></th>
						<td>${notice.noticeNo }</td>
						<!-- 제목 클릭 시 모달을 열도록 수정 -->
						<td><a href="#" class="notice-title" data-bs-toggle="modal"
							data-bs-target="#noticeModal" data-notice-no="${notice.noticeNo}">${notice.noticeTitle}</a></td>
						<td>${notice.noticeContent }</td>
						<td>${notice.noticeHit }</td>
						<td>${notice.createDate }</td>
					</tr>
				</c:forEach>
			</c:if>

		</tbody>
	</table>

	<!-- 페이지네이션 -->
	<ul class="pagination justify-content-center">
		<!-- 앞에 보여줄 것이 있다 -->
		<c:if test="${pb.startPage > pb.pagePerBlock }">
			<li class="page-item"><a class="page-link"
				href="${path }/admin/notice.do?pageNum=1"> <i
					class="icofont-duotone icofont-arrow-first"></i></a></li>
			<li class="page-item"><a class="page-link"
				href="${path }/admin/notice.do?pageNum=${pb.startPage -1 }">
					<i class="bi bi-arrow-left-circle"></i>
			</a></li>
		</c:if>
		<!-- 페이지 번호 표시 -->
		<c:forEach var="i" begin="${pb.startPage }" end="${pb.endPage }">
			<c:if test="${pb.currentPage == i }">
				<li class="page-item"><a class="page-link active"
					href="${path }/admin/notice.do?pageNum=${i}">${i }</a></li>
			</c:if>
			<c:if test="${pb.currentPage != i }">
				<li class="page-item"><a class="page-link"
					href="${path }/admin/notice.do?pageNum=${i}">${i }</a></li>
			</c:if>
		</c:forEach>
		<!-- 뒤에 보여줄 것이 있다 -->
		<c:if test="${pb.endPage < pb.totalPage }">
			<li class="page-item"><a class="page-link"
				href="${path }/admin/notice.do?pageNum=${pb.endPage+1 }"> <i
					class="bi bi-arrow-right-circle"></i></a></li>
			<li class="page-item"><a class="page-link"
				href="${path }/admin/notice.do?pageNum=${pb.totalPage}"> <i
					class="icofont-duotone icofont-arrow-last"></i></a></li>
		</c:if>
	</ul>

<!-- 모달 창 HTML 추가 -->
    <div id="noticeModal" class="modal fade" tabindex="-1" aria-labelledby="noticeModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 id="modalTitle" class="modal-title"></h1>
                    <!-- X 버튼 제거 -->
                </div>
                <div class="modal-body">
                    <p id="modalContent"></p>
                </div>
                <div class="modal-footer">
                    <!-- Close 버튼을 활성화 -->
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>

</body>
</html>