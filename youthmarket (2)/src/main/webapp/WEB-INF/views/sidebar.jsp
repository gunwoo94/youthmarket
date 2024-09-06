<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="/youthmarket/resources/css/common/sideBar.css">
<title>Insert title here</title>

</head>
<body>
	<div class="navBar">
		<!--찜 하트 수-->
		<a href="${pageContext.request.contextPath }/mypage/heartList.do">
			<div class="nfavorites">
				<div class="nfavoritesText">찜한상품</div>
				<div class="nfavoritesCount">
					<p id="ntoFavorites" class="ntoFavorites">
						<i class="nfas fa-heart"> <img
							src="https://cdn-icons-png.flaticon.com/512/833/833472.png"
							width="20">
						</i>
					</p>
				</div>
				<!-- favoritesCount -->
			</div>
		</a>
		<!--찜 끝-->

		<!-- 최근 본 상품 시작 -->
		<div class="nrecently">
			<div class="nrecentlyText">최근본상품</div>
			<div class="nrecentlyProduct">
				<div id="nrecentlyCnt"></div>
				<div id="nrecentlyArea">
					<ul id="nrecentlyList">
						<!-- 최근본상품  -->
					</ul>
				</div>
			</div>
			<div id="recentlyPaging" style="text-align: center;">
				<button id="recentlySubPage" class="btn subpage Btm">&lt;</button>

				<span id="currentPage">1 / 3</span>

				<button id="recentlyAddPage" class="btn addpage Btm">&gt;</button>
			</div>
		</div>
		<!-- 최근 본 상품 끝 -->
		<div class="ntheTop">
			<a href="#" class="ntopText">TOP</a>
		</div>
	</div>

	<script>

// localStorage에서 products 키값 가져오기.
let sideBarProducts = localStorage.getItem("products");

// 만약 products가 undefined가 아니라면 list 변수에 JSON.parse(sideBarProducts)를 통해서 JSON Array를 만들고, 그게 아니라면 list 변수를 새로운 배열로 생성한다.
let sideBarList = sideBarProducts ? JSON.parse(sideBarProducts) : [];

<c:choose>
    <c:when test="${sessionScope.loginUser != null}">
    let sideBarUrl = sideBarList.length > 0 ? "${pageContext.request.contextPath}/recent/update" : "${pageContext.request.contextPath}/recent/products";

        $.ajax({
            async: false,
            url: sideBarUrl,
            data: JSON.stringify(sideBarList),
            type: "post",
            dataType: "json",
            contentType: "application/json",
            success: function(data) {
                console.log("Response data: ", data); // 수신한 원시 데이터 로그
                if (!data || data.length === 0) {
                    console.error("Received null or empty data from server");
                    return;
                }
                console.log("Sending data to server:", JSON.stringify(sideBarList));
                console.log("Processing received data: ", data);
                localStorage.removeItem("products");
                $("#nrecentlyList").children().remove();

                $(data).each((i, elem) => {
                    if (!elem || !elem.imgSell) {
                        console.error("imgSell is not present or elem is null: ", elem);
                        return;
                    }
                    
                    // 이미지 경로 수정
                    elem.imgSell = "${path}/resources/images/sell/" + elem.imgSell;

                    $("#nrecentlyList")
                        .append($("<li>")
                            .append($("<a>", { href: "${pageContext.request.contextPath}/sell/sellDetail/" + elem.sellNo })
                                .append($("<img>", { src: elem.imgSell }).addClass("nrecentlyImage"))
                            )
                            .append($("<input>", { type: "hidden", name: "recentNo", value: elem.recentNo }))
                            .append($("<input>", { type: "hidden", name: "sellNo", value: elem.sellNo }))
                            .append($("<input>", { type: "hidden", name: "imgSell", value: elem.imgSell }))
                            .append($("<button>", { text: "X", class: "deleteBtn" }))
                        );
                });
	
                $("#nrecentlyCnt").text(data.length);
            },

            error: function() {
                console.log("오류 발생");
            }
        });
    </c:when>
    <c:otherwise>
        
        // 리스트가 빈값이 아니라면
        if (sideBarList) {
            $("#nrecentlyList").children().remove();

            for (let i = 0; i < sideBarList.length; i++) {
                // 경로 수정
                sideBarList[i].imgSell = "${path}/resources/images/sell/" + sideBarList[i].imgSell;
                
                $("#nrecentlyList")
                    .append($("<li>")
                        .append($("<a>", { href: "${pageContext.request.contextPath}/sell/sellDetail/" + sideBarList[i].sellNo })
                            .append($("<img>", { src: sideBarList[i].imgSell }).addClass("nrecentlyImage"))
                        )
                        .append($("<input>", { type: "hidden", name: "sellNo", value: sideBarList[i].sellNo }))
                        .append($("<input>", { type: "hidden", name: "imgSell", value: sideBarList[i].imgSell }))
                        .append($("<button>", { text: "X", class: "deleteBtn" }))
                    );
            }
        }
    </c:otherwise>
