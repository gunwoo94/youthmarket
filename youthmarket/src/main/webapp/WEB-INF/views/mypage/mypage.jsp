<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="/youthmarket/resources/css/member/mypage.css">
<script type="text/javascript">
	function del(){
	    let pt = prompt("탈퇴하시려면 '회원 탈퇴'를 입력하세요")
	    if(pt == "회원 탈퇴") {
	        let cf = confirm("정말로 탈퇴하시겠습니까?")
	        if(cf) {
	            location.href="${path}/member/delete.do"
	        } else {
	            alert("탈퇴가 취소 되었습니다");
	        }
	    } else if(pt == null) {
	        alert("탈퇴가 취소 되었습니다");
	    } else {
	        alert("입력이 잘못되었습니다");
	        
	    }
	}
</script>
</head>
<body>
	<div id="wrap">
		<div id="container">
			<div id="contents">
				<section id="mypage">
					<div class="side_menu">
						<div class="side_menu_title">
							<h1>마이 페이지</h1>
						</div>
						<div class="side_menu_1">
							<h2>거래 정보</h2>
							<ul>
								<li><a href="#">판매내역</a></li>
								<li><a href="#">구매내역</a></li>
								<li><a href="${path}/mypage/heartList.do">찜한상품</a></li>
							</ul>
						</div>
						<div class="side_menu_2">
							<h2>내 정보</h2>
							<ul>
								<li><a href="${path }/member/updateForm.do">정보 수정</a></li>
								<li><a href="#">거래 후기</a></li>
								<li><a href="${path }/admin/QaBoard.do">1:1 문의</a></li>
								<li><button onclick="del()">탈퇴하기</button></li>
							</ul>
						</div>
					</div>
					<div class="main_menu">
						<div class="profile_box">
							<div class="profile_1">
								<div class="profile_iamge_box">
									<img
										src="${path }/resources/images/fileSave/${member.fileName }"
										alt="프로필 사진" width="300px">
								</div>
								<div class="profile_2">
									<div class="my_nickname">
										<h2>${member.userName}</h2>
									</div>
									<div class="info-list">
										<div class="market-open">
											<div class="market-opendate">
												<img src="/youthmarket/resources/images/icon/상점오픈.png"
													width="20" height="15" alt="상점오픈일 아이콘">&nbsp;<span>상점오픈일</span>&nbsp;<span>${marketOpen }일
													전</span>
											</div>
										</div>

										<div class="follower">
											<div class="market-follower">
												<img src="/youthmarket/resources/images/icon/팔로워.png"
													width="20" height="15" alt="팔로워 아이콘">&nbsp;<span>팔로워</span>&nbsp;<span>${followCount }명</span>
											</div>
										</div>

										<div class="sell-product">
											<div class="market-sell">
												<img src="/youthmarket/resources/images/icon/판매수.png"
													width="20" height="15" alt="상품판매 아이콘"> &nbsp; <span>상품판매</span>&nbsp;<span>${sellCount }회</span>
											</div>
										</div>

										<div class="report">
											<div class="market-report">
												<img src="/youthmarket/resources/images/icon/신고수.png"
													width="20" height="15" alt="신고 아이콘""> &nbsp; <span>신고</span>&nbsp;<span>${reportCount }회</span>
											</div>
										</div>
									</div>
									<div class="button-area1">
										<a
											href="${pageContext.request.contextPath }/follow/followList"
											class="following-list">팔로잉 목록</a>
									</div>
								</div>
							</div>
							<div class="my_product">
								<div class="my_product_title">
									<h2>내 상품</h2>
								</div>
								<div class="product_section">
									<ul>
										<li class="active"><a>전체</a></li>
										<li class=""><a>판매중</a></li>
										<li class=""><a>판매완료</a></li>
									</ul>
								</div>
								<div class="product_count_and_sort">
									<div class="product_count active">
										<span>총</span> <span>${fn:length(sellList)}</span> <span>개</span>
									</div>
									<div class="product_count">
										<span>총</span> <span>${fn:length(sellList2)}</span> <span>개</span>

									</div>
									<div class="product_count">
										<span>총</span> <span>${fn:length(sellList3)}</span> <span>개</span>
									</div>
									<!-- <div class="product_sort">
										<ul>
											<li class="on"><button>최신순</button></li>
											<span> &#124; </span>
											<li class=""><button>낮은가격순</button></li>
											<span> &#124; </span>
											<li class=""><button>높은가격순</button></li>
										</ul>
									</div> -->
								</div>
								<div class="product_list_box">
									<div class="product_list active">
										<c:forEach var="s" items="${sellList}" varStatus="status">
											<div class="product">
												<div id="itemSolid" class="slist-items">
													<img src="${path}/resources/images/sell/${s.imgSell}"
														alt="" class="prImg hover"
														onclick="sellDetail(${s.sellNo})">
													<%-- <c:if test="${s.sellStatus eq 'N' }">
														<div class="over-img"></div>
														<div class="text-c">
															<h3>판매완료</h3>
														</div>
													</c:if> --%>
													<div class="price-time">
														<span onclick="sellDetail(${s.sellNo})" class="hover">&nbsp;${s.sellTitle}</span><br>
														<div class="time">
															<div class="ta_end">
																<img src="${path }/resources/images/icon/heart.png"
																	class="htImg">${s.heartNum}&nbsp;
															</div>
															<div class="ta_end">&nbsp;${s.timeago}</div>
														</div>
														<div class="price">
															<c:if test="${s.sellStatus eq 'Y' }">
																<span style="font-size: 25px; font-weight: bold;">&nbsp;${s.price}원</span>
															</c:if>
															<c:if test="${s.sellStatus eq 'N' }">
																<span style="font-size: 25px; font-weight: bold;">&nbsp;판매완료</span>
															</c:if>
														</div>
													</div>
												</div>
											</div>
										</c:forEach>
										<c:if test="${empty sellList}">
											<div class="no_pr">
												<p>상품이 없습니다.</p>
											</div>
										</c:if>
									</div>
									<div class="product_list">
										<c:forEach var="s" items="${sellList}" varStatus="status">
											<c:if test="${s.sellStatus eq 'Y' }">
												<div class="product">
													<div id="itemSolid" class="slist-items">
														<img src="${path}/resources/images/sell/${s.imgSell}"
															alt="" class="prImg hover"
															onclick="sellDetail(${s.sellNo})">
														<div class="price-time">
															<span onclick="sellDetail(${s.sellNo})" class="hover">&nbsp;${s.sellTitle}</span><br>
															<div class="time">
																<div class="ta_end">
																	<img src="${path }/resources/images/icon/heart.png"
																		class="htImg">${s.heartNum}&nbsp;
																</div>
																<div class="ta_end">&nbsp;${s.timeago}</div>
															</div>
															<div class="price">
																<c:if test="${s.sellStatus eq 'Y' }">
																	<span style="font-size: 25px; font-weight: bold;">&nbsp;${s.price}원</span>
																</c:if>
															</div>
														</div>
													</div>
												</div>
											</c:if>
										</c:forEach>
										<c:if test="${fn:length(sellList2) == 0}">
											<div class="no_pr">
												<p>판매중인 상품이 없습니다.</p>
											</div>
										</c:if>
									</div>
									<div class="product_list">
										<c:forEach var="s" items="${sellList}" varStatus="status">
											<c:if test="${s.sellStatus eq 'N' }">
												<div class="product">
													<div id="itemSolid" class="slist-items">
														<img src="${path}/resources/images/sell/${s.imgSell}"
															alt="" class="prImg hover"
															onclick="sellDetail(${s.sellNo})">
														<%-- <c:if test="${s.sellStatus eq 'N' }">
														<div class="over-img"></div>
														<div class="text-c">
															<h3>판매완료</h3>
														</div>
													</c:if> --%>
														<div class="price-time">
															<span onclick="sellDetail(${s.sellNo})" class="hover">&nbsp;${s.sellTitle}</span><br>
															<div class="time">
																<div class="ta_end">
																	<img src="${path }/resources/images/icon/heart.png"
																		class="htImg">${s.heartNum}&nbsp;
																</div>
																<div class="ta_end">&nbsp;${s.timeago}</div>
															</div>
															<div class="price">
																<span style="font-size: 25px; font-weight: bold;">&nbsp;판매완료</span>
															</div>
														</div>
													</div>
												</div>
											</c:if>
										</c:forEach>
										<c:if test="${fn:length(sellList3) == 0}">
											<div class="no_pr">
												<p>판매된 상품이 없습니다.</p>
											</div>
										</c:if>
									</div>
								</div>
							</div>
						</div>
					</div>
				</section>
			</div>
		</div>
	</div>
