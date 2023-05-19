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
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&family=Roboto&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
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

        .inputdiv {
            width: 100%;
            max-width: 680px;
            margin: 40px auto 10px;
        }

        .inputdiv {
            width: 100%;
            max-width: 680px;
            margin: 40px auto 10px;
        }

        .inputdiv .input__block {
            margin: 20px auto;
            display: block;
            position: relative;
        }

        .inputdiv .input__block.first-input__block::before {
            content: "";
            position: absolute;
            top: -15px;
            left: 50px;
            display: block;
            width: 0;
            height: 0;
            background: transparent;
            border-left: 15px solid transparent;
            border-right: 15px solid transparent;
            border-bottom: 15px solid rgba(15, 19, 42, .1);
            transition: .2s linear;
        }

        .inputdiv .input__block.signup-input__block::before {
            content: "";
            position: absolute;
            top: -15px;
            left: 150px;
            display: block;
            width: 0;
            height: 0;
            background: transparent;
            border-left: 15px solid transparent;
            border-right: 15px solid transparent;
            border-bottom: 15px solid rgba(15, 19, 42, .1);
            transition: .2s linear;
        }

        .inputdiv .input__block input {
            display: block;
            width: 90%;
            max-width: 680px;
            height: 50px;
            margin: 0 auto;
            border-radius: 8px;
            border: 1px solid rgba(15, 19, 42, .2);
            background: rgba(15, 19, 42, .1);
            color: rgba(15, 19, 42, .5);
            padding: 0 0 0 15px;
            font-size: 18px;
            font-family: 'Noto Sans KR', 'Roboto';
        }

        .inputdiv .input__block input:focus,
        .inputdiv .input__block input:active {
            outline: none;
            border: none;
            color: rgba(15, 19, 42, 1);
        }

        .inputdiv .input__block input.repeat__password {
            opacity: 0;
            display: none;
            transition: .2s linear;
        }

        footer p {
            margin-top: 4vh;
            text-align: center;
        }

        footer p a {
            text-decoration: none;
            font-size: 17px;
            margin: 0 5px;
        }

        #m_pass:focus {
            outline: none;
            border: 1px solid #8007AD;
        }

        #sendemail {
            position: absolute;
            left:50%;
            top:50%;
            margin-left: 20%;

            background: rgba(128,7,173,0.5);
            color: white;
            display: block;
            width: 25%;
            max-width: 680px;
            height: 50px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-size: 2vh;
            font-family: 'Noto Sans KR', 'Roboto';
            font-weight: bold;
        }

        #sendemail:hover {
            background: rgba(128,7,173,1);
            transition: .2s;
        }
    </style>
</head>
<body>
<input type="hidden" id="m_type" value="0">
<div class="container">
    <!-- Heading -->
    <div class="logo">
        <a href="${root}/" style="text-decoration: none;"> <img src="/photo/logo.png" class="logotext">
            <span><img src="/photo/logoimage.png" class="logoimage"></span>
        </a>
        <div style="color:#0f132a; opacity: 0.6; font-weight: bold">회&nbsp;원&nbsp;가&nbsp;입</div>
    </div>

    <div class="inputdiv">
        <div class="input__block">
            <div class="input-group">
                <input type="password" placeholder="Password" class="input" id="m_pass" required/>
                <button type="button" id="sendemail">인증요청</button>
            </div>
        </div>
        <footer>
            <p>
            </p>
        </footer>
    </div>
</div>
<script>

</script>
</body>
</html>