<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript"
	src="/youthmarket/resources/js/sellDetail.js"></script>
<link rel="stylesheet"
	href="/youthmarket/resources/css/sell/sellDetail.css">
<script type="text/javascript" src="/youthmarket/resources/js/header.js"></script>


</head>
<body>


	<div class="main-section">
		<div class="sellDetail-div2">
			<div class="sellDetail-div3">
				<div class="sellDetail-div4">
					<div class="categy">
						<div class="categy2">
							<img
								src="https://m.bunjang.co.kr/pc-static/resource/f1f8a93028f0f6305a87.png"
								alt="">&nbsp;&nbsp;&nbsp;카테고리

						</div>
						<div class="categy3">
							<img class=""
								src="https://m.bunjang.co.kr/pc-static/resource/c5ce9d5a172b0744e630.png"
								alt=""> ${s.categoryName }
						</div>
					</div>
				</div>
				<!-- 상품 이미지 -->
				<div class="sellImg">
					<div class="sellImg2">
						<div class="sellImg3">
							<div class="sellImgFirst"
								style="border: 1px solid rgb(238, 238, 238);">
								<img src="${path}/resources/images/sell/${s.imgSell}"
									width="100%" height="100%" class="rounded float-start" alt="">
								<c:if test="${s.sellStatus eq 'N' }">
									<div class="over-img">
										<div class="text-c"
											style="color: white; margin-top: 180px; margin-bottom: 195px;">
											<h1>판매완료</h1>
										</div>
									</div>
								</c:if>
							</div>

							<div class="sellImg3_Box">
								<div class="sellImg3_1"
									style="border: 1px solid rgb(238, 238, 238);">
									<img src="${path}/resources/images/sell/${s.imgSell}" alt=""
										style="width: 100%; height: 100%;">
								</div>

							</div>



							<!-- 판매자 정보 -->
							<div class="sellerInfo">
								<c:set var="sellerUrl" value="" />
								<%--  <c:if test="${loginUser.userNo != s.userNo }"> --%>
								<c:set var="sellerUrl" value="" />
								<%--  </c:if> --%>
								<a href="">
									<div class="sellGradeAndNameBox">
										<div class="sellerGradeImg">
											<img
												src="/youthmarket/resources/images/icon/backGray_grade3.png"
												width="100%" height="100%" />
										</div>
										<div class="sellerNameInfoBox">
											<div class="sellerName">
												<p style="font-size: 30px;">상점 ${s.userNo}호점</p>
												&nbsp;<img
													src="https://m.bunjang.co.kr/pc-static/resource/0acf058f19649d793382.png"
													width="15px" height="18px"
													style="margin-left: 15px; margin-bottom: 3px;">&nbsp;
												<p
													style="font-size: 16px; MARGIN-TOP: 12px; color: rgb(177, 171, 171);">${s.report_Num}</p>
											</div>

											<div class="sellNumAndFollowerBox">
												<p>상품 ${s.sell_Num} | 팔로워 ${s.follower_Num}</p>
											</div>
										</div>
									</div>
								</a>

								<div class="followBtn-sellDetail">
									<c:if
										test="${loginUser.getUserNo() == null || s.follow_Is == 0}">
										<button type="button" class="followBtn-sell"
											style="width: 100%; height: 100%;">
											<img class="followBtm"
												src="/youthmarket/resources/images/icon/followAddBtn.png"
												width="100%" height="80%">
										</button>
									</c:if>
									<c:if test="${s.follow_Is != 0}">
										<button type="button" class="followBtn-sell"
											style="width: 100%; height: 100%;">
											<img class="followBtm"
												src="/youthmarket/resources/images/icon/followSubBtn.png"
												width="100%" height="80%">
										</button>
									</c:if>
								</div>
							</div>
						</div>


						<!-- 상품 제목 및 가격 -->
						<div class="sellDetailInfo">
							<div class="sellTitleDiv">
								<div class="sellProductTitle">${s.sellTitle}</div>
								<br>
								<div class="sellProductPrice">
									<div class="sellProductPriceText">
										${s.price}<span>원</span>
									</div>
									<c:if test="${loginUser.userNo!=s.userNo }">
										<!-- 찜하기 버튼 -->
										<div class="right_area">
											<a href="javascript:;"
												class="icon heart ${s.heart_Is == 0?'':'active'}"> <!-- 찜 안되어있는 경우 -->
												<c:if test="${s.heart_Is == 0}">
													<img
														src="https://cdn-icons-png.flaticon.com/512/812/812327.png"
														alt="찜하기">
												</c:if> <!-- 찜 되어있는 경우 --> <c:if test="${s.heart_Is != 0}">
													<img
														src="https://cdn-icons-png.flaticon.com/512/803/803087.png"
														alt="찜취소">
												</c:if>
											</a>
										</div>
									</c:if>
								</div>
							</div>
							<!-- 찜수, 조회수, 몇분전 게시 출력 -->
							<div class="sellInfoBox">
								<div class="sellInfoTextBox">
									<div class="sellInfoTextBox2">
										<div class="sellInfoTextBox">
											<img
												src="https://m.bunjang.co.kr/pc-static/resource/e92ccca1b575780c7cb4.png"
												width="16" height="16" alt="상품 찜수 아이콘">
											<div class="sellHeartNumText">
												<span>${s.heartNum}</span>
											</div>
										</div>

										<div class="sellInfoTextBox">
											<img
												src="https://m.bunjang.co.kr/pc-static/resource/95ccf1c901ac09d733ec.png"
												width="16" height="16" alt="상품 조회수 아이콘">
											<div class="sellHeartNumText">
												<span>${s.count}</span>
											</div>
										</div>

										<div class="sellInfoTextBox">
											<img
												src="https://m.bunjang.co.kr/pc-static/resource/f5ac734eb33eb0faa3b4.png"
												width="16" height="16" alt="상품 몇분전 아이콘">
											<div class="sellHeartNumText">
												<span>${s.createDate}</span>
											</div>
										</div>
										<c:if test="${loginUser.userNo!=s.userNo }">

											<div class="sellInfoTextBox">
												<div class="sellInfoTextBoxReport">
													<img
														src="https://m.bunjang.co.kr/pc-static/resource/0acf058f19649d793382.png"
														width="16" height="16" alt="상품 몇분전 아이콘">
													<div class="sellHeartNumText">
														<span id="addReport" class="reportBtn">신고하기</span>
													</div>
												</div>
											</div>
										</c:if>
									</div>
								</div>
							</div>
							<br> <br>

							<!-- 채팅하기 버튼 -->
							<div class="purchaseGobtnBox">
								<!-- 본인이 등록한 상품일 경우에만 수정하기, 삭제하기 버튼 보이게 -->
								<c:if test="${sessionScope.userNo eq s.userNo}">
									<button class="chattingbtn-sellDetail"
										onclick="sellUpdateForm(${s.sellNo})">수정하기</button>
									<button class="chattingbtn-sellDetail"
										onclick="deleteSellDetail(${s.sellNo});">삭제하기</button>

								</c:if>

								<!-- 본인이 등록한 상품이 아닌 경우에만 채팅하기 버튼 보이게 -->
								<c:if test="${sessionScope.userNo ne s.userNo}">
									<c:if test="${s.sellStatus eq 'Y'}">
										<button class="chattingbtn-sellDetail" id="chatting-start">채팅하기</button>
									</c:if>
								</c:if>

								<!-- 거래 완료된 상품일 경우 -->
								<c:if test="${s.sellStatus eq 'N'}">
									<button class="chattingbtn-sellDetail">거래완료된 상품입니다</button>
								</c:if>
							</div>



							<!-- 상품 설명 텍스트 -->
							<div class="sellProductDetailInfoBox">
								<br> <span>&nbsp;상품정보</span>
								<p>${s.sellContent }</p>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		//상품 수정
		function sellUpdateForm(sellNo){
			location.href = "${pageContext.request.contextPath}/sell/sellUpdateForm/"+sellNo;
		}
		
		//상품 삭제
		function deleteSellDetail(sellNo) {
    if (confirm("정말로 이 상품을 삭제하시겠습니까?")) {
        // AJAX 요청을 통해 서버에 삭제 요청 보내기
        $.ajax({
            type: 'POST',
            url: '${path}/sell/sellDelete.do',
            data: { sellNo: sellNo },
            success: function(response) {
                if (response == 1) {
                    alert("상품이 성공적으로 삭제되었습니다.");
                    location.href="${path}/sell/home.do"
                } else {
                    alert("상품 삭제에 실패했습니다.");
                }
            },
            error: function(xhr, status, error) {
                console.log("Status: " + status);
                console.log("Error: " + error);
                console.log("Response Text: " + xhr.responseText);
                alert("서버 오류가 발생했습니다. 나중에 다시 시도해주세요.");
            }
        });
    }
}

	</script>



</body>
</html>