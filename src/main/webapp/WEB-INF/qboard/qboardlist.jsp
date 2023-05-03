<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
<h5 class="alert alert-danger">총 ${totalCount}개의 글이 있습니다.</h5>
<table class="table table-bordered">
    <tr style="background-color: #ddd">
        <th style="width: 40px">번호</th>
        <th style="width: 250px">제목</th>
        <th style="width: 100px">작성자</th>
        <th style="width: 120px">작성일</th>
    </tr>
    <c:if test="${totalCount == 0}">
        <tr height="50">
            <td colspan="5" align="center" valign="middle">
                <b style="font-size: 1.3em">등록된 게시글이 없습니다.</b>
            </td>
        </tr>
    </c:if>
    <c:if test="${totalCount>0}">
        <c:forEach var="dto" items="${list}">
            <tr>
                <td align="center">
                        ${no}
                    <c:set var="no" value="${no-1}"/>
                </td>
                <!-- 제목 -->
                <td>
                    <a href="detail?qb_idx=${dto.qb_idx}&currentPage=${currentPage}" style="color: black; text-decoration: none; cursor: pointer;">
                        <!-- 사진이 있을경우 아이콘 출력 -->
                        <c:if test="${dto.qb_photo!=''}">
                            <i class="bi bi-images"></i>
                        </c:if>
                            <%--   제목이 길경우 150px 만 나오고 말 줄임표...--%>
                        <span style="text-overflow:ellipsis;overflow: hidden;white-space: nowrap;display: inline-block;max-width: 300px;">${dto.qb_subject}
                        </span>
                    </a>
                </td>
                <td>
                        ${dto.m_idx}
                </td>
                <td>
                    <fmt:formatDate value="${dto.qb_writeday}" pattern="yyyy-MM-dd"/>
                </td>
            </tr>
        </c:forEach>
    </c:if>
</table>

    <button type="button" onclick="location.href='./writeform'">
        작성
    </button>

    <div style="width: 700px; text-align: center; font-size: 20px">
        <!-- 이전 -->
        <c:if test="${startPage > 1}">
            <a style="color: black; text-decoration: none; cursor: pointer;" href="list?currentPage=${startPage-1}">이전</a>
        </c:if>
        <c:if test="${startPage <= 1}">
            <a style="color: black; text-decoration: none; cursor: pointer; visibility: hidden;" href="list?currentPage=${startPage-1}">이전</a>
        </c:if>
        <!-- 페이지 번호 출력 -->
        <c:forEach var="pp" begin="${startPage}" end="${endPage}">
            <c:if test="${currentPage == pp }">
                <a style="color: green; text-decoration: none; cursor: pointer;" href="list?currentPage=${pp}">${pp}</a>
            </c:if>
            <c:if test="${currentPage != pp }">
                <a style="color: black; text-decoration: none; cursor: pointer;" href="list?currentPage=${pp}">${pp}</a>
            </c:if>
            &nbsp;
        </c:forEach>
        <!-- 다음 -->
        <c:if test="${endPage < totalPage}">
            <a style="color: black; text-decoration: none; cursor: pointer;" href="list?currentPage=${endPage+1}">다음</a>
        </c:if>
        <c:if test="${endPage >= totalPage}">
            <a style="color: black; text-decoration: none; cursor: pointer; visibility: hidden;" href="list?currentPage=${endPage+1}">다음</a>
        </c:if>
    </div>
</body>
</html>