</body>

<script>
    window.onload = function () {
        const tabBtn = document.querySelectorAll(".product_section > ul > li"); //버튼 설정
        const tabCont = document.querySelectorAll(".product_list_box > div");   //콘텐츠 설정
        const tabCont2 = document.querySelectorAll(".product_count_and_sort > div");   //콘텐츠 설정
                
        tabCont.forEach(el => el.style.display = "none");   //모든 콘텐츠를 숨김
        tabCont2.forEach(el => el.style.display = "none");   //모든 콘텐츠를 숨김
        tabCont[0].style.display = "flex";     //첫 번째 콘텐츠를 보이게 설정
        tabCont2[0].style.display = "block";     //첫 번째 콘텐츠를 보이게 설정

        tabBtn.forEach((tab, index) => {
            tab.addEventListener("click", () => {
                tabBtn.forEach(tab => tab.classList.remove("active"));  //모든 버튼 클래스 삭제
                tab.classList.add("active");        //클릭한 버튼만 클래스 추가

                tabCont.forEach(cont => cont.style.display = "none");   //모든 콘텐츠를 숨김
                tabCont2.forEach(cont => cont.style.display = "none");   //모든 콘텐츠를 숨김
                tabCont[index].style.display = "flex";     //클릭한 버튼의 콘텐츠 내용을 보여줌
                tabCont2[index].style.display = "block";     //클릭한 버튼의 콘텐츠 내용을 보여줌
            });
        });
    };
    function sellDetail(sellNo){
			location.href = "${pageContext.request.contextPath}/sell/sellDetail/"+sellNo;
		}

