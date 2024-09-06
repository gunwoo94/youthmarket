<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1대1 문의 내역</title>
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

.board-table tbody th p{
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
  text-align: center; /* 텍스트 중앙 정렬 */
}
.blind {
  position: absolute;
  overflow: hidden;
  clip: rect(0 0 0 0);
  margin: -1px;
  width: 1px;
  height: 1px;
}

</style>
<script type="text/javascript">
//게시글 삭제 기능
function userDelete(qaNo) {
	let cf = confirm("해당 문의 글을 삭제 하시겠습니까?");
	if (cf) {
		$.post('qaBoardDelete.do', "qaNo="+qaNo, function(data) {
			if(data == 1) {
				alert("해당 문의 글을 삭제 했습니다.")
				location.reload();
			}
		})
	} else {
		alert ("삭제가 취소 되었습니다.");
	}
}
</script>
</head>
<body>

<section class="notice">
  <div class="page-title">
        <div class="container">
            <h3>1대1 문의 내역</h3>
        </div>
    </div>

    <!-- 검색 폼 -->
    <div id="board-search">
        <div class="container">
            <div class="search-window">
            <!-- 검색 기능을 위한 폼 -->
                <form id="searchForm" action="${path }/qa/QaList" method="get" >
                    <div class="search-wrap">
                    <!-- 검색 카테고리 선택 -->
                        <select class="searchCategory" class="form-select" aria-label="검색 카테고리" name="searchCategory">
                        <!-- 옵션 목록 - 검색할 카테고리 선택 -->
                            <option value="qa_no" ${param.searchCategory == 'qaNo' ? 'selected ' : '' }>번호</option>
                            <option value="qa_Title" ${param.searchCategory == 'qaTitle' ? 'selected ' : '' }>제목</option>
                            <option value="qa_Content" ${param.searchCategory == 'qaContent' ? 'selected ' : '' }>내용</option>
                            <option value="qa_Hit" ${param.searchCategory == 'qaHit' ? 'selected ' : '' }>작성일</option>
                            <option value="create_Date" ${param.searchCategory == 'createDate' ? 'selected ' : '' }>작성일</option>
                        </select>
                        <label for="search" class="blind">검색어 입력</label>
                        <input id="search" type="search" name="" placeholder="검색어를 입력해주세요." value="">
                        <button type="submit" class="btn btn-dark">검색</button>
                        <a href="QaBoardForm.do" class="btn btn-warning" role="button">글쓰기</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
								
   
  <table class="table table-info table-hover table-bordered rounded h-75">
        <thead>
            <tr>
                <th scope="col"></th>
                <th scope="col">번호</th>
                <th scope="col">제목</th>
                <th scope="col">문의 내용</th>
                <th scope="col">사진</th>
                <th scope="col">조회수</th>
                <th scope="col">작성일</th>
                <!-- <th scope="col">수정</th> -->
                <th scope="col">삭제</th>
            </tr>
        </thead>
        <tbody class="a_content">
        <c:if test="${empty qaList }">
            <tr><th colspan="8">데이터가 없습니다</th></tr>
        </c:if>

				<c:if test="${not empty qaList }">
					<c:forEach var="qa" items="${qaList}">
						<tr>
							<th scope="row">${count }<c:set var="count"
									value="${count - 1 }"></c:set></th>
							<td>${qa.qaNo}</td>
							<td>${qa.qaTitle}</td>
							<td>${qa.qaContent}</td>
							<td><img src="/youthmarket/resources/images/qa/${qa.qaImg}" alt="" width="50px" height="50px"/></td>
							<td>${qa.qaHit}</td>
							<td>${qa.createDate}</td>
							<%-- <td><button type="button" class="btn btn-primary"
									onclick="userUpdate(${qa.qaNo })">수정</button></td> --%>
							<td><button type="button" class="btn btn-secondary"
									onclick="userDelete(${qa.qaNo })">삭제</button></td>
						</tr>
					</c:forEach>
				</c:if>

			</tbody>
    </table>
    <ul class="pagination justify-content-center">
    <!-- 앞에 보여줄 것이 있다 -->
    <c:if test="${pb.startPage > pb.pagePerBlock }">
        <li class="page-item"><a class="page-link" href="${path }/qa/QaBoard.do?pageNum=1">
            <i class="icofont-duotone icofont-arrow-first"></i></a></li>
        <li class="page-item"><a class="page-link" href="${path }/qa/QaBoard.do?pageNum=${pb.startPage -1 }">
            <i class="bi bi-arrow-left-circle"></i></a></li>
    </c:if>
    <c:forEach var="i" begin="${pb.startPage }" end="${pb.endPage }">
        <c:if test="${pb.currentPage == i }">
            <li class="page-item"><a class="page-link active" href="${path }/qa/QaBoard.do?pageNum=${i}">${i }</a></li>
        </c:if>
        <c:if test="${pb.currentPage != i }">
            <li class="page-item"><a class="page-link" href="${path }/qa/QaBoard.do?pageNum=${i}">${i }</a></li>
        </c:if>
    </c:forEach>
    <!-- 뒤에 보여줄 것이 있다 -->
    <c:if test="${pb.endPage < pb.totalPage }">
        <li class="page-item"><a class="page-link" href="${path }/qa/QaBoard.do?pageNum=${pb.endPage+1 }">
            <i class="bi bi-arrow-right-circle"></i></a></li>
        <li class="page-item"><a class="page-link" href="${path }/qa/QaBoard.do?pageNum=${pb.totalPage}">
            <i class="icofont-duotone icofont-arrow-last"></i></a></li>
    </c:if>
</ul>

</section>
</body>
</html>
