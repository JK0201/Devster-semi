<%--
  Created by IntelliJ IDEA.
  User: hyunohsmacbook
  Date: 2023/05/02
  Time: 10:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="Refresh" content="10;url=./list"><!-- 10초에 한번씩 refresh -->
  <title>Insert title here</title>
  <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Jua&family=Lobster&family=Nanum+Pen+Script&family=Single+Day&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
  <style>
    body, body *{
      font-family: 'Jua'
    }
    div.box {
      width: 300px;
      height: 220px;
      border: 1px solid gray;
      border-radius: 0px;
      float: left;
      margin-right: 30px;
      padding-left: 20px;
      padding-top: 20px;
    }

      #photo{
        width:80px;
        height:80px;
        position: relative;
        left:20%;
      }


  </style>
</head>
<body>
<button type="button" class="btn btn-sm btn-outline-success"
        onclick="location.href='form'" style="margin-bottom: 10px">글작성</button>


<c:forEach var="dto" items="${list}" varStatus="i">
  <div class="box">
    <a href="hireboarddetail?hb_idx=${dto.hb_idx}&currentPage=${currentPage}"><h5 style="text-align: center;"><b>${dto.hb_subject}</b></h5></a>
    <br>
    <b>조회수 : ${dto.hb_readcount}</b>
    <br><b><fmt:formatDate value="${dto.fb_writeday}" pattern="yyyy-MM-dd"/></b>
    <a href="hireboarddetail?hb_idx=${dto.hb_idx}&currentPage=${currentPage}">
      <img src="http://${imageUrl}/hire/${dto.hb_photo}" id="photo">
    </a>
  </div>
  <c:if test="${i.count%2==0}">
    <br style="clear: both;"><br>
  </c:if>
</c:forEach>

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



