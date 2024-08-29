<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/youthmarket/resources/css/member/mypage.css">
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
								<li><a href="#">찜한상품</a></li>
							</ul>
						</div>
						<div class="side_menu_2">
							<h2>내 정보</h2>
							<ul>
								<li><a href="${path }/member/updateForm.do">정보 수정</a></li>
								<li><a href="#">거래 후기</a></li>
								<li><a href="#">1:1 문의</a></li>
								<li><button onclick="del()">
										탈퇴하기</button></li>
							</ul>
						</div>
					</div>
					<div class="main_menu">
						<div class="profile_box">
							<div class="profile_1">
								<div class="profile_iamge_box">
									<img src="${path }/resources/images/fileSave/${member.fileName }"
										alt="프로필 사진" width="300">
								</div>
								<div class="my_nickname">
									<h2>${member.userName}</h2>
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
										<li class=""><a>예약중</a></li>
										<li class=""><a>판매완료</a></li>
									</ul>
								</div>
								<div class="product_count_and_sort">
									<div class="product_count">
										<span>총</span> <span>(개수)</span> <span>개</span>
									</div>
									<div class="product_sort">
										<ul>
											<li class="on"><button>최신순</button></li>
											<span> &#124; </span>
											<li class=""><button>낮은가격순</button></li>
											<span> &#124; </span>
											<li class=""><button>높은가격순</button></li>
										</ul>
									</div>
								</div>
								<div class="product_list_box">
									<div class="product_list active">
										<p>상품 전체 리스트 넣는 곳</p>
									</div>
									<div class="product_list">
										<p>판매중 상품 리스트 넣는 곳</p>
									</div>
									<div class="product_list">
										<p>예약중 상품 리스트 넣는 곳</p>
									</div>
									<div class="product_list">
										<p>판매완료 리스트 넣는 곳</p>
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
                
        tabCont.forEach(el => el.style.display = "none");   //모든 콘텐츠를 숨김
        tabCont[0].style.display = "block";     //첫 번째 콘텐츠를 보이게 설정

        tabBtn.forEach((tab, index) => {
            tab.addEventListener("click", () => {
                tabBtn.forEach(tab => tab.classList.remove("active"));  //모든 버튼 클래스 삭제
                tab.classList.add("active");        //클릭한 버튼만 클래스 추가

                tabCont.forEach(cont => cont.style.display = "none");   //모든 콘텐츠를 숨기
                tabCont[index].style.display = "block";     //클릭한 버튼의 콘텐츠 내용을 보여줌
            });
        });
       	
        
    };
</script>
</body>

</html>