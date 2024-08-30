<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="/youthmarket/resources/js/header.js"></script>
<!-- Alert 창  -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link rel="stylesheet"
	href="/youthmarket/resources/css/common/header.css">

<title>Insert title here</title>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
</head>
<body>
	<div class="headerbar">
		<div class="header1" style="background: white">
			<div class="header2">
				<div class="header3">
					<div>
						<a href="${pageContext.request.contextPath}" class="logo"> <img
							src="/youthmarket/resources/images/icon/icon.png" width="136"
							height="80" alt="보물상점 로고">
						</a>
					</div>
					<form id="sfm"
						action="${pageContext.request.contextPath}/sell/search"
						enctype="multipart/form-data" method="post">
						<div class="search1">
							<div class="search2">
								<input type="text" id="search" class="search3"
									placeholder="상품명을 입력해주세요" name="search"> <img
									onclick="document.getElementById('search').value='';"
									class="exx" id="exit"
									src="/youthmarket/resources/images/icon/x.png" width="30px"
									height="30px" alt="검색어 삭제 버튼 아이콘"> <img
									onclick="document.getElementById('sfm').submit();"
									class="searchicon"
									src="/youthmarket/resources/images/icon/search.png"
									width="30px" height="30px" alt="검색 버튼 아이콘" id="searchGO">
							</div>
						</div>
					</form>


					<div class="etIgxm">
						<!-- 본인인증 방법 로그인 O && 카카오로그인 X && 네이버 로그인 X -->
						<c:if test="${sessionScope.userId != null}">
							<a href="${path }/member/logout.do" class="items">
								${sessionScope.userName}님 환영합니다^ㅁ^<br> 로그아웃
							</a>
						</c:if>
						<!-- 본인인증 로그인 X && 카카오로그인 X 네이버로그인 XX-->
						<c:if test="${sessionScope.userId == null}">
							<a href="${path}/member/loginForm.do" class="items">
								<p>로그인</p>
							</a>
							<a href="${path}/member/joinForm.do" class="items">
								<p>회원가입</p>
							</a>
						</c:if>
					</div>
				</div>

				<div class="sun_wrap">
					<div class="sun_wrap_div">
						<a href="#" class="sun_wrap_div_cate" id="sun_wrap_div_cate">
							<span class="onecate"></span> <span class="onecate"></span> <span
							class="onecate"></span>
						</a>

					</div>
					<div class="sun_wrap_li">
						<ul id="sun_wrap_ul">
							<li><a
								href="${pageContext.request.contextPath}/chat/chatRoomList"
								class="checkUserNo"><img
									src="/youthmarket/resources/images/icon/번개.png" alt="채팅 이미지">채팅하기</a></li>

							<li><a href="${path}/sell/sellInsertForm.do "
								class="checkUserNo"> <!-- <a onclick="sellGo()" class="checkUserNo"> -->
									<img src="/youthmarket/resources/images/icon/원.png"
									alt="판매등록 이미지"> 판매하기
							</a></li>

							<li><a
								href="${pageContext.request.contextPath}/report/reportSearchForm.do"><img
									src="/youthmarket/resources/images/icon/사기조회.png"
									alt="사기조회 이미지">사기조회</a></li>
							<li><a
								href="${pageContext.request.contextPath}/mypage/mypage"
								class="checkUserNo"><img
									src="/youthmarket/resources/images/icon/내상점.png" alt="내상점 이미지">내상점</a></li>
							<c:if test="${sessionScope.userId != null}">
								<li><a href="${path }/mypage/mypage.do" class="checkUserNo"><img
										src="/youthmarket/resources/images/icon/내상점.png" alt="내상점 이미지">내상점</a>
								</li>
							</c:if>
						</ul>
					</div>
				</div>
				<div class="catebox3">

					<ul class="inner-menu">
						<li class="catebox cate1"><a href="${path }/sell/category/1"><img
								src="/youthmarket/resources/images/icon/star.png" width="40px"
								height="35px"><br>인기매물</a></li>
						<li class="catebox cate2"><a href="${path}/sell/category/10"><img
								src="/youthmarket/resources/images/icon/디지털기기.png" width="40px"
								height="35px"><br>전자</a></li>
						<li class="catebox cate3"><a
							href="${pageContext.request.contextPath}/sell/category/20"><img
								src="/youthmarket/resources/images/icon/가전제품.png" width="40px"
								height="35px"><br>생활가전</a></li>
						<li class="catebox cate4"><a
							href="${pageContext.request.contextPath}/sell/category/30"><img
								src="/youthmarket/resources/images/icon/유아용품.png" width="40px"
								height="35px"><br>유아용품</a></li>
						<li class="catebox cate5"><a
							href="${pageContext.request.contextPath}/sell/category/40"><img
								src="/youthmarket/resources/images/icon/패션.png" width="40px"
								height="35px"><br>패션</a></li>
						<li class="catebox cate6"><a
							href="${pageContext.request.contextPath}/sell/category/50"><img
								src="/youthmarket/resources/images/icon/도서.png" width="40px"
								height="35px"><br>도서</a></li>
						<li class="catebox cate7"><a
							href="${pageContext.request.contextPath}/sell/category/60"><img
								src="/youthmarket/resources/images/icon/반려동물용품.png" width="40px"
								height="35px"><br>반려동물</a></li>
						<li class="catebox cate8"><a
							href="${pageContext.request.contextPath}/sell/category/70">&nbsp;&nbsp;<img
								src="/youthmarket/resources/images/icon/스포츠.png" width="40px"
								height="35px"><br>스포츠
						</a></li>
						<li class="catebox cate9"><a
							href="${pageContext.request.contextPath}/sell/category/80"><img
								src="/youthmarket/resources/images/icon/뷰티.png" width="40px"
								height="35px"><br>뷰티</a></li>
						<li class="catebox cate10"><a
							href="${pageContext.request.contextPath}/sell/category/90"><img
								src="/youthmarket/resources/images/icon/교환권.png" width="40px"
								height="35px"><br>교환권</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<script>
		//카테고리 클릭시 해당 카테고리로 이동
		function Gocategory(categoryCode) {
			location.href = "${pageContext.request.contextPath}/sell/category/"
					+ categoryCode;
		}

		//카테고리박스 관련
		$(function() {
			$(".catebox3").hide();
			$(".sun_wrap_div").mouseover(function() {
				$(".onecate").css("background-color", "gold");
				$(".catebox3").slideDown();
			});

			$(".main-section").mouseover(function() {
				$(".onecate").css('background-color', 'black');
				$(".catebox3").slideUp();
			})
		})

		let accountInfo = "${accountInfo}";
	</script>

</body>
</html>