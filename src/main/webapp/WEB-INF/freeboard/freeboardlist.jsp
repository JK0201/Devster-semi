<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Jua&family=Lobster&family=Nanum+Pen+Script&family=Single+Day&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <style>

    </style>
</head>
<body>
--%>

<table class="freeboard_table">
    <caption align="top"><h1>Free Board</h1></caption>

    <thead>
        <tr>
            <th>번호</th>
            <th>작성자</th>
            <th>제목</th>
            <th>조회</th>
            <th>좋아요</th>
            <th>싫어요</th>
            <th>작성일</th>
        </tr>
    </thead>

    <tbody>
<c:if test="${totalCount==0}">
    <h2>등록된 게시글이 없습니다..</h2>
</c:if>

<c:if test="${totalCount>0}">
    <c:forEach var="dto" items="${list}">
        <tr>
            <td>${dto.fb_idx}번</td>

            <td>${dto.nickName}</td>

            <td>
                <a href="freeboarddetail?fb_idx=${dto.fb_idx}&currentPage=${currentPage}" style="color: #000;">
                    ${dto.fb_subject}
                        <c:if test="${dto.fb_photo!='no'}">
                        &nbsp; <i class="bi bi-images"></i>
                        </c:if>
                </a>
            </td>

            <td>${dto.fb_readcount}</td>

            <td>${dto.fb_like}</td>

            <td>${dto.fb_dislike}</td>

            <td>${dto.fb_writeday}</td>
        </tr>

    </c:forEach>
</c:if>
    </tbody>
    <tfoot>
        <tr>
            <td>총 ${totalCount}개의 게시글
                <button type="button" onclick="location.href='./freewriteform'">글쓰기</button>
            </td>
        </tr>
    </tfoot>
</table>



<!-- 페이징 처리 -->
<div style="width:700px; text-align: center; font-size: 20px; background-color: rgba(255, 255, 255, 0.6)">
    <!-- 이전 -->
    <c:if test="${startPage>1}">
    <a style="font-size:17px; font-weight: bold; color: black; text-decoration: none; cursor: pointer;" href="list?currentPage=${startPage-1 }">&nbsp;이전&nbsp;</a>
    </c:if>

    <!-- 페이지번호출력 -->
    <c:forEach var="pp" begin="${startPage }" end="${endPage }">

    <c:if test="${currentPage == pp }">
    <a style="color: #3366CC; text-decoration: none; cursor: pointer; font-weight: bold;" href="list?currentPage=${pp }">&nbsp;${pp}&nbsp;</a>
    </c:if>
    <c:if test="${currentPage != pp }">
    <a style="color: black; text-decoration: none; cursor: pointer; font-weight: bold;" href="list?currentPage=${pp }">&nbsp;${pp}&nbsp;</a>
    </c:if>
    </c:forEach>

    <!-- 다음 -->
    <c:if test="${endPage<totalPage}">
    <a style="font-size:17px; font-weight: bold; color: black; text-decoration: none; cursor: pointer;" href="list?currentPage=${endPage+1 }">&nbsp;다음&nbsp;</a>
    </c:if>
<%--</body>
</html>--%>



















