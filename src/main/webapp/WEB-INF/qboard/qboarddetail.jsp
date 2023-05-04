<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Jua&family=Lobster&family=Nanum+Pen+Script&family=Single+Day&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <style>
        body, body * {
            font-family: 'Jua'
        }
    </style>
</head>
<body>
<div style="width: 60%; margin-top: 100px; margin-left: 30px; border: 3px solid black">
    <h1>
        제목 : ${dto.qb_subject}
    </h1>
    <h6 style="color: #94969B">
        조회 ${dto.qb_readcount}
    </h6>
    <br>
    <h2>
       작성자 : ${nickname}
    </h2>
    <br>
    <h2>
        작성일자 : ${dto.qb_writeday}
    </h2>
    <br>
    <h3>
        내용 : ${dto.qb_content}
    </h3>
    <br>
        <c:forEach items="${list}" var="images">
            <img src="http://${imageUrl}/qboard/${images}" style="float: left; width: 300px">
        </c:forEach>
    <div style="clear: both">
        <button class="btn btn-outline-dark" type="button" onclick="location.href='delete?qb_idx=${dto.qb_idx}'">
            삭제
        </button>
        <button class="btn btn-outline-dark" type="button" onclick="location.href='updateform?qb_idx=${dto.qb_idx}'">
            수정
        </button>
        <button class="btn btn-success" type="button" onclick="">
            추천
        </button>
        <button class="btn btn-danger" type="button" onclick="">
            비추천
        </button>
        <button class="btn btn-warning" type="button" onclick="location.href='./list?currentPage=${currentPage}'">
            목록
        </button>
        <button class="btn btn-warning" type="button" onclick="location.href='./writeform'">
            글쓰기
        </button>
    </div>
</div>
</body>
</html>
