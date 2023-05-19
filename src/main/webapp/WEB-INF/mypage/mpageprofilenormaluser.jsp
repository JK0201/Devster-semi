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
    </style>
</head>
<body>
    <div style="border: 3px solid black; width: 600px; margin-left: 400px">
        <h2>
            이메일 : ${dto.m_email}<br>
            이름 : ${dto.m_name}<br>
            전화번호 : ${dto.m_tele}<br>
            소속 : ${dto.ai_name}<br>
            별명 : ${dto.m_nickname}<br>
        </h2>
        <div id="imgbox">

        </div>
        <script>
            let s = '<img src="http://${imageUrl}/member/${dto.m_photo}" style="width: 300px">';
            if(${dto.m_photo != 'no'}) {
                $("#imgbox").html(s);
            }
        </script>
    </div>
</body>
</html>
