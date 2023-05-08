<%--
  Created by IntelliJ IDEA.
  User: hyunohsmacbook
  Date: 2023/05/02
  Time: 10:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>
<%--<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="Refresh" content="10;url=./list"><!-- 10초에 한번씩 refresh -->
  <title>Insert title here</title>
  <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Jua&family=Lobster&family=Nanum+Pen+Script&family=Single+Day&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
  <style>




  </style>
</head>
<body>--%>


<div class="hb_wrap clear">


    <c:forEach var="dto" items="${list}" varStatus="i">
        <div class="box" <c:if test="${i.index % 2 == 1}">style="border-left: 1px solid #eee;padding-right: 0px;padding-left: 20px;"</c:if>>

            <span class="hb_writeday"><fmt:formatDate value="${dto.fb_writeday}" pattern="MM-dd"/></span>
            <span class="hb_readcount">조회수 : ${dto.hb_readcount}</span>

            <span class="hb_photo">
                <a href="hireboarddetail?hb_idx=${dto.hb_idx}&currentPage=${currentPage}">
                    <img src="http://${imageUrl}/hire/${dto.hb_photo}" id="photo">
                </a>
            </span>

            <h3 class="hb_subject">
                <a href="hireboarddetail?hb_idx=${dto.hb_idx}&currentPage=${currentPage}"><b>${dto.hb_subject}</b></a>
            </h3>


        </div>
        <%-- <c:if test="${i.count%2==0}">
             <br style="clear: both;"><br>
         </c:if>--%>
    </c:forEach>

</div>

<div style="width: 700px; text-align: center; font-size: 20px; margin-left: 270px;">
    <!-- 이전 -->
    <c:if test="${startPage > 1}">
        <a style="color: black; text-decoration: none; cursor: pointer;"
           href="list?currentPage=${startPage-1}">이전</a>
    </c:if>
    <c:if test="${startPage <= 1}">
        <a style="color: black; text-decoration: none; cursor: pointer; visibility: hidden;"
           href="list?currentPage=${startPage-1}">이전</a>
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
        <a style="color: black; text-decoration: none; cursor: pointer; visibility: hidden;"
           href="list?currentPage=${endPage+1}">다음</a>
    </c:if>
</div>

<br>
<button type="button" class="btn btn-sm btn-outline-success writebtn"
        onclick="location.href='form'" style="margin-bottom: 10px">글작성
</button>


<%--
</body>
</html>
--%>



