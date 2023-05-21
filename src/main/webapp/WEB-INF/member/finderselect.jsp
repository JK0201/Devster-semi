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
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
            charset="utf-8"></script>
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
            cursor: pointer;
        }

        #normmember span {
            color: #8007AD;
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
            border: none;
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

        .separator {
            display: block;
            margin: 30px auto 10px;
            text-align: center;
            height: 40px;
            position: relative;
            background: transparent;
            color: rgba(15, 19, 42, .5);
            font-size: 13px;
            width: 90%;
            max-width: 680px;
        }

        .separator::before {
            content: "";
            position: absolute;
            top: 8px;
            left: 0;
            background: rgba(15, 19, 42, .2);
            height: 1px;
            width: 35%;
        }

        .separator::after {
            content: "";
            position: absolute;
            top: 8px;
            right: 0;
            background: rgba(15, 19, 42, .2);
            height: 1px;
            width: 35%;
        }

        .kakao__btn,
        .naver__btn {
            display: block;
            width: 50%;
            max-width: 680px;
            margin: 20px auto;
            height: 50px;
            cursor: pointer;
            font-size: 14px;
            font-family: 'Noto Sans KR', 'Roboto';
            border-radius: 8px;
            border: none;
            line-height: 50px;
        }

        .kakao__btn {
            background: #F7E600;
            color: white;
            box-shadow: 0 15px 30px rgba(91, 144, 240, .36);
            transition: .2s linear;
            text-decoration: none;
        }

        .kakao__btn:hover {
            box-shadow: 0 0 0 rgba(91, 144, 240, 0);
        }

        .naver__btn {
            background: #2DB400;
            color: white;
            box-shadow: 0 15px 30px rgba(37, 40, 45, .36);
            transition: .2s linear;
        }

        .naver__btn:hover {
            box-shadow: 0 0 0 rgba(37, 40, 45, 0);
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

        .memberlayout footer {
            margin-top: 200px;
        }

        #kakao-account, #kakao-pass {
            font-weight: bold;
            text-align: center;
            color: black;
            font-size: 2vh;
        }

        #naver-signin {
            font-weight: bold;
            text-align: center;
            color: white;
            font-size: 2vh;
        }

        #selmember span, #signin span {
            text-decoration: none;
            color: #0f132a;
            opacity: 0.6;
            font-weight: bold;
            transition: .2s linear;
        }

        #selmember span:hover, #signin span:hover {
            color: #8007AD;
            opacity: 1;
        }

        .agreementbox {
            display: block;
            width: 90%;
            max-width: 680px;
            height: 100%;
            margin: 0 auto;
            border-radius: 8px;
            background: rgba(15, 19, 42, .1);
            color: rgba(15, 19, 42, .5);
            padding: 0 0 0 15px;
            font-size: 18px;
            font-family: 'Noto Sans KR', 'Roboto';
            transition: .2s linear;
        }

        .finderoption {
            width: 50%;
            height: 50px;
            line-height: 50px;
            margin: 0 auto;
            cursor: pointer;
            text-align: center;
            transition: .2s linear;
        }

        .finderoption:hover {
            color: #8007AD;
            opacity: 1;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Heading -->
    <div class="logo">
        <a href="${root}/" style="text-decoration: none;"> <img src="/photo/logo.png" class="logotext">
            <span><img src="/photo/logoimage.png" class="logoimage"></span>
        </a>
        <div style="color:#0f132a; opacity: 0.6; font-weight: bold">아&nbsp;이&nbsp;디&nbsp;&&nbsp;비&nbsp;밀&nbsp;번&nbsp;호&nbsp;찾&nbsp;기</div>
    </div>

    <div class="inputdiv">
        <!-- Links -->
        <ul class="links">
            <li>
                <a href="#" id="normmember"><span>일반회원</span></a>
            </li>
            <li>
                <a href="#" id="compmember"><span>기업회원</span></a>
            </li>
        </ul>

        <div id="normmode">
            <div class="first-input input__block first-input__block">
                <div class="agreementbox">
                    <div class="finderoption" id="accfinder">
                        <strong>아&nbsp;이&nbsp;디&nbsp;찾&nbsp;기</strong>
                    </div>
                </div>
            </div>
            <!-- password input -->
            <div class="input__block">
                <div class="agreementbox">
                    <div class="finderoption" id="passfinder">
                        <strong>비&nbsp;밀&nbsp;번&nbsp;호&nbsp;찾&nbsp;기</strong>
                    </div>
                </div>
            </div>
            <div>
                <!-- separator -->
                <div class="separator">
                    <p>소셜 계정 & 비밀번호 찾기</p>
                </div>
                <!-- kakao button -->
                <div style="background-color: pink; width:50%;">
                    <div>
                        <strong>카카오</strong>
                    </div>
                    <a id="kakao-account-btn"
                       href="https://accounts.kakao.com/weblogin/find_account?app_type=web&continue=https%3A%2F%2Faccounts.kakao.com%2Fweblogin%2Faccount%2Finfo&lang=ko"
                       class="kakao__btn" target="_blank">
                        <div id="kakao-account">
                            <i class="bi bi-chat-fill"></i>
                            &nbsp;
                            <span>아&nbsp;이&nbsp;디&nbsp;찾&nbsp;기</span>
                        </div>
                    </a>
                    <a id="kakao-pass-btn"
                       href="https://accounts.kakao.com/weblogin/find_password?app_type=web&continue=https%3A%2F%2Faccounts.kakao.com%2Fweblogin%2Faccount%2Finfo&lang=ko"
                       class="kakao__btn" target="_blank">
                        <div id="kakao-pass">
                            <i class="bi bi-chat-fill"></i>
                            &nbsp;
                            <span>비밀번호 찾기</span>
                        </div>
                    </a>
                </div>
                <!-- naver button -->
                <div style="background-color: blue; width:50%;">
                    <div>
                        <strong>네이버</strong>
                    </div>
                    <div class="naver__btn">
                        <div id="naver-signin">
                            <a href="https://nid.naver.com/user2/help/idInquiry.nhn?menu=idinquiry" target="_blank">
                                <span style="color: white">N</span>
                                &nbsp;
                                <span style="color: white">아&nbsp;이&nbsp;디&nbsp;찾&nbsp;기</span>
                            </a>
                        </div>
                    </div>
                    <div class="naver__btn">
                        <div id="naver-signin">
                            <a href="https://nid.naver.com/user2/help/pwInquiry.nhn?menu=pwinquiry" target="_blank">
                                <span style="color: white">N</span>
                                &nbsp;
                                <span style="color: white">비밀번호 찾기</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Comp member -->
        <div id="compmode">
            <div class="first-input input__block first-input__block">
                <div class="agreementbox">
                    <div class="finderoption" id="caccfinder">
                        <strong>아&nbsp;이&nbsp;디&nbsp;찾&nbsp;기</strong>
                    </div>
                </div>
            </div>
            <div class="input__block">
                <div class="agreementbox">
                    <div class="finderoption" id="cpassfinder">
                        <strong>비&nbsp;밀&nbsp;번&nbsp;호&nbsp;찾&nbsp;기</strong>
                    </div>
                </div>
            </div>
        </div>
        <section>
            <p>
                <a href="selmember" id="selmember"><span>회원가입</span></a>
                <strong style="color:#0f132a; opacity: 0.6;">|</strong>
                <a href="signin" id="signin"><span>로그인</span></a>
            </p>
        </section>
    </div>
</div>
<div id="naver_id_login" style="display: none;"></div>

<script>
    $(document).ready(function () {
        let normmode = $("#normmode");
        let compmode = $("#compmode");
        let compmember = $(".links").find("li").find("#compmember");
        let normmember = $(".links").find("li").find("#normmember");

        let first_input = $(".inputdiv").find(".first-input");
        let hidden_input1 = $(".inputdiv").find(".input__block").find("#cm_email");
        let hidden_input2 = $(".inputdiv").find(".input__block").find("#cm_pass");

        compmode.hide();
        //----------- comp ---------------------
        compmember.on("click", function (e) {
            e.preventDefault();
            $(this).parent().find("span").css("color", "#8007AD");
            $(this).parent().css("opacity", "1");
            $(this).parent().siblings().find("span").css("color", "#0f132a");
            $(this).parent().siblings().css("opacity", ".5");
            normmode.hide();
            compmode.show();

            first_input.removeClass("first-input__block").addClass("signup-input__block");
            hidden_input1.css({
                "opacity": "1",
                "display": "block"
            });
            first_input.removeClass("first-input__block").addClass("signup-input__block");
            hidden_input2.css({
                "opacity": "1",
                "display": "block"
            });
        });

        //----------- norm ---------------------
        normmember.on("click", function (e) {
            e.preventDefault();
            $(this).parent().find("span").css("color", "#8007AD");
            $(this).parent().css("opacity", "1");
            $(this).parent().siblings().find("span").css("color", "#0f132a");
            $(this).parent().siblings().css("opacity", ".5");
            normmode.show();
            compmode.hide();

            first_input.addClass("first-input__block").removeClass("signup-input__block");
            hidden_input1.css({
                "opacity": "0",
                "display": "none"
            });
            first_input.addClass("first-input__block").removeClass("signup-input__block");
            hidden_input2.css({
                "opacity": "0",
                "display": "none"
            });
        });
    });

    $("#accfinder").click(function () {
        location.href = "accfinder";
    });
    $("#passfinder").click(function () {
        location.href = "passfinder";
    });
    $("#caccfinder").click(function () {
        location.href = "caccfinder";
    });
    $("#cpassfinder").click(function () {
        location.href = "cpassfinder";
    });
</script>
</body>
</html>