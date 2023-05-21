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
    <link href="https://fonts.googleapis.com/css?family=Poppins:600&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a81368914c.js"></script>
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
            display: flex;
            justify-content: space-evenly;
            list-style-type: none;
            text-align: center;
            margin: 0 30px 0 0;
        }

        .links li {
            display: inline-block;
            font-size: 4vh;
            border-top: 2px solid transparent;
        }

        .links li:hover {
            border-color: #8007AD;
            transition: .5s linear;
        }

        .links li span:hover {
            color: #8007AD;
            opacity: 1 !important;
            transition: .5s linear;
        }

        .links li span {
            opacity: 0.6;
        }

        .links li a {
            text-decoration: none;
            color: #0f132a;
            font-weight: bolder;
            text-align: center;
            cursor: pointer;
        }

        .inputdiv {
            width: 100%;
            max-width: 680px;
            margin: 40px auto 10px;
            box-shadow: 4px 4px 14px 7px #bdbebd;
            padding-top: 5vh;
            padding-bottom: 5vh;
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
            width: 90%;
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

        #kakao-signin {
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

        #signin, #finder {
            color: #0f132a;
            opacity: 0.6;
            font-weight: bold;
        }

        #signin {
            text-decoration: underline;
        }

        #signin:hover {
            opacity: 1;
            color: #8007AD;
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
        <div style="color:#0f132a; opacity: 0.6; font-weight: bold">회&nbsp;원&nbsp;가&nbsp;입</div>
    </div>

    <div class="inputdiv">
        <!-- Links -->
        <ul class="links">
            <li>
                <a href="signup" id="normmember"><span>일반회원</span></a>
            </li>
            <li>
                <a href="compsignup" id="compmember"><span>기업회원</span></a>
            </li>
        </ul>
        <div>
            <!-- separator -->
            <div class="separator">
                <p>소셜 계정으로 간편 가입하기</p>
            </div>
            <!-- kakao button -->
            <a id="kakao-login-btn" href="javascript:kakaoLogin()" class="kakao__btn">
                <div id="kakao-signin">
                    <i class="bi bi-chat-fill"></i>
                    &nbsp;
                    <span>카카오 아이디로 회원가입</span>
                </div>
            </a>
            <!-- naver button -->
            <div class="naver__btn">
                <div id="naver-signin">
                    <span>N</span>
                    &nbsp;
                    <span>네이버 아이디로 회원가입</span>
                </div>
            </div>
        </div>
        <section>
            <p>
                <a id="finder">이미 계정이 있나요?</a>
                <a href="signin" id="signin">로그인</a>
            </p>
        </section>
    </div>
</div>
<div id="naver_id_login" style="display: none;"></div>
<script>
    //kakao
    window.Kakao.init("82a8d8044b53724691554098e719219c");

    function kakaoLogin() {

        window.Kakao.Auth.login({

            // scope: 'profile_nickname, profile_image, account_email',
            scope: 'account_email',
            success: function (res) {
                console.log(res);
                let m_pass = res.access_token;
                window.Kakao.API.request({
                    url: '/v2/user/me',
                    success: res => {
                        const kakao_account = res.kakao_account;
                        console.log(kakao_account);
                        // console.log(kakao_account.email);
                        // console.log(res.properties.nickname);
                        // console.log(res.properties.profile_image);
                        // let m_nickname = res.properties.nickname;
                        // let m_photo = res.properties.profile_image;
                        let m_email = kakao_account.email;
                        $.ajax({
                            type: "get",
                            url: "accapichk",
                            data: {"m_email": m_email},
                            dataType: "json",
                            success: function (res) {
                                if (res.result == "yes") {
                                    Swal.fire({
                                        icon: 'question',
                                        title: '이미 계정이 존재합니다',
                                        text: '지금 바로 로그인 하시겠습니까?',

                                        showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
                                        confirmButtonColor: '#8007AD', // confrim 버튼 색깔 지정
                                        cancelButtonColor: '#bdbebd', // cancel 버튼 색깔 지정
                                        confirmButtonText: '확인', // confirm 버튼 텍스트 지정
                                        cancelButtonText: '취소', // cancel 버튼 텍스트 지정

                                        reverseButtons: true // 버튼 순서 거꾸로
                                    }).then(result => {
                                        if (result.isConfirmed) {
                                            location.href = "signin";
                                        } else {
                                            return false;
                                        }
                                    });
                                } else {
                                    $.ajax({
                                        type: "get",
                                        url: "apiaccinfo",
                                        data: {"m_email": m_email, "m_pass": m_pass},
                                        dataType: "text",
                                        success: function () {
                                            location.href = "apisignup"
                                        }
                                    });
                                }
                            }
                        });
                    }
                });
            }
        });
    }

    //naver
    var naver_id_login = new naver_id_login("Qr3pEkAiiIBJ_L9HaGiY", "http://localhost:9000/member/navercallbackacc");
    var state = naver_id_login.getUniqState();
    naver_id_login.setButton("green", 10, 40);
    naver_id_login.setDomain("http://localhost:9000");
    naver_id_login.setState(state);
    naver_id_login.setPopup();
    naver_id_login.init_naver_id_login();

    $(document).on("click", ".naver__btn", function () {
        var btnNaverLogin = document.getElementById("naver_id_login").firstChild;
        btnNaverLogin.click();
    });
</script>
</body>
</html>