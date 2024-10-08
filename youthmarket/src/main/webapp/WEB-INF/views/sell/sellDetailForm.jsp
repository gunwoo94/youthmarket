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
	<script>
		// localStorage에서 "products" 키 값으로 가져온다.
		let products = localStorage.getItem("products");
	
		// 만약 products가 undefined가 아니라면 list 변수에 JSON.parse(products)를 통해서 JSON Array를 만들고, 그게 아니라면 list 변수를 새로운 배열로 생성한다.
		let list = products ? JSON.parse(products) : [];
	
		// 날짜를 실시간으로 얻기
		let date = new Date();
		let year = date.getFullYear(); // 2023출력
	
		let month = date.getMonth() + 1; // 0부터 시작하니 + 1 해줘서 현재 월을 출력
		month = month < 10 ? "0" + month : month; // 4월 또는 8월을 04월 08월 출력
	
		let day = date.getDate();
		day = day < 10 ? "0" + day : day;
	
		let hour = date.getHours();
		hour = hour < 10 ? "0" + hour : hour;
	
		let minute = date.getMinutes();
		minute = minute < 10 ? "0" + minute : minute;
	
		let second = date.getSeconds();
		second = second < 10 ? "0" + second : second;
	
		let dateString = year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second;
	
		let item = {sellNo : ${s.sellNo}, imgSell : "${s.imgSell}",createDate : dateString};
	
		<c:if test="${sessionScope.loginUser == null}">
			// 로그인 하지 않은 상태
			// 일단 아이템이 현재 로컬 스토리지의 상품들에 있지 않다는 가정
			let exists = false; // 존재하지 않음을 설정
			// localStorage의 상품을 for문으로 반복
			for (let i = 0; i < list.length; i++) {
				// 만약 상품들 중 현재 보는 item이 있다면
				if (item.sellNo == list[i].sellNo) {
					// list에서 제거하고
					list.splice(i, i + 1);
					// 존재함을 true로 변경 후에
					exists = true;
					// 반복문을 빠져나간다.
					break;
				}
			}
			// list의 첫번째 부분에 item을 추가함
		</c:if>
	
		list.unshift(item); // 배열 맨 앞에 추가할 item.
	
		// localStorge에 "products" 키값으로 JSON 형태로 list를 파싱하여 넣는다.
		localStorage.setItem("products", JSON.stringify(list));
		
	</script>
	

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
								<c:set var="sellerUrl"
									value="${pageContext.request.contextPath }/mypage/mypage.do" />
								<c:if test="${sessionScope.userNo != s.userNo }">
									<c:set var="sellerUrl"
										value="${pageContext.request.contextPath }/sell/seller/${s.userNo }" />
								</c:if>
								<a href="${sellerUrl }">
									<div class="sellGradeAndNameBox">
										<div class="sellerGradeImg">
											<img
												src="${path }/resources/images/fileSave/${member.fileName }"
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
												width="100%" heisght="80%">
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
								<c:if test="${session eq 'N'}">
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



	<script>

	$(document).on("click", ".followBtn-sell", (e) => {
		if ("${loginUser.userNo}" == "${s.userNo}") {
	   				Swal.fire({
		                icon: 'error',
		                title: '본인 상점은 팔로우 안돼요 !'                  
		            });
			return;
		}

		let sellUserNumber = ${s.userNo};
		
		
		$(e.target).parent().removeClass("followBtn-sell"); // 중복 이벤트 방지를 위해 class를 제거. (class를 제거하면 더 이상 이벤트 발생 안함)
		$.ajax({
			url : '${pageContext.request.contextPath}/follow/addFollow',
			type : "post",
			data : {fwId : "${s.userNo}"},
			dataType : "json",
			success : function(data) {

				let result = Number(data.result);
				if (result == 1) {
						Swal.fire({
		 	   		        icon: 'success',
		 	   		        title: sellUserNumber+'호점 팔로우 성공',
		 	   		        allowOutsideClick : false,
		 	   		    	showConfirmButton: false,
						});
						
	 	   		        setTimeout(function() {
      	            	  location.reload();
      	            	}, 1300);
					
				} else if (result == 2) {
					
						Swal.fire({
							icon:'question',
							text:'이미 팔로우 했습니다. 팔로우를 취소하시겠습니까?',
							showCancelButton: false,
							confirmButtonText: '네',
							allowOutsideClick : true
						}).then(function(){
							   follow();
						})

				} else {
					Swal.fire({
		                icon: 'error',
		                title: '로그인 후 가능합니다.'
					})
				}
				console.log(data);
			},
			error : function() {
				alert("오류가 발생.");
				console.log("오류");
			},
			complete : function () {
				$(e.target).parent().addClass("followBtn-sell");
			}
		})

	    });
	</script>

	<script>
	function follow(){
		
		$.ajax({
			url : '${pageContext.request.contextPath}/follow/delFollow',
			type : "post",
			data : {fwId : "${s.userNo}"},
			dataType : "json",
			success : function(data) {
				let count = Number(data.result)
				if (count == 1) {
					
 	   	   				Swal.fire({
 	   		                icon: 'success',
 	   		                title: '팔로우 취소되었습니다.',
 	   		            	showConfirmButton: false,
 	   		           		allowOutsideClick : false,
 	   		           		timer: 1300 
 	   		            });
 	   	   				
					$(".followBtm").attr("src", $(".followBtm").attr("src").replace("followSubBtn.png", "followAddBtn.png"));
					setTimeout(function() {
  	            	  location.reload();
  	            	}, 1300);
				} else {
 	   	   				Swal.fire({
 	   		                icon: 'error',
 	   		                title: '팔로우 취소 실패되었습니다.'                  
 	   		            });
				}
			},
			error : function() {
				alert("오류!!!");
				console.log("오류");
			}
		});
		
	}
	
	</script>

	<script>
	   //신고버튼 클릭 시
		 $('#addReport').on('click', function(){
			if( !(${loginUser.userNo >= 0}) ){
				alert("로그인하고 신고해주세요");
				return;
			 }
			 
	 		Swal.fire({
	 		  title: '상점신고',
	 		  input: 'radio',
	 		  inputOptions: {
		 			주류_담배 : '주류/담배',
		 			전문의약품_의료기기 : '전문 의약품/의료기기',
		 			개인정보거래 : '개인정보 거래',
		 			음란물_성인용품 : '음란물/성인용품',
		 			위조상품 : '위조상품',
		 			총포_도검류 : '총포/도검류',
		 			게임계정 : '게임 계정',
		 			동물분양_입양글 : '동물 분양, 입양글',
		 			기타 : '기타'
	 		  },
	 		  customClass: {
	 			    input: 'inline-flex',
	 			    inputLabel: 'inline-block'
	 		  }
			}).then(function(reportContent) {
			    if (reportContent.value) {
			    	Swal.fire('상점신고 완료', reportContent.value+" (으)로 신고하셨습니다.", "success");
			        reportAdd(reportContent.value);
			        console.log("Result: " + reportContent.value);
			    }
			})
	 	
		 });
	   
	   
		//신고추가
		 function reportAdd(value){

			 	const sellUserNo = 	"${AllList.get('product').userNo }";
			 	const purchaseUserNo = "${AllList.get('purchaseInfo').userNo }";
			
				$.ajax({
					url : "${pageContext.request.contextPath}/report/addReport",
					type:"POST",
					data : {reportContent : value,
							sellUserNo : ${s.userNo}
	      		},
					success : function(result){
						if(result == 1){
							setTimeout(function() {
          	            	  location.reload();
          	            	}, 2000);

						}
					},
					error : function(){
						console.log("통신실패");
					}
				});
	    };
	</script>


	<script>
	$(function() {
	    var $likeBtn = $('.icon.heart');
	    var isProcessing = false;

	    $likeBtn.click(function() {
	        if (isProcessing) {
	            return;  // 이미 요청이 처리 중인 경우 중복 방지
	        }
	        isProcessing = true;

	        if (!this.classList.contains('active')) {
	            // 찜하기 추가
	            $.ajax({
	                url: '${pageContext.request.contextPath}/addHeart',
	                type: 'post',
	                data: { sellNo: "${s.sellNo}" },
	                success: function(result) {
	                    if (result == "c") {
	                        Swal.fire({
	                            icon: 'success',
	                            title: '찜하기 성공'
	                        });
	                        $likeBtn.toggleClass('active');
	                        $likeBtn.find('img').attr({
	                            'src': 'https://cdn-icons-png.flaticon.com/512/803/803087.png',
	                            alt: '찜하기 완료'
	                        });
	                        setTimeout(function() {
	                            location.reload();
	                        }, 1000);
	                    } else {
	                        Swal.fire({
	                            icon: 'error',
	                            title: '회원만 사용할 수 있습니다.'
	                        });
	                    }
	                },
	                error: function() {
	                    Swal.fire({
	                        icon: 'error',
	                        title: '찜하기 실패(관리자에게 문의해주세요)'
	                    });
	                },
	                complete: function() {
	                    isProcessing = false;  // 요청 완료 후 처리 상태 해제
	                }
	            });
	        } else {
	            // 찜하기 취소
	            $.ajax({
	                url: '${pageContext.request.contextPath}/mypageDeleteHeart',
	                type: 'post',
	                data: { sellNo: "${s.sellNo}" },
	                success: function(result) {
	                    if (result == "f") {
	                        Swal.fire({
	                            icon: 'success',
	                            title: '찜하기 취소'
	                        });
	                        $likeBtn.toggleClass('active');
	                        $likeBtn.find('img').attr({
	                            'src': 'https://cdn-icons-png.flaticon.com/512/812/812327.png',
	                            alt: '찜하기 취소'
	                        });
	                        setTimeout(function() {
	                            location.reload();
	                        }, 1000);
	                    } else {
	                        Swal.fire({
	                            icon: 'error',
	                            title: '회원만 사용할 수 있습니다.'
	                        });
	                    }
	                },
	                error: function() {
	                    Swal.fire({
	                        icon: 'error',
	                        title: '찜하기 취소 실패(관리자에게 문의해주세요)'
	                    });
	                },
	                complete: function() {
	                    isProcessing = false;  // 요청 완료 후 처리 상태 해제
	                }
	            });
	        }
	    });
	});

	       
    </script>

</body>
</html>