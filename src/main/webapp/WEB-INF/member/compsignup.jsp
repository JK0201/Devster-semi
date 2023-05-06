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
<strong> 세션 : ${ecode}</strong>
<input type="email" id="email">
<button type="button" id="send">보내기</button>

<input type="text" id="code">
<button type="button" id="codebtn">확인</button>
<script>
    $("#send").click(function () {
        let email = $("#email").val();
        alert("인증번호가 발송되었습니다");
        $.ajax({
            type: "get",
            url: "sendemail?email=" + email,
            cache: false,
            success:function(res) {
                alert("보냄"+res);
            }
        });
    });

    $("#codebtn").click(function() {

    });
</script>
</body>
</html>

