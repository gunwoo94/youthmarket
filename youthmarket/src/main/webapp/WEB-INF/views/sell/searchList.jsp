<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../common.jsp"%>
<html>
<head>
<title>Home</title>
<link rel="stylesheet"
	href="/youthmarket/resources/css/sell/searchList.css">
<link rel="stylesheet" href="/youthmarket/resources/css/common/home.css">
<link rel="stylesheet"
	href="/youthmarket/resources/css/common/Gocategory.css">
<link rel="stylesheet"
	href="https://naver.github.io/billboard.js/release/latest/dist/theme/datalab.min.css">
<script
	src="https://naver.github.io/billboard.js/release/latest/dist/billboard.pkgd.min.js"></script>
<script type="text/javascript" src="/youthmarket/resources/js/header.js"></script>
</head>

<body>

	<div class="main-section">
		<div class="searchresultBox" style="display: flex;">
			<p>${keyword}</p>
			의 검색결과
		</div>
		<hr
			style="width: 1000px; background: #e4e0e1; height: 1px; border: 0;">

		<div id="display-list" class="row" style="padding-top: 50px;">
			<c:forEach var="s" items="${sList}" begin="0"
				end="${fn:length(sList)}" step="1">
				<div class="item col-2">
					<div class="item" onclick="sellDetail(${s.sellNo})">
						<div id="itemSolid" class="slist-items">
								<img src="${path}/resources/images/sell/${s.imgSell}"
									width="100%" height="150px;" class="rounded float-start" alt="">
							<div class="price-time">
								<span>&nbsp;${s.sellTitle}</span><br>
								<br>
								<div class="price-time2">
									<br> &nbsp;<img
										src="/youthmarket/resources/images/icon/heart.png"
										width="15px" height="15px" style="margin-top: 2px;">&nbsp;${s.heartNum}
									&nbsp;&nbsp;&nbsp;${s.timeago} <br> <span
										style="font-size: 33px; color: black;">${s.price}원</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

	<script>
		function sellDetail(sellNo) {
			location.href = "${pageContext.request.contextPath}/sell/sellDetail/" + sellNo;
		}
	</script>

	<script>
		$(document).ready(function() {
			var keyword = "${keyword}"; 
			
			if (keyword != "") {  // 검색어 부분 유지하기
				$("#search").val(keyword);
			}
		});
	</script>

</body>
</html>
