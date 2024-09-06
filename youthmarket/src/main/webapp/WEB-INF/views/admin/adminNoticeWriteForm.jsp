<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
body {
   margin: 0;
}
/* ========================== */
/* 로그아웃 */
.header-main-container {
   width: 100%;
   height: 70px;
   display: flex;
   justify-content: end;
   align-items: center;
   background-color: #e5e1dc;
}

.logout-div {
   margin-right: 25px;
   display: flex;
}

.logout-img {
   width: 15px;
   align-items: center;
   height: 15px;
   display: flex;
   margin: auto;
}

.logout-text {
   color: #00944e;
}
/* ========================== */
/* ========================== */
/* top 상단바 */
#layout-body {
   height: 90vh;
   background-color: #e5e1dc;
}

}
.content {
   position: static;
   background-color: #e5e1dc;
   height: 900px;
}

.top-div {
   background-color: #fff;
   height: 50px;
}

.top-title {
   margin: 10px 0 0 25px;
   font-weight: 900;
   font-size: 30px;
}
/* ========================== */
.adminboard-container {
   margin: 0;
   width: 100%;
   height: 100vh;
   background-color: #e5e1dc;
   background-size: cover;
}

.m-container {
   display: flex;
}

.menu-main-container {
   margin: 0;
   height: 100vh;
   background-color: #293b4b;
}

#icon-div {
   background-color: #243646;
   height: 90px;
}

.menu-div {
   width: 200px;
   height: 60px;
   color: white;
   font-size: 16px;
   display: flex;
   justify-content: center;
   align-items: center;
   cursor: pointer;
}

.menu-div:hover {
   background-color: #243646;
}

.menu-img {
   width: 20px;
}

.menu-img2 {
   width: 25px;
}

.a_content {
   font-size: 14px;
   text-align: center;
}
</style>

<script type="text/javascript">
   //관리자 페이지 사이드 메뉴 이동
   function pageView(data, message) {
      alert(message);
      location.href = data;
   }
</script>


</head>
<body>
   <div class="m-container">
      <div class="menu-main-container">
         <div class="menu-div"
            onclick="pageView('adminLoginForm.do', '관리자 로그인으로 이동합니다.')">
            <img class="menu-img5">&nbsp;관리자 페이지
         </div>
         <div class="menu-div"
            onclick="pageView('adminUser.do','유저 관리 페이지로 이동합니다.')">
            <img class="menu-img" alt="이미지 없음"
               src="/youthmarket/resources/images/admin/유저.png" />&nbsp;유저 관리
         </div>
        <!--  <div class="menu-div"
            onclick="pageView('adminBoard.do','게시글 관리 페이지로 이동합니다.')">
            <img class="menu-img2" alt="이미지 없음"
               src="/youthmarket/resources/images/admin/게시글.png" />&nbsp;게시글 관리
         </div> -->
         <div class="menu-div"
            onclick="pageView('adminNotice.do', '공지사항 관리 페이지로 이동합니다.')">
            <img class="menu-img" alt="이미지 없음"
               src="/youthmarket/resources/images/admin/공지사항.png" />&nbsp; 공지사항
            관리
         </div>
         <div class="menu-div"
            onclick="pageView('adminBlockList.do', '차단 회원 목록 페이지로 이동합니다.')">
            <img class="menu-img" alt="이미지 없음"
               src="/youthmarket/resources/images/admin/차단.png" />&nbsp; 차단 회원 목록
         </div>
      	<div class="menu-div" onclick="pageView('/youthmarket/sell/home.do', '홈페이지로 이동합니다.')">
				<img class="menu-img" alt="이미지 없음"
					src="/youthmarket/resources/images/icon/icon.png" />&nbsp; 홈페이지로 이동
			</div>
      </div>
      <div class="adminboard-container">
         <div class="header-main-container">
            <div class="logout-div">
               <img class="logout-img" alt=""
                  src="/youthmarket/resources/images/admin/로그아웃.png"> <a
                  href="adminLoginForm.do"> <span class="logout-text">Log
                     out</span>
               </a>
            </div>
         </div>
         <div id="layout-body">
            <div class="container-sm">
               <div class="top-title">공지사항 작성</div>
               <%-- 입력 폼 --%>
               <form action="adminNoticeWrite" method="post">
                  <input type="hidden" name="bdGroup" value=> <input
                     type="hidden" name="bdOrder" value=> <input type="hidden"
                     name="bdIndent" value=> <input type="text"
                     name="noticeTitle" class="form-control mt-4 mb-2"
                     placeholder="제목을 입력해주세요." required>
                  <div class="form-group">
                     <textarea class="form-control" rows="10" name="noticeContent"
                        placeholder="내용을 입력해주세요" required></textarea>
                  </div>
                  <button type="submit" class="btn btn-secondary mb-3">등록하기</button>
               </form>
            </div>
         </div>
      </div>
      </div>
</body>
</html>