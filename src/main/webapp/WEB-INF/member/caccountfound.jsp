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
        body, html {
            margin: 0;
            padding: 0;
            font-family: 'Noto Sans KR', 'Roboto';
            background: white;
        }

        .container {
            display: block;
            max-width: 680px;
            width: 80%;
            margin: -60px auto;
        }

        .logo {
            font-size: 20px;
            text-align: center;
            margin: 120px 0 40px 0;
            transition: .2s linear;
        }

        .links {
            list-style-type: none;
        }

        .links li {
            display: inline-block;
            margin: 0 20px 0 0;
            transition: .2s linear;
        }

        .links li:nth-child(1):hover {
            opacity: 1;
        }

        .links li:nth-child(2) {
            opacity: .6;
        }

        .links li a {
            text-decoration: none;
            color: #0f132a;
            font-weight: bolder;
            text-align: center;
            cursor: default;
        }

        #normmember span {
            opacity: 0.6;
        }

        .inputdiv {
            width: 100%;
            max-width: 680px;
            margin: 40px auto 10px;
            box-shadow: 4px 4px 14px 7px #bdbebd;
            padding-top: 5vh;
            padding-bottom: 5vh;
        }

        .inputdiv .input__block {
            margin: 20px auto;
            display: block;
            position: relative;
        }

        .inputdiv .input__block input {
            display: block;
            width: 90%;
            max-width: 680px;
            height: 50px;
            margin: 0 auto;
            border-radius: 8px;
            border: 2px solid rgba(15, 19, 42, .2);
            background: rgba(15, 19, 42, .1);
            color: rgba(15, 19, 42, .5);
            padding: 0 0 0 15px;
            font-size: 18px;
            font-family: 'Noto Sans KR', 'Roboto';
            transition: .2s linear;
        }

        .inputdiv .input__block input:focus,
        .inputdiv .input__block input:active {
            outline: none;
            border-color: #8007AD;
            color: rgba(15, 19, 42, 1);
        }

        .inputdiv .input__block b {
            margin-left: 40px;
        }

        .inputdiv .input__block span {
            margin-left: 40px;
            color: #808080;
        }

        .inputdiv .signin__btn {
            background: #8007AD;
            color: white;
            display: block;
            width: 92.5%;
            max-width: 680px;
            height: 50px;
            border-radius: 8px;
            margin: 0 auto;
            border: none;
            cursor: pointer;
            font-size: 19px;
            font-family: 'Noto Sans KR', 'Roboto';
            box-shadow: 0 15px 30px rgba(114, 30, 166, .36);
            transition: .2s linear;
            font-weight: bold;
        }

        .inputdiv .signin__btn:hover {
            box-shadow: 0 0 0 rgba(233, 30, 99, 0);
        }

        .memberlayout footer {
            margin-top: 200px;
        }

        .inputdiv .membermail {
            margin-bottom: 20px;
            display: block;
            position: relative;
        }

        .inputdiv .membermail input {
            float: left;
            display: block;
            width: 70%;
            max-width: 680px;
            height: 50px;
            margin-left: 33px;
            border-radius: 8px;
            border: 2px solid rgba(15, 19, 42, .2);
            background: rgba(15, 19, 42, .1);
            color: rgba(15, 19, 42, .5);
            padding: 0 0 0 15px;
            font-size: 18px;
            font-family: 'Noto Sans KR', 'Roboto';
            transition: .2s linear;
        }

        .inputdiv .membermail b {
            margin-left: 40px;
        }

        .inputdiv .membermail span {
            margin-left: 40px;
            color: #808080;
        }

        .inputdiv .membermail input:focus,
        .inputdiv .membermail input:active {
            outline: none;
            border-color: #8007AD;
            color: rgba(15, 19, 42, 1);
        }

        .inputdiv .memberbtn {
            background: #8007AD;
            color: white;
            display: block;
            width: 20%;
            height: 50px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-size: 2vh;
            font-family: 'Noto Sans KR', 'Roboto';
            font-weight: bold;
            opacity: 0.85;
            transition: .2s linear;
        }

        .inputdiv .memberbtn:hover {
            opacity: 1;
        }

        section p {
            margin-top: 4vh;
            text-align: center;
        }

        section p a {
            text-decoration: none;
            font-size: 17px;
            margin: 0 5px;
        }

        #selmember span, #finder span {
            text-decoration: none;
            color: #0f132a;
            opacity: 0.6;
            font-weight: bold;
            transition: .2s linear;
        }

        #selmember span:hover, #finder span:hover {
            color: #8007AD;
            opacity: 1;
        }
    </style>
</head>
<script>
    $(function () {
        if ($("#cm_name").val() == "" || $("#cm_cp").val() == "") {
            location.replace("signin");
        }
    });
</script>
<body>
<input type="hidden" name="cm_name" id="cm_name" value="${cm_name}">
<input type="hidden" name="cm_cp" id="cm_cp" value="${cm_cp}">
<div class="container">
    <!-- Heading -->
    <div class="logo">
        <a href="${root}/" style="text-decoration: none;"> <img src="/photo/logo.png" class="logotext">
            <span><img src="/photo/logoimage.png" class="logoimage"></span>
        </a>
        <div style="color:#0f132a; opacity:0.6; font-weight: bold;">아&nbsp;이&nbsp;디&nbsp;찾&nbsp;기</div>
    </div>

    <div class="inputdiv">
        <div style="margin-left:33px; padding-bottom: 20px;">
            <strong style="color:#8007AD; font-weight: bold; margin-bottom: 10px;">기업회원</strong>
        </div>
        <!-- Links -->
        <ul class="links">
            <li>
                <a href="#" id="normmember"
                   style="font-size: 20px"><span>${cm_name} 담당자님이 요청하신 이메일이 ${list.size()}건 검색되었습니다</span></a>
            </li>
        </ul>
        <div style="padding-top:10px">
            <table class="table" style="width:90%; margin:0 auto;">
                <tr>
                    <th style="width:40%">이메일</th>
                    <th style="width:40%">회사명</th>
                    <th style="width:20%">가입일</th>
                </tr>
                <c:forEach items="${list}" var="dto">
                    <tr style="font-weight: bold; opacity: 0.5">
                        <td>
                                ${dto.cm_email}
                        </td>
                        <td>
                                ${dto.cm_compname}
                        </td>
                        <td>
                            <fmt:formatDate value="${dto.cm_date}" pattern="yyyy-MM-dd"/>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <section>
            <p>
                <a href="signin" id="selmember"><span>로그인</span></a>
                <strong style="color:#0f132a; opacity: 0.6;">|</strong>
                <a href="finder" id="finder"><span>아이디/비밀번호 찾기</span></a>
            </p>
        </section>
    </div>
</div>
</body>
</html>

