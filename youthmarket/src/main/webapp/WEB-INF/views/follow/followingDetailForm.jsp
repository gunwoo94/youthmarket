<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<link rel="stylesheet"
	href="/youthmarket/resources/css/sell/following.css">
<script type="text/javascript" src="/youthmarket/resources/js/header.js"></script>
<title>Insert title here</title>
</head>
<body>

	<div class="main-section">
		<div class="following_box">
			<h2 class="following_title">팔로잉 목록</h2>
			<ul class="following_body">
				<c:forEach var="follow" items="${followList}">
					<li class="following_list">
						<div class="profile-image1" data-seller-no="${follow.userNo}">
							<img src="/youthmarket/resources/images/icon/grade3.png"
								height="100%" width="100%" />
						</div>
						<div>
							<div class="market-name0" data-seller-no>상점
								${follow.userNo} 호점</div>
						</div>
						<div>
							<div class="market-name1" data-seller-no>
								<img src="/youthmarket/resources/images/icon/판매수.png" width="20"
									height="15" alt="상품판매 아이콘" style="margin-top: 5px;">
								&nbsp;상품판매 ${follow.sellCount}회
							</div>
						</div>
						<div class="follow-cancel-box">
							<div class="market-name2">
								<button type="button" class="follow-cancel"
									data-fwid="${follow.userNo}">팔로잉 취소</button>
							</div>
						</div>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>

	<script>
    $(function() {
        // 팔로잉 목록 항목 클릭 시 페이지 이동
        $(".following_list").click(function(e) {
            // 클릭한 요소가 follow-cancel 버튼이 아닐 경우
            if (!$(e.target).hasClass('follow-cancel')) {
                let no = $(this).find(".profile-image1").data("seller-no");
                location.href = '${pageContext.request.contextPath}/sell/seller/' + no;
            }
        });

        // 팔로잉 취소 버튼 클릭 시 AJAX 요청
        $(document).on("click", ".follow-cancel", function(e) {
            e.stopPropagation(); // 클릭 이벤트 전파 방지

            Swal.fire({
                title: '팔로잉을 취소하시겠습니까?',
                showCancelButton: true,
                confirmButtonText: '팔로잉 취소'
            }).then((result) => {
                if (result.isConfirmed) {
                    let li = $(this).closest("li"); // 현재 li 요소 찾기
                    console.log("fwId : ", $(this).data("fwid"));
                    $.ajax({
                        url: '${pageContext.request.contextPath}/follow/delFollow',
                        type: "post",
                        data: { fwId: $(this).data("fwid") },
                        dataType: "json",
                        success: function(data) {
                            let count = Number(data.result);
                            if (count == 1) {
                                Swal.fire({
                                    title: "팔로우가 취소되었습니다.",
                                    icon: "success",
                                    showConfirmButton: true,
                                    allowOutsideClick: false,
                                    timer: 1300
                                });
                                $(li).remove(); // 리스트에서 해당 항목 제거
                            } else {
                                Swal.fire({
                                    title: "팔로우 취소 실패.",
                                    icon: "error"
                                });
                            }
                        },
                        error: function() {
                            Swal.fire({
                                title: "오류 발생",
                                text: "관리자에게 문의해주세요",
                                icon: "error"
                            });
                            console.log("오류");
                        }
                    });
                }
            });
        });
    });
</script>
</body>
</html>