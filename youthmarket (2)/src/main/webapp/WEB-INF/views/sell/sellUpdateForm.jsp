<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="/youthmarket/resources/css/sell/sellInsert.css">
<script type="text/javascript"
	src="/youthmarket/resources/js/sellInsert.js"></script>
<title>상품 수정 페이지</title>
</head>
<body>
	<div class="sellInsert-div">
		<form id="sellInsertForm" action="${path}/sell/sellUpdate.do"
			enctype="multipart/form-data" method="post">
			<input type="hidden" name="sellNo" value="${s.sellNo }" />
			<div class="main-section">
				<div class="sellInsert1">
					<main class="sellInsert2">
						<section class="sellInsert3">
							<h2 class="sellInsert4">판매 수정</h2>
							<ul id="listBody">
								<!-- 이미지 -->
								<li class="list">
									<div class="image_sub">
										상품이미지<span>*</span><small>(1/3)</small>
									</div>
									<div class="image_con">
										<ul class="sellInsertImages" id="imageList">
											<li class="imageList">이미지 등록 <input type="file"
												id="inputImage" name="upfile" multiple
												onchange="clearExistingImage()"></li>
											<li draggable="false" class="registUserImages"
												id="existingImageContainer">
												<div class="imageRepresentive">대표이미지</div> <img
												src="${pageContext.request.contextPath}/resources/images/sell/${s.imgSell}"
												alt="상품이미지" id="existingImage">
											</li>
										</ul>
									</div>
								</li>
								<!-- 제목 -->
								<li class="list">
									<div class="title_insert">
										제목<span>*</span>
									</div>
									<div class="title_insert2">
										<input type="text" minlength="2" maxlength="40"
											placeholder="상품 제목을 입력해주세요." class="titleInput"
											id="product_subject" name="sellTitle" required
											value="${s.sellTitle}">
									</div>
								</li>
								<!-- 카테고리 -->
								<li class="list">
									<div class="category_sub">
										카테고리<span>*</span>
									</div>
									<div class="category_sub">
										<select name="categoryNo" id="category_sub" required>
											<c:forEach var="c" items="${cateList }">
												<option value="${c.categoryNo }"
													<c:if test="${s.categoryNo eq c.categoryNo }">selected="selected"</c:if>>${c.categoryName }</option>
											</c:forEach>
										</select>
									</div>
								</li>
								<!-- 가격 -->
								<li class="list">
									<div class="price_sub">
										가격<span>*</span>
									</div>
									<div class="price_con">
										<input type="text" placeholder="숫자만 입력해주세요."
											class="priceInput" id="product_price" name="price" required
											maxlength="11" value="${s.price }" />원
									</div>
								</li>
								<!-- 설명 -->
								<li class="list">
									<div class="content_sub">
										설명<span>*</span>
									</div>
									<div class="content_con">
										<textarea style="resize: none;" rows="10" class="content"
											id="sell_content" name="sellContent" required minlength="10"
											maxlength="2000">${s.sellContent }</textarea>
									</div>
								</li>
							</ul>
						</section>
					</main>
				</div>
				<footer class="insertBtm">
					<div class="insertBtmArea">
						<button type="submit" id="updateBtn">수정하기</button>
					</div>
				</footer>
			</div>
		</form>
	</div>
	<script type="text/javascript">
		function clearExistingImage() {
			const existingImageContainer = document
					.getElementById('existingImageContainer');
			existingImageContainer.style.display = 'none'; // 기존 이미지 숨기기
		}
	</script>

</body>
</html>
