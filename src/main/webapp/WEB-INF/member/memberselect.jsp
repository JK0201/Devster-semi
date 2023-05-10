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
<div style="width:100px; height:50px; border: 1px solid black" id="norm">
    <a>일반회원</a>
</div>
<div style="width:100px; height:50px; border: 1px solid black" id="comp">
    <a>기업회원</a>
</div>
<script>
    $("#norm").click(function(){
       let type="0";
       console.log(type);
       location.href="agreement?type="+type;
    });
    $("#comp").click(function(){
        let type="2";
        console.log(type);
        location.href="agreement?type="+type;
    })
</script>
</body>
</html>

