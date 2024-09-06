<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 상세보기</title>
    <link rel="stylesheet" type="text/css" href="${path}/resources/css/style.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            margin-top: 0;
        }
        .notice-detail {
            border-bottom: 1px solid #ddd;
            padding-bottom: 20px;
            margin-bottom: 20px;
        }
        .notice-detail p {
            margin: 10px 0;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            background-color: #333;
            color: #fff;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn:hover {
            background-color: #555;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>공지사항 상세보기</h2>

        <!-- 공지사항 상세 내용 -->
        <div class="notice-detail">
            <h3><c:out value="${notice.noticeTitle}"/></h3>
            <p><strong>작성일:</strong> <c:out value="${notice.createDate}"/></p>
            <p><strong>조회수:</strong> <c:out value="${notice.noticeHit}"/></p>
            <div class="notice-content">
                <c:out value="${notice.noticeContent}"/>
            </div>
        </div>

        <!-- 이전 목록으로 돌아가기 버튼 -->
        <a href="${path}/admin/noticeList" class="btn">목록으로 돌아가기</a>
    </div>
</body>
</html>
