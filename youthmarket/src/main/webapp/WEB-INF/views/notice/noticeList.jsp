<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 목록</title>
    <!-- Bootstrap CSS 추가 -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
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
    <div class="container">
        <h2>공지사항 목록</h2>

        <!-- 검색 폼 -->
        <div id="board-search">
            <div class="search-window">
                <form id="searchForm" action="${pageContext.request.contextPath}/notice/noticeList" method="get">
                    <div class="search-wrap">
                        <select id="searchCategory" name="searchCategory" class="form-select">
                            <option value="notice_no" ${param.searchCategory == 'notice_no' ? 'selected' : ''}>번호</option>
                            <option value="notice_title" ${param.searchCategory == 'notice_title' ? 'selected' : ''}>제목</option>
                            <option value="notice_content" ${param.searchCategory == 'notice_content' ? 'selected' : ''}>내용</option>
                            <option value="notice_hit" ${param.searchCategory == 'notice_hit' ? 'selected' : ''}>조회수</option>
                            <option value="create_date" ${param.searchCategory == 'create_date' ? 'selected' : ''}>작성일</option>
                        </select>
                        <input id="search" type="search" name="searchKeyword" placeholder="검색어를 입력하세요." value="${param.searchKeyword}" class="form-control">
                        <input type="submit" value="검색" class="btn btn-dark">
                    </div>
                </form>
            </div>
        </div>

        <!-- 공지사항 목록 테이블 -->
        <c:choose>
            <c:when test="${not empty noticeList}">
                <table class="table table-info table-hover table-bordered rounded h-75">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>공지사항 내용</th>
                            <th>조회수</th>
                            <th>작성일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="notice" items="${noticeList}">
                            <tr>
                                <td>${notice.noticeNo}</td>
                                <td><a href="#" class="notice-title" data-notice-no="${notice.noticeNo}">${notice.noticeTitle}</a></td>
                                <td>${notice.noticeContent}</td>
                                <td>${notice.noticeHit}</td>
                                <td>${notice.createDate}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <p class="no-result">검색 결과가 없습니다. 다시 검색해 주세요.</p>
            </c:otherwise>
        </c:choose>

        <!-- 페이지 네비게이션 -->
        <c:if test="${not empty noticeList}">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <c:if test="${pageNum > 1}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/noticeList?pageNum=${pageNum - 1}&searchCategory=${param.searchCategory}&searchKeyword=${param.searchKeyword}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${i == pageNum ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/noticeList?pageNum=${i}&searchCategory=${param.searchCategory}&searchKeyword=${param.searchKeyword}">${i}</a>
                        </li>
                    </c:forEach>
                    <c:if test="${pageNum < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/noticeList?pageNum=${pageNum + 1}&searchCategory=${param.searchCategory}&searchKeyword=${param.searchKeyword}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </c:if>
    </div>

    <!-- 모달 창 -->
    <div class="modal fade" id="noticeModal" tabindex="-1" aria-labelledby="noticeModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title" id="modalTitle"></h1>
                </div>
                <div class="modal-body">
                    <div id="modalContent"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
