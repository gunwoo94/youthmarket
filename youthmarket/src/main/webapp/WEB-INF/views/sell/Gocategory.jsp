<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../common.jsp"%>
<html>
<head>
<title>카테고리</title>

<link rel="stylesheet" href="/youthmarket/resources/css/common/home.css">
<link rel="stylesheet"
	href="/youthmarket/resources/css/common/Gocategory.css">
<script type="text/javascript" src="/youthmarket/resources/js/header.js"></script>

</head>
<body>
	<div class="main-section">
		<div id="displayHeader">
			<p class="cate_main-Title" style="font-size: 20px;">
				<img
					src="https://m.bunjang.co.kr/pc-static/resource/f1f8a93028f0f6305a87.png"
					width="20px" height="20px">&nbsp;&nbsp;&nbsp;카테고리&nbsp; <img
					class=""
					src="https://m.bunjang.co.kr/pc-static/resource/c5ce9d5a172b0744e630.png"
					width="15px" height="15px">&nbsp;
				<c:if test="${categoryCode == 1}">
                인기매물
            </c:if>
				<c:if test="${categoryCode != 1}">
                ${sellList[0].categoryName}
            </c:if>
				<a href="${path}/sell/category/${categoryCode}/recent"
					style="padding-left: 380px;">최신순</a> <a
					href="${path}/sell/category/${categoryCode}/popular">인기순</a> <a
					href="${path}/sell/category/${categoryCode}/lowest">저가순</a> <a
					href="${path}/sell/category/${categoryCode}/high">고가순</a>
			</p>
			<hr>
			<br>
		</div>
		<div id="display-list" class="row">
			<c:choose>
				<c:when test="${empty sellList}">
					<p>등록된 상품이 없습니다.</p>
				</c:when>
				<c:otherwise>
					<c:forEach var="s" items="${sellList}" begin="0" end="9" step="1"
						varStatus="status">
						<div class="item col-3">
							<div class="item" onclick="sellDetail(${s.sellNo})">
								<div id="itemSolid" class="slist-items">
									<img src="${path}/resources/images/sell/${s.imgSell}"
										width="100%" height="150px;" class="rounded float-start"
										alt="">
									<div class="price-time">
										<span>&nbsp;${s.sellTitle}</span><br> <br>
										<div class="price-time2">
											<br> &nbsp;<img
												src="${path}/resources/images/icon/heart.png" width="15px"
												height="15px" style="margin-top: 2px;">&nbsp;${s.heartNum}
											<br> <span style="font-size: 33px; color: black;">${s.price}원</span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>
	</div>


	<script>
	function sellDetail(sellNo){
		location.href = "${pageContext.request.contextPath}/sell/sellDetail/"+sellNo;
	} 

	</script>


</body>
</html>
