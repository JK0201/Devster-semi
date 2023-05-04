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
<div style="width: 60%; margin-top: 100px; margin-left: 30px; border: 3px solid black">
    <form action="insert" enctype="multipart/form-data" method="post">
        <input type="hidden" name="m_idx" value="${sessionScope.memidx}">
        <div style="width: 300px">
            <input class="form-control" type="text" name="qb_subject" value="${dto.qb_subject}" placeholder="제목">
        </div>
        <div style="width: 300px">
            <textarea name="qb_content" class="form-control" placeholder="내용">${dto.qb_content}</textarea>
        </div>
        <div style="width: 300px">
            <input class="form-control" type="file" name="upload" multiple><br>
        </div>
        <button type="submit" class="btn btn-outline-info">글 작성</button>
        <button type="button" class="btn btn-outline-dark" onclick="history.back()">취소</button>
    </form>
</div>
</body>
</html>
