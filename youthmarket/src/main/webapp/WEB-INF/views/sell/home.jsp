<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<head>
<title>Home</title>
<link rel="stylesheet" href="/youthmarket/resources/css/common/home.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript"
	src="/youthmarket/resources/js/theBogi.js"></script>
<script type="text/javascript" src="/youthmarket/resources/js/header.js"></script>
</head>
<body>

	<%-- 	<c:if test="${not empty alertMsg }">
		<c:if test="${loginUser == null }">
			<script>
			Swal.fire({
                icon: 'success',
                title: '${alertMsg}'                  
            });		
			</script>
		</c:if>
		
		<c:if test="${loginUser != null }">
			<script>
				Swal.fire({
	                icon: 'success',
	                title: '${alertMsg}'                  
	            });		
			</script>
		</c:if>
			<c:remove var="alertMsg" scope="session"/>
	</c:if> --%>

	<div class="main-section">
		<c:if test="${empty sellList}">
			<div id="displayHeader">
				<p class="main-Title">
					<b style="padding-left: 45%;"><img
						src="/youthmarket/resources/images/icon/icon.png" width="500px"
						height="500px"></b>
				</p>
				<p class="notice">데이터가 없습니다.</p>
				<hr>
				<hr>

				<br>
			</div>
		</c:if>
		<c:if test="${empty sellList}">
			<div id="displayHeader">
				<p class="main-Title">
					<b style="padding-left: 45%;"><img
						src="/youthmarket/resources/images/icon/icon.png" width="500px"
						height="500px"></b>
				</p>
				<p class="notice">데이터가 없습니다.</p>
				<hr>
				<hr>
				<br>
			</div>
		</c:if>

		<c:if test="${not empty sellList}">
			<div id="display-list" class="row">
				<c:forEach var="s" items="${sellList}" begin="0"
					end="9" step="1" varStatus="status">
					<div class="item col-3">
							<div class="item" onclick="sellDetail(${s.sellNo})">
							<div id="itemSolid" class="slist-items">
								<img src="${path}/resources/images/sell/${s.imgSell}"
									width="100%" height="150px;" class="rounded float-start" alt="">
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
			</div>
		</c:if>
	</div>

		<br>
		<div id="moreShow">
			<button class="TheBogiBtn" onclick="theBogi();" style="margin: auto;">더보기</button>
		</div>
		<div id="theBogi_body"></div>


		<script>
		function sellDetail(sellNo){
			location.href = "${pageContext.request.contextPath}/sell/sellDetail/"+sellNo;
		} 
	
		function theBogi(){
		    var ele = document.getElementById('display-list');
		    var eleCount = ele.childElementCount; // 현재 로드된 아이템 수
		    
		    $.ajax({
		        url : "${pageContext.request.contextPath}/sell/theBogi",
		        type : "POST",
		        dataType : "json",
		        data : { start: eleCount,limit:10},
		        success : function(data) {
		            var sellList = data.sellList;
		            
		            if(sellList.length > 0){
		                $(sellList).each(function(index, s){
		                    $("#display-list").append(
		                        '<div class="item col-3">'
		                        + '<div class="item" onclick="sellDetail('+ s.sellNo +')">'
		                        + '<div id="itemSolid" class="slist-items">'
		                        + '<img src="'+ '${pageContext.request.contextPath}/resources/images/sell/'+ s.imgSell +'" width="100%" height="150px;" class="rounded float-start" alt="">'
		                        + '<div class="price-time">'
		                        + '<span>&nbsp;' + s.sellTitle + '</span><br> <br>'
		                        + '<div class="price-time2">'
		                        + '<br> &nbsp;<img src="/resources/images/icon/heart.png" width="15px" height="15px" style="margin-top: 2px;">&nbsp;' + s.heartNum 
		                        + '<br> <span style="font-size: 33px; color: black;">' + s.price + '원</span>'
		                        + '</div></div></div></div></div>'
		                    );
		                });
		            } else {
		                $("#moreShow").remove(); // 더 이상 로드할 데이터가 없으면 더보기 버튼 제거
		            }
		        },
		        error : function(xhr, status, error) {
		        	  console.log("xhr: ", xhr);
			            console.log("status: ", status);
			            console.log("error: ", error);
		            alert("오류가 발생했습니다.");
		        }

		    });
		    
		    
		}



	</script>
</body>
</html>