</script>
<script>
      function sellDetail(sellNo){
         location.href = "${pageContext.request.contextPath}/sell/sellDetail/"+sellNo;
      }
   </script>


<script>
window.onload = function () {
    const tabBtn = document.querySelectorAll(".product_section > ul > li"); //버튼 설정
    const tabCont = document.querySelectorAll(".product_list_box > div");   //콘텐츠 설정
    const tabCont2 = document.querySelectorAll(".product_count_and_sort > div");   //콘텐츠 설정
            
    tabCont.forEach(el => el.style.display = "none");   //모든 콘텐츠를 숨김
    tabCont2.forEach(el => el.style.display = "none");   //모든 콘텐츠를 숨김
    tabCont[0].style.display = "flex";     //첫 번째 콘텐츠를 보이게 설정
    tabCont2[0].style.display = "block";     //첫 번째 콘텐츠를 보이게 설정

    tabBtn.forEach((tab, index) => {
        tab.addEventListener("click", () => {
            tabBtn.forEach(tab => tab.classList.remove("active"));  //모든 버튼 클래스 삭제
            tab.classList.add("active");        //클릭한 버튼만 클래스 추가

            tabCont.forEach(cont => cont.style.display = "none");   //모든 콘텐츠를 숨김
            tabCont2.forEach(cont => cont.style.display = "none");   //모든 콘텐츠를 숨김
            tabCont[index].style.display = "flex";     //클릭한 버튼의 콘텐츠 내용을 보여줌
            tabCont2[index].style.display = "block";     //클릭한 버튼의 콘텐츠 내용을 보여줌
        });
    });
};
</script>
<script>

$("#allCheck").click(function(){
    var chk = $("#allCheck").prop("checked");
    if(chk) {
     $(".chBox").prop("checked", true);
    } else {
     $(".chBox").prop("checked", false);
    }
 })
  </script>



<script>
$(".chBox").click(function(){
    $("#allCheck").prop("checked", false);
    });
    
    </script>

<script>
     $(".selectDelete_btn").click(function(){
   var confirm_val = true;
   
   if(confirm_val) {
    var checkArr = [];
    
    
    $("input[class='chBox']:checked").each(function(){
     checkArr.push($(this).attr("data-heartNum"));
    })
    
    
    console.log(checkArr);
    
    
    $.ajax({
     url : '${pageContext.request.contextPath}/deleteHeart',
     type : 'post',
     data : { chbox : checkArr },
     success : function(result){
    	if(result==1){
    		Swal.fire({
                icon: 'success',
                title: '삭제되었습니다.'                  
            });	
    		setTimeout(function() {
            	  location.reload();
          	}, 1500);
    	}
     },
     error:function(){
        console.log("실패")
     }
   
    });
   } 
  });
  
  
  </script>
</body>

</html>