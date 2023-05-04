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
    <form action="update" enctype="multipart/form-data" method="post">
        <input type="hidden" name="m_idx" value="3">
        <input type="hidden" name="qb_idx" value="${dto.qb_idx}">
        제목 : <input type="text" name="qb_subject" value="${dto.qb_subject}"><br>
        내용 : <textarea name="qb_content">${dto.qb_content}</textarea><br>
        사진 : <input type="file" name="upload" id="myfile"><br>
        <img src="http://${imageUrl}/qboard/${dto.qb_photo}" id="show">
        <button type="submit">글 작성</button>
    </form>
</body>
<script>
    $("#myfile").change(function () {
        console.log("1:" + $(this)[0].files.length);
        console.log("2:" + $(this)[0].files[0]);
//정규표현식
        var reg = /(.*?)\/(jpg|jpeg|png|bmp)$/;
        var f = $(this)[0].files[0];//현재 선택한 파일
        if (!f.type.match(reg)) {
            alert("확장자가 이미지파일이 아닙니다");
            return;
        }
        if ($(this)[0].files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $("#show").attr("src", e.target.result);
            }
            reader.readAsDataURL($(this)[0].files[0]);
        }
    });
</script>
</html>
