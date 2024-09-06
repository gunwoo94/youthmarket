<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="/youthmarket/resources/css/member/mypage.css">
<script type="text/javascript" src="/youthmarket/resources/js/mypage.js"></script>
<script type="text/javascript" src="/youthmarket/resources/js/header.js"></script>
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
			<div id="contents" style="float:left; width:16%; text-align:center; margin-left:286px">
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
								<li><a href="#">1:1 문의</a></li>
								<li><button onclick="del()">탈퇴하기</button></li>
							</ul>
						</div>
					</div>
					</section>
			</div>
			<div class="list-form" style="margin: auto; padding-left: 50px;">
				<fieldset id="mForm">
					<div class="list-content">
						<div class="list-a">
							<button class="market-heart" type="button" onclick="show(this);"
								id="heart" name="show">
								<span class="rheart">찜 목록 확인 </span>
							</button>
						</div>
						<br> <br>
					</div>

					<!-- 찜목록 버튼 클릭 시, 나오는 박스 -->
					<div class="box box3" id="heartshow"
						style="display: none; padding-left: 30px; padding-top: 20px;">
						<div class="allCheck">
							<input type="checkbox" name="allCheck" id="allCheck" /><label
								for="allCheck">모두 선택</label>
						</div>
						<div class="delBtn">
							<button type="button" class="selectDelete_btn">선택 삭제</button>
						</div>

						<br> <br> <br>

						<c:forEach items="${heartList}" var="h" begin="0"
							end="${fn:length(heartList)}" step="1" varStatus="status">
							<div class="list-box">
								<div class="checkBox">
									<input type="checkbox" name="chBox" class="chBox"
										data-heartNum="${h.heartNo}" />
								</div>

								<div class="thumb" onclick="sellDetail(${h.sellNo})">
									<img src="${path}/resources/images/sell/${h.imgSell}"
										width="78px" height="78px" style="margin-top: -4px;" />
								</div>

								<div class="gdsInfo" onclick="sellDetail(${h.sellNo})">
									<p style="margin-top: 18px;">
										<span>${h.sellTitle}</span><br> <br> <span
											style="float: left; color: #bdb7b7; font-size: 21px;">${h.createDate}</span>
										<span
											style="font-size: 30px; float: right; margin-right: 627px;">${h.price}원</span><br>
									</p>
								</div>
							</div>
						</c:forEach>
					</div>
				</fieldset>
			</div>
			<!-- 찜목록 버튼 클릭 시, 나오는 박스 -->
						
			<div class="product_list_box">
				<div class="product_list active">
					<div id="productshow" class="box">
						<div class="box box3" id="heartshow"
										style="display: none; padding-left: 30px; padding-top: 20px;">
										<div class="allCheck">
												<input type="checkbox" name="allCheck" id="allCheck" /><label
												for="allCheck">모두 선택</label>
										</div>
							<c:forEach items="${heartList}" var="h" begin="0"
								end="${fn:length(heartList)}" step="1" varStatus="status">
								<div class="item col-2">
									<div class="thumb" onclick="sellDetail(${h.sellNo}">
										<div id="itemSolid" class="slist-items">
											<img src="${path}/resources/images/sell/${h.imgSell}"
												width="100%" height="150px;" class="rounded float-start"
												alt="">
											<c:if test="${s.sellStatus eq 'N' }">
												<div class="over-img"></div>
												<div class="text-c"
													style="color: white; margin-left: 71px; margin-top: -93px; margin-bottom: 75px;">
													<h3>판매완료</h3>
												</div>
											</c:if>
											<div class="price-time">
												<span>&nbsp;${h.sellTitle}</span><br> <br>
												<div class="price-time2">
													<br>&nbsp;<img
														src="/youthmarket/resources/images/icon/heart.png"
														width="15px" height="15px" style="margin-top: 2px;">&nbsp;
													&nbsp;&nbsp;&nbsp;${h.createDate} <br> <span
														style="font-size: 33px; color: black;">${h.price}원</span>
												</div>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>

					</div>
				</div>
			</div>


		</div>
	</div>







</body>
<script>
      function sellDetail(sellNo){
         location.href = "${pageContext.request.contextPath}/sell/sellDetail/"+sellNo;
      }
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