</c:choose>

// 처음 인덱스
let index = 0;

$(function() {
    setCount();
});

// 이전 버튼
$(document).on("click", "#recentlySubPage", (e) => {

    // index가 0이라면 첫 페이지다.
    if (index == 0) {
        console.log("첫 페이지입니다.");
        return;
    }

    // 만약 첫 페이지가 아니라면 index에서 3을 빼준다.
    index -= 3;

    $("#nrecentlyList").children().each((i, elem) => {
        // i 가 index 이상이고, i가 index에 2를 더한 것 이하라면
        if (i >= index && i <= index + 2) {
            // 요소를 보여주고
            $(elem).show();
        } else {
            // 아니라면 감춘다.
            $(elem).hide();
        }
    });

    setCount();

});

// 다음 버튼
$(document).on("click", "#recentlyAddPage", (e) => {
    // index에 3을 더한 것이 이미지의 개수 이상이라면
    if ($("#nrecentlyList").children().length <= (index + 3)) {
        console.log("마지막 페이지입니다.");
        return;
    }

    index += 3;

    setCount();

});

$(document).on("click", ".deleteBtn", (e) => {

    let li = $(e.target).closest("li");

    let sellNo = $(li).find(":hidden[name=sellNo]").val();

    <c:choose>
        <c:when test="${sessionScope.loginUser != null}">

            let recentNo = $(li).find(":hidden[name=recentNo]").val();

            $.ajax({
                async: false, // 비동기로 하면 삭제 시점과 다시 출력해주는 시점이 겹치거나 빠를 수 있다.
                url: "${pageContext.request.contextPath}/recent/delete",
                type: "post",
                data: { recentNo: recentNo, sellNo: sellNo, userNo: "${sessionScope.loginUser.userNo}" },
                dataType: "json",
                success: (data) => {
                    if (Number(data.result) > 0) { // data.result가 0 이상이라면 삭제가 되었다는 의미이므로
                        $(li).remove();
                        setCount($("#nrecentlyList").children().length);
                    }
                },
                error: () => {
                    console.log("에러 발생");
                }
            });
        </c:when>
        <c:otherwise>
            $(li).remove();
            sideBarList = [];
            $("#nrecentlyList").children().each((i, elem) => {
                sideBarList.push(
                    {
                        sellNo: $(elem).find(":hidden[name=sellNo]").val(),
                        imgSell: $(elem).find(".nrecentlyImage").val(),
                        createDate: $(elem).find(":hidden[name=createDate]").val()
                    }
                );
            });
            console.log("sideBarList 삭제 후 :", sideBarList);
            setCount();
            // localStorage에 "products" 키값으로 JSON 형태로 list를 파싱하여 넣는다.
            localStorage.setItem("products", JSON.stringify(sideBarList));
        </c:otherwise>
    </c:choose>
});

function setCount() {
    $("#nrecentlyList").children().each((i, elem) => {
        // i 가 index 이상이고, i가 index에 2를 더한 것 이하라면
        if (i >= index && i <= index + 2) {
            // 요소를 보여주고
            $(elem).show();
        } else {
            // 아니라면 감추기.
            $(elem).hide();
        }
    });

    let len = $("#nrecentlyList").children().length;
    $("#nrecentlyCnt").text(len);
    $("#currentPage").text((index / 3 + 1) + " / " + (Math.ceil(len / 3)));
}
		
</script>

</body>
</html>
