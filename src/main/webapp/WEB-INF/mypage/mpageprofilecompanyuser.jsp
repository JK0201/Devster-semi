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
    <div style="border: 3px solid black; width: 600px; margin-left: 400px">
        <h2>
            이메일 : ${dto.cm_email}<br>
            회사 이름 : ${dto.cm_compname}<br>
            회사 전화번호 : ${dto.cm_tele}<br>
            회사 주소 : ${dto.cm_addr}<br>
            회사 우편번호 : ${dto.cm_post}<br>
            담당자 이름 : ${dto.cm_name}<br>
            담당자 번호 : ${dto.cm_cp}
        </h2>
    </div>
</body>
</html>
