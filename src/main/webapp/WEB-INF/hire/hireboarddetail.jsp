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

<div>
    제목 : ${dto.hb_subject}<br>
    내용 : ${dto.hb_content}<br>
    작성자 (hb_idx) : ${dto.hb_idx}<br>
    조회수: ${dto.hb_readcount}<br>
    작성일 :  <fmt:formatDate value="${dto.fb_writeday}" pattern="yyyy.MM.dd"/><br>

    <c:if test="${dto.hb_photo!='no'}">
        사진 주소 : ${dto.hb_photo}
        <img src="https://${imageUrl}/hire/${dto.hb_photo}">
    </c:if><br><hr>
</div>
<div>
    <button type="button" onclick="location.href=''">수정</button>
    <button type="button" onclick="del(${dto.hb_idx})">삭제</button>
    <button type="button" onclick="location.href='./list?currenPage=${currentPage}'">목록</button>
</div>


<script>
    function del(hb_idx) {
        if (confirm("삭제하시겠습니까?")) {
            location.href = "./hireboarddelete?hb_idx=" + hb_idx
        }
    }
</script>

</body>
</html>
