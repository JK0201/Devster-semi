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
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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

        #normmember span {
            opacity: 0.6;
        }

        .inputdiv {
            width: 100%;
            max-width: 680px;
            margin: 40px auto 10px;
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

        .rotating-image {
            transition: transform 2s;
            transform-style: preserve-3d;
        }

        @keyframes spin {
            from {
                transform: rotateY(0deg);
            }
            to {
                transform: rotateY(10turn);
            }
        }

        .rotating {
            animation: spin 2s linear infinite;
        }

        @keyframes rainbow {
            0% {
                background: red;
            }
            14% {
                background: orange;
            }
            28% {
                background: yellow;
            }
            42% {
                background: green;
            }
            57% {
                background: blue;
            }
            71% {
                background: indigo;
            }
            85% {
                background: violet;
            }
            100% {
                background: red;
            }
        }

        .rainbow {
            animation: rainbow 2s linear infinite;
            color: white; /* 글자 색상을 흰색으로 변경하였습니다. */
        }

        .dogy {
            display: none;
        }
    </style>
</head>
<script>
</script>
<body>
<img src="/photo/devster-dogy.gif" class="dogy" style="position:absolute; left:10%; top:10%">
<img src="/photo/devster-dogy.gif" class="dogy" style="position:absolute; left:33%; top:23%">
<img src="/photo/devster-dogy.gif" class="dogy" style="position:absolute; left:23%; top:53%">
<img src="/photo/devsterdogyfast.gif" class="dogy" style="position:absolute; left:60%; top:22%">
<img src="/photo/devsterdogyfast.gif" class="dogy" style="position:absolute; left:23%; top:33%">
<img src="/photo/devsterdogyfast.gif" class="dogy" style="position:absolute; left:77%; top:33%">
<img src="/photo/devster-dogy.gif" class="dogy" style="position:absolute; left:70%; top:10%">
<img src="/photo/devster-dogy.gif" class="dogy" style="position:absolute; left:70%; top:70%">
<img src="/photo/devsterdogyfast.gif" class="dogy" style="position:absolute; left:23%; top:33%">
<img src="/photo/devsterdogyfast.gif" class="dogy" style="position:absolute; left:77%; top:33%">
<img src="/photo/devster-dogy.gif" class="dogy" style="position:absolute; left:90%; top:60%">
<img src="/photo/devsterdogyfast.gif" class="dogy" style="position:absolute; left:10%; top:70%">
<div class="container">
    <!-- Heading -->
    <div class="logo">
        <a href="${root}/" style="text-decoration: none;"> <img src="/photo/logo.png" class="logotext">
            <span><img src="/photo/logoimage.png" class="logoimage"></span>
        </a>
        <div style="color:#0f132a; opacity: 0.6; font-weight: bold">잘&nbsp;했&nbsp;어&nbsp;!</div>
    </div>
    <div class="inputdiv">
        <section>
            <p>
                <a><span style="font-size: 3vh; opacity: 0.6; font-weight: bold">회원가입을 진심으로 축하드립니다!</span></a>
            </p>
        </section>
        <div style="width:100%;">
            <img src="/photo/musk.png" class="rotating-image"
                 style="width:70%; margin-left:80px;">
        </div>
        <div style="display: flex; width:100%;">
            <img src="/photo/dogycoin.jpg" class="rotating-image dogy" style="width:20%;">
            <div class="input__block">
                <button class="signin__btn" id="tothemars" style="width:200%; margin-left:-50%">화&nbsp;성&nbsp;갈&nbsp;끄&nbsp;니&nbsp;까&nbsp;~
                </button>
            </div>
            <img src="/photo/dogycoin.jpg" class="rotating-image dogy" style="width:20%">
        </div>
    </div>
</div>
<script>
    $("#tothemars").click(function(){
       location.href="/";
    });

    $('#tothemars').mouseover(function () {
        $('.rotating-image').addClass('rotating');
    });

    $('#tothemars').mouseout(function () {
        $('.rotating-image').removeClass('rotating');
    });
    $('#tothemars').mouseout(function () {
        $('.rotating-image').removeClass('rotating');
    });
    $('#tothemars').mouseover(function () {
        $(this).addClass('rainbow');
        $('.rotating-image').addClass('rotating');
        $(".dogy").removeClass('dogy');
    });

    $('#tothemars').mouseout(function () {
        $(this).removeClass('rainbow');
        $('.rotating-image').removeClass('rotating');
    });
</script>
</body>
</html>