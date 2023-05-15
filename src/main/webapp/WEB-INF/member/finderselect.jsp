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
<div style="width:200px; height:100px; border: 1px solid black" id="norm">
        개인회원
    <div>
        <a href="accfinder">아이디 찾기</a>
        <a href="passfinder">비밀번호 찾기</a>
    </div>
</div>
<div style="width:200px; height:100px; border: 1px solid black" id="comp">
    기업회원
    <div>
        <a href="caccfinder">아이디 찾기</a>
        <a href="cpassfinder">비밀번호 찾기</a>
    </div>
</div>
</body>
</html>

